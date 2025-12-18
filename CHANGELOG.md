# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `flake.nix` - Nix fallback package management (RSR requirement)
- `CHANGELOG.md` - Project changelog following Keep a Changelog format

### Fixed
- `security.txt` - RFC 9116 compliance with valid expiry date (was placeholder)
- `RSR_COMPLIANCE.adoc` - Updated compliance status to reflect current state

### Changed
- `STATE.scm` - Updated roadmap and completion status (25% → 35%)

## [0.1.0] - 2025-12-15

### Added
- Initial project structure with RSR compliance
- `guix.scm` - Primary package management (Guix)
- `.guix-channel` - Guix channel configuration
- `META.scm` - Architecture Decision Records
- `ECOSYSTEM.scm` - Project relationships
- `STATE.scm` - Session state persistence
- GitHub Actions workflows:
  - `security-policy.yml` - Security checks (weak crypto, HTTP, secrets)
  - `quality.yml` - Code quality (TruffleHog, EditorConfig)
  - `workflow-linter.yml` - RSR workflow validation
  - `guix-nix-policy.yml` - Package manager enforcement
  - `npm-bun-blocker.yml` - Forbidden package manager blocking
  - `wellknown-enforcement.yml` - RFC 9116 validation
  - `scorecard.yml` - OSSF Scorecard security analysis
  - `mirror.yml` - Multi-platform mirroring
  - `codeql.yml` - Static analysis (placeholder)
- `.well-known/` directory:
  - `security.txt` - RFC 9116 security contact
  - `ai.txt` - Consent-aware AI policy
  - `humans.txt` - Human-readable credits
  - `consent-required.txt` - HTTP 430 consent framework
  - `provenance.json` - Source provenance
- Community files:
  - `SECURITY.md` - Security policy
  - `CONTRIBUTING.md` - Contribution guidelines
  - `CODE_OF_CONDUCT.md` - Contributor Covenant v2.1
  - `CITATION.cff` - Citation metadata
  - `codemeta.json` - CodeMeta metadata
- Configuration files:
  - `.editorconfig` - Editor configuration
  - `.gitignore` - Git ignore patterns
  - `.gitattributes` - Git attributes
  - `justfile` - Task runner (TODO recipes)
  - `.gitlab-ci.yml` - GitLab CI/CD pipeline
  - `dependabot.yml` - Dependency automation

[Unreleased]: https://github.com/hyperpolymath/checky-monkey/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/hyperpolymath/checky-monkey/releases/tag/v0.1.0
