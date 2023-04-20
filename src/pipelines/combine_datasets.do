/*

COMBINED ALL DATA CONSTRUCTION FILES FOR VIETNAM 
BOMBING PROJECT INTO TWO FINAL DATA FILES THAT
ARE THEN USED IN THE DATA ANALYSIS
------------------------------------------

*/

/*-----------------------------------


A. DISTRICT LEVEL


-----------------------------------*/


/*-----------------------------------
U.S. Military Data

-----------------------------------*/


use "$data/raw/dsca/DSCAdata.dta"

sort district

save "$data/raw/dsca/DSCAdata.dta", replace

clear

/*-----------------------------------
Poverty, Geographic, and 
Climatic Data
-----------------------------------*/

/*
Geographical disctrict controls
*/


use "$data/raw/ifpri/GIS_var1.dta"

tempfile geo

save `geo'

rename 																		///
	(district_code _ha__arable_land)										///
	(district ha_arable)
	
// Navigable river length

rename 																		///
	(percentage_of_total_area_by_elev percentage_of_total_area_by_slop)		///
	(area_0_250m slp_c1)
	
gen area_over_1000m = area_1001 + area_over_1500m

foreach var in																///
	area_0_250m																///
	area_251																///
	area_501																///
	area_over_1000m{
	replace `var' = `var'/100
	}

gen slp_c45 = slp_c4 + slp_c5

rename 																	    ///
	percentage_of_total_area_by_soil										///
	soil_1

// Geographic isolation

rename 																		///
	(mean mean_1)															///
	(dist_p_town_mean dist_d_town_mean)


// District Outcomes

rename 																		///
	percentage_of_total_area_under_ 										///
	percent_cultivated
	
rename																		///
	market_variables_no_markets												///
	num_markets
	
rename																		///
	length_of_roads_by_type_length_t										///
	length_tot

	
// Latitude

rename																		/// 
	y_coord																	///
	north_lat

replace 																	///
	north_lat = north_lat/100000
	
gen diff_17 = abs(north_lat-17)

gen diff_17_2 = diff_17^2

// Longitude

rename																		/// 
	utm48_coordinates_district_centr										///
	east_long
	
replace east_long = east_long/100000 + 100

sort district

tempfile geo

save `geo'

/*
Climate disctrict controls
*/

use "$data/raw/ifpri/GIS_var2a.dta"

tempfile cli

save `cli'

// Precipitation & SD accross months
foreach var in																///
	pre																		///
	tmp																		///
	hum																		///
	sun{
		gen `var'_avg = (													///
		`var'_avg_jan +														/// 
		`var'_avg_feb +														/// 
		`var'_avg_mar +														///
		`var'_avg_apr +														/// 
		`var'_avg_may +														/// 
		`var'_avg_jun +														///
		`var'_avg_jul +														///
		`var'_avg_aug +														/// 
		`var'_avg_sep +														/// 
		`var'_avg_oct +														/// 
		`var'_avg_nov +														///
		`var'_avg_dec														///
		)/12
		egen `var'_sd = rsd(												///
		`var'_avg_jan														///
		`var'_avg_feb														///
		`var'_avg_mar														///
		`var'_avg_apr														///
		`var'_avg_may														///
		`var'_avg_jun														/// 
		`var'_avg_jul														///
		`var'_avg_aug														///
		`var'_avg_sep														///
		`var'_avg_oct														///
		`var'_avg_nov														///
		`var'_avg_dec														///
		)
		drop `var'_avg_*
		}

sort district

tempfile cli

save `cli'

insheet using "$data/raw/ifpri/SES-data.csv", clear

merge m:m district using `geo', nogen

sort district

merge m:m district using `cli', nogen

sort district

merge m:m district using "$data/raw/dsca/DSCAdata.dta", nogen

tempfile dsca

