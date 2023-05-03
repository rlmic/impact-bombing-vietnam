clear
#delimit ;

/* EXTRACT DATA FOR JIWON KIM, YALE PHD STUDENT */;

use war_data_district_sep09.dta;

keep district* province* region* area_tot_km2 north east ha_* percent_c*
	plant* bare* area_* rough* max* range* mean* std* *elev* slp* soil* *length*
	pre_* tmp_* sun_* hum_*;

summ;

save extract-kim_2011-06, replace;
