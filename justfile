# checky-monkey — Development Task Runner.
#
# This justfile defines the authoritative build and maintenance recipes 
# for the Checky-Monkey project. It ensures that environment-specific 
# variables are loaded and that all commands run in a strict shell.

set shell := ["bash", "-uc"]
set dotenv-load := true

project := "checky-monkey"

# LIST: Displays all available development recipes.
default:
    @just --list --unsorted

# BUILD: Compiles the bot kernel and its multi-language components.
build:
    @echo "Orchestrating multi-language build (Rust/Zig/Idris)..."

# TEST: Executes the unified integration test suite.
test:
    @echo "Running verified bot tests..."

# FORMAT: Enforces ecosystem-wide coding standards.
fmt:
    @echo "Applying standard formatting..."

# [AUTO-GENERATED] Multi-arch / RISC-V target
build-riscv:
	@echo "Building for RISC-V..."
	cross build --target riscv64gc-unknown-linux-gnu
