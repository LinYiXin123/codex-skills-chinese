$ErrorActionPreference = "Stop"

$sourceDir = Split-Path -Parent $PSCommandPath
$targetDir = Join-Path $HOME ".codex\\tools\\skill-chinese"

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $targetDir "logs") | Out-Null

$files = @(
    "sync_skill_chinese.py",
    "install_skill_chinese_autorun.ps1",
    "skill_chinese_overrides.json",
    "立即同步技能中文.cmd"
)

foreach ($file in $files) {
    Copy-Item -LiteralPath (Join-Path $sourceDir $file) -Destination (Join-Path $targetDir $file) -Force
}

Write-Output "Files copied to: $targetDir"
powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $targetDir "install_skill_chinese_autorun.ps1")