save `dsca'

/*
Poverty metrics
*/
	
rename 																		///
	pcexp																	///
	pcexp_99

gen lit_rate = literate_15plus/pop_15plus

gen illit_rate = 1 - lit_rate

gen elec_rate = hh_elec/no_hh

gen tv_rate = hh_tv/no_hh

gen radio_rate = hh_radio/no_hh

gen urban_pct = pcturban/100

// Population density 1999

gen popdensity1999 = pop_tot/area_tot_km2

gen log_popdensity1999 = log(popdensity1999)

// Province FE

tab province, gen(Iprovince)

drop Iprovince1

egen pop_prov = sum(pop_tot), by(province)

gen mine_per = Mine/area_tot_km2

// Ordnance: Two Methods

// Method 1. Sum up total

gen tot_bmr  = 																///
	General_Purpose + 														///
	Cluster_Bomb + 															///
	Missile + 																///
	Rocket + 																///
	Cannon_Artillery

gen tot_bmr_2 = (tot_bmr)^2

gen log_tot_bmr = log(tot_bmr)

gen tot_bmr_per  = tot_bmr/area_tot_km2

gen tot_bmr_per_2 = (tot_bmr_per)^2

gen log_tot_bmr_per = log(tot_bmr_per)

gen tot_bomb = General_Purpose + Cluster_Bomb

gen tot_bomb_per = tot_bomb/area_tot_km2

replace tot_bomb_per = . 													///
	if tot_bomb_per>1000

gen tot_bmr_hi = (tot_bmr>35500 & tot_bmr~ = .)								///

gen tot_bmr_per_hi = (tot_bmr_per>78 & tot_bmr~ = .)

// Method 2. PCA index

pca 																		///
	$ord0																	///
	$ord1																	///
	$ord2																	///
	$ord3																	///
	[aw=pop_tot],															///
	mineigen(1)																///
	comp(2)

predict war_f1 war_f2

label var 																	///
	war_f1																	///
	"U.S. war intensity index (eigenvector 1)"
	
label var 																	///
	war_f2 																	///
	"U.S. war intensity index (eigenvector 2)"

label var 																	///
	poverty_p0																///
	"District poverty rate, 1999"

label var																	///
	pcexp_99																///
	"District per capita consumption expenditures, 1999"
	
label var 																	///
	gini 																	///
	"District GINI coefficient, 1999"
	
label var 																	///
	popdensity1999															///
	"Population Density 1999"
	
label var																	///
	log_popdensity1999														///
	"Log(Population Density 1999)"
	
label var																	///
	log_tot_bmr_per															///
	"Log(Total U.S. bombs, missiles, rockets per km2)"
	
label var																	///
	tot_bmr_per_2															///
	"Total U.S. bombs, missiles, rockets per km2 - squared"
	
label var																	///
	tot_bmr_per																///
	"Total U.S. bombs, missiles, rockets per km2"
	
label var																	///
	log_tot_bmr																///
	"Log(Total # of U.S. bombs, missiles, rockets)"
	
label var																	///
	tot_bmr_2																///
	"Total # of U.S. bombs, missiles, rockets - squared"
	
label var																	///
	tot_bmr 																///
	"Total # of U.S. bombs, missiles, rockets"
	
label var																	///
	tot_bmr_per_hi															///
	"Total U.S. bombs, missiles, rockets per km2 > 78"
	
label var																	///
	tot_bmr_hi 																///
	"Total U.S. bombs, missiles, rockets > 355000"
	
label var																	///
	General_Purpose 														///
	"Total # of U.S. general purpose bombs"
	
label var																	///
	tot_bomb_per															///
	"Total U.S. bombs per km2"
	
label var																	///
	tot_bomb 																///
	"Total # of U.S. bombs"
	
sort district

tempfile dsca

save `dsca'

save "$data/interim/dsca.dta", replace


/*-----------------------------------
Pre-American War Data
-----------------------------------*/

use "$data/raw/prewar/prewardt.dta"

foreach year in 1961 1962 1963{
	label var															    ///
		rubberplanted`year'													///
		"Rubber Planted Area, Hectares, `year'"
	}
	
foreach year in 1958 1959 1961 1962 1963{
	label var															    ///
		rubberworkable`year'												///
		"Rubber Workable Area, Hectares, `year'"
	label var															    ///
		rubberworked`year'													///
		"Rubber Worked Area, Hectares, `year'"
	label var															    ///
		rubberworkedtoworkable`year'										///
		"Rubber Ratio Worked/Workable, `year'"
	}
	
label var																	///
	cerealprod_padval1960_n													///
	"Output of Cereals, in tons of paddy value, 1960"
	
label var																	///
	cerealprod_padval1965_n													///
	"Output of Cereals, in tons of paddy value, 1965"
	
label var																	///
	cerealprodpercap_pv_kgper1960_n 										///
	"Output of Cerals per cap, kg of paddy vaule per person, 1960"
	
label var																	///
	cerealprodpercap_pv_kgper1965_n 										///
	"Output of Cerals per cap, kg of paddy vaule per person, 1965"
	
label var																	///
	plantedarea_crop1960_n													///
	"Planted Crop Area, Hectares, 1960"
	
label var																	///
	plantedarea_crop1965_n													///
	"Planted Crop Area, Hectares, 1965"
	
label var																	///
	plantedarea_nonpadc1960_n												///
	"Planted Non-Paddy Crop Area, Hectares, 1960"
	
label var																	///
	plantedarea_nonpadc1965_n												///
	"Planted Non-Paddy Crop Area, Hectares, 1965"
	
label var																	///
	plantedarea_total1960_n													///
	"Planted Total Area, Hectares, 1960"
	
label var																	///
	plantedarea_total1965_n													///
	"Planted Total Area, Hectares, 1965"
	
label var																	///
	popdens_pctdis1960_n													///
	"Avg % Disagreemnt b/t Underlying Backed-Out Pop Figures, 1960"
	
label var																	///
	popdens_pctdis1965_n													///
	"Avg % Disagreemnt b/t Underlying Backed-Out Pop Figures, 1965"
	
