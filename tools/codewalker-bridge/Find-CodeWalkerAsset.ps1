[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[A-Za-z0-9_.-]+$')]
    [string]$Filename
)

$ErrorActionPreference = 'Stop'
$baseUri = 'http://127.0.0.1:5555'

$status = Invoke-RestMethod -Uri "$baseUri/api/service-status" -TimeoutSec 5
if (-not $status.servicesReady) {
    throw 'CodeWalker bridge is not ready. Run Start-CodeWalkerBridge.ps1 first.'
}

$uri = "$baseUri/api/search-file?filename=$([uri]::EscapeDataString($Filename))"
$matches = Invoke-RestMethod -Uri $uri -TimeoutSec 15

[pscustomobject]@{
    filename = $Filename
    matchCount = @($matches).Count
    matches = @($matches)
} | ConvertTo-Json -Depth 5
