# @vtxdeo/protocol

[![npm version](https://img.shields.io/npm/v/@vtx/protocol.svg)](https://www.npmjs.com/package/@vtx/protocol)

**The Official SDK and Build Toolchain for VTX Plugins.**

This package provides the core WIT definitions, TypeScript types, and a CLI tool to compile your JavaScript code into VTX-compatible WebAssembly components.

## Installation

```bash
npm install @vtx/protocol --save

```

## Usage

### 1. Writing a Plugin (TypeScript/JavaScript)

Imports are fully typed based on the protocol definition.

```javascript
import { api } from '@vtx/protocol';

export const handle = (req) => {
  return {
    status: 200,
    body: null
  };
};

```

### 2. Building the Plugin

You don't need to manually configure `jco` or find the WIT files. Just use the built-in CLI:

```bash
# Compiles app.js -> plugin.wasm using the bundled protocol definition
npx vtx-protocol build app.js -o my-plugin.wasm

```

### 3. Advanced: Accessing Paths

If you need to integrate with other tools:

```javascript
import { witPath } from '@vtx/protocol';
console.log(witPath);

```