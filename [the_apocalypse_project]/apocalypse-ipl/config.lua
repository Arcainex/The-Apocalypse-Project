ApocalypseIpl = {
    -- Set false only when another resource deliberately owns these IPLs.
    -- The map can then be less stable around configured vanilla interiors.
    enabled = true,
    pollIntervalMs = 1000,
    debug = false,
    -- Bob74's base GTA V world-fix IPL set. This deliberately excludes its
    -- optional player-property and DLC interior styles, which can conflict
    -- with custom MLOs and each other.
    globals = {
        bob74_base = {
            enabled = true,
            removeIpls = {
                'dt1_05_hc_end',
                'dt1_05_hc_req',
            },
            ipls = {
                'post_hiest_unload', 'refit_unload', 'FINBANK',
                'Coroner_Int_on', 'coronertrash',
                'CS1_02_cf_onmission1', 'CS1_02_cf_onmission2',
                'CS1_02_cf_onmission3', 'CS1_02_cf_onmission4',
                'farm', 'farmint', 'farm_lod', 'farm_props', 'des_farmhouse',
                'FIBlobby', 'atriumglmission', 'dt1_05_hc_remove',
                'FruitBB', 'sc1_01_newbill', 'hw1_02_newbill',
                'hw1_emissive_newbill', 'sc1_14_newbill', 'dt1_17_newbill',
                'id2_14_during_door', 'id2_14_during1', 'facelobby',
                'v_tunnel_hole', 'Carwash_with_spinners',
                'sp1_10_real_interior', 'sp1_10_real_interior_lod',
                'ch1_02_open', 'bkr_bi_id1_23_door', 'lr_cs6_08_grave_closed',
                'methtrailer_grp1', 'bkr_bi_hw1_13_int', 'CanyonRvrShallow',
                'bh1_47_joshhse_unburnt', 'bh1_47_joshhse_unburnt_lod',
                'hei_sm_16_interior_v_bahama_milo_',
                'cs3_05_water_grp1', 'cs3_05_water_grp1_lod', 'trv1_trail_start',
                'canyonriver01', 'canyonriver01_lod', 'ferris_finale_anim',
                'ld_rail_01_track', 'ld_rail_02_track', 'dockcrane1', 'pcranecont',
                'dt1_21_prop_lift_on', 'cs5_4_trains',
            },
        },
    },
    zones = {
        arena_real = {
            center = vector3(-257.98, -2024.03, 29.15),
            radius = 175.0,
            ipls = { 'sp1_10_real_interior' },
            removeIpls = { 'sp1_10_fake_interior' },
            interiorPoints = {
                vector3(-257.98, -2024.03, 29.15),
            },
        },
        metro_del_perro = {
            center = vector3(-828.0, -117.0, 23.0),
            radius = 175.0,
            -- Add only IPL names verified against the map import and game build.
            ipls = {},
            interiorPoints = {
                vector3(-828.0, -117.0, 27.0),
                vector3(-805.0, -135.0, 19.0),
            },
        },
        oneil_ranch = {
            center = vector3(2450.0, 4975.0, 46.0),
            radius = 600.0,
            -- Restore the intact Oneil Ranch state. Burnt and cap IPLs can
            -- leave the exterior terrain and ranch interior in conflicting states.
            ipls = {
                'farm',
                'farmint',
                'farm_lod',
                'farm_props',
            },
            removeIpls = {
                'farm_burnt',
                'farm_burnt_lod',
                'farm_burnt_props',
                'farmint_cap',
                'farmint_cap_lod',
            },
            interiorPoints = {
                vector3(2450.0, 4975.0, 46.0),
            },
        },
    },
}