label var																	///
	popdensity1960_n														///
	"PopDensity, per km2, backed-out from cereal/paddy percap (avg), 1960"
	
label var																	///
	popdensity1960_n														///
	"PopDensity, per km2, backed-out from cereal/paddy percap (avg), 1960"
	
tempfile prewar

save `prewar'

save "$data/interim/prewar.dta", replace

use `dsca'

merge m:m district using `prewar', nogen

sort district

tempfile district_bombing

save `district_bombing'

// Vietnam Living Standards Survey (VLSS)

use "$data/raw/vlss/hhvlss98collapse.dta"

gen notbornhere = 1 - bornhere

drop urb93

foreach varpart in 															///
	calpc																	///
	calok																	///
	expb																	///
	exph																	///
	exp																		///
	exppc																	///
	fexp																	///
	fpct																	///
	hfpct																	///
	adults																	///
	children																///
	infants 																///
	hhsize  																///
	ricevb  																///
	ricevh 																	///
	riceqb 																	///
	ricexpd 																///
	nonrice																	///
	totnfdx1																///
	totnfdh1																///
	nonfood1																///
	pcfdex1																	///
	riceqh																	///
	maizev																	///
	maizeq																	///
	maniocv																	///
	maniocq																	///
	swpotv																	///
	swpotq																	/// 
	rcpi																	///
	mcpi {
		rename `varpart'93 `varpart'_93
		}

rename exppc_93 pcexp1_93
		
gen rlpcex1_9398 = 														    ///
	(pcexp1 + pcexp1_93)/2
	
rename exp_93 hhexp1_93

rename exp93r98 rlhhex1_93

rename exppc93r98 rlpcex1_93

rename fexp_93 food_93

replace sex_head_female_93 = 0 												///
	if sex_head_female_93==1
	
label define diploma 														///
	0 Never 																///							
	1 "Nhatre = Kindergarten" 												///
	2 "<cap I = <primary" 													///
	3 "Cap I = Primary" 													///
	4 "Cap II = Lower Sec"													///
	5 "Cap III = Higher Sec" 												///
	6 "Nghe SC = Voc Training" 												///
	7 "THCN = Secondary Voc Training"										/// 
	8 DHDC																	///
	9 "DHCD = Bachelors" 													///
	10 "Thac sy = Masters" 													///
	11 "PTS = PhD Candidate" 												///
	12 "TS = PhD", modify
	
label val comped98_head diploma
	
label var																	///
	rlhhex1_93 																///
	"93: Cons exp 93, in 98 1000VND, adj for reg/mo price diff"
	
label var																	///
	sex_head_female 														///
	"HHEXP: Avg Gender of HH.head (0:M;1:F)"
	
label var																	///
	age_head 																///
	"HHEXP: Avg Age of HH.head"
	
label var																	///
	agegroup_head 															///
	"HHEXP: Avg AgeGroup of HH.head"
	
label var																	///
	comped98_head															///
	"HHEXP: Avg completed diploma HH.head"

label var																	///
	educyr98_head 															///
	"HHEXP: Avg schooling years of HH.head"
	
label var																	///
	farm 																	///
	"Type of HH (1:farm; 0:nonfarm)"
	
label var																	///
	urban98 																///
	"1:urban 98, 0:rural 98"
	
label var																	///
	urban92 																///
	"1:urban 92, 0:rural 92"
	
label var																	///
	avg_ill4wks 															///
	"HH: Avg of Avg days ill in past 4wks (all HH members)"
	
label var																	///
	avg_hospital12mths 														///
	"HH: Avg of Avg days spent in hospital past 12mths (all HH members)"
	
label var																	///
	literate 																///
	"HH: ED: Can you read this sentence?"
		
label var																	///
	numerate 																///
	"HH: ED: Can you do these calculations?"

label var																	///
	ricexpd																	///
	"HHEXP: Avg Value rice expenditures, current 1000VND"
	
label var																	///
	nonrice 																///
	"HHEXP: Avg Value food expenditures no rice, current 1000VND"
	
label var																	///
	totnfdx1																///
	"HHEXP: Avg Value Nonfood exp.purchase/barter, current 1000VND (comp 93)"
	
label var																	///
	totnfdhp																///
	"HHEXP: Avg Value Nonfood home production, current 1000VND"
	
label var																	///
	totnfdh1																///
	"HHEXP: totnfdhp, excl. coal,wood,sawdust,chaff consumed, current 1000VND (comp 93)"
	
label var																	///
	food																	///
	"HHEXP: Avg Exp on food/foodstuff, current 1000VND (comp 93)"
	
label var																	///
	nonfood1																///
	"HHEXP: Avg Exp on non-food(stuffs), current 1000VND (comp 93)"
	
label var																	///
	hhexp1																	///
	"HHEXP: Avg total exp = food + nonfood1, current 1000VND (comp 93)"
	
label var																	///
	pcexp1																	///
	"HHEXP: Avg Exp per Cap = hhexp1/hhsize, current 1000VND (comp 93)"
	
