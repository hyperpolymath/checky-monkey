;; SPDX-License-Identifier: PMPL-1.0-or-later
;; STATE.scm - Project state for checky-monkey

(state
  (metadata
    (version "0.1.0")
    (schema-version "1.0")
    (created "2024-06-01")
    (updated "2025-01-17")
    (project "checky-monkey")
    (repo "hyperpolymath/checky-monkey"))

  (project-context
    (name "Checky Monkey")
    (tagline "Git forge-based registry and validation for userscripts and extensions")
    (tech-stack ("haskell" "ipfs")))

  (current-position
    (phase "alpha")
    (overall-completion 20)
    (working-features
      ("Userscript validation"
       "Registry architecture"
       "Decentralized storage"))))
