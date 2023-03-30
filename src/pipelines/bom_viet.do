/*

Program analyzes data at 
district & province level
------------------------------------------

Last modified: 29 March 2023
*/

clear
capture log close
set more off
set mem 100m
set matsize 800
//log using war-analysis_2010-04, text


// Defining globals

global x_elev = "area_251 area_501 area_over_1000m";
global x_slope = "slp_c2 slp_c3 slp_c45";
global x_soil1 = "soil_1 soil_3 soil_6 soil_7 soil_8 soil_9 soil_10 soil_11 soil_12";
global x_soil2 = "soil_14 soil_24 soil_26 soil_33 soil_34 soil_35 soil_39 soil_40 soil_41";
global x_gis = "north_lat";
global x_weather = "pre_avg tmp_avg";
global ord0 = "Ammunition";
global ord1 = "General_Purpose Cluster_Bomb Missile Rocket Cannon_Artillery";
global ord2 = "Incendiary WP";
global ord3 = "Mine";
global ord3_per = "mine_per";

// Little predictive 
// power and variation
global ord4 = "AAC";
global ord5 = "HE HECVT HEPD";
global ord6 = "ILL ILLUM ILUM";
global ord7 = "MK10 MK12 MK7";
global ord8 = "RAP VT";
global x_oth = "area_tot_km2 area_tot_km2_2"
// Total U.S. bombs, missiles, and rockets per km2
global dep_bom = "tot_bmr_per"
global dep_pov = "poverty_p0"
global dep_pop_den = "popdensity1985"
global dep_pop_gro = "ch_popdensity_20001985"
global dep_nborn = "nbhere"

/*-----------------------------------
LOAD DATASETS AS FRAMES
-----------------------------------*/

// District Level

frames reset
frame create district
cwf district
use "../archives/war_data_district_sep09.dta", clear
//use "../dataverse/war_data_district.dta", clear

// Province Level

frame create province
cwf province
use "../archives/war_data_province_sep09.dta"
//use "../dataverse/war_data_province.dta", clear

// List datasets
frame dir

/*-----------------------------------
TABLES
-----------------------------------*/

/*-----------
TABLE 1
-------------

SUMMARY STATISTICS
— U.S. ORDENANCE 
DATA, 1965-1975

-----------*/

/*
PANEL A
*/

summ                                                                        ///
    tot_bmr_per                                                             ///
    tot_bmr                                                                 ///
    $ord1                                                                   ///
    $ord2                                                                   ///
    $ord0                                                                   ///
    if sample_all==1

// Correlation with general purpose bombs

pwcorr                                                                      ///
    tot_bmr_per                                                             ///
    tot_bmr                                                                 ///
    $ord1                                                                   ///
    $ord2                                                                   ///
    $ord0                                                                   /// 
    if sample_all==1                                                        ///
    [aw=pop_tot], star(0.05)

    
/*
PANEL B
*/

cwf province
summ                                                                        ///
    tot_bmr_per                                                             ///
    if sample_all==1                                                        
    
/*-----------
TABLE 2
-------------

SUMMARY STATISTICS
— ECONOMIC, DEMOGRAPHIC,
CLIMATIC AND GEOGRAPHIC 
DATA

-----------*/


/*
PANEL A
*/

cwf district
summ                                                                        /// 
    poverty_p0                                                              ///
    popdensity1999                                                          ///
    elec_rate                                                               ///
    lit_rate                                                                ///
    $x_elev                                                                 ///
    area_tot_km2                                                            ///
    $x_weather                                                              ///
    south                                                                   ///
    $x_gis                                                                  ///
    diff_17                                                                 ///
    if sample_all==1


/*
PANEL B
*/

cwf province
gen nbhere=(1-bornhere)
summ                                                                        ///
    popdensity6061                                                          ///
    popdensity1985                                                          ///
    popdensity1999                                                          ///
    ch_popdensity_20001985                                                  ///
    nbhere                                                                  ///
    exppc93r98                                                              ///
    exppc02r98                                                              ///
    consgrowth_9302                                                         ///
    $x_gis                                                                  ///
    diff_17                                                                 ///
    if sample_all==1


/*-----------
TABLE 3
-------------

PREDICTING BOMBING
INTENSITY

-----------*/

// Excludes soil controls
// due to problems
// with degrees of freedom

// Column 1: Province level

cwf province
regress                                                                     ///
    $dep_bom                                                                ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust
  
summ                                                                        ///
    $dep_bom                                                                ///
    if sample_all==1


// Column 2: District level: All

cwf district
regress                                                                     ///
    $dep_bom                                                                ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust cluster(province)

summ                                                                        ///
    $dep_bom                                                                ///
    if sample_all==1

// Column 3: District level: Exclude Quang Tri

regress                                                                     ///
    $dep_bom                                                                ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1 & provincename~="Quang Tri", robust cluster(province)
    
summ                                                                        ///
    $dep_bom                                                                ///
    if sample_all==1 & provincename~="Quang Tri"

    
