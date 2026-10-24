# Apocalypse Buildings

Damaged facades and structural replacements for selected Los Santos buildings and skyscrapers. Original map placements are retained. Surviving facade UV layouts are preserved; selected large atlas members use smaller textures with matching mip chains to keep streaming memory within budget.

## Current coverage

- `ch2_04_build03b`: four damaged facade sections with recessed room backing, broken slabs, reinforcement and attached fallen panels. Roof and ground-level CNT letters have chipped contours and a neutral, non-emissive weathered finish. The surrounding signs are unchanged.
- `dt1_05_build1_damage`: fallen-FIB window damage with paired normal/specular maps and a matched glass band in the distance atlas. The existing fallen geometry and collision are retained; this is a material pass, not a structural rebuild.
- `dt1_11_dt1_tower`: two deep impact cavities, enclosed interior walls, failed floor bays, bent framing and rubble. Surviving office areas contain damaged partitions, desks, filing cabinets and unlit equipment; three small aircraft fragments rest inside the damaged area. Includes matching facade materials and broken nighttime emissive lighting.
- `hw1_04`: complete near and HI facade replacements, distance-matched wall and ground LODs, damaged shopfront glazing, a closed-shelter billboard and mostly blacked-out nighttime emissive windows.

The Downtown tower pass also adds grime, concrete discoloration, corrosion, cracked glazing, irregular dark window groups and reduced gloss. Native distance models retain the damage silhouette. Collision replacements open the damaged sections while preserving neighbouring streets and structures. No new map placements or district-wide material swaps are included.

Keep this resource and `apocalypse-los-santos` on the same release. Maze's shared far-distance parents live in the main Los Santos map and retain its existing destroyed-building work.

## Test

In the server console: `refresh`, then `ensure apocalypse-buildings`. Reconnect FiveM.

- CNT tower: inspect near `762.81, 171.35, 81.77`.
- Fallen FIB: inspect the tilted tower near `-875.10, -728.97, 83.15`, including aerial and street-level views.
- Downtown tower: inspect around `-75.0, -818.0`; test at street level and from an aircraft.
- Hawick block: inspect the `hw1_04` block at street level, then move far enough away to verify its wall, ground and nighttime emissive transitions.

Compare the same views with the resource enabled and disabled, reconnecting between tests. Inspect wet/day/night appearance, close-to-LOD transitions and helicopter approaches. Disabling this resource does not revert the shared skyline parents in `apocalypse-los-santos`; compare matching map versions when testing the complete structural pass. No installed GTA archive is modified.

For the structural changes, check each opening from the front, sides and above. Test bullet impacts, floor contact, player movement and helicopter approaches; move away and return to check distance transitions. Offline mesh and collision checks do not replace these live FiveM tests.
