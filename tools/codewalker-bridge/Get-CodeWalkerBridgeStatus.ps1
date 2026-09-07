$ErrorActionPreference = 'Stop'
Invoke-RestMethod -Uri 'http://127.0.0.1:5555/api/service-status' -TimeoutSec 5 | ConvertTo-Json -Depth 4