label var																	///
	pcfdex1																	///
	"HHEXP: Avg exp per cap food/foodstuff = food/hhsize, current 1000VND (comp 93)"
	
label var																	///
	rlfood																	///
	"HHEXP: Avg Exp on food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)"
	
label var																	///
	rlnfd1																	///
	"HHEXP: Avg Exp on non-food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)"
	
label var																	///
	rlhhex1																	///
	"HHEXP: Avg total exp, adj for reg/mo prices, 1998 1000VND (comp 93)"
	
label var																	///
	rlpcfdex																///
	"HHEXP: Avg exp per cap on food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)"
	
label var																	///
	nonfood2																///
	"HHEXP: Avg Exp on non-food(stuffs), current 1000VND (not comp 93)"
	
label var																	///
	hhexp2																	///
	"HHEXP: Avg total exp = food + nonfood2, current 1000VND (not comp 93)"
	
label var																	///
	pcexp2																	///
	"HHEXP: Avg Exp per Cap = hhexp2/hhsize, current 1000VND (not comp 93)"
	
label var																	///
	hhexp2																	///
	"HHEXP: Avg total exp = food + nonfood2, current 1000VND (not comp 93)"
	
label var																	///
	pcexp2																	///
	"HHEXP: Avg exp per cap = hhexp2/hhsize, current 1000VND (not comp 93)"
	
label var																	///
	rlhhex2																	///
	"HHEXP: Avg total exp, adj for reg/mo prices, 1998 1000VND (not comp 93)"
	
label var																	///
	rlpcex2																	///
	"HHEXP: Avg Exp per cap, adj for reg/mo prices, 1998 1000VND (not comp 93)"

label var																	///
	comped98father															///
	"HH: EDPAR: Avg of HH.head's Father's highest diploma"
	
label var																	///
	comped98mother															///
	"HH: EDPAR: Avg of HH.head's Mother's highest diploma"
	
label var																	///
	educyr98father															///
	"HH: EDPAR: Avg of HH.head's Father's yrs formal sch (grade+postsec)"
	
label var																	///
	educyr98mother 															///
	"HH: EDPAR: Avg of HH.head's Mother's yrs formal sch (grade+postsec)"
	
label var																	///
	workedpast12mo															///
	"HH: EMP: Avg Have you worked (for pay, at your farm, self-employed) in past 12 mo?"
	
label var																	///
	yearsinwork																///
	"HH: EMP: Avg How many years have you been doing mainjob?"
	
label var																	///
	salary																	///
	"HH: EMP: Avg Have you ever or will you receive salary or wage for mainjob, inc. pay-in-kind?"
	
label var																	///
	bornhere																///
	"HH: IMM: Avg Born in current district?"
label var																	///
	yrshere																	///
	"HH: IMM: Avg How many years have you lived in current residence?"
	
label var																	///
	dwellingshared															///
	"HH: HOUSE: Avg Does your hh share dwelling with another?"
	
label var																	///
	dwellingowned															///
	"HH: HOUSE: Avg Does a member of your hh own all or part of dwelling? 0=none,1=part,2=all"

label var																	///
	calpc_93																///
	"MINOT: kcal per cap per day, 1993"
	
label var																	///
	calok_93																///
	"MINOT: 1 if 3500>=calpc_93>=1000"
	
label var																	///
	expb_93																	///
	"MINOT: Exp Bought/Bartered, Past12mo 1000VND"
	
label var																	///
	exph_93 																///
	"MINOT: Exp Home-Produced, Past12mo 1000VND"
	
label var																	///
	hhexp1_93 																///
	"MINOT: Exp, Past12mo 1000VND"
	
label var																	///
	pcexp1_93																///
	"MINOT: Exp per cap, Past12mo 1000VND"
	
label var																	///
	food_93																	///
	"MINOT: Exp on Consumption, Past12mo 1000VND"
	
label var																	///
	fpct_93																	///
	"MINOT: Fraction Consumption Exp = food_93/hhexp1_93"
	
label var																	///
	hfpct_93																///
	"MINOT: Fraction of Cons Exp that is Home Produced"
	
label var																	///
	sex_head_female_93														///
	"HHEXP: Avg Gender of HH.head (0:M;1:F)"
	
label var																	///
	ricevb_93																///
	"MINOT: Value of bought rice 1000VND"
	
label var																	///
	ricevh_93																///
	"MINOT: Value of home produced rice 1000VND"
	
label var																	///
	riceqb_93																///
	"MINOT: Quantity of bought rice kg?"
	
label var																	///
	riceqh_93																///
	"MINOT: Quantity of home produced rice kg?"
	
label var																	///
	maizev_93																///
	"MINOT: Value of maize 1000VND"
	
label var																	///
	maizeq_93 																///
	"MINOT: Quantity of maize kg?"
	
label var																	///
	maniocv_93																///
	"MINOT: Value of manioc 1000VND"
	
