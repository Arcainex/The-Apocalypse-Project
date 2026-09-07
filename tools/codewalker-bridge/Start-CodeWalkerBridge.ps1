$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent | Split-Path -Parent
$runtime = Join-Path $projectRoot 'tools\.runtime\codewalker-api'
$api = Join-Path $runtime 'CodeWalker.API.exe'
$statusUrl = 'http://127.0.0.1:5555/api/service-status'

function Test-BridgeReady {
    try { return (Invoke-RestMethod -Uri $statusUrl -TimeoutSec 2) } catch { return $null }
}

$status = Test-BridgeReady
if ($null -eq $status) {
    if (-not (Test-Path -LiteralPath $api)) { throw "CodeWalker API runtime is missing: $api" }
    Start-Process -FilePath $api -WorkingDirectory $runtime -WindowStyle Hidden
    for ($attempt = 1; $attempt -le 30; $attempt++) {
        Start-Sleep -Milliseconds 500
        $status = Test-BridgeReady
        if ($null -ne $status) { break }
    }
}
if ($null -eq $status) { throw 'CodeWalker API did not become ready on localhost:5555.' }
$status | ConvertTo-Json -Depth 4