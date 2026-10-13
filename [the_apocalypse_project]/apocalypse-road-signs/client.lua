local replacements = {
  ["prop_barrier_work02a"] = {"prop_barrier_work02a"},
  ["prop_barrier_work04a"] = {"prop_barrier_work04a", "prop_sign_back_01", "prop_sign_back_01s", "prop_sign_road_roadworkahead_01"},
  ["prop_barrier_work05"] = {"prop_barrier_work05"},
  ["prop_barrier_work06a"] = {"prop_barrier_work06"},
  ["prop_barrier_work06b"] = {"prop_barrier_work06", "prop_sign_back_01", "prop_sign_back_01s", "prop_sign_road_roadworkahead_01"},
  ["prop_sign_big_01"] = {"prop_bilboard_01_d", "prop_metal_base_01_s", "prop_metal_white", "prop_sign_big_01_l_01_pal", "prop_sign_big_01_l_02_pal", "prop_sign_big_01_pal"},
  ["prop_sign_freewayentrance"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_freewayentrance", "prop_sign_lodprop_lodpole_1_a"},
  ["prop_sign_interstate_01"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_interstate_a", "prop_sign_back_01", "prop_sign_interstate_01prop_sign_interstate_a", "prop_sign_lodprop_lodpole_1_a", "prop_wood_plank_07"},
  ["prop_sign_interstate_02"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_interstate_a", "prop_sign_back_01", "prop_sign_interstate_02prop_sign_interstate_a", "prop_sign_lodprop_lodpole_1_a", "prop_wood_plank_07"},
  ["prop_sign_interstate_03"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_interstate_a", "prop_sign_back_01", "prop_sign_interstate_03prop_sign_interstate_a", "prop_sign_lodprop_lodpole_1_a", "prop_wood_plank_07"},
  ["prop_sign_interstate_04"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_interstate_a", "prop_sign_back_01", "prop_sign_interstate_04prop_sign_interstate_a", "prop_sign_lodprop_lodpole_1_a", "prop_wood_plank_07"},
  ["prop_sign_interstate_05"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_interstate_a", "prop_sign_back_01", "prop_sign_interstate_05prop_sign_interstate_a", "prop_sign_lodprop_lodpole_1_a", "prop_wood_plank_07"},
  ["prop_sign_loading_1"] = {"prop_sign_loading_1", "prop_sign_loading_1_s"},
  ["prop_sign_mallet"] = {"prop_forsale_sign_01_mallet"},
  ["prop_sign_parking_1"] = {"prop_bulb_orange", "prop_sign_parking_1"},
  ["prop_sign_prologue_01a"] = {"prop_chrome_burned_s", "prop_sign_prologue_01a", "prop_sign_prologue_back"},
  ["prop_sign_prologue_06e"] = {"prop_chrome_burned_s", "prop_sign_prologue_06e", "prop_sign_prologue_back", "prop_sign_prologue_pole"},
  ["prop_sign_prologue_06g"] = {"prop_chrome_burned_s", "prop_sign_prologue_06g", "prop_sign_prologue_back", "prop_sign_prologue_pole"},
  ["prop_sign_road_01a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_stop_01"},
  ["prop_sign_road_01b"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_stop_01", "prop_sign_road_wrongway_01"},
  ["prop_sign_road_01c"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_stopahead_01"},
  ["prop_sign_road_02a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_yield_01"},
  ["prop_sign_road_03a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_donotenter_01"},
  ["prop_sign_road_03b"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_donotenter_01", "prop_sign_road_wrongway_01"},
  ["prop_sign_road_03c"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_alltraffic_01"},
  ["prop_sign_road_03d"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_hospital_01"},
  ["prop_sign_road_03e"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_intersection_01"},
  ["prop_sign_road_03f"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_keepright_01"},
  ["prop_sign_road_03g"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_keepright_02", "prop_sign_road_reflector_01"},
  ["prop_sign_road_03h"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_litter_02"},
  ["prop_sign_road_03i"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_litter_03"},
  ["prop_sign_road_03j"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_localaccess_01"},
  ["prop_sign_road_03k"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_looktrains_01"},
  ["prop_sign_road_03l"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_noturn_01"},
  ["prop_sign_road_03m"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_nouturn_01"},
  ["prop_sign_road_03n"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_restriction_02"},
  ["prop_sign_road_03o"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_restriction_03"},
  ["prop_sign_road_03p"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_restriction_05"},
  ["prop_sign_road_03q"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_roadclosed_01"},
  ["prop_sign_road_03r"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_sidewalkclosed_01"},
  ["prop_sign_road_03s"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_truck_01"},
  ["prop_sign_road_03t"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_truck_02"},
  ["prop_sign_road_03u"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_truck_03"},
  ["prop_sign_road_03v"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_truck_04"},
  ["prop_sign_road_03w"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_restriction_05", "prop_sign_road_wildlife_01"},
  ["prop_sign_road_03x"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_wildlife_02"},
  ["prop_sign_road_03y"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_exit"},
  ["prop_sign_road_03z"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_stayinlane"},
  ["prop_sign_road_04a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_parking_16"},
  ["prop_sign_road_04b"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_beach_01"},
  ["prop_sign_road_04c"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_beach_02", "prop_sign_road_beach_03"},
  ["prop_sign_road_04d"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_beach_04"},
  ["prop_sign_road_04e"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_beach_05", "prop_sign_road_beach_06"},
  ["prop_sign_road_04f"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_beach_07"},
  ["prop_sign_road_04g"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_road_beach_08"},
  ["prop_sign_road_04g_l1"] = {"prop_sign_road_beach_08"},
  ["prop_sign_road_04h"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_bike_01", "prop_sign_road_dog_01"},
  ["prop_sign_road_04i"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_bike_02"},
  ["prop_sign_road_04j"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_bike_03"},
  ["prop_sign_road_04k"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_bike_04"},
  ["prop_sign_road_04l"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_carpool_01"},
  ["prop_sign_road_04m"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_dike_01"},
  ["prop_sign_road_04n"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_dog_02", "prop_sign_road_park_03"},
  ["prop_sign_road_04o"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_dog_03"},
  ["prop_sign_road_04p"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_dog_04"},
  ["prop_sign_road_04q"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_loitering_01"},
  ["prop_sign_road_04r"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_loitering_02", "prop_sign_road_parking_01"},
  ["prop_sign_road_04s"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_park_01"},
  ["prop_sign_road_04t"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_tsunami_01"},
  ["prop_sign_road_04u"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_usecrosswalk_01"},
  ["prop_sign_road_04v"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_wildlife_03"},
  ["prop_sign_road_04w"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_parking_02"},
  ["prop_sign_road_04x"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_parking_03"},
  ["prop_sign_road_04y"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_parking_09", "prop_sign_road_parking_17"},
  ["prop_sign_road_04z"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_parking_10", "prop_sign_road_parking_11"},
  ["prop_sign_road_04za"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_parking_12", "prop_sign_road_parking_14"},
  ["prop_sign_road_04zb"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_parking_13", "prop_sign_road_parking_15"},
  ["prop_sign_road_05a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_pedxing_01"},
  ["prop_sign_road_05b"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_pedxing_02"},
  ["prop_sign_road_05c"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_45arrow_01"},
  ["prop_sign_road_05d"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_45arrow_01"},
  ["prop_sign_road_05e"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_90arrow_01"},
  ["prop_sign_road_05f"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_90arrow_01"},
  ["prop_sign_road_05g"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_bumps_01"},
  ["prop_sign_road_05h"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_cow_01", "prop_wood_plank_07"},
  ["prop_sign_road_05i"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_deer_01"},
  ["prop_sign_road_05j"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_duck_01"},
  ["prop_sign_road_05k"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_fallingrocks_01"},
  ["prop_sign_road_05l"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_flooding_01"},
  ["prop_sign_road_05m"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_hiddenintersection_01"},
  ["prop_sign_road_05n"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_horse_01"},
  ["prop_sign_road_05o"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_lane_01"},
  ["prop_sign_road_05p"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_merge_01"},
  ["prop_sign_road_05q"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_lowaircraft_01"},
  ["prop_sign_road_05r"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_notathroughroad_01"},
  ["prop_sign_road_05s"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_pier_01"},
  ["prop_sign_road_05t"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_slippery_01"},
  ["prop_sign_road_05u"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_tractor_01", "prop_wood_plank_07"},
  ["prop_sign_road_05v"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_tram_01"},
  ["prop_sign_road_05w"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_truckentrance_01"},
  ["prop_sign_road_05x"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_windingroad_01"},
  ["prop_sign_road_05y"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_windingroad_02"},
  ["prop_sign_road_05z"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_merge_02"},
  ["prop_sign_road_05za"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_reflector_01", "prop_sign_road_splitlane_01"},
  ["prop_sign_road_06a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_15", "prop_wood_plank_07"},
  ["prop_sign_road_06b"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_5", "prop_wood_plank_07"},
  ["prop_sign_road_06c"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_15", "prop_wood_plank_07"},
  ["prop_sign_road_06d"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_25", "prop_wood_plank_07"},
  ["prop_sign_road_06e"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_35", "prop_wood_plank_07"},
  ["prop_sign_road_06f"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_50", "prop_wood_plank_07"},
  ["prop_sign_road_06g"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_60", "prop_wood_plank_07"},
  ["prop_sign_road_06h"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_aircraft", "prop_wood_plank_07"},
  ["prop_sign_road_06i"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_exit_25", "prop_wood_plank_07"},
  ["prop_sign_road_06j"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_exit_55", "prop_wood_plank_07"},
  ["prop_sign_road_06k"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_ramp", "prop_wood_plank_07"},
  ["prop_sign_road_06l"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_school", "prop_wood_plank_07"},
  ["prop_sign_road_06m"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_trucks_5", "prop_wood_plank_07"},
  ["prop_sign_road_06n"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_trucks_20", "prop_wood_plank_07"},
  ["prop_sign_road_06o"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_trucks_45", "prop_wood_plank_07"},
  ["prop_sign_road_06p"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_speed_trucks_55", "prop_wood_plank_07"},
  ["prop_sign_road_06q"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_straightarrow_01", "prop_wood_plank_07"},
  ["prop_sign_road_06r"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_straightarrow_01", "prop_wood_plank_07"},
  ["prop_sign_road_06s"] = {"prop_sign_hitch_hike"},
  ["prop_sign_road_07a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_oneway_01"},
  ["prop_sign_road_07b"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_oneway_02"},
  ["prop_sign_road_08a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_railroad_01", "prop_sign_road_railroad_02"},
  ["prop_sign_road_08b"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_railroad_01", "prop_sign_road_railroad_03"},
  ["prop_sign_road_09a"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_cheveron_01", "prop_wood_plank_07"},
  ["prop_sign_road_09b"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_cheveron_01", "prop_wood_plank_07"},
  ["prop_sign_road_09c"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_straightarrow_02", "prop_wood_plank_07"},
  ["prop_sign_road_09d"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_straightarrow_02", "prop_wood_plank_07"},
  ["prop_sign_road_09e"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_reflector_01", "prop_wood_plank_07"},
  ["prop_sign_road_09f"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_warning", "prop_wood_plank_07"},
  ["prop_sign_road_callbox"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_callbox", "prop_sign_callboxphone", "prop_sign_lodprop_lodpole_1_a"},
  ["prop_sign_route_01"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_route_a", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_route_01prop_sign_route_a", "prop_wood_plank_07"},
  ["prop_sign_route_11"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_route_a", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_route_11prop_sign_route_a", "prop_wood_plank_07"},
  ["prop_sign_route_13"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_route_a", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_route_13prop_sign_route_a", "prop_wood_plank_07"},
  ["prop_sign_route_15"] = {"prop_chrome_burned_s", "prop_chrome_dirtyprop_sign_route_a", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_route_15prop_sign_route_a", "prop_wood_plank_07"},
  ["prop_sign_sec_01"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_security_01", "prop_wood_plank_07"},
  ["prop_sign_sec_02"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_security_02", "prop_wood_plank_07"},
  ["prop_sign_sec_03"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_security_03", "prop_wood_plank_07"},
  ["prop_sign_sec_04"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_security_04", "prop_wood_plank_07"},
  ["prop_sign_sec_05"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_security_05", "prop_wood_plank_07"},
  ["prop_sign_sec_06"] = {"prop_chrome_burned_s", "prop_sign_back_01", "prop_sign_lodprop_lodpole_1_a", "prop_sign_road_security_06", "prop_wood_plank_07"},
  ["prop_sign_taxi_1"] = {"prop_sign_loading_1_s", "prop_sign_taxi_1"},
}

local function applyReplacements(silent)
  RequestStreamedTextureDict('apocalypse_signs', false)
  local deadline = GetGameTimer() + 30000
  while not HasStreamedTextureDictLoaded('apocalypse_signs') and GetGameTimer() < deadline do
    Wait(100)
  end
  if not HasStreamedTextureDictLoaded('apocalypse_signs') then
    if not silent then
      print('^1[apocalypse-road-signs]^7 roadside texture dictionary failed to load; retrying shortly')
    end
    return false
  end
  local count = 0
  for txd, textures in pairs(replacements) do
    for _, txn in ipairs(textures) do
      AddReplaceTexture(txd, txn, 'apocalypse_signs', txn)
      count = count + 1
    end
  end
  if not silent then
    print(('^2[apocalypse-road-signs]^7 applied %d roadside texture replacements'):format(count))
  end
  return true
end

CreateThread(function()
  for _, delay in ipairs({0, 5000, 15000, 30000}) do
    Wait(delay)
    applyReplacements()
  end
end)

-- Embedded prop dictionaries are created only when their models stream in.
-- Keep registering the replacements so signs first encountered later in a
-- session receive the same weathering as signs loaded during player spawn.
CreateThread(function()
  while true do
    Wait(10000)
    applyReplacements(true)
  end
end)

AddEventHandler('playerSpawned', function()
  CreateThread(function()
    Wait(2500)
    applyReplacements()
  end)
end)

AddEventHandler('onResourceStop', function(resource)
  if resource ~= GetCurrentResourceName() then return end
  for txd, textures in pairs(replacements) do
    for _, txn in ipairs(textures) do RemoveReplaceTexture(txd, txn) end
  end
end)
