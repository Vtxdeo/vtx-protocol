# VTX Protocol Definitions

**The Single Source of Truth (SSOT) for the VTX Plugin Interface.**

This repository serves as the **Schema Registry** (the "Legislative Branch") for the VTX ecosystem. It hosts the official WIT (WebAssembly Interface Type) definitions and distributes them to multiple language ecosystems as raw data packages.

> **Note for Developers**: If you are looking to build a plugin, please use the **VTX SDK** for your specific language. This repository is primarily for tooling authors and protocol maintainers.

## Repository Architecture

This project enforces a strict unidirectional data flow. The core asset is the WIT definition, and the packages are merely "carriers" to distribute this file to different registries.

* `wit/` - The core interface definitions. **All modifications must originate here.**
* `packages/` - Schema carriers (containing only the `.wit` file and path helpers):
    * `rust/` -> [Crates.io: vtx-protocol](https://crates.io/crates/vtx-protocol)
    * `npm/` -> [NPM: @vtxdeo/protocol](https://www.npmjs.com/package/@vtxdeo/protocol)
    * `python/` -> [PyPI: vtx-protocol](https://pypi.org/project/vtx-protocol/)

## Prerequisites

* **Wasm Tools**: Required for validating WIT syntax (`wasm-tools`).

## Development Workflow

### 1. Initialize Environment
Install the verification tools:

```bash
make install-tools

```

### 2. Modify Interface

Edit the `wit/vtx.wit` file to introduce new types or functions.

### 3. Verify Changes

Run the syntax verification suite. This ensures the WIT file is valid before distribution.

```bash
make check

```

### 4. Commit Guidelines

We enforce **Conventional Commits** to automate version management.

* `feat`: Interface changes (Triggers MINOR version bump)
* `fix`: Typos or comment fixes in definitions (Triggers PATCH version bump)

## Release Process

Releases are fully automated via [Release Please](https://github.com/googleapis/release-please).
Merging a Release PR into `master` will automatically publish the raw WIT packages to Crates.io, NPM, and PyPI.

## License

[Apache-2.0](LICENSE)