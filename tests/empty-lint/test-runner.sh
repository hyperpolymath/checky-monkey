#!/usr/bin/env bash
# SPDX-License-Identifier: MPL-2.0
# Test runner for empty-linter inline logic validation
#
# This script validates the invisible character detection patterns
# used in .github/workflows/dogfood-gate.yml

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="$SCRIPT_DIR"

# The pattern from dogfood-gate.yml (post-fix, with (*UTF) locale-independent mode)
PATTERNS='(*UTF)[\x00-\x08\x0B\x0C\x0E-\x1F\x{a0}\x{ad}\x{200b}-\x{200f}\x{202a}-\x{202f}\x{2060}\x{2066}-\x{2069}\x{feff}]'

# C0 control pattern (blocking subset)
C0_PATTERN='\x00|[\x01-\x08\x0B\x0C\x0E-\x1F]'

# Leading BOM pattern (separate check as required by issue #70)
# U+FEFF BOM in UTF-8 is ef bb bf bytes
LEADING_BOM_PATTERN='^\xef\xbb\xbf'

echo "====================================================================="
echo "Empty-Linter Test Suite"
echo "====================================================================="
echo ""

PASS=0
FAIL=0

test_file() {
    local file="$1"
    local should_detect="$2"
    local pattern_name="${3:-invisible}"
    local test_pattern="${4:-$PATTERNS}"

    local basename="$(basename "$file")"

    if grep -aPq "$test_pattern" "$file" 2>/dev/null; then
        if [ "$should_detect" = "yes" ]; then
            echo "[PASS] $basename: correctly detected $pattern_name"
            PASS=$((PASS + 1))
        else
            echo "[FAIL] $basename: false positive - detected $pattern_name when it should be clean"
            FAIL=$((FAIL + 1))
        fi
    else
        if [ "$should_detect" = "no" ]; then
            echo "[PASS] $basename: correctly clean (no $pattern_name)"
            PASS=$((PASS + 1))
        else
            echo "[FAIL] $basename: false negative - missed $pattern_name"
            FAIL=$((FAIL + 1))
        fi
    fi
}

echo "Test 1: General invisible character detection"
echo "---------------------------------------------------------------------"
test_file "$TEST_DIR/test-clean.txt" "no" "invisible characters"
test_file "$TEST_DIR/test-bom-leading.txt" "yes" "BOM"
test_file "$TEST_DIR/test-c0-nul.txt" "yes" "C0/NUL"
test_file "$TEST_DIR/test-c0-backspace.txt" "yes" "C0/backspace"
test_file "$TEST_DIR/test-nbsp.txt" "yes" "NBSP"
echo ""

echo "Test 2: C0 control character detection (blocking subset)"
echo "---------------------------------------------------------------------"
test_file "$TEST_DIR/test-clean.txt" "no" "C0 controls" "$C0_PATTERN"
test_file "$TEST_DIR/test-c0-nul.txt" "yes" "C0/NUL" "$C0_PATTERN"
test_file "$TEST_DIR/test-c0-backspace.txt" "yes" "C0/backspace" "$C0_PATTERN"
test_file "$TEST_DIR/test-nbsp.txt" "no" "C0 controls (NBSP is not C0)" "$C0_PATTERN"
test_file "$TEST_DIR/test-bom-leading.txt" "no" "C0 controls (BOM is not C0)" "$C0_PATTERN"
echo ""

echo "Test 3: Leading BOM detection (separate check per issue #70)"
echo "---------------------------------------------------------------------"
test_file "$TEST_DIR/test-clean.txt" "no" "leading BOM" "$LEADING_BOM_PATTERN"
test_file "$TEST_DIR/test-bom-leading.txt" "yes" "leading BOM" "$LEADING_BOM_PATTERN"
test_file "$TEST_DIR/test-c0-nul.txt" "no" "leading BOM" "$LEADING_BOM_PATTERN"
test_file "$TEST_DIR/test-nbsp.txt" "no" "leading BOM" "$LEADING_BOM_PATTERN"
echo ""

echo "====================================================================="
echo "Results: $PASS passed, $FAIL failed"
echo "====================================================================="

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi

echo "All tests passed!"
