clear
capture log close
set more off
set mem 60m
set matsize 800
#delimit ;

log using war_oct04, t replace;


/* DATA CONSTRUCTION */;
cd DSCA;
use DSCAdata;
sort district;
save DSCAdata, replace;
clear;


cd ..;
cd IFPRI;
use GIS_var1;
save temp1, replace;
/* USE THESE VARIABLES BOTH AS DISTRICT CONTROLS AND OUTCOMES */;

/* DISTRICT GEOGRAPHIC CONTROLS */;
rename district_code district;

rename _ha__arable_land ha_arable;
/* ANOTHER GOOD CONTROL: navigable river length, NAV_RIV_LENGTH */;

rename percentage_of_total_area_by_elev area_0_250m;
gen area_over_1000m = area_1001 + area_over_1500m;
/* ELEV_STD HAS NOT PREDICTIVE POWER */;
/* OMITTED CATEGORY = LOW ELEVATION */;
global x_elev = "area_251 area_501 area_over_1000m";

rename percentage_of_total_area_by_slop slp_c1;
gen slp_c45 = slp_c4 + slp_c5;
/* OMITTED CATEGORY = 1 */;
global x_slope = "slp_c2 slp_c3 slp_c45";

rename percentage_of_total_area_by_soil soil_1;
/* ONLY CONSIDER THOSE SOIL TYPES ACCOUNTING FOR AT LEAST
ONE PERCENT OF VIETNAMESE LAND AREAS, THE MINOR SOIL TYPES
ARE THE OMITTED CATEGORY. 18 DISTINCT SOIL TYPES */;
global x_soil1 = "soil_1 soil_3 soil_6 soil_7 soil_8 soil_9 soil_10 soil_11 soil_12";
global x_soil2 = "soil_14 soil_24 soil_26 soil_33 soil_34 soil_35 soil_39 soil_40 soil_41";

/* GEOGRAPHIC ISOLATION */;
rename mean dist_p_town_mean;
rename mean_1 dist_d_town_mean;

global x_oth = "ha_arable nav_riv_length";


/* DISTRICT OUTCOMES */;
rename percentage_of_total_area_under_  percent_cultivated;
rename market_variables_no_markets num_markets;
rename length_of_roads_by_type_length_t length_tot;
/* OTHER ROAD VARIABLES LENGTH_MAIN, LENGTH_MINOR */;

sort district;
save temp1, replace;
clear;


use GIS_var2a;
save temp2, replace;
/* DISTRICT GEOGRAPHIC CONTROLS */;

