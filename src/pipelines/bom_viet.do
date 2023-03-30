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
global x_soil = "soil_*";
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
global dep_pop_den_1999 = "popdensity1999"
global dep_consum_2002 ="exppc02r98"
global dep_consum_1992 ="exppc93r98"
global dep_consum_gro ="consgrowth_9302"
global dep_acc_elec ="elec_rate"

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
    soil*,                                                                  ///
    robust cluster(province)

    
summ $dep_pov                                                                 

// (OLS 3)
areg                                                                        ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil                                                                 ///
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
    $x_soil                                                                 ///
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
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil                                                                 ///
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
    $x_soil(                                                                ///
        diff_17                                                             ///
        popdensity6061                                                      ///
        south                                                               ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        $x_soil                                                             ///
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

// (1) (2)
bys south: regress                                                          ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil                                                                 ///
    if sample_all==1,                                                       ///
    robust cluster(province)
    
bys south: summ $dep_pov if sample_all==1

// (3) (4)
gen urban_6061 = (popdensity6061>200 & popdensity6061~=.)

bys urban_6061: regress                                                     ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil                                                                 ///                
    south                                                                   ///                
    if sample_all==1,                                                       ///
    robust cluster(province)
    
bys urban_6061: summ $dep_pov  if sample_all==1
drop urban_6061

// (5)
regress                                                                     ///
    $dep_pov                                                                ///
    tot_bmr_per                                                             ///
    tot_bmr_per_2                                                           ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil                                                                 ///    
    south                                                                   ///
    if sample_all==1,                                                       ///
    robust cluster(province)    
    
summ $dep_pov if sample_all==1

// (6)
regress                                                                     ///
    $dep_pov                                                                ///
    tot_bmr_hi                                                              ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil                                                                 ///    
    south                                                                   ///
    if sample_all==1,                                                       ///
    robust cluster(province)
    
summ $dep_pov if sample_all==1

/*-----------
TABLE 6
-------------

LOCAL WAR IMPACTS
ON CONSUMPTION
EXPENDITURES 
AND GROWTH

-----------*/

cwf province

/*
PANEL A
*/

// (1)
regress                                                                     /// 
    $dep_consum_2002                                                        ///
    tot_bmr_per                                                             ///                
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ exppc02r98 if sample_all==1

// (2)
regress                                                                     /// 
    $dep_consum_2002                                                        ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
summ exppc02r98 if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     /// 
    $dep_consum_2002                                                        ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ exppc02r98 if sample_all==1

/*
PANEL B
*/

// (1)
regress                                                                     ///
    $dep_consum_1992                                                        ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ exppc93r98 if sample_all==1

// (2)
regress                                                                     ///
    $dep_consum_1992                                                        ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
summ exppc93r98 if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $dep_consum_1992                                                        ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ exppc93r98 if sample_all==1


/*
PANEL C
*/

// (1)
regress                                                                     ///
    $dep_consum_gro                                                         ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $dep_consum_gro if sample_all==1

// (2)
regress                                                                     ///
    $dep_consum_gro                                                         /// 
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
summ $dep_consum_gro                                                        ///
    if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $dep_consum_gro                                                         /// 
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $dep_consum_gro if sample_all==1

/*-----------
TABLE 7
-------------

LOCAL WAR IMPACTS
ON PHYSICAL 
INFRASTRUCTURE AND
HUMAN CAPITAL

-----------*/

/*
PANEL A
*/

// (1)
cwf province
regress                                                                     /// 
    $dep_acc_elec                                                           ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

summ $dep_acc_elec if sample_all==1

// (2)
cwf district
regress                                                                     /// 
    $dep_acc_elec                                                           ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil,                                                                ///        
    robust cluster(province)

summ $dep_acc_elec

// (3)
areg                                                                        ///
    $dep_acc_elec                                                           ///
    tot_bmr_per                                                             ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil,                                                                ///        
    if sample_all==1,                                                       ///
    a(province) robust cluster(province)

summ $dep_acc_elec if sample_all==1

// (4)
regress                                                                     ///
    $dep_acc_elec                                                           ///
    tot_bmr_per
    popdensity6061
    south
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil,                                                                ///        
    /* [aw=pop_tot] */
    if provincename~="Quang Tri" & sample_all==1,
    robust cluster(province);
**summ elec_rate if provincename~="Quang Tri" & sample_all==1;

// (5)
regress elec_rate
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);
**summ elec_rate if sample_all==1;

// (6)
regress elec_rate tot_bmr_per
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
**summ elec_rate if sample_all==1;


/*
PANEL B
*/

cwf province

// (1)

regress lit_rate tot_bmr_per 
    popdensity6061
    south
    $x_elev $x_gis $x_weather
    if sample_all==1, robust;
