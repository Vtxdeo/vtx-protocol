# VTX Protocol Definitions

**The Single Source of Truth (SSOT) for the VTX Plugin Interface.**

This repository hosts the official WIT (WebAssembly Interface Type) definitions used by the VTX Host and all SDKs. It automatically publishes bindings/wrappers to multiple language ecosystems.

## Repository Structure

* `wit/` - The core definition files. **All changes start here.**
* `packages/` - Distribution wrappers for package managers.
    * `rust/` -> [Crates.io: vtx-protocol](https://crates.io/crates/vtx-protocol)
    * `npm/` -> [NPM: @vtx/protocol](https://www.npmjs.com/package/@vtx/protocol)
    * `python/` -> [PyPI: vtx-protocol](https://pypi.org/project/vtx-protocol/)

## Development Workflow

We use a `Makefile` to simplify verification across languages.

1. **Verify Syntax**:
   ```bash
   make verify-wit

```

2. **Test Bindings Compatibility**:
```bash
make verify-bindings

```


3. **Bump Version & Release**:
   Trigger the **"Prepare Release"** workflow in GitHub Actions.
* Do not manually edit `package.json` or `Cargo.toml` versions.
* The CI will synchronize versions across all packages and the WIT file.



## Contributing

1. Modify `wit/vtx.wit`.
2. Run `make check` to ensure compatibility.
3. Submit a Pull Request.

## License

Apache-2.0