/*-----------
TABLE 4
-------------

LOCAL BOMBING
IMPACTS ON ESTIMATED
1999 POVERTY RATE

-----------*/

// (OLS 1)
cwf province
regress                                                                     ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust
    
summ                                                                        ///
    $dep_pov                                                                ///
    if sample_all==1

// (OLS 2)
cwf district
regress                                                                     ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2,                                                               ///
    robust cluster(province)
    
summ $dep_pov                                                                 

// (OLS 3)
areg                                                                        ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1,                                                       ///
    a(province)                                                             ///
    robust cluster(province)
    
summ                                                                        ///
    $dep_pov                                                                ///
    if sample_all==1

// (OLS 4)
regress                                                                     ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if provincename~="Quang Tri" & sample_all==1,                           ///
    robust cluster(province)
    
summ                                                                        ///
    $dep_pov                                                                ///
    if provincename~="Quang Tri" & sample_all==1

// (OLS 5)
regress                                                                     ///
    $dep_pov                                                                ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev $x_gis                                                          ///
    $x_weather                                                              ///
    $x_soil1 $x_soil2                                                       ///
    if sample_all==1, robust cluster(province)
    
summ $dep_pov if sample_all==1

// (IV-2SLS 6)
regress                                                                     ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2(                                                               ///
        diff_17                                                             ///
        popdensity6061                                                      ///
        south                                                               ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        )                                                                   ///
    if sample_all==1, robust cluster(province)
summ $dep_pov if sample_all==1

/*-----------
TABLE 5
-------------

LOCAL BOMBING
IMPACTS ON ESTIMATED
1999 POVERTY RATE
ALTERNATIVE 
SPECIFICATIONS
-----------*/

***5.1 5.2 /* NORTH VERSUS SOUTH */;
bys south: regress poverty_p0 tot_bmr_per 
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
bys south: summ poverty_p0 if sample_all==1;

***5.3 5.4 /* URBAN VERSUS RURAL: WHERE TO MAKE THIS CUT? AT 200/KM2? */;
gen urban_6061 = (popdensity6061>200 & popdensity6061~=.);
bys urban_6061: regress poverty_p0 tot_bmr_per
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
bys urban_6061: summ poverty_p0  if sample_all==1;
drop urban_6061;

***5.5 /* QUADRATIC TERM */;
regress poverty_p0 tot_bmr_per tot_bmr_per_2
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
summ poverty_p0 if sample_all==1;

***5.6  /* TOP 10% OF DISTRICTS */;
regress poverty_p0 tot_bmr_hi
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
summ poverty_p0 if sample_all==1;

/*-----------
TABLE 6
-------------

LOCAL WAR IMPACTS
ON CONSUMPTION
EXPENDITURES 
AND GROWTH

-----------*/


/*-----------
TABLE 7
-------------

LOCAL WAR IMPACTS
ON PHYSICAL 
INFRASTRUCTURE AND
HUMAN CAPITAL

-----------*/

/*-----------
TABLE 8
-------------

LOCAL WAR IMPACTS
ON POPULATION 
DENSITY

-----------*/

// (1)
cwf province

regress  popdensity1999 tot_bmr_per 
	popdensity6061
	south
	$x_elev $x_gis $x_weather /* $x_oth */
	/* $x_soil1 $x_soil2 */
	/* [aw=pop_prov] */
	if sample_all==1, robust;
