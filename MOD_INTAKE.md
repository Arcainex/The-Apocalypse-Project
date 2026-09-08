# External Map Intake

This register tracks maps proposed for evaluation. A source credit is not a redistribution licence: no candidate is copied into the project until its author has explicitly approved redistribution in this FiveM/GitHub project.

| Candidate | Author | Format | Status |
| --- | --- | --- | --- |
| Los Santos Apocalypse | ConorM | Map Editor XML | Already present as END.ymap; do not import a second copy |
| Abandoned Road / Post-Apocalypse | Axel Fala | YMAP / Menyoo | Permission approved; archive pending |
| Post-Apocalypse Vinewood | Axel Fala | YMAP / Menyoo | Permission approved; archive pending |
| After Us Zombie Hospital | Azpect-YT | Map Editor | Permission approved; archive pending |
| The Richman Hotel Post-Apocalypse | Axel Fala | YMAP / Menyoo | Already integrated; do not import again |
| Apocalypse | Stuart688 | Map Editor XML | Permission approved; archive pending |
| Liberty City Post-Apocalypse | Axel Fala | Menyoo | Rejected: requires Liberty City |
| Los Santos Zombie Apocalypse | Crazy city | YMAP | Permission approved; archive pending; full Los Santos conflict/performance audit required |
| Time Square Post-Apocalypse | Axel Fala | Menyoo | Rejected: requires Liberty City |
| Several Safezones | hadinajafi77 | Map Editor XML | Permission approved; archive pending |
| Apocalypse | Tobaklo | Menyoo | Audited; excluded from release because it fully overlaps CityCentral and causes unsafe local prop density |
| Metro Apocalypse | ManuGammer | Map Editor XML | Permission approved; archive pending |
| Military Checkpoint Vinewood Radio Tower | Yougi | Map Editor | Permission approved; archive pending |
| Apocalypse Safebase | JohnnyMillion | Map Editor XML | Permission approved; archive pending |
| Military Base [Zombie base] | RDK_Ulman | Map Editor / Menyoo | Permission approved; archive pending |
| The Walking Dead Inspired: Zombie Survival Map | roosybigmods / The Ultimate ShotHD listing | Menyoo | Permission approved; archive pending |
| Last Of Us Map 1 + Map 2 | Den Edwin | Menyoo / Build a Mission | Audited and converted as static FiveM YMAPs; mission-only content excluded |
| 2 Many Years — Bridge / The Lost | 2ManyYears | Map Editor / Menyoo | Selected: Bridge added; The Lost replaces the Stab City override; all other pack locations excluded |

Every approved archive is processed as follows: extract outside the streamed resources; convert only static supported entities; remove exact and near conflicts against project YMAPs; recalculate flags/extents in CodeWalker; reload/validate; and add the final author credit plus source link to the README and forum post.

## Implemented
- **The Walking Dead Inspired Zombie Survival Map** — roosybigmods / Ultimate ShotHD. Converted only the 19 static placements to `apocalypse-blaine/stream/community/walking-dead-survival; no runtime script content included.

- **Metro Apocalypse: The Last of Us and The Division** — ManuGammer. Converted 130 conflict-free static placements to `apocalypse-los-santos/stream/community/metro-apocalypse; no runtime data included.

- **VEST Military Base in the Desert** — RDK_Ulman. Neutral static layout only: 1,033 props under `apocalypse-blaine/stream/community/vest-military-base; four airport overlaps pruned; runtime content excluded.

- **Last Of Us Map 1 + Map 2** — Den Edwin. Converted 1,564 static props to `apocalypse-last-of-us`; five non-static mission entries, all task sequences, peds, vehicles, and custom-script dependencies excluded; safe 500m LODs applied and no exact active-YMAP overlaps found.

- **2 Many Years — Bridge / The Lost** — 2ManyYears. Bridge added as a 703-prop static YMAP; The Lost replaces the 39-prop `stabcity.ymap` override with 127 static props. Every other 2ManyYears location was deliberately excluded after the conflict review.


## Implemented — conversion batch

- **Stuart Apocalypse** — Stuart688: Part 1 and Part 2 converted as conflict-pruned static YMAPs.
- **Abandoned Road / Post-Apocalypse** — Axel Fala: converted as a conflict-pruned static YMAP.
- **Post-Apocalypse Vinewood** — Axel Fala: converted as a conflict-pruned static YMAP.
- **Apocalypse Safebase** — JohnnyMillion: converted as a static YMAP.
- **Apocalypse** — Tobaklo: converted and audited from parse-sanitized Menyoo XML; excluded from the release because it fully overlaps CityCentral and creates unsafe local prop density.
- **Several Safezones** — hadinajafi77: split into six conflict-pruned zone YMAPs.
- **After Us Zombie Hospital** — Azpect-YT: Abandoned layout only, converted as a conflict-pruned static YMAP.

## Rejected

- **Military Checkpoint Vinewood Radio Tower** — Yougi: not converted because it duplicates the existing `antena.ymap` placement set.
