# @vtx/protocol

[![npm version](https://img.shields.io/npm/v/@vtx/protocol.svg)](https://www.npmjs.com/package/@vtx/protocol)

**Official WIT interface definitions for VTX Project plugins.**

This package contains the raw `vtx.wit` definitions required to compile JavaScript/TypeScript code into VTX-compatible WebAssembly components.

## Installation

```bash
npm install @vtx/protocol --save-dev

```

## Usage

### 1. Programmatic Usage (Build Scripts)

This package exports the absolute path to the `vtx.wit` file.

```javascript
import { witPath, witDir } from '@vtx/protocol';
// or: const { witPath } = require('@vtx/protocol');

console.log(witPath);
// Output example: /Users/dev/project/node_modules/@vtx/protocol/wit/vtx.wit

```

### 2. Using with `jco` (CLI)

You can use the path directly in your CLI commands to componentize your application:

```bash
# Example: Transpile JS to Component
jco componentize app.js \
  --wit "$(node -p "require('@vtx/protocol').witPath")" \
  --world plugin \
  --out plugin.wasm

```

### 3. Using with `componentize-js` (API)

```javascript
import { componentize } from '@bytecodealliance/componentize-js';
import { witPath } from '@vtx/protocol';
import { readFile } from 'node:fs/promises';

const source = await readFile('app.js', 'utf8');

const { component } = await componentize(source, {
  witPath: witPath, // Pass the path directly
  world: 'plugin',
});

```

## Versioning

The version of this package matches the version of the `vtx:api` WIT definition.

```

---

### 3. 根目录 (`README.md`)

这是给生态维护者（你自己和贡献者）看的，解释这个仓库是做什么的。

```markdown
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
