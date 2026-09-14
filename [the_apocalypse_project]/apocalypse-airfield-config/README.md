# Grand Senora Airfield Profiles

Only one airfield safezone is active at a time.

In `server.cfg`, choose one profile before `ensure [the_apocalypse_project]`:

```cfg
# Default: Calplusprime India's Post Apocalyptic Airbase
setr apocalypse_airfield_profile new

# Optional: the repaired legacy VEST Military Base
# setr apocalypse_airfield_profile legacy
```

Restart the server after changing profile. The selected map and its matching zombie safezone load together; the other profile is prevented from streaming.
