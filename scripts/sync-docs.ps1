$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$docs = Join-Path $root "docs"

if (Test-Path $docs) {
    Remove-Item -LiteralPath $docs -Recurse -Force
}

New-Item -ItemType Directory -Path $docs | Out-Null

$rootFiles = @(
    "index.md",
    "timeline.md",
    "index-by-year.md",
    "index-by-field.md"
)

foreach ($file in $rootFiles) {
    Copy-Item -LiteralPath (Join-Path $root $file) -Destination (Join-Path $docs $file)
}

Copy-Item -LiteralPath (Join-Path $root "README.md") -Destination (Join-Path $docs "gioi-thieu.md")

$rootDirs = @(
    "concepts",
    "tags",
    "assets"
)

foreach ($dir in $rootDirs) {
    Copy-Item -LiteralPath (Join-Path $root $dir) -Destination (Join-Path $docs $dir) -Recurse
}

Write-Host "Synced content to $docs"
