#!/usr/bin/env python3
"""
合并 Markdown 相关设置到 VSCode 的 settings.json 中。
不会覆盖用户已有的其他设置，仅新增/更新 Markdown 相关的键。
"""
import json
import os
import sys
from pathlib import Path

# ---- 要写入的 Markdown 设置 ----
MARKDOWN_SETTINGS = {
    "markdown-preview-enhanced.d2Theme": 302,
    "markdown-preview-enhanced.codeBlockTheme": "twilight.css",
    "hediet.vscode-drawio.resizeImages": None,
}

# ---- VSCode 用户设置路径 ----
if sys.platform == "darwin":
    SETTINGS_DIR = Path.home() / "Library/Application Support/Code/User"
elif sys.platform == "linux":
    SETTINGS_DIR = Path.home() / ".config/Code/User"
elif sys.platform == "win32":
    SETTINGS_DIR = Path(os.environ.get("APPDATA", "")) / "Code/User"
else:
    print(f"[错误] 不支持的操作系统: {sys.platform}")
    sys.exit(1)

SETTINGS_FILE = SETTINGS_DIR / "settings.json"


def main():
    # 确保目录存在
    SETTINGS_DIR.mkdir(parents=True, exist_ok=True)

    # 读取现有设置
    if SETTINGS_FILE.exists():
        try:
            with open(SETTINGS_FILE, "r", encoding="utf-8") as f:
                content = f.read().strip()
            current = json.loads(content) if content else {}
        except json.JSONDecodeError:
            print(f"[警告] settings.json 格式异常，将创建备份后重新生成")
            backup = SETTINGS_FILE.with_suffix(".json.bak")
            SETTINGS_FILE.rename(backup)
            print(f"  已备份至: {backup}")
            current = {}
    else:
        current = {}

    # 合并设置（不覆盖无关设置）
    updated_count = 0
    for key, value in MARKDOWN_SETTINGS.items():
        if key not in current or current[key] != value:
            current[key] = value
            print(f"  [写入] {key} = {value}")
            updated_count += 1
        else:
            print(f"  [跳过] {key} 已存在且值相同")

    # 写回文件（保持缩进格式）
    with open(SETTINGS_FILE, "w", encoding="utf-8") as f:
        json.dump(current, f, indent=4, ensure_ascii=False)
        f.write("\n")

    print(f"\n完成：{updated_count} 项设置已更新，共 {len(current)} 项设置")
    print(f"文件位置：{SETTINGS_FILE}")


if __name__ == "__main__":
    main()
