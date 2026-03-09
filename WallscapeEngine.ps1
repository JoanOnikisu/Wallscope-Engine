# Onyx Zero - Wallscape Engine (High-Fidelity WIC Edition)
Add-Type -AssemblyName PresentationCore, PresentationFramework

# 1. Path Detection (Local & OneDrive Support)
$SearchPaths = @(
    (Join-Path $env:USERPROFILE "Pictures\Wallpapers"),
    (Join-Path $env:USERPROFILE "OneDrive\Imagens\Wallpapers"),
    (Join-Path $env:USERPROFILE "OneDrive\Pictures\Wallpapers")
)
$TargetDir = $null
foreach ($P in $SearchPaths) { if (Test-Path $P) { $TargetDir = $P; break } }

if (-not $TargetDir) { 
    Write-Host " [!] Error: 'Wallpapers' folder not found in Pictures or OneDrive." -ForegroundColor Red
    pause; exit 
}

$ParentDir = (Get-Item $TargetDir).Parent.FullName
Set-Location $TargetDir
Write-Host "--- ONYX ZERO: WALLSCAPE ENGINE STARTING ---" -ForegroundColor Cyan

# 2. Rescue & Import Phase (Importing from Parent Directory)
$Incoming = Get-ChildItem -Path $ParentDir -File | Where-Object { $_.Extension -match "jpg|jpeg|webp|jfif|png" }

foreach ($file in $Incoming) {
    $tempName = "import_$( [guid]::NewGuid().ToString().Substring(0,8) ).png"
    try {
        # Using WIC Engine to bypass "Out of Memory" legacy errors
        $stream = [System.IO.File]::OpenRead($file.FullName)
        $decoder = [System.Windows.Media.Imaging.BitmapDecoder]::Create($stream, "None", "Default")
        $encoder = New-Object System.Windows.Media.Imaging.PngBitmapEncoder
        $encoder.Frames.Add($decoder.Frames[0])
        
        $output = Join-Path $TargetDir $tempName
        $saveStream = [System.IO.File]::OpenWrite($output)
        $encoder.Save($saveStream)
        
        $saveStream.Close(); $saveStream.Dispose(); $stream.Close(); $stream.Dispose()
        Remove-Item $file.FullName -Force
        Write-Host "  [+] Rescued & Imported: $($file.Name)" -ForegroundColor Green
    } catch {
        Write-Host "  [!] Critical Fail: $($file.Name) (File might be corrupted)" -ForegroundColor Red
        if ($stream) { $stream.Close() }
    }
}

# 3. Global Re-Indexing Phase (The Shuffle)
Write-Host "`n [+] Re-indexing entire gallery..." -ForegroundColor White
$AllFiles = Get-ChildItem -Path $TargetDir -File | Where-Object { $_.Extension -eq ".png" -or $_.Extension -match "jpg|jpeg|webp" }

# Step A: Temporary Names (Prevents 'File already exists' conflicts)
foreach ($f in $AllFiles) {
    $tmpName = "shuffle_$( [guid]::NewGuid().ToString().Substring(0,8) ).png"
    Rename-Item $f.FullName $tmpName -Force
}

# Step B: Final Sequence (wallpaper_1, wallpaper_2...)
$counter = 1
Get-ChildItem -Path $TargetDir -Filter "shuffle_*" | Sort-Object LastWriteTime | ForEach-Object {
    Rename-Item $_.FullName "wallpaper_$counter.png" -Force
    $counter++
}

Write-Host "`n--- MISSION ACCOMPLISHED ---" -ForegroundColor Green
Write-Host " All assets are now standardized and indexed."