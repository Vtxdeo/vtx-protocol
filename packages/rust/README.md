# vtx-protocol

[![Crates.io](https://img.shields.io/crates/v/vtx-protocol.svg)](https://crates.io/crates/vtx-protocol)
[![Docs](https://docs.rs/vtx-protocol/badge.svg)](https://docs.rs/vtx-protocol)

**Official WIT interface definitions for VTX Project.**

This crate acts as a **Schema Carrier**. It provides the raw `.wit` file content and its filesystem path. It is primarily used by the `vtx-sdk` and `vtx-cli` to generate bindings during the build process.

> **Building a Plugin?** You probably want the high-level SDK instead: **`vtx-sdk`**.

## Installation

```toml
[dependencies]
vtx-protocol = "1.2.6"

```

## Usage

This crate does not contain generated bindings. It only provides access to the protocol definition.

```rust
// 1. Get the raw WIT content string
let content = vtx_protocol::WIT_CONTENT;

// 2. Get the absolute path to the bundled vtx.wit file
// (Useful for build.rs scripts or CLI tools)
let wit_path = vtx_protocol::get_wit_path();

```