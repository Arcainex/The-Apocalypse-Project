# Apocalypse Roads

Map-wide FiveM texture resource for weathered roads and related infrastructure. Installed GTA V archives are never modified.

## Coverage

- 4,885 selected road, highway, sidewalk, kerb, barrier and marking references
- 4,838 active runtime replacements across 1,795 source texture dictionaries
- 768 generated weathered materials, with 765 used by the runtime layer
- 29 compact streamed texture dictionaries

Roads and highways receive heavy irregular cracking, grime, faded paint, age variation and localized growth. Sidewalks, kerbs, shoulders, concrete slabs and compatible barriers receive deeper seam damage, staining and moss. Normal maps remain unchanged, and navigation markings remain readable despite pronounced wear.

Each texture shard loads and applies independently. A delayed shard no longer prevents the rest of the road package from loading. The largest streamed dictionary stays below 10 MiB.

Mixed map dictionaries are handled at material level: bundled road and pavement textures and standard freeway barriers are weathered, while unique specialist finishes and gas-station surfaces remain owned by their dedicated resources. This prevents isolated vanilla road sections without replacing stronger hand-finished infrastructure.

## Testing

Restart the resource and reconnect after clearing the client cache when validating a new build. Check close, medium and distant views in dry, wet, day and night conditions. Geometry and collisions are unchanged.

Useful test points include `849.07, 125.36, 71.45` and `422.32, -1413.61, 31.08`.