**summ `var' if sample_all==1;


cwf district

// (2)

regress lit_rate tot_bmr_per
    popdensity6061
    $x_weather $x_elev $x_gis
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */,
    robust cluster(province);
**summ lit_rate;

***7.B.3 /* PROVINCE FE */;
areg lit_rate tot_bmr_per
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_tot] */
    if sample_all==1,
    a(province) robust cluster(province);
**summ lit_rate if sample_all==1;

***7.B.4 /* EXCLUDE QUANG TRI */;
regress lit_rate tot_bmr_per
    popdensity6061
    $x_weather $x_elev $x_gis
    $x_soil1 $x_soil2
    south
    if provincename~="Quang Tri" & sample_all==1,
    robust cluster(province);
**summ lit_rate if provincename~="Quang Tri" & sample_all==1;

***7.B.5 /* REDUCED FORM */;
regress lit_rate
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather
    $x_soil1 $x_soil2
    if sample_all==1, robust cluster(province);
**summ lit_rate if sample_all==1;

***7.B.6 /* IV-2SLS */;
regress lit_rate tot_bmr_per
    popdensity6061
    south
    $x_elev $x_gis $x_weather
    $x_soil1 $x_soil2
    (diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather
    $x_soil1 $x_soil2)
    if sample_all==1, robust cluster(province);
**summ lit_rate if sample_all==1;



/*-----------
TABLE 8
-------------

LOCAL WAR IMPACTS
ON POPULATION 
DENSITY

-----------*/

// (1)
cwf province

regress
    $dep_pop_den_1999
    tot_bmr_per 
    popdensity6061
    south
    $x_elev $x_gis $x_weather
    if sample_all==1, robust
    
**summ `var' if sample_all==1

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
    diff_17                                                                 ///
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

use war_data_province, clear;
gen tot_bmr_q1 = (tot_bmr_per>=0 & tot_bmr_per < 3.5);
gen tot_bmr_q2 = (tot_bmr_per>=3.5 & tot_bmr_per < 12.3);
gen tot_bmr_q3 = (tot_bmr_per>=12.3 & tot_bmr_per < 39.6);
gen tot_bmr_q4 = (tot_bmr_per>=39.6 & tot_bmr_per ~=.);
save temp0, replace;


/* Q1 BOMBED PROVINCES */;
collapse popdensity1976 popdensity1985 popdensity1990 popdensity1992 popdensity1994 popdensity1996 popdensity1998 popdensity2000
    if tot_bmr_q1==1 /* & popdensity1976~=. */;

foreach num in
    /* 1976 */ 1985 1990 1992 1994 1996 1998 2000
{;
rename popdensity`num' q1_`num';
};

gen temp=1;
reshape long q1_, i(temp) j(year);
drop temp;
sort year;
save temp_q1, replace;
clear;

use temp0;
/* Q2 BOMBED PROVINCES */;
collapse popdensity1976 popdensity1985 popdensity1990 popdensity1992 popdensity1994 popdensity1996 popdensity1998 popdensity2000
    if tot_bmr_q2==1 /* & popdensity1976~=. */;

foreach num in
    /* 1976 */ 1985 1990 1992 1994 1996 1998 2000
{;
rename popdensity`num' q2_`num';
};

gen temp=1;
reshape long q2_, i(temp) j(year);
drop temp;
sort year;
save temp_q2, replace;
clear;

use temp0;
/* Q3 BOMBED PROVINCES */;
collapse popdensity1976 popdensity1985 popdensity1990 popdensity1992 popdensity1994 popdensity1996 popdensity1998 popdensity2000
    if tot_bmr_q3==1 /* & popdensity1976~=. */;

foreach num in
    /* 1976 */ 1985 1990 1992 1994 1996 1998 2000
{;
rename popdensity`num' q3_`num';
};

gen temp=1;
reshape long q3_, i(temp) j(year);
drop temp;
sort year;
save temp_q3, replace;
clear;

use temp0;
/* Q4 BOMBED PROVINCES */;
collapse popdensity1976 popdensity1985 popdensity1990 popdensity1992 popdensity1994 popdensity1996 popdensity1998 popdensity2000
    if tot_bmr_q4==1 /* & popdensity1976~=. */;

foreach num in
    /* 1976 */ 1985 1990 1992 1994 1996 1998 2000
{;
rename popdensity`num' q4_`num';
};

gen temp=1;
reshape long q4_, i(temp) j(year);
drop temp;
sort year;
save temp_q4, replace;
clear;

use temp_q1;
merge year using temp_q2;
tab _merge; drop _merge;
sort year;

merge year using temp_q3;
tab _merge; drop _merge;
sort year;

merge year using temp_q4;
tab _merge; drop _merge;
sort year;

label var q1_ "Quartile 1";
label var q2_ "Quartile 2";
label var q3_ "Quartile 3";
label var q4_ "Quartile 4";
label var year "Year";

gen lab1 = 1;
gen lab2 = 2;
gen lab3 = 3;
gen lab4 = 4;


gen ratio2 = q2_/q1_;
gen ratio3 = q3_/q1_;
gen ratio4 = q4_/q1_;

gen ratio34 = (q3_+q4_)/(q2_+q1_);
label var ratio34 "Ratio Above/Below Median";

