
clear
set mem 50m
set matsize 600

#delimit ;

use war_data_district_aug05;

keep 	district district_name province region
	pop_tot area_tot_km2
	north_lat east_long
	tot_bmr;

label var pop_tot "Total district population, 1999";
label var area_tot_km2 "Total district land area (sq. km)";

save vietnam-bombs_jan08, replace;
