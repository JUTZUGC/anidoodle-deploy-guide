# anidoodle 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/alexgreensh/anidoodle/blob/main/README.md
# 更新日期：2026-10-28
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

node -e "const a=+process.versions.node.split('.')[0]; if(a<20){console.error('需要 Node.js 20 或更高，当前 '+process.versions.node);process.exit(1)}"
git clone https://github.com/alexgreensh/anidoodle.git
node anidoodle\engine\tools\scaffold.mjs "$HOME\anidoodle-art" --still hero --film intro --format 9x16 --duration 60
cd "$HOME\anidoodle-art"; npm install; npx playwright-core install chromium
Write-Host "安装完成：在 $HOME\anidoodle-art 运行 node tools/still.mjs hero --out out/hero.png"

Write-Host ''

Write-Host '安装完成：进入生成的艺术工程目录，运行 node tools/still.mjs hero --out out/hero.png 出图'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/alexgreensh/anidoodle/blob/main/README.md'
