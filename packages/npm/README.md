# @vtxdeo/protocol

[![npm version](https://img.shields.io/npm/v/@vtxdeo/protocol.svg)](https://www.npmjs.com/package/@vtxdeo/protocol)

**Official WIT interface definitions for VTX Project.**

This package contains the raw `.wit` definitions used by the VTX ecosystem. It is intended for use by build tools, CLIs, and SDKs that need to reference the official protocol contract.

> **Note**: This package does **not** contain the CLI tool or runtime bindings.
> * To build plugins, use the **VTX CLI**.
> * To write plugins, use the **VTX SDK**.

## Installation

```bash
npm install @vtxdeo/protocol --save-dev

```

## Usage

```javascript
const { witPath, witDir } = require('@vtxdeo/protocol');

console.log(`Protocol definition is located at: ${witPath}`);
// Output: .../node_modules/@vtxdeo/protocol/wit/vtx.wit

```