**twoway (connected q1_ year, ml(lab1) mlabp(12)) (connected q2_ year, ml(lab2) mlabp(12)) (connected q3_ year, ml(lab3) mlabp(12)) (connected q4_ year, ml(lab4) mlabp(12)), ylabel(0(100)600) l1title("Population density") saving(ch_popdensity_20001985, replace);

/*twoway (connected ratio2 year, ml(lab2) mlabp(12)) (connected ratio3 year, ml(lab3) mlabp(12)) (connected ratio4 year, ml(lab4) mlabp(12)),
    l1title("Population density ratio");

twoway (connected ratio34 year, mlabp(12)),
    ylabel(1(0.2)1.6) l1title("Population density") saving(popdensity_median_20001985, replace);*/

clear;

/* POST-WAR INVESTMENT PATTERNS OVER TIME */
use temp0;

/* Q1 BOMBED PROVINCES */;
collapse (sum) invest_76 invest_77 invest_78 invest_79 invest_80 invest_81 invest_82 invest_83 invest_84 invest_85
    pop_85
    if tot_bmr_q1==1;

foreach num in
    76 77 78 79 80 81 82 83 84 85
{;
replace invest_`num' = invest_`num'/pop_85;
rename invest_`num' q1_`num';
};

gen temp=1;
reshape long q1_, i(temp) j(year);
drop temp;
sort year;
save temp_q1, replace;
clear;

use temp0;

/* Q2 BOMBED PROVINCES */;
collapse (sum) invest_76 invest_77 invest_78 invest_79 invest_80 invest_81 invest_82 invest_83 invest_84 invest_85
    pop_85
    if tot_bmr_q2==1;

foreach num in
    76 77 78 79 80 81 82 83 84 85
{;
replace invest_`num' = invest_`num'/pop_85;
rename invest_`num' q2_`num';
};

gen temp=1;
reshape long q2_, i(temp) j(year);
drop temp;
sort year;
save temp_q2, replace;
clear;


use temp0;
/* Q3 BOMBED PROVINCES */;
collapse (sum) invest_76 invest_77 invest_78 invest_79 invest_80 invest_81 invest_82 invest_83 invest_84 invest_85
    pop_85
    if tot_bmr_q3==1;

foreach num in
    76 77 78 79 80 81 82 83 84 85
{;
replace invest_`num' = invest_`num'/pop_85;
rename invest_`num' q3_`num';
};

gen temp=1;
reshape long q3_, i(temp) j(year);
drop temp;
sort year;
save temp_q3, replace;
clear;

use temp0;
/* Q4 BOMBED PROVINCES */;
collapse (sum) invest_76 invest_77 invest_78 invest_79 invest_80 invest_81 invest_82 invest_83 invest_84 invest_85
    pop_85
    if tot_bmr_q4==1;

foreach num in
    76 77 78 79 80 81 82 83 84 85
{;
replace invest_`num' = invest_`num'/pop_85;
rename invest_`num' q4_`num';
};

gen temp=1;
reshape long q4_, i(temp) j(year);
drop temp;
sort year;
save temp_q4, replace;
clear;


use temp_q1;
merge year using temp_q2;
tab _merge; drop _merge;
sort year;

merge year using temp_q3;
tab _merge; drop _merge;
sort year;

merge year using temp_q4;
tab _merge; drop _merge;
sort year;

label var q1_ "Quartile 1";
label var q2_ "Quartile 2";
label var q3_ "Quartile 3";
label var q4_ "Quartile 4";
label var year "Year";

gen lab1 = 1;
gen lab2 = 2;
gen lab3 = 3;
gen lab4 = 4;

gen ratio2 = q2_/q1_;
gen ratio3 = q3_/q1_;
gen ratio4 = q4_/q1_;

gen ratio34 = (q3_+q4_)/(q2_+q1_);
label var ratio34 "Ratio Above/Below Median";

/*twoway (connected q1_ year, ml(lab1) mlabp(12)) (connected q2_ year, ml(lab2) mlabp(12)) (connected q3_ year, ml(lab3) mlabp(12)) (connected q4_ year, ml(lab4) mlabp(12)),
    l1title("Investment (in current Dong)") saving(invest_19851976, replace);

twoway (connected ratio2 year, ml(lab2) mlabp(12)) (connected ratio3 year, ml(lab3) mlabp(12)) (connected ratio4 year, ml(lab4) mlabp(12)),
    l1title("Investment ratio (in current Dong)") saving(invest_ratio_19851976, replace);*/

twoway (connected ratio34 year, mlabp(12)),
    ylabel(0.8(0.2)1.6) l1title("State investment") saving(invest_median_19851976, replace);

foreach num in
    1 2 3 4
{;
erase temp_q`num'.dta;
};

summ ratio34;
bys year: summ ratio34;
summ ratio34 if year>=76 & year<=80;
summ ratio34 if year>=81 & year<=86;

erase temp0.dta;


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
