# vtx-protocol

[![Crates.io](https://img.shields.io/crates/v/vtx-protocol.svg)](https://crates.io/crates/vtx-protocol)
[![Docs](https://docs.rs/vtx-protocol/badge.svg)](https://docs.rs/vtx-protocol)

**Official WIT interface definitions for VTX Project plugins.**

This crate serves as the **Single Source of Truth (SSOT)** for the VTX plugin interface. It embeds the `vtx.wit` definition directly into your compiled binary or build process, eliminating the need to manually copy or manage `.wit` files.

## Installation

Add this to your `Cargo.toml`:

```toml
[dependencies]
vtx-protocol = "1.2.0"
wit-bindgen = "0.25.0" # Ensure compatibility with the WIT version

```

## Usage

### Using with `wit-bindgen`

Instead of pointing `wit-bindgen` to a local file path, you can use the exported `WIT_CONTENT` constant. This ensures your plugin is always built against the exact version of the protocol defined in `Cargo.toml`.

```rust
use vtx_protocol::WIT_CONTENT;

wit_bindgen::generate!({
    // Use the embedded WIT string directly
    inline: WIT_CONTENT,
    world: "plugin",
    // Optional: Configure ownership model
    ownership: Borrowing {
        duplicate_if_necessary: true
    }
});

struct MyPlugin;

export!(MyPlugin);

impl Guest for MyPlugin {
    fn handle(req: HttpRequest) -> HttpResponse {
        // Implementation...
    }
}

```

### Accessing Raw Files (Advanced)

If you need the physical path to the WIT file (e.g., for build scripts), use the helper function:

```rust
// Returns the PathBuf to the bundled vtx.wit file
let wit_path = vtx_protocol::get_wit_path();

```

## Versioning

This crate follows **Semantic Versioning**.

* `Major.Minor.Patch` corresponds strictly to the version of the `vtx:api` interface.