<!--
SPDX-License-Identifier: CC-BY-SA-4.0
SPDX-FileCopyrightText: 2025-2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->

[![License: PMPL-1.0](https://img.shields.io/badge/License-MPL--2.0-blue.svg)](https://github.com/hyperpolymath/palimpsest-license) <embed
src="https://api.thegreenwebfoundation.org/greencheckimage/github.com"
data-link="https://www.thegreenwebfoundation.org/green-web-check/?url=github.com" />

[![Palimpsest](https://img.shields.io/badge/Philosophy-Palimpsest-indigo.svg)](https://github.com/hyperpolymath/palimpsest-license)

![Checky Monkey Logo](docs/images/checky-monkey-logo.svg)

<div class="text-center" wrapper="1">

**The Trust Layer for the Userscript Ecosystem**

</div>

<div class="text-center" wrapper="1">

*Validate. Verify. Visualize. Vitalize.*

</div>

<div class="lead" wrapper="1">

Checky Monkey is a git forge-based registry and comprehensive
validation/verification platform for userscripts, userstyles, and
browser customization scripts. Think VirusTotal meets npm—but
purpose-built for the userscript community, with deep security analysis,
quality metrics, community intelligence, and eventually AI-assisted
script improvement.

</div>

> [!NOTE]
> This project is in early development. See the [Roadmap](ROADMAP.adoc)
> for planned features and milestones.

------------------------------------------------------------------------

<div id="toc">

</div>

------------------------------------------------------------------------

# Executive Summary

## The Problem

The userscript ecosystem is fragmented and lacks a unified trust layer:

- **Security Uncertainty**: Users install scripts without knowing if
  they contain malicious code, XSS vulnerabilities, or privacy-violating
  trackers

- **Quality Opacity**: No standardized way to assess script reliability,
  performance impact, or compatibility

- **Fragmented Ecosystem**: Scripts scattered across Greasy Fork,
  OpenUserJS, GitHub Gists, random repositories, and personal sites

- **No Provenance**: Difficult to verify authorship, track
  modifications, or ensure script integrity

- **Accessibility Blind Spots**: Many scripts break accessibility
  features or don’t consider users with disabilities

- **Documentation Deficits**: Most scripts lack proper documentation,
  changelogs, or usage guides

## The Solution

Checky Monkey provides:

| Capability | Description |
|----|----|
| **Unified Registry** | Git forge-based, content-addressed repository of userscripts with full version history and provenance tracking |
| **Deep Analysis** | Multi-dimensional validation covering security, performance, accessibility, usability, and compatibility |
| **Community Intelligence** | Crowdsourced ratings, reviews, and behavioral reports—similar to VirusTotal’s community features |
| **IPFS Distribution** | Decentralized, censorship-resistant script distribution with content-addressed integrity |
| **Script Enhancement** | AI-assisted script improvement, documentation generation, and eventually full ReScript rewrites |
| **Developer Tools** | ADE (Application Development Environment), templates, and best-practice scaffolding |

## Vision Statement

> To elevate the userscript ecosystem from the wild west of browser
> customization to a trusted, transparent, and thriving community where
> users can confidently enhance their web experience, and developers can
> build on solid foundations with maximum visibility into their code’s
> impact.

# Project Overview

## What is Checky Monkey?

Checky Monkey is a comprehensive platform consisting of:

### 1. The Registry (Forge)

A git-native registry for userscripts that:

- Stores scripts with full version control history

- Provides content-addressed storage (CUBS database)

- Mirrors to IPFS for decentralized distribution

- Integrates with existing sources (Greasy Fork, OpenUserJS, GitHub)

- Maintains cryptographic provenance chains

### 2. The Analysis Engine

A multi-faceted validation system that evaluates scripts across:

Security  
Vulnerability scanning, malware detection, permission analysis, CSP
compliance

Privacy  
Tracker detection, data exfiltration analysis, third-party communication
auditing

Performance  
Resource usage profiling, DOM mutation analysis, network request
auditing

Accessibility  
WCAG compliance checking, screen reader compatibility, keyboard
navigation

Usability  
UI/UX heuristic evaluation, error handling, user feedback mechanisms

Compatibility  
Browser compatibility matrix, script manager interoperability, conflict
detection

Functionality  
Behavior verification, regression testing, feature completeness

Dependability  
Reliability metrics, error rates, recovery capabilities

### 3. The Community Platform

A collaborative ecosystem featuring:

- **Trust Scoring**: Aggregate reputation based on analysis results and
  community feedback

- **Behavioral Reports**: Real-world usage reports from the community

- **Discussion Forums**: Script-specific discussions, bug reports,
  feature requests

- **Maintainer Verification**: Identity verification for script authors

- **Endorsement Network**: Web of trust between verified maintainers

### 4. The Browser Integration

A meta-script/extension that:

- Integrates with Tampermonkey, Violentmonkey, Greasemonkey, and AdGuard

- Provides real-time trust indicators before script installation

- Enables automatic updates from the verified registry

- Reports behavioral anomalies back to the community

### 5. The Developer Toolkit

Tools for script developers including:

- **ADE (Application Development Environment)**: Purpose-built IDE
  integration

- **Template Library**: Best-practice templates with security by default

- **Linting & Validation**: Pre-publish quality gates

- **Documentation Generator**: AI-assisted documentation creation

- **Testing Framework**: Automated testing infrastructure

## Supported Script Types

Checky Monkey supports validation and registry for:

| Type | Sources | Managers |
|----|----|----|
| **Userscripts** | Greasy Fork, OpenUserJS, GitHub, GitLab, Codeberg, standalone | Tampermonkey, Violentmonkey, Greasemonkey, Userscripts (Safari), FireMonkey |
| **Userstyles** | UserStyles.world, UserStyles.org (archived), GitHub | Stylus, Stylish, xStyle |
| **User CSS** | Custom CSS files, GitHub repositories | Browser DevTools, Stylus, custom injectors |
| **Content Scripts** | Browser extension components, MV3 content scripts | Browser extension APIs |
| **Bookmarklets** | Various sources, custom | Browser bookmarks, bookmarklet managers |

## Technical Philosophy

Checky Monkey is built on these technical principles:

| Principle | Implementation |
|----|----|
| **Functional First** | Core logic in Haskell for correctness, type safety, and formal verification potential |
| **Content Addressed** | CUBS database with content-addressable storage; every version permanently referenceable |
| **Decentralized by Design** | IPFS integration for censorship-resistant distribution; no single point of failure |
| **Containerized & Reproducible** | OCI containers, Nix/Guix builds, reproducible environments |
| **Open & Interoperable** | Standard APIs, integration with existing ecosystems, no vendor lock-in |
| **Privacy Preserving** | Minimal data collection, anonymous analysis options, local-first capabilities |

# Architecture

## System Overview

    ┌─────────────────────────────────────────────────────────────────────────────┐
    │                              CHECKY MONKEY                                   │
    ├─────────────────────────────────────────────────────────────────────────────┤
    │                                                                              │
    │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐ │
    │  │   Ingress   │  │   Analysis  │  │   Registry  │  │   Distribution      │ │
    │  │   Gateway   │──│   Engine    │──│   (CUBS)    │──│   (IPFS/HTTP)       │ │
    │  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────────┬──────────┘ │
    │         │                │                │                     │            │
    │         │                ▼                ▼                     │            │
    │         │         ┌─────────────────────────────┐               │            │
    │         │         │      CUBS Database          │               │            │
    │         │         │  (Content-addressed store)  │               │            │
    │         │         └─────────────────────────────┘               │            │
    │         │                                                       │            │
    │  ┌──────▼─────────────────────────────────────────────────────▼──────────┐  │
    │  │                         API Layer (GraphQL + REST)                     │  │
    │  └────────────────────────────────────────────────────────────────────────┘  │
    │                                                                              │
    └──────────────────────────────────┬───────────────────────────────────────────┘
                                       │
            ┌──────────────────────────┼──────────────────────────┐
            ▼                          ▼                          ▼
    ┌───────────────┐          ┌───────────────┐          ┌───────────────┐
    │  Web Frontend │          │ Browser Ext.  │          │   CLI Tools   │
    │  (Community)  │          │ (Validators)  │          │  (Developers) │
    └───────────────┘          └───────────────┘          └───────────────┘

## Core Components

### Ingress Gateway

The ingress layer handles script acquisition from multiple sources:

```haskell
-- Conceptual type signatures for the ingress system
data ScriptSource
  = GreasyFork URL
  | OpenUserJS URL
  | GitRepository GitURL Branch
  | DirectUpload ByteString
  | IPFSHash CID
  deriving (Show, Eq, Generic)

data IngestedScript = IngestedScript
  { sourceLocation :: ScriptSource
  , rawContent     :: ByteString
  , metadata       :: ScriptMetadata
  , fetchTime      :: UTCTime
  , contentHash    :: ContentHash
  }
```

**Capabilities:**

- Fetches scripts from configured sources (Greasy Fork API, OpenUserJS
  API, Git repositories)

- Normalizes script metadata across different formats

- Computes content hashes for deduplication and versioning

- Queues scripts for analysis pipeline

- Handles rate limiting and source-specific authentication

### Analysis Engine

The heart of Checky Monkey—a comprehensive validation pipeline:

                        ┌─────────────────────────────────┐
                        │         Raw Script              │
                        └───────────────┬─────────────────┘
                                        │
                        ┌───────────────▼─────────────────┐
                        │         Parse & Extract         │
                        │  (AST, Metadata, Dependencies)  │
                        └───────────────┬─────────────────┘
                                        │
            ┌───────────────────────────┼───────────────────────────┐
            ▼                           ▼                           ▼
    ┌───────────────┐           ┌───────────────┐           ┌───────────────┐
    │   Security    │           │  Performance  │           │ Accessibility │
    │   Analyzer    │           │   Profiler    │           │   Checker     │
    └───────┬───────┘           └───────┬───────┘           └───────┬───────┘
            │                           │                           │
            ▼                           ▼                           ▼
    ┌───────────────┐           ┌───────────────┐           ┌───────────────┐
    │   Privacy     │           │  Usability    │           │ Compatibility │
    │   Auditor     │           │   Evaluator   │           │   Matrix      │
    └───────┬───────┘           └───────┬───────┘           └───────┬───────┘
            │                           │                           │
            └───────────────────────────┼───────────────────────────┘
                                        ▼
                        ┌───────────────────────────────┐
                        │      Composite Score &        │
                        │      Detailed Report          │
                        └───────────────────────────────┘

**Analysis Dimensions:**

| Dimension | Weight | Checks Performed |
|----|----|----|
| **Security** | Critical | Static analysis for XSS, injection, eval usage, dangerous APIs, obfuscation detection, known malware signatures, permission escalation, CSP violations |
| **Privacy** | Critical | Third-party requests, tracking pixel detection, cookie manipulation, local storage access patterns, fingerprinting techniques, data exfiltration indicators |
| **Performance** | High | DOM query efficiency, mutation observer usage, memory leak detection, network request patterns, animation frame usage, blocking operation detection |
| **Accessibility** | High | ARIA attribute usage, focus management, color contrast impacts, screen reader compatibility, keyboard navigation, motion sensitivity |
| **Usability** | Medium | Error handling, user feedback mechanisms, undo capabilities, settings persistence, documentation quality, i18n support |
| **Compatibility** | Medium | Browser version support, script manager compatibility, @match pattern analysis, conflict detection, CSP compatibility |
| **Functionality** | Medium | Behavior verification against declared purpose, regression detection, feature completeness assessment |
| **Dependability** | Medium | Error recovery, graceful degradation, offline handling, update mechanism safety |

### CUBS Database

**C**ontent-addressed **U**niversal **B**inary **S**tore—the persistence
layer:

```haskell
-- CUBS provides content-addressed storage with versioning
data CUBSEntry = CUBSEntry
  { contentId    :: ContentHash      -- SHA-256 of content
  , content      :: ByteString       -- The actual script content
  , metadata     :: ScriptMetadata   -- Parsed metadata
  , analysis     :: AnalysisReport   -- Validation results
  , provenance   :: ProvenanceChain  -- Origin and modification history
  , references   :: [ContentHash]    -- Dependencies and related scripts
  , timestamp    :: UTCTime          -- When added to CUBS
  }

-- Provenance tracks the complete history
data ProvenanceChain = ProvenanceChain
  { originalSource :: ScriptSource
  , modifications  :: [Modification]
  , signatures     :: [CryptographicSignature]
  , attestations   :: [CommunityAttestation]
  }
```

**Features:**

- **Content Addressing**: Every script version has a unique, permanent
  identifier

- **Immutable History**: Complete modification history preserved

- **Cryptographic Integrity**: Optional signing by maintainers and
  validators

- **Efficient Storage**: Deduplication across similar scripts

- **IPFS Ready**: Native CID generation for IPFS pinning

### Distribution Layer

Multi-protocol distribution for maximum availability:

- **HTTP/HTTPS**: Traditional CDN-backed delivery

- **IPFS**: Decentralized, content-addressed distribution

- **Git**: Clone-able repositories for developers

- **API**: Programmatic access via GraphQL and REST

## Technology Stack

| Layer | Technology | Rationale |
|----|----|----|
| **Core Logic** | Haskell (GHC 9.6+) | Type safety, correctness guarantees, excellent for parsing and analysis |
| **Analysis Plugins** | Haskell + Lua (for extensibility) | Core analyzers in Haskell; community plugins in sandboxed Lua |
| **Database** | Custom CUBS (on PostgreSQL + content store) | Content-addressed with relational metadata; proven, scalable foundation |
| **API** | Servant (Haskell) + GraphQL | Type-safe API definitions; flexible querying |
| **Web Frontend** | Future: ReScript + React | Type-safe frontend; compiles to efficient JS |
| **Browser Extension** | TypeScript (transitioning to ReScript) | Browser compatibility; gradual migration path |
| **Containerization** | OCI (Docker/Podman) + Nix | Reproducible builds; deterministic deployments |
| **IPFS Integration** | Kubo (go-ipfs) + Haskell bindings | Mature IPFS implementation; native Haskell access |
| **CI/CD** | GitHub Actions + self-hosted runners | Community accessible; reproducible with Nix |

## Data Model

### Script Representation

```haskell
-- Core script representation
data Script = Script
  { scriptId        :: ScriptId           -- Unique identifier
  , contentHash     :: ContentHash        -- Content-addressed hash
  , scriptType      :: ScriptType         -- Userscript, Userstyle, etc.
  , metadata        :: ScriptMetadata     -- Parsed headers
  , content         :: ScriptContent      -- The actual code
  , versions        :: NonEmpty Version   -- Version history
  , analysisReports :: [AnalysisReport]   -- Validation results
  , communityData   :: CommunityData      -- Ratings, reports, etc.
  }

-- Metadata extracted from script headers
data ScriptMetadata = ScriptMetadata
  { name            :: Text
  , namespace       :: Maybe Text
  , version         :: SemVer
  , description     :: Maybe Text
  , author          :: Maybe Author
  , license         :: Maybe SPDX
  , homepageURL     :: Maybe URL
  , supportURL      :: Maybe URL
  , updateURL       :: Maybe URL
  , downloadURL     :: Maybe URL
  , includes        :: [MatchPattern]
  , excludes        :: [MatchPattern]
  , matches         :: [MatchPattern]
  , grants          :: [GrantPermission]
  , requires        :: [RequireURL]
  , resources       :: [(Text, URL)]
  , runAt           :: RunAt
  , noframes        :: Bool
  , unwrap          :: Bool
  , sandbox         :: Maybe SandboxMode
  }

-- Grant permissions analyzed for security implications
data GrantPermission
  = GMNone
  | GMUnsafeWindow
  | GMGetValue | GMSetValue | GMDeleteValue | GMListValues
  | GMGetResourceText | GMGetResourceURL
  | GMAddStyle
  | GMLog
  | GMOpenInTab
  | GMRegisterMenuCommand | GMUnregisterMenuCommand
  | GMNotification
  | GMSetClipboard
  | GMXmlHttpRequest
  | GMDownload
  | GMGetTab | GMSaveTab
  | GMWebRequest
  | GrantUnknown Text
  deriving (Show, Eq, Generic)
```

### Analysis Report

```haskell
data AnalysisReport = AnalysisReport
  { reportId         :: ReportId
  , scriptHash       :: ContentHash
  , analysisVersion  :: SemVer
  , timestamp        :: UTCTime
  , overallScore     :: TrustScore
  , dimensions       :: DimensionScores
  , findings         :: [Finding]
  , recommendations  :: [Recommendation]
  , certifications   :: [Certification]
  }

data DimensionScores = DimensionScores
  { security       :: DimensionScore
  , privacy        :: DimensionScore
  , performance    :: DimensionScore
  , accessibility  :: DimensionScore
  , usability      :: DimensionScore
  , compatibility  :: DimensionScore
  , functionality  :: DimensionScore
  , dependability  :: DimensionScore
  }

data DimensionScore = DimensionScore
  { score          :: Score            -- 0-100
  , confidence     :: Confidence       -- How certain we are
  , findings       :: [Finding]        -- Issues found
  , details        :: AnalysisDetails  -- Dimension-specific data
  }

data Finding = Finding
  { severity       :: Severity         -- Critical, High, Medium, Low, Info
  , category       :: FindingCategory
  , title          :: Text
  , description    :: Text
  , location       :: Maybe CodeLocation
  , remediation    :: Maybe Text
  , references     :: [URL]
  , cweId          :: Maybe CWE
  }
```

# Features

## Current Features (v0.1.x)

> [!NOTE]
> Checky Monkey is in early development. Current features are
> foundational.

- [x] Project scaffolding and infrastructure

- [x] CI/CD pipeline with quality gates

- [x] Dual licensing (PMPL-1.0 OR MPL-2.0)

- [x] Basic documentation structure

- [x] Community health files (CODE_OF_CONDUCT, CONTRIBUTING, SECURITY)

## Planned Features

See <a href="ROADMAP.adoc" class="adoc">ROADMAP</a> for detailed
timelines and milestones.

### Phase 1: Foundation

- [ ] Userscript metadata parser (Greasemonkey/Tampermonkey format)

- [ ] Userstyle parser (Stylus format)

- [ ] Basic static analysis engine

- [ ] CUBS database schema and implementation

- [ ] CLI for local script validation

### Phase 2: Analysis Engine

- [ ] Security analyzer (XSS, injection, dangerous APIs)

- [ ] Privacy auditor (trackers, data exfiltration)

- [ ] Performance profiler (DOM efficiency, resource usage)

- [ ] Accessibility checker (WCAG compliance)

- [ ] Compatibility matrix generator

### Phase 3: Registry & Distribution

- [ ] Git-based script registry

- [ ] IPFS integration for decentralized distribution

- [ ] API (GraphQL + REST) for script queries

- [ ] Integration with Greasy Fork and OpenUserJS

- [ ] awesome-userscripts synchronization

### Phase 4: Community Platform

- [ ] Web frontend for browsing and searching

- [ ] User accounts and script claiming

- [ ] Rating and review system

- [ ] Behavioral reports submission

- [ ] Discussion forums per script

### Phase 5: Browser Integration

- [ ] Checky Monkey browser extension

- [ ] Tampermonkey integration

- [ ] Violentmonkey integration

- [ ] AdGuard integration

- [ ] Real-time trust indicators

### Phase 6: Developer Tools

- [ ] ADE (Application Development Environment)

- [ ] Best-practice template library

- [ ] Pre-publish validation hooks

- [ ] Documentation generator

- [ ] Testing framework

### Phase 7: AI Enhancement

- [ ] SLM-powered documentation generation

- [ ] Script improvement suggestions

- [ ] ReScript transpilation assistance

- [ ] Automated vulnerability remediation

# Installation

## Prerequisites

| Requirement   | Version  | Notes                                    |
|---------------|----------|------------------------------------------|
| GHC           | \>= 9.6  | Glasgow Haskell Compiler                 |
| Cabal         | \>= 3.10 | Or Stack \>= 2.13                        |
| PostgreSQL    | \>= 15   | For CUBS metadata storage                |
| IPFS (Kubo)   | \>= 0.24 | Optional, for decentralized distribution |
| Nix           | \>= 2.18 | Optional, for reproducible builds        |
| Docker/Podman | Latest   | Optional, for containerized deployment   |

## From Source (Cabal)

```bash
# Clone the repository
git clone https://github.com/hyperpolymath/checky-monkey.git
cd checky-monkey

# Build with Cabal
cabal update
cabal build all

# Run tests
cabal test all

# Install
cabal install
```

## From Source (Nix)

```bash
# Clone the repository
git clone https://github.com/hyperpolymath/checky-monkey.git
cd checky-monkey

# Build with Nix
nix build

# Enter development shell
nix develop

# Run
nix run
```

## Container Deployment

```bash
# Pull the image
podman pull ghcr.io/hyperpolymath/checky-monkey:latest

# Run with Docker Compose (or Podman Compose)
podman-compose up -d

# Or run standalone
podman run -d \
  --name checky-monkey \
  -p 8080:8080 \
  -v checky-data:/var/lib/checky-monkey \
  ghcr.io/hyperpolymath/checky-monkey:latest
```

## Development Setup

```bash
# Clone the repository
git clone https://github.com/hyperpolymath/checky-monkey.git
cd checky-monkey

# Install development dependencies (using Nix)
nix develop

# Or manually install prerequisites
# See Prerequisites section above

# Set up the development database
just db-setup

# Run in development mode
just dev

# Run tests
just test

# Format and lint
just fmt
just lint
```

# Usage

## CLI Interface

```bash
# Validate a local script
checky-monkey validate script.user.js

# Validate from URL
checky-monkey validate https://example.com/script.user.js

# Validate with specific checks
checky-monkey validate script.user.js --checks security,privacy,accessibility

# Generate detailed report
checky-monkey validate script.user.js --format json --output report.json

# Submit to registry
checky-monkey submit script.user.js

# Search the registry
checky-monkey search "dark mode"

# Get script info
checky-monkey info script-id

# Fetch from IPFS
checky-monkey fetch ipfs://QmXyz...
```

## API Examples

### GraphQL Query

```graphql
query GetScript($id: ID!) {
  script(id: $id) {
    id
    name
    version
    description
    author {
      name
      verified
    }
    analysisReport {
      overallScore
      security {
        score
        findings {
          severity
          title
          description
        }
      }
      privacy {
        score
      }
      accessibility {
        score
      }
    }
    communityRating
    installCount
  }
}
```

### REST API

```bash
# Get script by ID
curl https://api.checkymonkey.org/v1/scripts/abc123

# Search scripts
curl "https://api.checkymonkey.org/v1/scripts?q=dark+mode&sort=rating"

# Get analysis report
curl https://api.checkymonkey.org/v1/scripts/abc123/analysis

# Submit script for analysis
curl -X POST https://api.checkymonkey.org/v1/analyze \
  -H "Content-Type: application/javascript" \
  --data-binary @script.user.js
```

## Browser Extension

Once installed, the Checky Monkey extension:

1.  **Intercepts Installations**: When you click "Install" on Greasy
    Fork or similar, Checky Monkey checks the script first

2.  **Shows Trust Indicators**: Color-coded badges showing script
    trustworthiness

3.  **Provides Details on Demand**: Click for full analysis breakdown

4.  **Reports Anomalies**: Automatically reports suspicious behavior
    back to the community

# Integration

## awesome-userscripts Integration

Checky Monkey maintains bidirectional synchronization with
[awesome-userscripts](https://github.com/awesome-scripts/awesome-userscripts):

- Scripts listed in awesome-userscripts are automatically indexed and
  analyzed

- High-quality scripts validated by Checky Monkey can be nominated for
  inclusion

- Validation status is reflected in awesome-userscripts via badges

## Scaffoldia Foundation

Checky Monkey serves as the validation backbone for
[Scaffoldia](https://github.com/hyperpolymath/scaffoldia), providing:

- Trusted script registry for Scaffoldia’s script recommendations

- Validation APIs for Scaffoldia’s quality gates

- Shared identity and reputation systems

## Script Manager Integration

| Manager | Integration Level | Capabilities |
|----|----|----|
| **Tampermonkey** | Deep | Pre-install validation, trust badges, auto-update verification |
| **Violentmonkey** | Deep | Pre-install validation, trust badges, behavioral monitoring |
| **Greasemonkey** | Moderate | Pre-install validation, trust badges |
| **AdGuard** | Moderate | Filter list validation, trust verification |
| **Stylus** | Basic | Style validation, security checks |
| **Userscripts (Safari)** | Basic | Pre-install validation |

# Contributing

We welcome contributions! Please see
<a href="CONTRIBUTING.md" class="md">CONTRIBUTING</a> for guidelines.

## Development Philosophy

- **Test First**: All new features require tests

- **Type Safe**: Leverage Haskell’s type system; if it compiles, it
  should work

- **Document Thoroughly**: Code should be self-documenting; complex
  logic needs comments

- **Security Conscious**: Security-sensitive code requires review by
  maintainers

- **Accessible by Default**: All UI must meet WCAG 2.1 AA

## Getting Started

```bash
# Fork and clone
git clone https://github.com/YOUR-USERNAME/checky-monkey.git
cd checky-monkey

# Create a branch
git checkout -b feature/your-feature

# Make changes, write tests

# Run tests
just test

# Format and lint
just fmt && just lint

# Commit and push
git commit -m "feat: add your feature"
git push origin feature/your-feature

# Open a Pull Request
```

## Contributor Covenant

This project adheres to the [Contributor Covenant Code of
Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this
code.

# Security

## Reporting Vulnerabilities

Please see <a href="SECURITY.md" class="md">SECURITY</a> for our
security policy and how to report vulnerabilities responsibly.

## Security Principles

- **Defense in Depth**: Multiple layers of validation and sandboxing

- **Minimal Privilege**: Analyzers run with minimal permissions

- **Transparency**: Analysis methodology is open and auditable

- **No Trust Assumption**: Every script is treated as potentially
  malicious

# Governance

## Decision Making

- **Technical Decisions**: Consensus among core maintainers; RFCs for
  significant changes

- **Community Decisions**: Open discussion; major changes require
  community input

- **Security Decisions**: Handled privately by security team; disclosed
  after mitigation

## Core Team

- **Hyper Polymath** (@hyperpolymath) - Project Lead

## Acknowledgments

- The Greasy Fork and OpenUserJS communities

- Contributors to awesome-userscripts

- The Tampermonkey, Violentmonkey, and Greasemonkey projects

- The Haskell community

# License

This project is dual-licensed:

- **Palimpsest-MPL License v1.0 (PMPL-1.0)** - For maximum flexibility

- **MPL-2.0** - For copyleft protection (especially for SaaS
  deployments)

You may choose either license. See
<a href="LICENSE.txt" class="txt">LICENSE</a> for full details.

## Palimpsest Principles

This project encourages (but does not legally require) adherence to the
[Palimpsest
License](https://github.com/hyperpolymath/palimpsest-license)
principles—a framework for consent-based digital interaction.

# Related Projects

- [Scaffoldia](https://github.com/hyperpolymath/scaffoldia) - Project
  scaffolding and templates

- [awesome-userscripts](https://github.com/awesome-scripts/awesome-userscripts) -
  Curated userscript list

- <https://www.greasy> fork.org\[Greasy Fork\] - Userscript hosting
  platform

- [OpenUserJS](https://openuserjs.org) - Open source userscript hosting

- [Tampermonkey](https://www.tampermonkey.net) - Popular userscript
  manager

- [Violentmonkey](https://violentmonkey.github.io) - Open source
  userscript manager

# Appendices

## Appendix A: Glossary

Userscript  
A script that modifies web pages, typically managed by browser
extensions like Tampermonkey

Userstyle  
A CSS stylesheet that modifies web page appearance, typically managed by
Stylus

Content Script  
A script that runs in the context of web pages, part of browser
extensions

CUBS  
Content-addressed Universal Binary Store, Checky Monkey’s database
system

CID  
Content Identifier, used by IPFS for content addressing

Trust Score  
A composite metric representing overall script trustworthiness

Grant Permission  
Special permissions requested by userscripts (e.g., cross-origin
requests)

Provenance  
The origin and history of a script, including all modifications

## Appendix B: Comparison with Alternatives

| Feature               | Checky Monkey | VirusTotal     | Greasy Fork | OpenUserJS |
|-----------------------|---------------|----------------|-------------|------------|
| **Userscript Focus**  | Primary       | None           | Primary     | Primary    |
| **Security Analysis** | Deep          | Deep (general) | Basic       | Basic      |
| **Privacy Analysis**  | Yes           | Limited        | No          | No         |
| **Accessibility**     | Yes           | No             | No          | No         |
| **Decentralized**     | Yes (IPFS)    | No             | No          | No         |
| **Community Intel**   | Yes           | Yes            | Yes         | Yes        |
| **API Access**        | Yes           | Yes            | Limited     | Yes        |
| **Open Source**       | Yes           | No             | Partial     | Yes        |

## Appendix C: File Format Support

| Extension     | Type                                 | Parser Status |
|---------------|--------------------------------------|---------------|
| `.user.js`    | Tampermonkey/Greasemonkey userscript | Planned       |
| `.user.css`   | Stylus userstyle                     | Planned       |
| `.user.styl`  | Stylus (with preprocessor)           | Planned       |
| `.user.less`  | LESS userstyle                       | Future        |
| `.user.scss`  | SCSS userstyle                       | Future        |
| `.json` (MV3) | Browser extension manifest           | Future        |

## Appendix D: Trust Score Calculation

The overall Trust Score is calculated as a weighted average:

    TrustScore = Σ(DimensionScore × Weight) / Σ(Weight)

    Where:
      Security:      Weight = 3.0  (Critical)
      Privacy:       Weight = 3.0  (Critical)
      Performance:   Weight = 2.0  (High)
      Accessibility: Weight = 2.0  (High)
      Usability:     Weight = 1.5  (Medium)
      Compatibility: Weight = 1.5  (Medium)
      Functionality: Weight = 1.5  (Medium)
      Dependability: Weight = 1.5  (Medium)

    Community feedback adjusts the final score by up to ±10%

# See Also

- <a href="ROADMAP.adoc" class="adoc">ROADMAP</a> - Development roadmap
  and milestones

- <a href="CONTRIBUTING.md" class="md">CONTRIBUTING</a> - Contribution
  guidelines

- <a href="CODE_OF_CONDUCT.md" class="md">CODE_OF_CONDUCT</a> -
  Community standards

- <a href="SECURITY.md" class="md">SECURITY</a> - Security policy

- <a href="docs/CITATIONS.adoc" class="adoc">CITATIONS</a> - How to cite
  this project

- <a href="docs/ARCHITECTURE.adoc" class="adoc">ARCHITECTURE</a> -
  Detailed architecture documentation (coming soon)

- <a href="docs/API.adoc" class="adoc">API</a> - API documentation
  (coming soon)

------------------------------------------------------------------------

<div class="text-center" wrapper="1">

**Built with care by [Hyper Polymath](https://github.com/hyperpolymath)
and contributors**

</div>

<div class="text-center" wrapper="1">

*"Trust, but verify. Then verify again."*

</div>

# Architecture

See <a href="TOPOLOGY.md" class="md">TOPOLOGY</a> for a visual
architecture map and completion dashboard.
