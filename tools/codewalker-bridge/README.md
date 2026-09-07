# CodeWalker Bridge

Project-owned local bridge for CodeWalker API. It runs only on `127.0.0.1:5555` and keeps its third-party runtime and generated output under `tools/.runtime/`, which is intentionally not committed.

Use `Start-CodeWalkerBridge.ps1` to start or verify the API, and `Get-CodeWalkerBridgeStatus.ps1` to inspect readiness. Map changes still go through the project validation workflow: inspect, save, reload, calculate flags/extents, deploy to the test server, then test in game.

The bridge will be extended with guarded map-audit and placement workflows; it is not a direct CodeWalker UI plugin.

Use `Find-CodeWalkerAsset.ps1 -Filename <asset.ydr>` to perform a read-only lookup in the configured GTA archives. This is the required first check before a new native prop is added to a map pass.

