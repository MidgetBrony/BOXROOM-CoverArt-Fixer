```powershell
# BOXROOM Missing Cover Repair
# Copies Steam's library_600x900.jpg to BOXROOM's boxart.jpg
# ONLY if boxart.jpg does not already exist

$steamCache = "${env:ProgramFiles(x86)}\Steam\appcache\librarycache"
$boxroomCache = "$env:USERPROFILE\AppData\LocalLow\NestedLoop\BOXROOM\steam_cache_v2"

$copied = 0
$skipped = 0
$missing = 0

Get-ChildItem $boxroomCache -Directory | ForEach-Object {

    $appId = $_.Name
    $boxArt = Join-Path $_.FullName "boxart.jpg"

    # Leave existing artwork alone
    if (Test-Path $boxArt) {
        $skipped++
        return
    }

    $steamFolder = Join-Path $steamCache $appId

    if (!(Test-Path $steamFolder)) {
        $missing++
        return
    }

    # Find library_600x900.jpg anywhere inside Steam's cache folder
    $cover = Get-ChildItem `
        -Path $steamFolder `
        -Recurse `
        -Filter "library_600x900.jpg" `
        -ErrorAction SilentlyContinue |
        Select-Object -First 1

    if ($cover) {
        Copy-Item $cover.FullName $boxArt

        Write-Host "[COPIED] $appId"
        $copied++
    }
    else {
        Write-Host "[NO COVER] $appId"
        $missing++
    }
}

Write-Host ""
Write-Host "========== SUMMARY =========="
Write-Host "Copied : $copied"
Write-Host "Skipped: $skipped"
Write-Host "Missing: $missing"
Write-Host "============================="
```
