clear

// Malesky
		
use "$data/external/dataverse/war_data_province.dta"

drop 																		///
	north_lat																///
	diff_17																	///
	diff_17_2
	
merge 1:1 province 															///
	using "$data/external/exposition/corrected_distance_SHARED.dta", nogen

drop 																		///
	diff_17			
	
rename 																		///
	(latitude corrected_diff_17 dist_17_2)									///
	(north_lat diff_17 dist_17)

save "$data/external/exposition/war_data_province_malesk.dta", replace

// Ho-chi-minh
clear

import																		/// 
	excel "$data/external/hochiminh/north_lattitude_fixed.xlsx", 			///
	firstrow case(lower)

drop 																		///
	north_lat																///
	provincename														
	
merge 1:1 province 															///
	using "$data/external/dataverse/war_data_province.dta", nogen

drop 																		///
	north_lat																///
	diff_17																	///
	diff_17_2

rename 																		///
	(north_lat2)															///
	(north_lat)
	
gen diff_17 = abs(north_lat-17)

gen diff_17_2 = diff_17^2
	
save "$data/external/hochiminh/war_data_province_huynh.dta", replace

clear
