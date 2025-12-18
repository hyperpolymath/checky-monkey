# SPDX-License-Identifier: AGPL-3.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
#
# flake.nix - Nix Flake (fallback package management)
# Primary: guix.scm | Fallback: flake.nix
# Run: nix develop
{
  description = "checky-monkey - RSR-compliant infrastructure project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "checky-monkey";
          version = "0.1.0";
          src = ./.;

          meta = with pkgs.lib; {
            description = "RSR-compliant infrastructure project";
            homepage = "https://github.com/hyperpolymath/checky-monkey";
            license = licenses.agpl3Plus;
            maintainers = [ ];
            platforms = platforms.all;
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Core tools
            git
            gnumake
            just

            # Guile Scheme (for SCM files)
            guile

            # Security tools
            trufflehog
            trivy

            # Linters
            shellcheck
            yamllint
            editorconfig-checker
          ];

          shellHook = ''
            echo "checky-monkey development environment"
            echo "Primary SCM: guix.scm"
            echo "Fallback SCM: flake.nix (this file)"
            echo ""
            echo "Available commands:"
            echo "  just --list    # Show available tasks"
            echo "  guile META.scm # Evaluate architecture decisions"
          '';
        };
      }
    );
}