**summ `var' if sample_all==1;
clear;

use war_data_district;
***8.2 /* DETAILED DISTRICT GEOGRAPHIC, CLIMATIC CONTROLS */;
regress  popdensity1999 tot_bmr_per
	popdensity6061
	$x_weather $x_elev $x_gis /* $x_oth */
	$x_soil1 $x_soil2
	south
	/* [aw=pop_tot] */,
	robust cluster(province);
**summ popdensity1999;

***8.3 /* PROVINCE FE */;
areg popdensity1999 tot_bmr_per
	$x_weather $x_elev $x_gis /* $x_oth */
	$x_soil1 $x_soil2
	/* [aw=pop_tot] */
	if sample_all==1,
	a(province) robust cluster(province);
**summ popdensity1999 if sample_all==1;

***8.4 /* EXCLUDE QUANG TRI */;
regress popdensity1999 tot_bmr_per
	popdensity6061
	$x_weather $x_elev $x_gis /* $x_oth */
	$x_soil1 $x_soil2
	south
	/* [aw=pop_tot] */
	if provincename~="Quang Tri" & sample_all==1,
	robust cluster(province);
**summ popdensity1999 if provincename~="Quang Tri" & sample_all==1;

***8.5 /* REDUCED FORM */;
regress popdensity1999
	diff_17
	popdensity6061
	south
	$x_elev $x_gis $x_weather /* $x_oth */
	$x_soil1 $x_soil2
	/* [aw=pop_prov] */
	if sample_all==1, robust cluster(province);
**summ popdensity1999 if sample_all==1;

***8.6 /* IV-2SLS */;
regress popdensity1999 tot_bmr_per
	popdensity6061
	south
	$x_elev $x_gis $x_weather /* $x_oth */
	$x_soil1 $x_soil2
	(diff_17
	popdensity6061
	south
	$x_elev $x_gis $x_weather /* $x_oth */
	$x_soil1 $x_soil2)
	/* [aw=pop_prov] */
	if sample_all==1, robust cluster(province);
**summ popdensity1999 if sample_all==1;

/*-----------
TABLE 9
-------------

LOCAL WAR IMPACTS
ON OTHER POPULATION
CHARACTERISTICS

-----------*/

// PANEL A
//--------

// (1)
cwf province
regress                                                                     ///
    $dep_pop_den                                                            ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $dep_pop_den if sample_all==1

// (2)
regress                                                                     ///
    $dep_pop_den                                                            ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust                    
    
summ $dep_pop_den                                                           /// 
    if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $dep_pop_den                                                            ///  
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $dep_pop_den if sample_all==1


// PANEL B
//--------

// (1)
regress                                                                     ///
    $dep_pop_gro                                                            ///  
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $dep_pop_gro if sample_all==1

// (2)
regress                                                                     ///
    $dep_pop_gro                                                            /// 
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust

summ $dep_pop_gro                                                           ///  
    if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $dep_pop_gro                                                            /// 
    diff_17																	///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $dep_pop_gro if sample_all==1

gen nbhere=(1-bornhere)

// PANEL C
//--------

// (1)
regress                                                                     ///
    $dep_nborn                                                              ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $dep_nborn if sample_all==1

// (2)
regress                                                                     ///
    $dep_nborn                                                              ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
summ nbhere if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $dep_nborn                                                              ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

summ nbhere if sample_all==1


/*-----------------------------------
FIGURES
-----------------------------------*/

/*-----------
FIGURE 1
-------------

MAP OF VIETNAM

-----------*/


/*-----------
FIGURE 2
-------------

ESTIMATED DISTRICT
POVERTY RATE 1999 
VS. TOTAL US BOMBS,
MISSILES, AND ROCKETS 
PER KM2 IN THE DISTRICT
 CONDITIONAL ON:
-Province population
-South Vietnam
-District temp
-Avg precipitation
-Soil
-Latitude

-----------*/


cwf district

gen qt = provincename

replace qt = "" if qt~="Quang Tri"

quietly regress                                                            ///
    $dep_bom                                                               ///
    popdensity6061                                                         ///
    south                                                                  ///
    $x_weather                                                             ///
    $x_elev                                                                ///
    $x_gis                                                                 ///
    $x_soil1                                                               ///
    $x_soil2                                                                
    
predict                                                                    ///
    tot_bmr_per_dc, residual

quietly regress                                                            ///
    $dep_pov                                                               ///
    popdensity6061                                                         ///
    south                                                                  ///
    $x_weather                                                             ///
    $x_elev                                                                ///
    $x_gis                                                                 ///
    $x_soil1                                                               ///
    $x_soil2
    
predict                                                                    /// 
    poverty_p0_dc, residual

twoway                                                                     ///
    (scatter poverty_p0_dc tot_bmr_per_dc, mlabel(qt) mlabp(12))           ///
    (lfit poverty_p0_dc tot_bmr_per_dc),                                   ///
    ytitle("Residuals/Fitted values")                                      ///
    saving(poverty_p0_tot_bmr_per_lin_dc, replace)

/*-----------
FIGURE 3
-------------

STATE INVESTMENTS,
RATIO OF MORE HEAVILY
BOMBED TO LESS HEAVILY
BOMBED
-----------*/


/*-----------------------------------
CODEBOOK
-----------------------------------*/

cwf district
    
desc                                                                        ///
    poverty_p0                                                              ///
    lit_rate                                                                ///
    elec_rate                                                               ///
    radio_rate                                                              ///
    urban_pct                                                               ///
    percent_cultivated                                                      ///
    pcexp_99                                                                /// 
    gini                                                                    ///
    rlpcex1_9398                                                            ///
    rlpcex1                                                                 ///
    rlpcex1_93                                                              ///
    CONSGROWTHPC                                                            ///
    avg_ill4wks                                                             ///
    literate numerate                                                       ///
    educyr98_head                                                           ///
    educyr98father                                                          ///
    educyr98mother                                                          ///
    farm                                                                    ///
    notbornhere                                                             ///
    yrshere                                                                 ///
    $ord0                                                                   ///
    $ord1                                                                   ///
    $ord2                                                                   ///
    $ord3                                                                   ///
    $ord3_per                                                               ///
    log_tot_bm*                                                             ///
    tot_bmr*                                                                ///
    tot_bomb*                                                               ///
    war_f1                                                                  ///
    war_f2                                                                  ///
    $x_weather                                                              ///
    $x_oth                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    log_popdensity*                                                         ///
    popdensity*                                                             ///
    log*paddy*                                                              ///
    paddyyield*                                                             ///
    births*                                                                 ///
    south*                                                                  ///
    region                                                                  ///
    pop_tot                                                                 ///
    pop_prov                                                                ///
    sample*                                                                 ///
    central                                                                 ///
    rural                                                                   ///
    diff_17*


log c;
