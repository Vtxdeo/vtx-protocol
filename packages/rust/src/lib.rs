use std::path::PathBuf;

/// The raw content of the WIT interface definition.
pub const WIT_CONTENT: &str = include_str!("../../../wit/vtx.wit");

/// Returns the absolute path to the bundled vtx.wit file.
///
/// Useful for build scripts or CLI tools that need to reference the protocol definition.
pub fn get_wit_path() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("..")
        .join("..")
        .join("wit")
        .join("vtx.wit")
}
