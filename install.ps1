# VSCode Markdown 配置安装脚本 (Windows PowerShell)
# 右键 → 使用 PowerShell 运行，或在终端中执行 .\install.ps1

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  VSCode Markdown 配置安装工具" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# ---- 检查 code 命令 ----
$codePath = Get-Command code -ErrorAction SilentlyContinue
if (-not $codePath) {
    Write-Host "[错误] 未找到 'code' 命令。" -ForegroundColor Red
    Write-Host "请先在 VSCode 中安装命令行工具："
    Write-Host "  打开 VSCode → Ctrl+Shift+P → 输入 'shell command' →"
    Write-Host "  选择 'Install 'code' command in PATH'"
    exit 1
}
Write-Host "[OK] 检测到 code 命令" -ForegroundColor Green

# ---- Step 1: 安装扩展 ----
Write-Host ""
Write-Host "--- 第 1 步：安装 Markdown 扩展 ---" -ForegroundColor Yellow

$extensions = @(
    "shd101wyy.markdown-preview-enhanced",
    "gicentre.markdown-preview-enhanced-with-litvis",
    "hediet.vscode-drawio"
)

foreach ($ext in $extensions) {
    Write-Host "  安装 $ext ... " -NoNewline
    try {
        code --install-extension $ext --force | Out-Null
        Write-Host "Done" -ForegroundColor Green
    } catch {
        Write-Host "Skip" -ForegroundColor Yellow
    }
}

# ---- Step 2: 合并设置 ----
Write-Host ""
Write-Host "--- 第 2 步：写入 Markdown 设置 ---" -ForegroundColor Yellow

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
python "$scriptDir\merge_settings.py"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  安装完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "重新打开 .md 文件即可看到效果。" -ForegroundColor Yellow
Write-Host ""
