# Apocalypse Buildings

Apocalyptic facade replacements for selected Los Santos buildings and skyscrapers. Original atlas dimensions, compression, mip chains and UV layouts are retained.

## Current coverage

- `ch2_04_build03b`: broken-glass impact atlas, paired embedded relief normal, reduced glass specular response and dark chipped CNT sign lettering. The sign edit is confined to its own UV rectangle; other signs are retained.
- `dt1_05_build1_damage`: fallen-FIB window damage with paired normal/specular maps and a matched glass band in the distance atlas. The existing fallen geometry and collision are retained; this is a material pass, not a structural rebuild.
- `dt1_11_dt1_tower`: complete near facade, embedded materials, HI overrides, LOD facade and broken nighttime emissive lighting.
- `hw1_04`: complete near and HI facade replacements, distance-matched wall and ground LODs, damaged shopfront glazing, a closed-shelter billboard and mostly blacked-out nighttime emissive windows.

The Downtown tower pass adds heavy grime, concrete discoloration, corrosion, cracked glazing, irregular dark window groups and reduced gloss. Road, plaza and unrelated shared materials are preserved.

## Test

In the server console: `refresh`, then `ensure apocalypse-buildings`. Reconnect FiveM.

- CNT tower: inspect near `762.81, 171.35, 81.77`.
- Fallen FIB: inspect the tilted tower near `-875.10, -728.97, 83.15`, including aerial and street-level views.
- Downtown tower: inspect around `-75.0, -818.0`; test at street level and from an aircraft.
- Hawick block: inspect the `hw1_04` block at street level, then move far enough away to verify its wall, ground and nighttime emissive transitions.

Compare the same views with the resource enabled and disabled, reconnecting between tests. Inspect wet/day/night appearance, close-to-LOD transitions and helicopter approaches. Stop the resource and reconnect to undo the overrides; no installed GTA archive is modified.
