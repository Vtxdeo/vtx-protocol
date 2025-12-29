# @vtxdeo/protocol

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