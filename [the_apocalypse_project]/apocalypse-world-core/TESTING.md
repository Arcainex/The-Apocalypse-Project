# World Core test checklist

Test a new grid alone before enabling further regions.

## CodeWalker review

1. Open CodeWalker dev48 and select **Project Window > New Project**.
2. Add the grid's review YMAP or create one from the coordinates in `grids/<grid-id>/grid.lua`.
3. Load the surrounding vanilla world and every nearby project YMAP.
4. Inspect every placement from above and at ground level. Check Z contact, pitch, roll, kerbs, walls, doors, lanes and sight lines.
5. Save the `.cwproj` outside the release resource. It is review material, not streamed content.

CodeWalker validates geometry and overlap, but FiveM is authoritative for server IPLs, custom collision and physics.

## FiveM acceptance pass

- Start with `worldprofile balanced`; repeat the performance pass on `low`.
- Approach from every road and from outside the streaming radius.
- Confirm no popping loop, duplicate spawn, floating object, buried wheel, severe clipping or blocked route.
- Ram each wreck from several angles. It must move, remain synchronized for a second player and must not become drivable.
- Leave for longer than the unload delay, return, and confirm clean re-streaming.
- Restart the resource and confirm deterministic authored positions return.
- Enter and leave every nearby IPL/MLO repeatedly. Interiors, portals and exterior props must not disappear.
- Test mission markers, garages, doors, intersections, safe zones and navigation clearances.
- Load live faction-base coordinates and confirm their protected radius contains no world-core entities.
- Inspect nearby existing YMAPs and completed bridges for new overlap.

## Performance gate

Record identical route, weather, time, player count and graphics settings with the resource stopped, then on balanced and low. Capture average FPS, 1% low, frame time, client memory, server entity count and network traffic. The densest view should remain within roughly 2–3 FPS of baseline, with no streaming-memory warning or sustained hitch. Low must show a meaningful reduction in nearby entities.

## Evidence and approval

For the review PDF retain: grid ID and bounds, overhead map, exclusion map, placement inventory, before/after views, CodeWalker checks, FiveM checklist results, multiplayer physics result, IPL regression result, performance table, known issues, rollback location and final decision. A grid passes only when floating/clipping props, blocked missions and severe pathing problems are absent.
