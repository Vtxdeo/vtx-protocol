pub const WIT_CONTENT: &str = include_str!("../wit/vtx.wit");

pub fn get_wit_path() -> std::path::PathBuf {
    std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("wit")
        .join("vtx.wit")
}