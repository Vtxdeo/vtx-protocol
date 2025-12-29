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

Releases are fully automated via [Release Please](https://github.com/googleapis/release-please), strictly following **Conventional Commits**.

### 1. Automatic Release PR
When you push commits to the `master` branch, the "Release Please" workflow analyzes your commit messages:
* If it finds "fix" or "feat" commits that haven't been released, it automatically creates (or updates) a **Release PR**.
* This PR includes the calculated version bump (e.g., v1.2.6 → v1.2.7) and an auto-generated `CHANGELOG.md`.

### 2. Publish
To publish a new version:
1. Review the auto-generated **Release PR**.
2. **Merge** the PR into `master`.
3. The merge triggers the tagging process, which subsequently kicks off the **"Release Protocol"** pipeline to:
  * Build artifacts for Rust, NPM, and Python.
  * Publish to Crates.io, NPM Registry, and PyPI simultaneously.

> **Note**: Do not manually trigger workflows or edit version numbers. Just merge the Release PR.

## License

[Apache-2.0](LICENSE)