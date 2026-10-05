# Repair incomplete Cursor update, then reopen the bootcamp folder.
# The updater left the app under ...\cursor\_\ instead of ...\cursor\

$ErrorActionPreference = "Stop"

$cursorRoot = Join-Path $env:LOCALAPPDATA "Programs\cursor"
$staged = Join-Path $cursorRoot "_"
$log = Join-Path $env:TEMP "cursor-repair.log"

function Write-Log($msg) {
  $line = "{0} {1}" -f (Get-Date -Format "HH:mm:ss"), $msg
  Add-Content -Path $log -Value $line
  Write-Host $line
}

Write-Log "=== Cursor repair start ==="
Write-Log "Root: $cursorRoot"
Write-Log "Staged: $staged"

if (-not (Test-Path (Join-Path $staged "Cursor.exe"))) {
  Write-Log "ERROR: staged Cursor.exe not found. Abort."
  exit 1
}

Write-Log "Stopping Cursor processes..."
Get-Process -Name "Cursor","cursor" -ErrorAction SilentlyContinue | ForEach-Object {
  Write-Log ("Kill PID {0}" -f $_.Id)
  Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
}
Start-Sleep -Seconds 2

# Move staged files up if root Cursor.exe is missing
$rootExe = Join-Path $cursorRoot "Cursor.exe"
if (-not (Test-Path $rootExe)) {
  Write-Log "Moving staged files from _\ to install root..."
  Get-ChildItem -Force -LiteralPath $staged | ForEach-Object {
    $dest = Join-Path $cursorRoot $_.Name
    if (Test-Path -LiteralPath $dest) {
      Write-Log ("Skip existing: {0}" -f $_.Name)
    } else {
      Move-Item -LiteralPath $_.FullName -Destination $dest
      Write-Log ("Moved: {0}" -f $_.Name)
    }
  }
  # Remove empty staging dir if possible
  try {
    Remove-Item -LiteralPath $staged -Force -ErrorAction SilentlyContinue
  } catch {}
} else {
  Write-Log "Root Cursor.exe already present; no move needed."
}

if (-not (Test-Path $rootExe)) {
  Write-Log "ERROR: Cursor.exe still missing after repair."
  exit 1
}

Write-Log "Ensuring Dev Containers extension is installed..."
$cursorCmd = Join-Path $cursorRoot "resources\app\bin\cursor.cmd"
if (Test-Path $cursorCmd) {
  & $cursorCmd --install-extension anysphere.remote-containers --force | Out-String | ForEach-Object { Write-Log $_ }
}

$workspace = "C:\bootcamp-devops-lemoncode"
Write-Log "Launching Cursor on $workspace"
Start-Process -FilePath $rootExe -ArgumentList @($workspace)
Write-Log "=== Cursor repair done ==="
Write-Log "Next in Cursor: Ctrl+Shift+P -> Dev Containers: Reopen in Container"
