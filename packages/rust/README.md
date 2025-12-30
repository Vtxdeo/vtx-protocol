# vtx-protocol

[![Crates.io](https://img.shields.io/crates/v/vtx-protocol.svg)](https://crates.io/crates/vtx-protocol)
[![Docs](https://docs.rs/vtx-protocol/badge.svg)](https://docs.rs/vtx-protocol)

**Official WIT interface definitions and SDK for VTX Project plugins.**

This crate serves as the **Single Source of Capability** for the VTX plugin interface. It automatically generates the necessary bindings at compile time, allowing you to focus on implementing the logic.

## Installation

Add this to your `Cargo.toml`:

```toml
[dependencies]
vtx-protocol = "1.2.6"

```

## Usage

### Implementing a Plugin

You no longer need to manually configure `wit-bindgen`. Simply import the types and the macro provided by the protocol crate.

```rust
use vtx_protocol::types::*;
use vtx_protocol::exports::Guest;

struct MyPlugin;

// Implement the protocol trait
impl Guest for MyPlugin {
    fn handle(req: HttpRequest) -> HttpResponse {
        HttpResponse {
            status: 200,
            body: None,
        }
    }
    
    fn get_manifest() -> Manifest {
        Manifest {
            id: "my-plugin".to_string(),
            version: "1.0.0".to_string(),
            name: "My Plugin".to_string(),
            description: "A VTX plugin".to_string(),
            entrypoint: "handle".to_string(),
        }
    }

    // ... implement other required methods
}

// Register the plugin
vtx_protocol::export!(MyPlugin);

```

### Advanced: Accessing Raw WIT

If you need the raw WIT content or path (e.g., for tooling):

```rust
// Access the WIT string content directly
let content = vtx_protocol::WIT_CONTENT;

// Get the path to the bundled file
let path = vtx_protocol::get_wit_path();

```

## Versioning

This crate follows **Semantic Versioning**.

* `Major.Minor.Patch` corresponds strictly to the version of the `vtx:api` interface.