# VTX Protocol Definitions

**The Single Source of Truth (SSOT) for the VTX Plugin Interface.**

This repository hosts the official WIT (WebAssembly Interface Type) definitions used by the VTX Host and all SDKs. It serves as the central contract registry, automatically validating and distributing bindings to multiple language ecosystems.

## Repository Architecture

The project enforces a strict unidirectional data flow. All interface changes originate in the `wit/` directory and propagate to language-specific packages through automated pipelines.

* `wit/` - The core interface definitions. **All modifications must originate here.**
* `packages/` - Distribution wrappers for package managers.
    * `rust/` -> [Crates.io: vtx-protocol](https://crates.io/crates/vtx-protocol)
    * `npm/` -> [NPM: @vtxdeo/protocol](https://www.npmjs.com/package/@vtxdeo/protocol)
    * `python/` -> [PyPI: vtx-protocol](https://pypi.org/project/vtx-protocol/)

## Prerequisites

Ensure the following tools are installed in your development environment:

* **Rust**: Stable toolchain (latest)
* **Node.js**: v20.x or higher
* **Python**: v3.10 or higher
* **Wasm Tools**: For WIT validation (`wasm-tools`)
* **Wit Bindgen**: For binding generation testing (`wit-bindgen-cli`)

## Getting Started

### 1. Initialize Environment
Install all required development dependencies and tools using the Makefile:

```bash
make install-tools

```

### 2. Local Development Link

Link the local protocol packages to your global development environment. This allows you to test protocol changes against local VTX plugins or Host implementations without publishing to registries.

```bash
make link-all
# Output:
# -> NPM package linked.
# -> Python package installed in editable mode.

```

## Development Workflow

### 1. Modify Interface

Edit the `wit/vtx.wit` file to introduce new types or functions.

### 2. Verify Changes

Run the full verification suite. This command validates WIT syntax, checks binding generation compatibility for all supported languages, and verifies package structural integrity.

```bash
make check

```

### 3. Commit Guidelines

This repository enforces **Conventional Commits** to automate version management and changelog generation.

**Format**: `<type>(<scope>): <description>`

* `feat`: New interfaces or features (Triggers MINOR version bump)
* `fix`: Bug fixes in definitions (Triggers PATCH version bump)
* `chore`: Maintenance, dependency updates, or script changes
* `ci`: Changes to CI/CD pipelines
* `docs`: Documentation updates only

**Example**:

```text
feat(sql): add support for transaction isolation levels
fix(stream): correct buffer offset type definition

```

## Release Process

Releases are managed via GitHub Actions with a strict two-phase workflow to ensure atomicity across ecosystems.

### 1. Prepare Release

Trigger the **"Prepare Release"** workflow manually in GitHub Actions.

* Input: Target Version (e.g., `1.2.0`)
* Action: This workflow updates versions in `wit/vtx.wit`, `Cargo.toml`, `package.json`, and `pyproject.toml`, then pushes a new git tag.

### 2. Automated Publishing

Pushing the tag triggers the **"Release Protocol"** pipeline:

1. **Build & Verify**: Concurrently builds artifacts for Rust (.crate), NPM (.tgz), and Python (.whl).
2. **Publish**: Only if **ALL** builds pass verification, artifacts are uploaded to Crates.io, NPM Registry, and PyPI simultaneously.

**Note**: Do not manually edit version numbers in package files. Always use the automation tools to maintain synchronization.

## License

[Apache-2.0](LICENSE)