# Apocalypse IPL Loader

A small project-owned loader for vanilla IPLs and interior residency. It deliberately activates only map features listed in `config.lua`.

## Compatibility with other IPL loaders

`config.lua` defaults to `enabled = true`. Keep it enabled unless another resource is intentionally managing the same IPLs. If the server already uses a loader such as `bob74_ipl`, set `enabled = false` to leave all IPL requests, removals, and interior refreshes to that resource.

The map assets themselves still stream with this switch off, but any Arena or Metro interior that depends on the other loader's configuration can be unstable, incomplete, or use the wrong IPL variant. Do not run two resources that actively manage the same IPLs.

## Metro

The Del Perro metro zone pins and refreshes the existing vanilla interior at the Metro Apocalypse placement. No IPL name is guessed: verified IPLs are added to this zone only after in-game validation.

Run `/tapiplstatus` in the client console to inspect the detected interior IDs and readiness state.

## Maintenance rule

When a future map import relies on a vanilla interior or IPL, add its verified IPL(s) and interior points to `config.lua`, then test before release.