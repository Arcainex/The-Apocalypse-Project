# Apocalypse World Core

Deterministic world dressing for gaps between existing map packs. The resource streams restrained debris locally and creates movable, undrivable wreck objects on the server. Wreck positions are synchronized and reset to their authored placement after a resource or server restart.

## Layout

Each 100 m cell is isolated at `grids/<grid-id>/grid.lua`. A grid contains bounds plus its wreck and clutter lists. Every cell touched by an existing authored YMAP footprint is excluded. This makes a faulty region removable without changing another grid. Review files, screenshots, backups and CodeWalker projects do not belong in the release resource.

## Performance profiles

Players can use `/worldprofile low`, `/worldprofile balanced` or `/worldprofile high`. The choice is saved locally. `/worldstatus` reports the active profile and nearby clutter count.

The low profile shortens streaming and physics distances, limits shared wreck demand and disables secondary clutter. Because wrecks are networked physical objects, the server uses the smallest wreck cap selected by any connected player; this prevents a low-profile player from receiving a larger shared set created for another client. Balanced is the default. Server owners can tune the profiles, global wreck and clutter caps, validation limits and update intervals in `config.lua`.

## Installation

Keep the folder inside `[the_apocalypse_project]`, then restart the server or run `refresh` followed by `ensure apocalypse-world-core`. OneSync must be active for server-owned wreck synchronization.

## Placement rules

New grids must avoid existing YMAP entity footprints, safe zones, faction bases, mission locations, IPL/MLO entrances and previously dressed bridges. Preserve usable routes, doors, garages and intersections. Match ground height, pitch and roll; keep clutter static and wrecks physically movable. Dynamic faction-base coordinates must be supplied to the exclusion check before a grid is approved.

## Rollback

Wrecks stay frozen until a nearby client finds a road surface within the authored height tolerance. A failed check withholds the wreck until restart instead of releasing it at a guessed height. Clutter also requires a valid nearby surface. These guards do not replace visual and in-game acceptance tests.

Stop the resource to remove its local dressing. Restore the pre-batch Git checkpoint or packaged backup to revert authored files. A single grid can be disabled by removing its `grid.lua` from the release and restarting the resource.
