use std::path::PathBuf;

pub const WIT_CONTENT: &str = include_str!("../wit/vtx.wit");

pub fn get_wit_path() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("..")
        .join("..")
        .join("wit")
        .join("vtx.wit")
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::fs;

    #[test]
    fn test_wit_file_path_resolution() {
        let path = get_wit_path();

        if !path.exists() {
            panic!("Critical: WIT file not found at path: {:?}", path);
        }

        assert!(path.is_file(), "Path exists but is not a file: {:?}", path);

        let content = fs::read_to_string(&path)
            .unwrap_or_else(|_| panic!("Failed to read WIT file at: {:?}", path));

        assert!(
            content.contains("package vtx:api"),
            "File content signature mismatch. Expected 'package vtx:api' header."
        );
    }

    #[test]
    fn test_embedded_content_validity() {
        assert!(!WIT_CONTENT.is_empty(), "Embedded WIT_CONTENT is empty");
        assert!(
            WIT_CONTENT.contains("package vtx:api"),
            "Embedded content signature mismatch"
        );
    }
}
