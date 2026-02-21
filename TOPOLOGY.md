<!-- SPDX-License-Identifier: PMPL-1.0-or-later -->
<!-- TOPOLOGY.md — Project architecture map and completion dashboard -->
<!-- Last updated: 2026-02-19 -->

# Checky Monkey — Project Topology

## System Architecture

```
                        ┌─────────────────────────────────────────┐
                        │              USERS / CLIENTS            │
                        │      (Browser Ext, CLI, Web HUD)        │
                        └───────────────────┬─────────────────────┘
                                            │
                                            ▼
                        ┌─────────────────────────────────────────┐
                        │           INTERFACE LAYER               │
                        │  ┌───────────┐  ┌───────────────────┐  │
                        │  │  Web      │  │  API Gateway      │  │
                        │  │  Frontend │  │ (GraphQL/REST)    │  │
                        │  └─────┬─────┘  └────────┬──────────┘  │
                        └────────│─────────────────│──────────────┘
                                 │                 │
                                 ▼                 ▼
                        ┌─────────────────────────────────────────┐
                        │           CORE LOGIC (HASKELL)          │
                        │                                         │
                        │  ┌───────────┐  ┌───────────────────┐  │
                        │  │ Analysis  │  │  Ingress          │  │
                        │  │ Engine    │  │  Gateway          │  │
                        │  └─────┬─────┘  └────────┬──────────┘  │
                        │        │                 │              │
                        │  ┌─────▼─────┐  ┌────────▼──────────┐  │
                        │  │ CUBS      │  │  Distribution     │  │
                        │  │ Logic     │  │  (IPFS/HTTP)      │  │
                        │  └─────┬─────┘  └────────┬──────────┘  │
                        └────────│─────────────────│──────────────┘
                                 │                 │
                                 ▼                 ▼
                        ┌─────────────────────────────────────────┐
                        │             DATA LAYER                  │
                        │  ┌───────────┐  ┌───────────────────┐  │
                        │  │ CUBS DB   │  │    PostgreSQL     │  │
                        │  │ (Content) │  │    (Metadata)     │  │
                        │  └───────────┘  └───────────────────┘  │
                        └─────────────────────────────────────────┘

                        ┌─────────────────────────────────────────┐
                        │          REPO INFRASTRUCTURE            │
                        │  Nix / flake.nix    .machine_readable/  │
                        │  Justfile           Tri-Perimeter CF    │
                        └─────────────────────────────────────────┘
```

## Completion Dashboard

```
COMPONENT                          STATUS              NOTES
─────────────────────────────────  ──────────────────  ─────────────────────────────────
CORE ENGINE (HASKELL)
  Ingress Gateway                   ████░░░░░░  40%    Greasy Fork/Git scrapers pending
  Analysis Engine                   ██████░░░░  60%    Static analyzer scaffolding
  CUBS Logic                        ████████░░  80%    Content hashing stable
  Distribution (IPFS)               ████░░░░░░  40%    Kubo integration active

INTERFACES & DB
  API Gateway (Servant)             ██████████ 100%    GraphQL/REST types stable
  Web Frontend (ReScript)           ██░░░░░░░░  20%    UI components prototyping
  PostgreSQL Schema                 ██████████ 100%    Relational metadata verified

REPO INFRASTRUCTURE
  Nix Development Env               ██████████ 100%    Reproducible builds verified
  Justfile                          ██████████ 100%    Build/Test automation
  .machine_readable/                ██████████ 100%    STATE.a2ml tracking

─────────────────────────────────────────────────────────────────────────────
OVERALL:                            █████░░░░░  ~50%   Core pipeline functional, UI pending
```

## Key Dependencies

```
Ingress ──────► Analysis Engine ──────► CUBS Store ──────► Distribution
                     │                     │                  │
                     ▼                     ▼                  ▼
               Metadata Sync ─────────► API Layer ────────► Clients
```

## Update Protocol

This file is maintained by both humans and AI agents. When updating:

1. **After completing a component**: Change its bar and percentage
2. **After adding a component**: Add a new row in the appropriate section
3. **After architectural changes**: Update the ASCII diagram
4. **Date**: Update the `Last updated` comment at the top of this file

Progress bars use: `█` (filled) and `░` (empty), 10 characters wide.
Percentages: 0%, 10%, 20%, ... 100% (in 10% increments).