label var																	///
	maniocq_93																///
	"MINOT: Quantity of manioc kg?"
	
label var																	///
	swpotv_93																///
	"MINOT: Value of sweet potatoes 1000VND"
	
label var																	///
	swpotq_93																///
	"MINOT: Quantity of sweet potatoes kg?"
	
label var																	///
	ricexpd_93																///
	"93: Expenditure on rice 1000VND"
	
label var																	///
	nonrice_93																///
	"93: Expenditure on food, no rice 1000VND"
	
label var																	///
	totnfdx1_93																///
	"93: Expenditure on non-food purchased/bartered 1000VND"
	
label var																	///
	totnfdh1_93																///
	"93: Value of home production of non-food"														
	
label var																	///
	nonfood1_93																///
	"93: Avg non-food expenditure, current 1000VND"
	
label var																	///
	pcfdex1_93																///
	"93: Exp per cap on food(stuffs), current price 1000VND"
	
label var																	///
	rcpi_93																	///
	"93: Avg regional price deflator for district"
	
label var																	///
	mcpi_93																	///
	"93: Avg monthly price deflator for district"
	
label var																	///
	CONSCHANGEHH															///
	"VLSS: Avg HH Cons Change 93-98, in 98 1000VND adj reg/mo price diffs"
	
label var																	///
	CONSCHANGEP																///
	"VLSS: Avg HH Percap Cons Change 93-98, in 98 1000VND adj reg/mo price diffs"
	
label var																	///
	CONSGROWTHHH															///
	"VLSS: Avg HH Cons %Change 93-98, adj reg/mo price diffs"
	
label var																	///
	count_hh 																///
	"COUNT: #HH Sampled in district"
	
label var																	///
	count_avgill4wks 														///
	"COUNT: #HH within district with non-missing 'avgill4wks'"
	
label var																	///
	count_avghospital12mths 												///
	"COUNT: #HH with in district with non-missing 'avghospital12mths'"
	
label var																	///
	count_ed98father														///
	"COUNT: #HH with in district with non-missing 'ed98father'"
	
label var																	///
	count_ed98mother														///
	"COUNT: #HH with in district with non-missing 'ed98mother'"
	
label var																	///
	count_workedpast12mo													///
	"COUNT: #HH with in district with non-missing 'workedpast12mo'"
	
label var																	///
	count_yearsinwork													    ///
	"COUNT: #HH with in district with non-missing 'yearsinwork'"
	
label var																	///
	count_salary 															///
	"COUNT: #HH with in district with non-missing 'salary'"
	
label var																	///
	count_bornhere															///
	"COUNT: #HH with in district with non-missing 'bornhere'"

label var 																	///
	count_yrshere															///
	"COUNT: #HH with in district with non-missing 'yrshere'"

label var 																	///
	rlpcex1_9398 															///
	"Avg Cons exp per cap 93 and 98, in 98 1000VND, adj for reg/mo price diff"

sort district

tempfile vlss

save `vlss'

merge m:m district using `district_bombing', nogen

sort district

gen area_tot_km2_2 = area_tot_km2^2

gen popdensity6061 = popdensity1961

gen log_popdensity6061 = log(popdensity6061)

gen paddyyield6061 = paddyyieldperhectare1961

gen log_paddyyield6061 = log(paddyyieldperhectare1961)

gen south = (popdensity1960_n==.)

gen south_popdensity6061 = south*popdensity6061

gen south_paddyyield6061 = south*paddyyield6061

gen south_tot_bmr = south*tot_bmr

gen south_tot_bmr_per = south*tot_bmr_per

gen south_log_tot_bmr_per = south*log_tot_bmr_per

gen south_tot_bmr_hi = south*tot_bmr_hi

gen south_General_Purpose = south*General_Purpose

gen south_war_f1 = south*war_f1

gen south_north_lat = south*north_lat

gen south_diff_17 = south*diff_17

replace popdensity6061 = popdensity1960_n 									///
	if popdensity6061== .

replace paddyyield6061 = paddyyieldperhectare1960_n 					    ///
	if paddyyield6061== .

replace log_paddyyield6061 = log(paddyyieldperhectare1960_n) 				///
	if log_paddyyield6061== .

// Create province bombing measures
foreach vio in																///
	tot_bmr																	///
	tot_bmr_hi																///										
	tot_bomb																///
	war_f1																	///
	war_f2{
		egen `vio'_prov = mean(`vio'), by(province)
		}
		
gen log_tot_bmr_prov = log(tot_bmr_prov)

// Define samples
gen sample_all = 1

replace sample_all = 0 														///
	if (																	///
	poverty_p0 == . |														///
	tot_bmr == . |															///
	tot_bmr_per == . |														///
	tot_bmr_per>1000 | 														///
	popdensity6061 == . |													///
	south == . |															///
	pre_avg == . |															///
	soil_1 == .																///
	)

gen rural = 1

