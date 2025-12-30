use std::path::PathBuf;

pub const WIT_CONTENT: &str = include_str!("../wit/vtx.wit");

pub fn get_wit_path() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("wit")
        .join("vtx.wit")
}

#[cfg(feature = "guest")]
mod guest_bindings {

    wit_bindgen::generate!({
        inline: crate::WIT_CONTENT,
        world: "plugin",
        ownership: Borrowing {
            duplicate_if_necessary: true
        }
    });
}

#[cfg(feature = "guest")]
pub mod types {
    // 导出核心数据结构（如 HttpRequest, HttpResponse, Manifest 等）
    pub use super::guest_bindings::vtx::api::types::*;

    // 导出 SQL 接口相关的类型（如 DbValue 等）
    pub use super::guest_bindings::vtx::api::sql;

    // 导出流式 IO 相关的类型
    pub use super::guest_bindings::vtx::api::stream_io;
}

#[cfg(feature = "guest")]
pub mod exports {

    pub use super::guest_bindings::Guest;
}

#[cfg(feature = "guest")]
pub use guest_bindings::export;

#[cfg(feature = "guest")]
pub use wit_bindgen;