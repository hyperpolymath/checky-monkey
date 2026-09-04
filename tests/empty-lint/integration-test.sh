#!/usr/bin/env bash
# SPDX-License-Identifier: MPL-2.0
# Integration test that simulates the dogfood-gate.yml workflow steps
#
# This script runs the exact same logic as the CI workflow to verify
# that the patterns work correctly in the actual CI environment context.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GITHUB_WORKSPACE="$SCRIPT_DIR"

echo "====================================================================="
echo "Empty-Linter Integration Test (CI Workflow Simulation)"
echo "====================================================================="
echo ""

# Clean up any previous results
rm -f /tmp/bom-results.txt /tmp/empty-lint-results.txt

echo "Step 1: Check for leading BOM (Byte Order Mark)"
echo "---------------------------------------------------------------------"

set +e
find "$GITHUB_WORKSPACE" \
  -not -path '*/.git/*' -not -path '*/node_modules/*' \
  -not -path '*/.deno/*' -not -path '*/target/*' \
  -not -path '*/_build/*' -not -path '*/deps/*' \
  -not -path '*/external_corpora/*' -not -path '*/.lake/*' \
  -type f \( -name '*.rs' -o -name '*.ex' -o -name '*.exs' -o -name '*.res' \
    -o -name '*.js' -o -name '*.ts' -o -name '*.json' -o -name '*.toml' \
    -o -name '*.yml' -o -name '*.yaml' -o -name '*.md' -o -name '*.adoc' \
    -o -name '*.idr' -o -name '*.zig' -o -name '*.v' -o -name '*.jl' \
    -o -name '*.gleam' -o -name '*.hs' -o -name '*.ml' -o -name '*.sh' \
    -o -name '*.txt' \) \
  -exec grep -aPl '^\xef\xbb\xbf' {} \; > /tmp/bom-results.txt 2>/dev/null
BOM_EXIT=$?
set -e

BOM_COUNT=$(wc -l < /tmp/bom-results.txt 2>/dev/null || echo 0)

echo "BOM check exit code: $BOM_EXIT"
echo "Files with leading BOM: $BOM_COUNT"

while IFS= read -r filepath; do
  [ -z "$filepath" ] && continue
  REL_PATH="${filepath#$GITHUB_WORKSPACE/}"
  echo "  [WARNING] $REL_PATH: File starts with UTF-8 BOM (U+FEFF)"
done < /tmp/bom-results.txt

if [ "${BOM_COUNT:-0}" -gt 0 ]; then
  echo "  [NOTICE] $BOM_COUNT file(s) have leading BOM - advisory only"
fi
echo ""

echo "Step 2: Scan for invisible characters"
echo "---------------------------------------------------------------------"

set +e
PATTERNS='(*UTF)[\x00-\x08\x0B\x0C\x0E-\x1F\x{a0}\x{ad}\x{200b}-\x{200f}\x{202a}-\x{202f}\x{2060}\x{2066}-\x{2069}\x{feff}]'
find "$GITHUB_WORKSPACE" \
  -not -path '*/.git/*' -not -path '*/node_modules/*' \
  -not -path '*/.deno/*' -not -path '*/target/*' \
  -not -path '*/_build/*' -not -path '*/deps/*' \
  -not -path '*/external_corpora/*' -not -path '*/.lake/*' \
  -type f \( -name '*.rs' -o -name '*.ex' -o -name '*.exs' -o -name '*.res' \
    -o -name '*.js' -o -name '*.ts' -o -name '*.json' -o -name '*.toml' \
    -o -name '*.yml' -o -name '*.yaml' -o -name '*.md' -o -name '*.adoc' \
    -o -name '*.idr' -o -name '*.zig' -o -name '*.v' -o -name '*.jl' \
    -o -name '*.gleam' -o -name '*.hs' -o -name '*.ml' -o -name '*.sh' \
    -o -name '*.txt' \) \
  -exec grep -aPrl "$PATTERNS" {} \; > /tmp/empty-lint-results.txt 2>/dev/null
EL_EXIT=$?
set -e

FINDINGS=$(wc -l < /tmp/empty-lint-results.txt 2>/dev/null || echo 0)

echo "Invisible character scan exit code: $EL_EXIT"
echo "Files with invisible characters: $FINDINGS"

# Check for blocking C0/NUL corruption
blocking=0
while IFS= read -r bf; do
  [ -z "$bf" ] && continue
  if grep -qaP '\x00|[\x01-\x08\x0B\x0C\x0E-\x1F]' "$bf"; then
    blocking=$((blocking+1))
    REL_PATH="${bf#$GITHUB_WORKSPACE/}"
    echo "  [ERROR] $REL_PATH: C0 control characters or NUL bytes - file corruption, blocks the gate"
  fi
done < /tmp/empty-lint-results.txt

# Emit warnings for non-blocking invisible chars
while IFS= read -r filepath; do
  [ -z "$filepath" ] && continue
  # Only warn if not already reported as blocking
  if ! grep -qaP '\x00|[\x01-\x08\x0B\x0C\x0E-\x1F]' "$filepath"; then
    REL_PATH="${filepath#$GITHUB_WORKSPACE/}"
    echo "  [WARNING] $REL_PATH: Invisible Unicode characters detected (zero-width space, BOM, NBSP, etc.)"
  fi
done < /tmp/empty-lint-results.txt

if [ "$EL_EXIT" -ne 0 ]; then
  echo "  [WARNING] invisible-character scan exited $EL_EXIT - results may be incomplete"
fi

if [ "${blocking:-0}" -gt 0 ]; then
  echo "  [ERROR] $blocking file(s) contain C0 control characters or NUL bytes - corruption, not typography"
elif [ "${FINDINGS:-0}" -gt 0 ]; then
  echo "  [NOTICE] $FINDINGS file(s) carry invisible Unicode (NBSP/BOM/zero-width) - advisory only"
fi
echo ""

echo "====================================================================="
echo "Summary"
echo "====================================================================="
echo "Leading BOM files: $BOM_COUNT (advisory)"
echo "Invisible character files: $FINDINGS (total)"
echo "C0/NUL corruption files: $blocking (blocking)"
echo ""

if [ "${blocking:-0}" -gt 0 ]; then
  echo "RESULT: FAIL - Blocking corruption detected"
  exit 1
else
  echo "RESULT: PASS - No blocking issues (advisory findings are acceptable)"
  exit 0
fi
