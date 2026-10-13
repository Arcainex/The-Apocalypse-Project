# Apocalypse Roads

Separate FiveM resource for TAP road-texture replacements. The installed GTA V files and RPF archives are never edited.

## Status

The original highway pilot remains packaged in `freewayrd.ytd` and `freewayrd+hi.ytd`. The map-wide pass adds 19 compact `tap_surface_*` dictionaries and maps 751 unique weathered materials across 1,777 GTA texture dictionaries at runtime. It covers 4,823 road, sidewalk, kerb and baked-marking references while excluding normal/specular maps and known UI, vehicle, sign, rail, wall and barrier false positives.

Roads receive cracking, age variation, dirt and edge growth. Sidewalks receive cracks, grime and moss concentrated around seams and borders. Painted road markings are faded and broken while remaining readable. The streamed textures preserve the original dimensions, alpha usage and mip chains; geometry and collisions are unchanged.

## Highway pilot

Run refresh, then ensure apocalypse-roads in the txAdmin console and reconnect the client. The server already starts the TAP resource group. Check close, medium, and distant views in dry and wet conditions. This is a local testing package; review redistribution rights for retained original members before public release. Never install these files into GTA V archives.

This is a broad texture pass, not a claim that every rare DLC/interior surface has been visually approved. Original normal maps remain unchanged and added plant detail is flat texture work, not 3D foliage. Check repetition, wet/night response, seams and LOD transitions in-game. Useful test points are `849.07, 125.36, 71.45` and the Strawberry area around `422.32, -1413.61, 31.08`.

The source inventory and contact sheets are under `tools/road-inventory/`; the [pilot notes](../../docs/highway-texture-pilot.md) identify the active source dictionaries and material families.
