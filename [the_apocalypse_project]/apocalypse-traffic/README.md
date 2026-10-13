# Apocalypse Traffic — texture pilot

Target: `prop_traffic_01b`, using `prop_traffic_01a` diffuse/specular textures in `prop_trafficlight.ytd` and `prop_trafficlight+hi.ytd`. Other props using the same materials are intentionally affected.

Severely weathered metal, peeling/corroded finish, reduced shine and dense moss-like surface growth in the lower-pole atlas region. Texture-only: no new foliage geometry, collision, model placement or traffic signal logic changes. Shared UVs may repeat the moss on other model sections; confirm in-game. Signal lenses retain their layout and remain distinguishable.

## Test

In txAdmin console: `refresh`, then `ensure apocalypse-traffic`. Reconnect FiveM. User's CodeWalker target is at 777.2983, 148.712357, 79.65961. Inspect the bottom of the pole, signal housing, medium-distance transitions and nighttime signals. Compare enabled/disabled with a reconnect between tests.

Original texture dimensions, BC1 compression and mip counts are preserved. All unrelated dictionary entries remain byte-identical. The shared streetlight-head diffuse also receives corrosion; emissive masks remain unchanged. The separate distant LOD atlas remains unchanged in this pilot. No installed game RPF files are edited.

Offline rendering confirms moss at the foot of prop_traffic_01b, with some repeated growth near the arm joint due to shared UVs. In-game behavior is still unverified.

The resource is mirrored to the test server. No commits or pushes. Local testing only; review rights for retained original dictionary entries before public distribution. Atlas preview and validation report: `output/traffic-pilot-v1` in the repository root.
