import os
from pathlib import Path

# 导出工具函数
def get_wit_path() -> str:
    """Returns the absolute path to vtx.wit"""
    return os.path.join(os.path.dirname(__file__), "wit", "vtx.wit")

def get_wit_content() -> str:
    """Returns the content of vtx.wit"""
    with open(get_wit_path(), 'r', encoding='utf-8') as f:
        return f.read()

try:
    from .generated import vtx
    from .generated.vtx import api
    from .generated.vtx.api import types, sql, stream_io

except ImportError:
    pass