replace rural = 0 															///
	if (																	///
	paddyyield6061== . |													///
	provincename=="Ho Chi Minh (City)" | 									///
	provincename=="Ha Noi (City)" | 										///
	provincename=="Da Nang (City)" | 										///
	provincename=="Hai Phong (City)"										///
	)
	
replace paddyyield6061 = .													///
	if rural==0

gen central = 0

replace central = 1 if (													///
	sample_all==1 & 														///
	(region==4 | region==5 | region==6 | region==7) & 						///
	provincename~="Ho Chi Minh (City)" & 									///
	provincename~="Da Nang (City)"											///
	)

keep if sample_all == 1

label var																	///
	elec_rate																///
	"District electricity, 1999"
	
label var																	///
	lit_rate																///
	"District literacy rate, 1999"
	
label var																	///
	rlpcex1_93																///
	"Per capita expenditures, 1993"
	
label var																	///
	rlpcex1																	///
	"Per capita expenditures, 1998"
	
label var																	///
	CONSGROWTHPC															///
	"Per capita expenditures growth, 1993-98"
	
label var																	///
	notbornhere																///
	"Proportion not born in district, 1998"
		
label var																	///
	north_lat																///
	"Degrees North Latitude"
	
label var																	///
	diff_17																	///
	"Abs value of (Latitude - 17 degrees)"
	
label var																	///
	east_long																///
	"Degrees East Longitude"
	
tempfile district_bombing

save `district_bombing'

save "$data/clean/district_bombing.dta", replace

/*-----------------------------------


B. PROVINCE LEVEL


-----------------------------------*/

use `district_bombing'

collapse																	///
	$ord0																	///
	$ord1																	///
	$ord2																	///
	$ord3																	///
	$ord3_per																///
	$ord4																	///
	$ord5																	///
	$ord6																	///
	$ord7																	///
	$ord8																	///
	log_tot_bmr*															///
	tot_bmr*																///
	tot_bomb*																///
	war_f1																	///
	war_f2																	///
	log_popdensity*															///
	popdensity*																///
	log*paddy*																///
	paddyyield*																///
	births*																	///
	south*																	///
	region																	///
	pop_prov																///
	sample*																	///
	central																	///
	rural																	///
	diff_17*																///
	(sum) area_sum	= area_tot_km2											///
	(sum) tot_bmr_sum = tot_bmr												///
	(sum) tot_bomb_sum = tot_bomb											///
	(sum) General_Purpose_sum = General_Purpose							    ///
	(sum) Mine_sum = Mine													///
	(sum) pop_tot_sum = pop_tot												///
	if sample_all==1, by(province)

replace popdensity1999 = pop_tot_sum/area_sum

replace log_popdensity1999 = log(popdensity1999)

replace tot_bmr = tot_bmr_sum

replace tot_bmr_2 = (tot_bmr)^2

replace log_tot_bmr = log(tot_bmr)

replace tot_bmr_per = tot_bmr/area_sum

replace tot_bmr_per_2 = (tot_bmr_2)^2

replace log_tot_bmr_per = log(tot_bmr_per)

replace tot_bomb = tot_bomb_sum

replace tot_bomb_per = tot_bomb/area_sum

replace Mine = Mine_sum

replace mine_per = Mine/area_sum

replace log_popdensity6061 = log(popdensity6061)

replace log_paddyyield6061 = log(paddyyield6061)

replace General_Purpose = General_Purpose_sum

label var 																	///
	popdensity1999															///
	"Population Density 1999"

label var																	///
	log_popdensity1999														///
	"Log(Population Density 1999)"

label var																	///
	tot_bmr																	///
	"Total # of U.S. bombs, missiles, rockets"
	
label var																	///
	log_tot_bmr																///
	"Log(Total # of U.S. bombs, missiles, rockets)"
	
label var																	///
	tot_bmr_per																///
	"Total U.S. bombs, missiles, rockets per km2"
	
label var																	///
	log_tot_bmr_per															///
	"Log(Total U.S. bombs, missiles, rockets per km2)"
	
label var																	///
	tot_bomb 																///
	"Total # of U.S. bombs"
		
label var																	///
	tot_bomb_per															///
	"Total U.S. bombs per km2"
		
label var																	///
	General_Purpose															///
	"Total # of U.S. general purpose bombs"
		
label var																	///
	tot_bmr_hi																///
	"Prop. districts where Total U.S. bombs, missiles, rockets > 355000"
	
label var																	///
	tot_bmr																	///
	"Total # of U.S. mines"
	
label var																	///
	mine_per																///
	"Total U.S. mines per km2"
	
label var																	///
	popdensity6061															///
	"Population Density 1960-61"
	
label var																	///
	log_popdensity6061														///
	"Log(Population Density 1960-61)"
	
label var																	///
	paddyyield6061															///
	"Paddy yield, 1960-61"
	
label var																	///
	log_paddyyield6061														///
	"Log(Paddy yield, 1960-61)"

tempfile province_bombing

save `province_bombing'

/*
Poverty metrics
*/

use `district_bombing'

