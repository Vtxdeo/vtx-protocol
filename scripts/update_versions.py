#!/usr/bin/env python3
import json
import sys
import re
from pathlib import Path
import tomlkit

# 定义项目根目录（基于当前脚本位置）
ROOT_DIR = Path(__file__).parent.parent.resolve()

def update_cargo_toml(version: str) -> None:
    """
    更新 Rust 项目的 Cargo.toml 版本号。
    """
    file_path = ROOT_DIR / "packages/rust/Cargo.toml"
    print(f"Updating {file_path}...")

    with open(file_path, "r", encoding="utf-8") as f:
        doc = tomlkit.parse(f.read())

    # 校验 package 表是否存在
    if "package" not in doc:
        raise ValueError(f"Invalid Cargo.toml: 'package' table not found in {file_path}")

    # 更新版本号
    doc["package"]["version"] = version

    with open(file_path, "w", encoding="utf-8") as f:
        f.write(tomlkit.dumps(doc))

def update_npm_package(version: str) -> None:
    """
    更新 NPM 项目的 package.json 版本号。

    副作用:
        - 修改 packages/npm/package.json 文件内容。
    """
    file_path = ROOT_DIR / "packages/npm/package.json"
    print(f"Updating {file_path}...")

    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    data["version"] = version

    with open(file_path, "w", encoding="utf-8") as f:
        # 使用 indent=2 保持标准 NPM 格式
        json.dump(data, f, indent=2)
        # 补全文件末尾换行符
        f.write("\n")

def update_pyproject_toml(version: str) -> None:
    """
    更新 Python 项目的 pyproject.toml 版本号。

    副作用:
        - 修改 packages/python/pyproject.toml 文件内容。
    """
    file_path = ROOT_DIR / "packages/python/pyproject.toml"
    print(f"Updating {file_path}...")

    with open(file_path, "r", encoding="utf-8") as f:
        doc = tomlkit.parse(f.read())

    if "project" not in doc:
        raise ValueError(f"Invalid pyproject.toml: 'project' table not found in {file_path}")

    doc["project"]["version"] = version

    with open(file_path, "w", encoding="utf-8") as f:
        f.write(tomlkit.dumps(doc))

def update_wit_definition(version: str) -> None:
    """
    更新 WIT 接口定义文件中的包版本声明。
    由于 WIT 尚无标准 Python 解析器，此处使用严格正则匹配。

    副作用:
        - 修改 wit/vtx.wit 文件内容。
    """
    file_path = ROOT_DIR / "wit/vtx.wit"
    print(f"Updating {file_path}...")

    content = file_path.read_text(encoding="utf-8")

    # 正则匹配说明:
    # ^package\s+       : 匹配行首的 package 关键字
    # [\w\-\:\.]+       : 匹配包名 (如 vtx:api)
    # @                 : 匹配版本分隔符
    # [\d\.]+           : 匹配旧版本号
    # ;                 : 匹配语句结束符
    pattern = re.compile(r'(^package\s+[\w\-\:\.]+@)([\d\.]+)(;)', re.MULTILINE)

    if not pattern.search(content):
        raise ValueError(f"Pattern not found in {file_path}. Is the format 'package name@version;'?")

    new_content = pattern.sub(f"\\g<1>{version}\\g<3>", content)

    file_path.write_text(new_content, encoding="utf-8")

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 scripts/update_versions.py <new_version>")
        sys.exit(1)

    new_version = sys.argv[1]

    # 简单的语义化版本校验
    if not re.match(r'^\d+\.\d+\.\d+$', new_version):
        print(f"Warning: Version '{new_version}' does not strictly match X.Y.Z format.")

    try:
        update_cargo_toml(new_version)
        update_npm_package(new_version)
        update_pyproject_toml(new_version)
        update_wit_definition(new_version)
        print(f"Successfully updated all packages to version {new_version}")
    except Exception as e:
        print(f"Error updating versions: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