/* PRECIPITATION */;
foreach var in
	pre tmp hum sun
{;
gen `var'_avg = (`var'_avg_jan + `var'_avg_feb + `var'_avg_mar + `var'_avg_apr
	+ `var'_avg_may + `var'_avg_jun + `var'_avg_jul + `var'_avg_aug
	+ `var'_avg_sep + `var'_avg_oct + `var'_avg_nov + `var'_avg_dec)/12;
/* STANDARD DEVIATION ACROSS MONTHS */;
egen `var'_sd = rsd(`var'_avg_jan `var'_avg_feb `var'_avg_mar `var'_avg_apr
	`var'_avg_may `var'_avg_jun `var'_avg_jul `var'_avg_aug
	`var'_avg_sep `var'_avg_oct `var'_avg_nov `var'_avg_dec);
drop `var'_avg_*;
};

/* TEMPERATURE AND SUN ARE HIGHLY CORRELATED, ONLY INCLUDE TEMPERATURE */;
global x_weather = "pre_avg pre_sd tmp_avg tmp_sd hum_avg hum_sd";

sort district;
save temp2, replace;
clear;

insheet using SES-data.csv, clear; sort district;
merge district using temp1;
tab _merge; drop _merge;

sort district;
merge district using temp2;
tab _merge; drop _merge;


cd ..;
cd DSCA;
sort district;
merge district using DSCAdata;

drop _merge*;
save temp1, replace;

cd ..;

label var poverty_p0 "District poverty rate, 1999";

/* GENERATE PROPORTIONS FROM POVERTY MAPPING */
gen lit_rate = literate_15plus/pop_15plus;
gen illit_rate = 1 - lit_rate;

gen elec_rate = hh_elec/no_hh;
gen tv_rate = hh_tv/no_hh;
gen radio_rate = hh_radio/no_hh;

gen urban_pct = pcturban/100;

/* GENERATE PROVINCE FE */;
/* # DISTRICTS / PROVINCE */;
tab province, gen(Iprovince);
drop Iprovince1;

egen pop_prov = sum(pop_tot), by(province);

/* ORDNANCE */;
/* Chemical, Grenade, Fuel_Air_Explosive, Submunition - almost no variation, drop */;
/* A, AC, ACC, HCC, HCP, HCPD, HCVT, HP, HVTF - almost no variation, drop */;
/* MK, MK07, MK70, MK8 - almost no variation, drop */;
/* RAGON, SHRKE, VC, VTN, VTNSD, VTSD, W - almost no variation, drop */;

/* IS AMMUNITION A MEASURE OF OVERALL COMBAT ACTIVITY? */;

global ord0 = "Ammunition";
global ord1 = "General_Purpose Cluster_Bomb Missile Rocket Cannon_Artillery";
global ord2 = "Incendiary WP";
global ord3 = "Mine";

/* THESE BELOW TEND TO HAVE LITTLE PREDICTIVE POWER / LITTLE VARIATION */;
global ord4 = "AAC";
global ord5 = "HE HECVT HEPD";
global ord6 = "ILL ILLUM ILUM";
global ord7 = "MK10 MK12 MK7";
global ord8 = "RAP VT";

/* HOW TO PROXY FOR OVERALL MILITARY ACTIVITY? */;
/* IT TURNS OUT THAT THESE MEASURES ARE VERY HIGHLY CORRELATED */;
pwcorr $ord0 $ord1 $ord2 $ord3 [aw=pop_tot], star(0.05);

/* TWO METHODS -
	1) SUM UP TOTAL BOMBS, MISSILES, ETC
	2) CREATE AN INDEX BASED ON PRINCIPAL COMPONENTS (COMMAND: PCA)
*/;

/* METHOD 1 */;
gen tot_bmr  = General_Purpose + Cluster_Bomb + Missile + Rocket + Cannon_Artillery;
label var tot_bmr "Total # of U.S. bombs, missiles, rockets";

gen tot_bomb = General_Purpose + Cluster_Bomb;
label var tot_bomb "Total # of U.S. bombs";

label var General_Purpose "Total # of U.S. general purpose bombs";


/* METHOD 2 - ONLY RETAIN STATISTICALLY SIGNIFICANT EIGENVECTORS */;
pca $ord0 $ord1 $ord2 $ord3 [aw=pop_tot], mineigen(1);

score war_f1 war_f2;
label var war_f1 "U.S. war intensity index (eigenvector 1)";
label var war_f2 "U.S. war intensity index (eigenvector 2)";

sort district; save temp1, replace;


/* PRE-WAR DATA, VLSS DATA */;
**//PRE-WAR DATA;  
**//NOTE: PER UNIT AREA VARS MORE INTUITIVELY ACCURATE, SINCE THERE WAS NO NEED TO NORMALIZE OVER AREA 
	TO DEAL WITH SHIFTING BOUNDARIES.
I.E., PER-UNIT-AREA, PRE-WAR DISTRICT FIGURES ARE JUST WEIGHTED AVGS OF THE VALUES OF THE PRE-WAR PROVINCES 
	THAT CONTAINED THEM.
NON-PER-UNIT-AREA FIGURES ARE CALCULATED, E.G., AS WEIGHTED-AVG[PROVINCEENTRY1960/PROVINCEAREA1960]*DISTRICTAREA1999;
clear;

cd "Pre-War Data"; use prewardt.dta; save temp1.dta, replace;
**//LABELS;
label var cerealprod_padval1960_n "Output of Cereals, in tons of paddy value, 1960";
label var cerealprod_padval1965_n "Output of Cereals, in tons of paddy value, 1965";
label var cerealprodpercap_pv_kgper1960_n "Output of Cerals per cap, kg of paddy vaule per person, 1960";
label var cerealprodpercap_pv_kgper1965_n "Output of Cerals per cap, kg of paddy vaule per person, 1965";
label var plantedarea_crop1960_n "Planted Crop Area, Hectares, 1960";
label var plantedarea_crop1965_n "Planted Crop Area, Hectares, 1965";
label var plantedarea_nonpadc1960_n "Planted Non-Paddy Crop Area, Hectares, 1960";
label var plantedarea_nonpadc1965_n "Planted Non-Paddy Crop Area, Hectares, 1965";
label var plantedarea_total1960_n "Planted Total Area, Hectares, 1960";
label var plantedarea_total1965_n "Planted Total Area, Hectares, 1965";
label var popdens_pctdis1960_n "Avg % Disagreemnt b/t Underlying Backed-Out Pop Figures, 1960";
label var popdens_pctdis1965_n "Avg % Disagreemnt b/t Underlying Backed-Out Pop Figures, 1965";
label var popdensity1960_n "PopDensity, per km2, backed-out from cereal/paddy percap (avg), 1960";
label var popdensity1960_n "PopDensity, per km2, backed-out from cereal/paddy percap (avg), 1960";
foreach year in 1961 1962 1963{; label var rubberplanted`year' "Rubber Planted Area, Hectares, `year'";}; 
foreach year in 1958 1959 1961 1962 1963{; 
	label var rubberworkable`year' "Rubber Workable Area, Hectares, `year'";
	label var rubberworked`year' "Rubber Worked Area, Hectares, `year'";
	label var rubberworkedtoworkable`year' "Rubber Ratio Worked/Workable, `year'";};
sort district; save temp1.dta, replace;
cd ..;
merge district using temp1.dta; tab _merge; drop _merge; sort district; 
save temp1.dta, replace;

**//VLSS DATA;
cd "VLSS"; use VLSScommune.dta; save temp1.dta, replace;
label var sex_head_female "HHEXP: Avg Gender of HH.head (0:M;1:F)";
label var age_head "HHEXP: Avg Age of HH.head";
label var agegroup_head "HHEXP: Avg AgeGroup of HH.head"; 
	label define agegroup 1 "under 20" 2 "from 20" 3 "from 30" 4 "from 40" 5 "from 50" 6 "from 60" 7 "70 or ab";
	label val agegroup_head agegroup;
label var comped98_head "HHEXP: Avg completed diploma HH.head";
	/*DIPLOMA LABELS TRANSLATED BY KHUYEN*/ label define diploma 0 Never 1 "Nhatre = Kindergarten" 
	2 "<cap I = <primary" 3 "Cap I = Primary" 4 "Cap II = Lower Sec" 5 "Cap III = Higher Sec" 6 "Nghe SC = Voc Training" 
	7 "THCN = Secondary Voc Training" 8 DHDC 9 "DHCD = Bachelors" 10 "Thac sy = Masters" 11 "PTS = PhD Candidate" 
	12 "TS = PhD", modify;
	label val comped98_head diploma;
label var educyr98_head "HHEXP: Avg schooling years of HH.head";
label var farm "Type of HH (1:farm; 0:nonfarm)";
label var urban98 "1:urban 98, 0:rural 98";
label var urban92 "1:urban 92, 0:rural 92";
label var avg_ill4wks "HH: Avg of Avg days ill in past 4wks (all HH members)";
label var avg_hospital12mths "HH: Avg of Avg days spent in hospital past 12mths (all HH members)";
label var literate "HH: ED: Can you read this sentence?"; label define literate 3 "yes w/o difficulty" 2 "yes w/ difficulty" 1 "only in other lang" 0 no; label val literate literate;
label var numerate "HH: ED: Can you do these calculations?"; label define numerate 2 "yes w/o difficulty" 1 "yes w/ difficulty" 0 no; label val numerate numerate;
label var ricexpd "HHEXP: Avg Value rice expenditures, current 1000VND";
label var nonrice "HHEXP: Avg Value food expenditures no rice, current 1000VND";
label var totnfdx1 "HHEXP: Avg Value Nonfood exp.purchase/barter, current 1000VND (comp 93)";
label var totnfdhp "HHEXP: Avg Value Nonfood home production, current 1000VND";
label var totnfdh1 "HHEXP: totnfdhp, excl. coal,wood,sawdust,chaff consumed, current 1000VND (comp 93)";
label var food "HHEXP: Avg Exp on food/foodstuff, current 1000VND (comp 93)";
label var nonfood1 "HHEXP: Avg Exp on non-food(stuffs), current 1000VND (comp 93)";
label var hhexp1 "HHEXP: Avg total exp = food + nonfood1, current 1000VND (comp 93)";
label var pcexp1 "HHEXP: Avg Exp per Cap = hhexp1/hhsize, current 1000VND (comp 93)";
label var pcfdex1 "HHEXP: Avg exp per cap food/foodstuff = food/hhsize, current 1000VND (comp 93)";
label var rlfood "HHEXP: Avg Exp on food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)";
label var rlnfd1 "HHEXP: Avg Exp on non-food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)";
label var rlhhex1 "HHEXP: Avg total exp, adj for reg/mo prices, 1998 1000VND (comp 93)";
label var rlpcex1 "HHEXP: Avg Exp per cap, adj for reg/mo prices, 1998 1000VND (comp 93)";
label var rlpcfdex "HHEXP: Avg exp per cap on food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)";
label var nonfood2 "HHEXP: Avg Exp on non-food(stuffs), current 1000VND (not comp 93)";
label var hhexp2 "HHEXP: Avg total exp = food + nonfood2, current 1000VND (not comp 93)";
label var pcexp2 "HHEXP: Avg Exp per Cap = hhexp2/hhsize, current 1000VND (not comp 93)";
label var hhexp2 "HHEXP: Avg total exp = food + nonfood2, current 1000VND (not comp 93)";
label var pcexp2 "HHEXP: Avg exp per cap = hhexp2/hhsize, current 1000VND (not comp 93)";
label var rlhhex2 "HHEXP: Avg total exp, adj for reg/mo prices, 1998 1000VND (not comp 93)";
label var rlpcex2 "HHEXP: Avg Exp per cap, adj for reg/mo prices, 1998 1000VND (not comp 93)";

label var factorydistance_min "COM: EXP: min(factorydistance*) across district";
label var factorylabor_sum "COM: EXP: sum(factorylabor*) across district";
label var comped98father "HH: EDPAR: Avg of HH.head's Father's highest diploma"; 
	label define diploma0 0 none 1 prim 2 lowsec 3 hisec 4 certif 5 training 6 "tech/prof.sec" 7 jc 8 assoc 9 bach 10 mast 11 "sub-doc" 12 phd 13 "don't know"; 
	label val comped98father diploma0; 
label var comped98mother "HH: EDPAR: Avg of HH.head's Mother's highest diploma"; 
	label val comped98mother diploma0; 
label var educyr98father "HH: EDPAR: Avg of HH.head's Father's yrs formal sch (grade+postsec)";
label var educyr98mother "HH: EDPAR: Avg of HH.head's Mother's yrs formal sch (grade+postsec)";
label var workedpast12mo "HH: EMP: Avg Have you worked (for pay, at your farm, self-employed) in past 12 mo?";
label var yearsinwork "HH: EMP: Avg How many years have you been doing mainjob?";
label var salary "HH: EMP: Avg Have you ever or will you receive salary or wage for mainjob, inc. pay-in-kind?";
label var bornhere "HH: IMM: Avg Born in current district?";
label var yrshere "HH: IMM: Avg How many years have you lived in current residence?";
label var dwellingshared "HH: HOUSE: Avg Does your hh share dwelling with another?";
label var dwellingowned "HH: HOUSE: Avg Does a member of your hh own all or part of dwelling? 0=none,1=part,2=all";

drop urb93;
label var calpc93 "MINOT: kcal per cap per day, 1993";
label var calok93 "MINOT: 1 if 3500>=calpc_93>=1000";
label var expb93 "MINOT: Exp Bought/Bartered, Past12mo 1000VND";
label var exph93 "MINOT: Exp Home-Produced, Past12mo 1000VND";
label var exp93  "MINOT: Exp, Past12mo 1000VND";
label var exppc93 "MINOT: Exp per cap, Past12mo 1000VND";
label var fexp93 "MINOT: Exp on Consumption, Past12mo 1000VND";
label var fpct93 "MINOT: Fraction Consumption Exp = fexp_93/exp_93";
label var hfpct93 "MINOT: Fraction of Cons Exp that is Home Produced";
**//label var adults93 
label var children93;
label var infants93;
label var hhsize93;
replace sex_head_female_93=0 if sex_head_female_93==1; label var sex_head_female_93 "HHEXP: Avg Gender of HH.head (0:M;1:F)";
label var ricevb93 "MINOT: Value of bought rice 1000VND";
label var ricevh93 "MINOT: Value of home produced rice 1000VND";
label var riceqb93 "MINOT: Quantity of bought rice kg?";
label var riceqh93 "MINOT: Quantity of home produced rice kg?";
label var maizev93 "MINOT: Value of maize 1000VND";
label var maizeq93 "MINOT: Quantity of maize kg?";
label var maniocv93 "MINOT: Value of manioc 1000VND";
label var maniocq93 "MINOT: Quantity of manioc kg?";
label var swpotv93 "MINOT: Value of sweet potatoes 1000VND";
label var swpotq93 "MINOT: Quantity of sweet potatoes kg?";
foreach varpart in calpc calok expb exph exp exppc fexp fpct hfpct adults children infants hhsize ricevb ricevh riceqb 
	ricexpd nonrice totnfdx1 totnfdh1 nonfood1 pcfdex1
	riceqh maizev maizeq maniocv maniocq swpotv swpotq 
	rcpi mcpi {;
		rename `varpart'93 `varpart'_93;};
/*NOTE: VARS WITH LABELS BEGINNING '93:' ARE CONSTRUCTED TO AGREE WITH VLSS98 HHEXPENDITURE FILE.*/
label var ricexpd_93 "93: Expenditure on rice 1000VND";
label var nonrice_93 "93: Expenditure on food, no rice 1000VND";
label var totnfdx1_93 "93: Expenditure on non-food purchased/bartered 1000VND";
label var totnfdh1_93 "93: Value of home production of non-food";
rename fexp_93 food_93;
label var nonfood1_93 "93: Avg non-food expenditure, current 1000VND";
rename exp_93 hhexp1_93;
rename exppc_93 pcexp1_93;
label var pcfdex1_93 "93: Exp per cap on food(stuffs), current price 1000VND";
rename exp93r98 rlhhex1_93; label var rlhhex1_93 "93: Cons exp 93, in 98 1000VND, adj for reg/mo price diff";
rename exppc93r98 rlpcex1_93; label var rlpcex1_93 "93: Cons exp per cap 93, in 98 1000VND, adj for reg/mo price diff";
label var rcpi_93 "93: Avg regional price deflator for district";
label var mcpi_93 "93: Avg monthly price deflator for district";
label var CONSCHANGEHH "VLSS: Avg HH Cons Change 93-98, in 98 1000VND adj reg/mo price diffs";
label var CONSCHANGEPC "VLSS: Avg HH Percap Cons Change 93-98, in 98 1000VND adj reg/mo price diffs";
label var CONSGROWTHHH "VLSS: Avg HH Cons %Change 93-98, adj reg/mo price diffs";
label var CONSGROWTHPC "VLSS: Avg HH Percap Cons %Change 93-98, adj reg/mo price diffs";
label var count_hh "COUNT: #HH Sampled in district";
label var count_avgill4wks "COUNT: #HH within district with non-missing 'avgill4wks'";
label var count_avghospital12mths "COUNT: #HH with in district with non-missing 'avghospital12mths'";
label var count_ed98father "COUNT: #HH with in district with non-missing 'ed98father'";
label var count_ed98mother "COUNT: #HH with in district with non-missing 'ed98mother'";
label var count_workedpast12mo "COUNT: #HH with in district with non-missing 'workedpast12mo'";
label var count_yearsinwork "COUNT: #HH with in district with non-missing 'yearsinwork'";
label var count_salary "COUNT: #HH with in district with non-missing 'salary'";
label var count_bornhere "COUNT: #HH with in district with non-missing 'bornhere'";
label var count_yrshere "COUNT: #HH with in district with non-missing 'yrshere'";

/*REDEFINE COM LABELS*/
label define cropcodes 1 "Winter Rice" 2 "Autumn Rice" 3 "Winter Rice" 4 "Swidden Rice" 5 "Annual Rice" 6 "Glutinous Rice" 
	7 "Specialty Rice" 8 "Corn/Maize" 9 "Sweet Potatoes" 10 "Cassava/Manioc" 11 "Other Staple Crops" 12 Potatoes 
	13 "Kohlrabi, Cabbage, Cauliflower" 14 "Other Leafy Greens" 15 "Tomatoes" 16 "Water Morning Glory" 17 "Fresh Legumes (Beans)" 
	18 "Dried Legumes (Beans)" 19 "Herbs and Spices" 20 "Other Vegetables, Tubers, and Fruits" 21 "Soy Beans" 22 Peanuts 
	23 "Sesame Seeds" 24 "Sugar Cane" 25 Tobacco 26 Cotton 27 "Jute, Ramie" 28 "Rush (For Making Mats" 29 "Other Annual Industrial Crops" 
	30 "Other Annual Crops" 31 Tea 32 Coffee 33 Rubber 34 "Black Pepper" 35 "Coconut (For Oil, Copra)" 36 Mulberry 37 Cashew 
	38 "Other Perennial Industrial Crops" 39 "Oranges, Limes and Mandarins" 40 Pineapple 41 Bananas 42 Mango 43 Apple 44 Grapes 
	45 Plum 46 Papaya 47 "Litchi, Longan, Rambutan" 48 Sapodilla 49 "Custard Apple" 50 "Jackfruit, Durian" 51 Mangosteen 
	52 "Other Fruit Trees" 53 "Mu Oil Tree" 54 "Cinnamon Tree" 55 "Anise Tree" 56 "Pine Tree" 57 "Varnish Tree" 58 "tree for Wood" 
	59 Bamboo 60 "Fan Palm Tree" 61 "Water Coconut Palm" 62 "Other Silviculture Tree";
label define noschool_reason 1 distance 2 "economic difficulties" 3 "illness/handicap" 4 "don't want to" 5 crowding 6 "parents don't care" 7 "must work" 8 other;
label define geogtype 1 coast 2 "inland delta" 3 "hills/midlands" 4 "low mts" 5 "hi mts";
label define maininc 1 agriculture 2 forestry 3 "aquatic products" 4 industry 5 handicrrafts 6 construction 7 trade 8 transport 9 services 10 other; 
label define changelivstdreason 1 "changes in agro policy" 2 "expansion in non-agro production" 3 weather 4 disaster 5 inflation 6 "changes in ability to obtain educ" 7 "changes in ability to use health svc" 8 "changes in ability to use social svc" 9 other;
label define immigration 1 "more move in than out" 2 "more move out than in" 3 equal 4 "nobody moved in or out"; 
label define infra_imps_type 1 road 2 "drinking water supply" 3 irrigation 4 "land reclamation" 5 "dryland converted to paddy" 6 school 7 "health ctr" 8 electricity 9 "other public inf" 10 other; 
label define illness 1 malaria 2 leprosy 3 goiter 4 tuberculosis 5 "other respiratory" 6 "dengue fever" 7 "childhood illness (diph,measles,polio,tetanus)" 8 "diarrhea/dysentery" 9 "child malnutrition" 10 rabies 11 "accident/injury" 12 "complicated birth" 13 other;

sort district; save temp1.dta, replace;
cd ..;
merge district using temp1.dta; tab _merge; drop _merge; sort district; 


/* SOUTH, NORTH HAVE PREWAR MEASURES FOR SLIGHTLY DIFFERENT YEARS */;
gen popdensity6061 = popdensity1961;
replace popdensity6061 = popdensity1960_n if popdensity6061==.;

gen paddyyield6061 = paddyyieldperhectare1961;
replace paddyyield6061 = paddyyieldperhectare1960_n if paddyyield6061==.;

gen south = (popdensity1960_n==.);
gen south_popdensity6061 = south*popdensity6061;
gen south_paddyyield6061 = south*paddyyield6061;
gen south_tot_bmr = south*tot_bmr;
gen south_General_Purpose = south*General_Purpose;
gen south_war_f1 = south*war_f1;

save temp1.dta, replace;


/* TABLE 1: SUMMARY STATISTICS */;
desc poverty_p0 lit_rate elec_rate radio_rate urban_pct percent_cultivated
	pcexp1 pcexp2 pcexp1_93 CONSGROWTHPC CONSCHANGEPC 
	calpc_93 avg_ill4wks
	literate numerate educyr98father educyr98mother
	factory farm bornhere
	$ord0 $ord1 $ord2 $ord3 /* $ord4 $ord5 $ord6 $ord7 $ord8 */
	tot_bmr tot_bomb war_f1 war_f2
	$x_weather $x_oth $x_soil1 $x_soil2 $x_elev $x_slope 
	popdensity* paddyyield* births* south*
	pop_tot pop_prov;

summ poverty_p0 lit_rate elec_rate radio_rate urban_pct percent_cultivated
	pcexp1 pcexp2 pcexp1_93 CONSGROWTHPC CONSCHANGEPC 
	calpc_93 avg_ill4wks
	literate numerate educyr98father educyr98mother
	factory farm bornhere
	$ord0 $ord1 $ord2 $ord3 /* $ord4 $ord5 $ord6 $ord7 $ord8 */
	tot_bmr tot_bomb war_f1 war_f2
	$x_weather $x_oth $x_soil1 $x_soil2 $x_elev $x_slope 
	popdensity* paddyyield* births* south*
	pop_tot pop_prov [aw=pop_tot];

collapse poverty_p0 lit_rate elec_rate radio_rate urban_pct percent_cultivated
	pcexp1 pcexp2 pcexp1_93 CONSGROWTHPC CONSCHANGEPC 
	calpc_93 avg_ill4wks
	literate numerate educyr98father educyr98mother
	factory farm bornhere
	$ord0 $ord1 $ord2 $ord3 $ord4 $ord5 $ord6 $ord7 $ord8
	tot_bmr tot_bomb war_f1
	$x_weather $x_oth $x_soil1 $x_soil2 $x_elev $x_slope 
	popdensity* paddyyield* births* south*
	pop_prov [aw=pop_tot], by(province);

save temp2, replace;


/* TABLE 2: PREWAR ANALYSIS - WHERE DID THE BOMBS FALL? */;

foreach vio in
	tot_bmr General_Purpose war_f1
{;
regress `vio' south
	[aw=pop_prov], robust;
bys south: regress `vio' 
	popdensity6061 paddyyield6061 
	[aw=pop_prov], robust;
regress `vio' south
	popdensity6061 paddyyield6061 
	south_popdensity6061 south_paddyyield6061
	[aw=pop_prov], robust;
regress `vio' south
	popdensity6061 paddyyield6061 
	south_popdensity6061 south_paddyyield6061
	$x_elev $x_weather
	[aw=pop_prov], robust;
};

clear;


foreach vio in
	tot_bmr /* General_Purpose war_f1 */
{;
use temp1;
/* NON-PARAMETRIC DENSITY */;
kdensity `vio', epanechnikov
	title("Non-parametric kernel density")
	saving(k_`vio', replace);
clear;

foreach var in
	/* CENSUS DATA, TABLES 3-4? */
	poverty_p0 lit_rate elec_rate radio_rate urban_pct /* percent_cultivated */
	/* VLSS DATA, TABLES 5-6? */
	pcexp1 /* pcexp2 */ pcexp1_93 CONSGROWTHPC /* CONSCHANGEPC */
	calpc_93 avg_ill4wks
	literate /* numerate */ educyr98father /* educyr98mother */
	factory farm bornhere
{;

use temp1;
/* NON-PARAMETRIC */;
lowess `var' `vio', saving(`var'_`vio'_1, replace);
lowess `var' `vio' if south==0, saving(`var'_`vio'_1n, replace);
lowess `var' `vio' if south==1, saving(`var'_`vio'_1s, replace);

/* SEMI-PARAMETRIC */;
quietly regress `vio' Iprovince*;
predict `vio'_within, residual;
label var `vio'_within "Within province variation, `vio'";

quietly regress `var' Iprovince*;
predict `var'_within, residual;
label var `var'_within "Within province variation, `var'";

lowess `var'_within `vio'_within,
	saving(`var'_`vio'_w1, replace);
twoway qfitci `var'_within `vio'_within [aw=pop_tot], saving(`var'_`vio'_w2, replace);
/* IT LOOKS LIKE A LOT OF THE ACTION IS DRIVEN BY OUTLIERS
BUT THIS TURNS OUT NOT TO BE THE CASE, SEE BELOW */;
/* DROPPING 10 HIGHEST OUTLIERS, 11 LOWEST OUTLIERS */;
twoway qfitci `var'_within `vio'_within [aw=pop_tot]
	if (tot_bmr<=170000 & tot_bmr>=7), saving(`var'_`vio'_w2b, replace);
drop *_within;

regress `var' `vio' [aw=pop_tot], robust cluster(province);
bys south: regress `var' `vio' [aw=pop_tot], robust cluster(province);
regress `var' `vio'
	south south_`vio' [aw=pop_tot], robust cluster(province);

regress `var' `vio'
	south south_`vio'
	popdensity6061 paddyyield6061 
	south_popdensity6061 south_paddyyield6061
	[aw=pop_tot], robust cluster(province);
regress `var' `vio'
	Iprovince* [aw=pop_tot], robust cluster(province);
areg `var' `vio'
	[aw=pop_tot], a(province) robust cluster(province);
bys south: areg `var' `vio'
	[aw=pop_tot], a(province) robust cluster(province);
areg `var' `vio'
	south south_`vio'
	[aw=pop_tot], a(province) robust cluster(province);
/* WHY THE RELATIONSHIP STRONGER WITHIN PROVINCE THAN
ACROSS PROVINCES? IS THE FORMER BETTER OR WORSE IDENTIFIED? */;

areg `var' `vio' war_f2
	[aw=pop_tot], a(province) robust cluster(province);

/* ROBUST TO DROPPING 10 HIGHEST OUTLIERS, 11 LOWEST OUTLIERS */;
areg `var' `vio'
	[aw=pop_tot]
	if (tot_bmr<=170000 & tot_bmr>=7), a(province) robust cluster(province);

/* ROBUST TO LOGS */;
gen l_`var' = log(`var');
gen l_`vio' = log(`vio');
gen south_l_`vio' = south*l_`vio';
areg l_`var' l_`vio'
	[aw=pop_tot], a(province) robust cluster(province);
bys south: areg l_`var' l_`vio'
	[aw=pop_tot], a(province) robust cluster(province);
areg l_`var' l_`vio'
	south south_l_`vio'
	[aw=pop_tot], a(province) robust cluster(province);
drop l_`var' *l_`vio';

/* POPULATION WEIGHTS STRENGTHEN THE RESULT SOMEWHAT (NOT SHOWN) */;

/* EFFECT OF LAND MINES */;
areg `var' `vio' $ord3
	[aw=pop_tot], a(province) robust cluster(province);
/* DETAILED DISTRICT GEOGRAPHIC, CLIMATIC CONTROLS */;
regress `var' `vio' south
	popdensity6061 paddyyield6061 
	south_popdensity6061 south_paddyyield6061
	$x_weather $x_oth $x_soil1 $x_soil2 $x_elev [aw=pop_tot],
	robust cluster(province);
areg `var' `vio' 
	$x_weather $x_oth $x_soil1 $x_soil2 $x_elev [aw=pop_tot],
	a(province) robust cluster(province);
areg `var' `vio' 
	$x_weather $x_oth $x_elev [aw=pop_tot],
	a(province) robust cluster(province);
bys south: areg `var' `vio'
	$x_weather $x_oth $x_elev [aw=pop_tot],
	a(province) robust cluster(province);
/* OTHER MILITARY MEASURES TYPICALLY DO NOT HAVE MUCH PREDICTIVE POWER */;
areg `var' `vio'
	$ord4 $ord5 $ord6 $ord7 $ord8
	[aw=pop_tot],
	a(province) robust cluster(province);

clear;


/* BETWEEN PROVINCE ANALYSIS */;
use temp2;
regress `var' `vio' [aw=pop_prov], robust;
bys south: regress `var' `vio' [aw=pop_prov], robust;
/* WHY ARE WITHIN / BETWEEN RESULTS SO DIFFERENT FOR LAND MINES? */;
regress `var' `vio' $ord3 [aw=pop_prov], robust;

};

};

log c;