collapse																	///
	lit_rate																///
	elec_rate																///
	radio_rate																///
	urban_pct																///
	percent_cultivated														///
	[aw=pop_tot]															///
	if sample_all==1, by(province)

label var																	///
	elec_rate														        ///
	"District electricity, 1999"
	
label var																	///
	lit_rate	          											        ///
	"District literacy rate, 1999"

sort province

merge m:m province using `province_bombing', nogen

tempfile province_bombing

save `province_bombing'

/*
Climate disctrict controls
*/


// Prueba comienza aca

use `district_bombing'														///

collapse																	///
	$x_gis,																    ///															
	by(province)
	
sort province

rename north_lat lat_prue

merge m:m province using `province_bombing', nogen

sort province

tempfile province_bombing

save `province_bombing'

// Termina aca

use `district_bombing'														///

collapse																	///
	$x_weather																///
	$x_elev																	///
	$x_gis																	///
	$x_soil1																///
	$x_soil2																///
	$x_slope																///
	east_long																///
	[aw=area_tot_km2]														///
	if sample_all==1, by(province)
	
sort province

merge m:m province using `province_bombing', nogen

sort province

tempfile province_bombing

save `province_bombing'

drop if sample_all ~= 1

sort province

tempfile province_bombing

save `province_bombing'

use `district_bombing'													

keep 																		///
	province																///
	provincename			
	
sort province

drop if 																	///
	province[_n-1] == province[_n]

merge m:m province using `province_bombing', nogen

sort province

tempfile province_bombing

save `province_bombing'

insheet using "$data/raw/ifpri/SES-data-prov.csv", clear

rename 																		///
	p0 poverty_p0
	
rename																		///
	exppc pcexp_99

keep																		///
	province																///
	poverty_p0																///
	pcexp_99																///
	gini
	
label var																	///
	poverty_p0															    ///
	"District poverty rate, 1999"
	
label var																	///
	pcexp_99															    ///
	"District per capita consumption expenditures, 1999"
	
label var																	///
	gini															        ///
	"District GINI coefficient, 1999"

merge m:m province using `province_bombing', nogen

sort province

tempfile province_bombing

sort province

save `province_bombing'

/*
Population
*/

insheet using "$data/raw/misc/pop_trends_jan05.csv", clear

keep																		///
	province																///
	pop*
	
sort province

merge m:m province using `province_bombing', nogen

foreach num in															    ///
	1990																	///
	1992																	///
	1994																	///
	1996																	///
	1998																	///
	2000{
		gen popdensity`num' = pop_`num'/area_sum
		
		label var														    ///
			popdensity`num'													///
			"Population Density `num'"
		}

tempfile province_bombing

sort province

save `province_bombing'

insheet using "$data/raw/misc/vietnam_data_31jan05.csv", clear

keep province industry_00 classrooms_99 phones_00

sort province

tempfile vietnam_data

save `vietnam_data'

use `province_bombing'

merge m:m province using `vietnam_data', nogen

sort province

replace industry_00 = industry_00/pop_prov

replace classrooms_99 = classrooms_99/pop_prov

replace phones_00 = phones_00/pop_prov

tempfile province_bombing

sort province

save `province_bombing'

// Earlier data by province

use "$data/raw/quoc/vn_oldyearbooks_20may05"

foreach num in																///
	76																		///
	77																		/// 
	78																		/// 
	79																		///
	80																		///
	81																		///
	82																		///
	83																		///
	84																		///
	85{
		gen pupils_`num' =													/// 
		pupils1_`num' + 													///
		pupils2_`num' + 													///
		pupils3_`num'									
		}

keep																		/// 
	province																///
	pupils_* 																///
	food2_*																	///
	pop_76-pop_85															///
	invest_76-invest_85														///
	output_81-output_85

gen invest_85_per = invest_85/pop_85

gen output_85_per = output_85/pop_85

gen food2_85_per = food2_85/pop_85

gen pupils_85_per = pupils_85/pop_85

sort province

tempfile old_book

save `old_book'

use `province_bombing'

merge m:m province using `old_book', nogen

foreach num in																///
	76																		///
	77																		/// 
	78																		/// 
	79																		///
	80																		///
	81																		///
	82																		///
	83																		///
	84																		///
	85{
		gen popdensity19`num' = pop_`num'*1000/area_sum
		replace popdensity19`num' = . if popdensity19`num' == 0
		}

gen ch_popdensity_20001990 = popdensity2000 - popdensity1990

gen ch_popdensity_20001985 = popdensity2000 - popdensity1985

gen ch_popdensity_20001976 = popdensity2000 - popdensity1976

tempfile province_bombing

sort province

save `province_bombing'

use "$data/raw/vlss/hhvlssALLcollapse_province_panel"

sort province

tempfile vlss_prov

save `vlss_prov'

use `province_bombing'

merge m:m province using `vlss_prov', nogen

replace exppc02r98 = exppc02r98*100

