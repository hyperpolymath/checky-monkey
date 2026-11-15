# TEST-NEEDS — Checky Monkey: measured coverage and assurance debt

<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->

**Status: incomplete; no CRG C or proof certification claimed by this document.** The previous "CRG C ACHIEVED" assertion was not backed by executable product coverage. Count jobs that ran on an exact commit, not workflow files, as execution evidence.

Canonical taxonomy: [metadatastician/standards 3-practice/testing-and-benchmarking/TESTING-TAXONOMY.adoc](https://github.com/metadatastician/standards/blob/main/3-practice/testing-and-benchmarking/TESTING-TAXONOMY.adoc), now **18 categories × 14 aspects**. Draw reusable tests from [proven-tests-and-benches](https://github.com/hyperpolymath/proven-tests-and-benches) FIRST. Workflow capabilities belong to [proven-cicd-and-workflows](https://github.com/hyperpolymath/proven-cicd-and-workflows). Do not promote advisory/placeholder actions into mandatory assurance.

## Executable current scope

The only exercised native subject is the `ffi/zig/` library, with Zig 0.13.0 unit and C ABI tests in `dogfood-gate.yml` job `native-ffi`. The additional `tests/abi/consumer.c` uses the reusable three-outcome C ABI contract harness from `proven-tests-and-benches` at an explicitly checked full source SHA. That harness is **unproven**; it runs caller-supplied assertions, not mathematical proofs. The existing shell regression suite tests invisible-character detection. There is still no userscript parser, static analyzer, registry, CLI, browser plugin, or complete Idris2 cross-language compilation gate.

**Status terms:** REAL = specifically exercised with a clean and planted defective case; THIN = a real assertion but incomplete category scope; ABSENT = no subject assertion in current CI; N/A = genuinely not yet applicable with a reason. The matrix is an assessment of intended coverage, NOT a CI pass claim; only a run on the latest commit qualifies execution.

| # | Canonical test category | Assessment | Current evidence / missing obligation |
|---|---|---|---|
| 1 | Unit | THIN | Zig source tests cover some lifecycle and status paths; public APIs and all error branches not exhaustive |
| 2 | Point-to-point (P2P) | THIN | Linked C ABI consumer; Idris2→Zig seam not compiled |
| 3 | End-to-end | ABSENT | No user-facing userscript intake→report pipeline |
| 4 | Build | THIN | Pinned Zig 0.13.0 Linux build; other supported targets and reproducibility untested |
| 5 | Execution & runtime | THIN | The library executes; no product runtime exists |
| 6 | Reflexive | THIN | Refusal of unsupported operations and no-tool diagnostics; no full doctor or run-claim verifier |
| 7 | Lifecycle | THIN | Init/free, two live handles, borrowed/owned string; allocation failure, stale pointer, leak stress absent |
| 8 | Smoke | THIN | C consumer runs and calls symbols; no CLI/user-facing artifact |
| 9 | Property-based / generative | ABSENT | No 1,000-case generators or shrinkers |
| 10 | Mutation | THIN | Reusable C harness planted compile/runtime mutants; no subject-source mutation campaign/score |
| 11 | Fuzz | ABSENT | No executable fuzz harness or corpus; the former scorecard-only placeholder has been removed |
| 12 | Contract / invariant | THIN | Public C status contract tested; Idris2/C/Zig layout not proven |
| 13 | Regression | THIN | Specific BOM, false-pass, error-ownership regressions covered; defects elsewhere still missing cases |
| 14 | Chaos / resilience | ABSENT | Allocation-failure injection and fault handling required before claiming resilience |
| 15 | Compatibility | ABSENT | First C ABI version, no versioned upgrade/consumer compatibility corpus |
| 16 | Proof regression | ABSENT | Idris2 module names, templates and ABI declarations remain inconsistent; no checked proofs |
| 17 | Type-safe | ABSENT | C static assertions are not Idris2 compiler negative-witness proofs |
| 18 | Coupling / drift-freedom | THIN | Public C header↔linked Zig code is exercised; Idris2 result enum and layout drift remain |

## Cross-cutting aspects (14)

| Aspect | Present evidence and debt |
|---|---|
| Dependability | Handle lifetime tests; no long-run fault-injection |
| Security | Explicit unsupported paths; no script threat model exercised |
| Usability | N/A until UI or CLI is implemented |
| Interoperability | Executed native C ABI seam, not yet Idris2 |
| Safety | Reject null/unsupported, but no memory-safety proof |
| Performance | No calibrated baseline or regression threshold |
| Functionality | Native ABI shell only; userscript functionality absent |
| Versability | C ABI v0.1 string check; no version compatibility tests |
| Accessibility | N/A until browser or CLI artifact ships |
| Maintainability | Shared harness contract; incomplete build/docs |
| Privacy | No implemented data pipeline to inspect; policies not tests |
| Observability | Last-error/status checks, no complete evidence receipts |
| Reproducibility | Pinned native Zig release and Proven source revision; not multi-platform |
| Portability | Linux CI observed; no Windows/macOS matrix |

## Next gates before claiming comprehensive assurance

1. **Preserve stable emitted context:** `Native Zig library build and C-ABI tests`. Required contexts must appear on pull requests to all bases, with a nonzero job count, a pinned subject SHA and a final fail-closed verdict. Rulesets are managed separately; do not require a context until its real canary passes.
2. **Qualify the Proven dependency:** independently test its silence/firing/void harness, publish a reviewed immutable commit, repin this consumer, and keep both 1 and 2 exit outcomes blocking.
3. **Repair Idris2 ABI**, then run genuine compiler checks and negative witnesses. Compiler-not-installed means **not run**, never a green proof.
4. **Introduce the userscript `userscript-submission/0.1` contract** from issue #101 and plant malformed/privilege mismatch/provenance false-claim fixtures. Only then implement parser→analysis→record/report E2E tests.
5. Add reproducible property generation with shrinking, coverage and source mutation, actual fuzz corpus once an untrusted parser exists, allocation failure/chaos, benchmarks and documented portability/compatibility matrices.
6. Restore meaningful CI startup checks (governance, Hypatia, secret scanning, SonarCloud). A green Dogfood Gate does **not** compensate for any failed required check or absent workflow.

## Explicit limitations

CRG grade and test completeness are **not established**. No % coverage metric exists for the entire product, nor can the current native unit tests establish security of userscript processing that has not been built. A cancelled, skipped, empty, setup-only or startup-failed job cannot become a passing test through a summary job. Work on product internals belongs to a scoped PR and must pass latest-head CI and reviewer threads before closure.
