# Apocalypse Buildings — CNT pilot

Texture-only trial for `ch2_04_build03b`. Replaces the window and door atlases in `ch2_04_buildings.ytd` and `ch2_04_buildings+hi.ytd`. Base specular maps are darkened to reduce the clean glossy finish. All other dictionary members are preserved.

The original atlas layout is retained. Procedural damage adds dirt streaks, frame corrosion, cracked panes and small seam moss patches. There are no model, placement, collision or installed GTA V archive changes. Shared texture effects on other buildings are intentional.

## Test

In the server console: `refresh`, then `ensure apocalypse-buildings`. Reconnect FiveM. Inspect the CNT tower near the user's test viewpoint 762.81, 171.35, 81.77. The CodeWalker screenshot identifies the model at 745.5779, 222.624146, 116.71917; do not teleport to its model origin inside the building.

Compare the same view with the resource enabled/disabled, reconnecting between tests. Inspect doors, windows, wet/day/night appearance and near/far transitions. The distant LOD, emissive overlays and original normal maps are not changed in this pilot; distant or nighttime appearance may remain cleaner.

This is a local testing package, not a public-release-ready distribution. Review redistribution rights for retained original GTA material before publishing. No commits or pushes are part of deployment.

Atlas comparisons and member-level validation report are in `output/building-pilot-v1` at the repository root. Stop the resource and reconnect to undo the texture override; no game archive restoration is needed.