gen consgrowth_9398 = (rlpcex1 - exppc93r98)/exppc93r98

gen consgrowth_9302 = (exppc02r98 - exppc93r98)/exppc93r98

foreach yr in																///
	1931																	///	
	1936																	///
	1941																	///
	1946																	///
	1951																	///
	1956																	///
	1961																	///
	1966																	///
	1971																	///
	1976{
		gen temp_f = height_f`yr'
		
		replace temp_f = 0 if height_f`yr' == .
	
		gen weight_f = hnum_f`yr'
		
		replace weight_f = 0 if hnum_f`yr' == .

		gen temp_m = height_m`yr'
		
		replace temp_m = 0 if height_m`yr' == .
		
		gen weight_m = hnum_m`yr'
		
		replace weight_m = 0 if hnum_m`yr' == .

		gen height_`yr' = (													///
			weight_f*temp_f + 												///
			weight_m*temp_m)/(weight_f+weight_m								///
		)
		
		gen hnum_`yr' = (													///
			weight_f +														///
			weight_m 														///
		)
		
		gen prop_`yr' = (weight_f)/(hnum_`yr')

		drop temp_f temp_m weight_f weight_m
		}

foreach num in																///
	3 																		///
	4 																		///
	5 																		///
	6 																		///
	7{
		gen height_`num'1`num'6 = (											///
			hnum_19`num'1*height_19`num'1 + 								///
			hnum_19`num'6*height_19`num'6)/(hnum_19`num'1 + 				///
			hnum_19`num'6													///
		)
		gen hnum_`num'1`num'6 = (											///
			hnum_19`num'1 + 												///
			hnum_19`num'6													///
		)

		gen prop_`num'1`num'6 = (											///
			hnum_19`num'1*prop_19`num'1 + 									///
			hnum_19`num'6*prop_19`num'6)/(hnum_19`num'1 + 					///
			hnum_19`num'6													///
		)
		}

foreach num in																///
	3																		///
	4																		///
	5																		///
	6																		///
	7{
		gen height_`num'1`num'6_3136 = height_`num'1`num'6 - height_3136	///
	
		gen prop_`num'1`num'6_3136 = prop_`num'1`num'6 - prop_3136			///
	
		gen height_`num'1`num'6_4146 = height_`num'1`num'6 - height_4146	///
	
		gen prop_`num'1`num'6_4146 = prop_`num'1`num'6 - prop_4146			///
	
		gen height_`num'1`num'6_5156 = height_`num'1`num'6 - height_5156	///
	
		gen prop_`num'1`num'6_5156 = prop_`num'1`num'6 - prop_5156			///

		gen temp_f1 = height_f19`num'1
		
		replace temp_f1 = 0 												///
			if height_f19`num'1 == .
		
		gen weight_f1 = hnum_f19`num'1
		
		replace weight_f1 = 0 												///
			if hnum_f19`num'1 == .
		
		gen temp_f6 = height_f19`num'6
		
		replace temp_f6 = 0 												///
			if height_f19`num'6 == .										
			
		gen weight_f6 = hnum_f19`num'6
		
		replace weight_f6 = 0 												///
			if hnum_f19`num'6==.
	
		gen temp_m1 = height_m19`num'1
		
		replace temp_m1 = 0 												///
			if height_m19`num'1 == .
		
		gen weight_m1 = hnum_m19`num'1
		
		replace weight_m1 = 0 												///
			if hnum_m19`num'1==.
	
		gen temp_m6 = height_m19`num'6
		
		replace temp_m6 = 0  												///
			if height_m19`num'6 == .
		
		gen weight_m6 = hnum_m19`num'6
		
		replace weight_m6 = 0  												///
			if hnum_m19`num'6 == . 
	
		gen height_f`num'1`num'6 = ( 										///
			weight_f1*temp_f1 + 											///
			weight_f6*temp_f6 												///
			)/(weight_f1 + weight_f6)
		
		gen height_m`num'1`num'6 = (										///
			weight_m1*temp_m1 + 											///
			weight_m6*temp_m6 												///
			)/(weight_m1 + weight_m6)
	
		drop temp_f* temp_m* weight_f* weight_m*
}

tempfile province_bombing

sort province

save `province_bombing'


use "$data/raw/hamla/hamla_1may05.dta"

drop province

rename province_code province

rename dev_score hamla_dev_score

label var hamla_dev_score "1967 Avg SES, Province"

sort province

tempfile hamla

save `hamla'

use `province_bombing'

sort province

merge m:m province using `hamla', nogen

drop sample_all

gen sample_all = 1

replace sample_all = 0 														///
	if (																	///
	poverty_p0 == . |														///
	tot_bmr == . |															///
	tot_bmr_per == . | 														///
	popdensity6061 == . | 													///
	south == . |															///
	pre_avg == . | 															///
	soil_1 == . |															///
	age_head02 == . |														///
	age_head == . |															///
	age_head93 == .															///
	)

save "$data/clean/province_bombing.dta", replace
	

