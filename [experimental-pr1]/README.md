# Experimental legacy map pack — PR #1

Source: https://github.com/Arcainex/The-Apocalypse-Project/pull/1
Commit: `7d93f5a` (`updated to fxmanifest`, Nov 2021)

This is the original map pack from PR #1, kept intact as an **experimental alternative**. The PR modernizes its ten legacy map-resource manifests to `fxmanifest.lua`.

## Safety

Do **not** run this pack beside `[the_apocalypse_project]`. They cover much of the same map and prop content, which can produce duplicate maps, props, and collisions. The live project already contains the modern rebuilt map set.

Use this only in an isolated test profile:

```cfg
ensure [experimental-pr1]
```

For normal Beyond Survival operation, keep `[experimental-pr1]` disabled and use the existing `[the_apocalypse_project]` resource set.
