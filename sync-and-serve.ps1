# A320 Simulator — ChatGPT-driven workflow (Windows)
# Run this script from a Git CLONE of the repository, not a Download ZIP extraction.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "Install Git for Windows first: https://git-scm.com/downloads/win" }
if (-not (Test-Path ".git")) { throw "This folder is not a Git clone. Clone https://github.com/biotv333-pixel/A320-Flight-Simulator instead of using Download ZIP." }
if ((git status --porcelain)) { throw "Local changes detected. Commit or stash them before syncing to avoid overwriting work." }
git pull --ff-only
if ($LASTEXITCODE -ne 0) { throw "Git pull failed. Fix the error shown above." }
if (-not (Get-Command rojo -ErrorAction SilentlyContinue)) { throw "Rojo CLI not found. Install Rojo and ensure 'rojo' is on PATH." }
Write-Host "GitHub files updated. Starting Rojo server; leave this window open."
rojo serve default.project.json
