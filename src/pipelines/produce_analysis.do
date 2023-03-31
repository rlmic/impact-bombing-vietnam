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
cd "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"
echo $dir

// Defining globals

global x_elev = "area_251 area_501 area_over_1000m";
global x_slope = "slp_c2 slp_c3 slp_c45";
global x_soil1 = "soil_1 soil_3 soil_6 soil_7 soil_8 soil_9 soil_10 soil_11 soil_12"
global x_soil2 = "soil_14 soil_24 soil_26 soil_33 soil_34 soil_35 soil_39 soil_40 soil_41"
global x_gis = "north_lat";
global x_weather = "pre_avg tmp_avg";
global ord0 = "Ammunition";
global ord1 = "General_Purpose Cluster_Bomb Missile Rocket Cannon_Artillery";
global ord2 = "Incendiary WP";
global ord3 = "Mine";
global y_bom = "tot_bmr_per"
global y_pov = "poverty_p0"
global y_pop_den = "popdensity1985"
global y_pop_gro = "ch_popdensity_20001985"
global y_pop_den_1999 = "popdensity1999"
global y_consum_2002 ="exppc02r98"
global y_consum_1992 ="exppc93r98"
global y_consum_gro ="consgrowth_9302"
global y_acc_elec ="elec_rate"
global y_lit = "lit_rate"

/*-----------------------------------
LOAD DATASETS AS FRAMES
-----------------------------------*/

// District Level

frames reset

frame create district
cwf district
//use "data/internal/archives/war_data_district_sep09.dta", clear
use "$dir/data/internal/dataverse/war_data_district.dta", clear

// Province Level

frame create province
cwf province
use "$dir/data/internal/archives/war_data_province_sep09.dta"
//use "../dataverse/war_data_province.dta", clear

frame drop default


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

cwf district
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
    $y_bom                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust
  
summ                                                                        ///
    $y_bom                                                                  ///
    if sample_all==1


// Column 2: District level: All

cwf district
regress                                                                     ///
    $y_bom                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust cluster(province)

summ                                                                        ///
    $y_bom                                                                  ///
    if sample_all==1

// Column 3: District level: Exclude Quang Tri

regress                                                                     ///
    $y_bom                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1 & provincename~="Quang Tri", robust cluster(province)
    
summ                                                                        ///
    $y_bom                                                                  ///
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
    $y_pov                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust
    
summ                                                                        ///
    $y_pov                                                                  ///
    if sample_all==1

// (OLS 2)
cwf district
regress                                                                     ///
    $y_pov                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2,                                                               ///
    robust cluster(province)

    
summ $y_pov                                                                 

// (OLS 3)
areg                                                                        ///
    $y_pov                                                                  ///
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
    $y_pov                                                                  ///
    if sample_all==1

// (OLS 4)
regress                                                                     ///
    $y_pov                                                                  ///
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
    $y_pov                                                                  ///
    if provincename~="Quang Tri" & sample_all==1

// (OLS 5)
regress                                                                     ///
    $y_pov                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province)
    
summ $y_pov if sample_all==1

// (IV-2SLS 6)
regress                                                                     ///
    $y_pov                                                                  ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil11                                                               ///
    $x_soil12(                                                              ///
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
    
summ $y_pov if sample_all==1

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
    $y_pov                                                                  ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1,                                                       ///
    robust cluster(province)
    
bys south: summ $y_pov if sample_all==1

// (3) (4)
gen urban_6061 = (popdensity6061>200 & popdensity6061~=.)

bys urban_6061: regress                                                     ///
    $y_pov                                                                  ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///                
    south                                                                   ///                
    if sample_all==1,                                                       ///
    robust cluster(province)
    
bys urban_6061: summ $y_pov  if sample_all==1
drop urban_6061

// (5)
regress                                                                     ///
    $y_pov                                                                  ///
    tot_bmr_per                                                             ///
    tot_bmr_per_2                                                           ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    south                                                                   ///
    if sample_all==1,                                                       ///
    robust cluster(province)    
    
summ $y_pov if sample_all==1

// (6)
regress                                                                     ///
    $y_pov                                                                  ///
    tot_bmr_hi                                                              ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    south                                                                   ///
    if sample_all==1,                                                       ///
    robust cluster(province)
    
summ $y_pov if sample_all==1

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
    $y_consum_2002                                                          ///
    tot_bmr_per                                                             ///                
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_consum_2002 if sample_all==1

// (2)
regress                                                                     /// 
    $y_consum_2002                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
summ $y_consum_2002 if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     /// 
    $y_consum_2002                                                          ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_consum_2002 if sample_all==1

/*
PANEL B
*/

// (1)
regress                                                                     ///
    $y_consum_1992                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_consum_1992 if sample_all==1

// (2)
regress                                                                     ///
    $y_consum_1992                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
summ $y_consum_1992 if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $y_consum_1992                                                          ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_consum_1992 if sample_all==1


/*
PANEL C
*/

// (1)
regress                                                                     ///
    $y_consum_gro                                                           ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_consum_gro if sample_all==1

// (2)
regress                                                                     ///
    $y_consum_gro                                                           ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
summ $y_consum_gro                                                          ///
    if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $y_consum_gro                                                           ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_consum_gro if sample_all==1

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
    $y_acc_elec                                                             ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

summ $y_acc_elec if sample_all==1

// (2)
cwf district
regress                                                                     /// 
    $y_acc_elec                                                             ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2,                                                               ///
    robust cluster(province)

summ $y_acc_elec

// (3)
areg                                                                        ///
    $y_acc_elec                                                             ///
    tot_bmr_per                                                             ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1,                                                       ///
    a(province) robust cluster(province)

summ $y_acc_elec if sample_all==1

// (4)
regress                                                                     ///
    $y_acc_elec                                                             ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if provincename~="Quang Tri" & sample_all==1,                           ///
    robust cluster(province)

summ $y_acc_elec if provincename~="Quang Tri" & sample_all==1

// (5)
regress                                                                     ///
    $y_acc_elec                                                             ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province) 

summ $y_acc_elec if sample_all==1

// (6)
regress                                                                     ///
    $y_acc_elec                                                             ///
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
    ) if sample_all==1, robust cluster(province)
    
summ $y_acc_elec if sample_all==1

/*
PANEL B
*/

// (1)
cwf province
regress                                                                     ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

summ $y_lit if sample_all==1

// (2)
cwf district
regress                                                                     ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    south,                                                                  ///
    robust cluster(province)
    
summ $y_lit

// (3)
areg                                                                        ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             ///
    $x_weather                                                              ///          
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, a(province) robust cluster(province)

summ $y_lit if sample_all==1

// (4)
regress                                                                     ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    south                                                                   ///
    if provincename~="Quang Tri" & sample_all==1, robust cluster(province)
    
summ $y_lit if provincename~="Quang Tri" & sample_all==1

// (5)
regress                                                                     ///
    $y_lit                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province)                              ///

summ $y_lit if sample_all==1

// (6)
regress                                                                     ///
    $y_lit                                                                  ///
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
    ) if sample_all==1, robust cluster(province)                        

summ $y_lit if sample_all==1

/*-----------
TABLE 8
-------------

LOCAL WAR IMPACTS
ON POPULATION 
DENSITY

-----------*/

// (1)
cwf province

regress                                                                     ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_pop_den_1999 if sample_all==1

// (2)
cwf district

regress                                                                     ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    south,                                                                  ///
    robust cluster(province)
    
summ $y_pop_den_1999

// (3)

areg                                                                        ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1,                                                       ///
    a(province) robust cluster(province)
    
summ $y_pop_den_1999 if sample_all==1

// (4)

regress                                                                     ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    south                                                                   ///
    if provincename~="Quang Tri" & sample_all==1,                           ///
    robust cluster(province)

summ $y_pop_den_1999 if provincename~="Quang Tri" & sample_all==1

// (5)

regress                                                                     ///
    $y_pop_den_1999                                                         ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province)

summ $y_pop_den_1999 if sample_all==1

// (6)
regress                                                                     ///
    $y_pop_den_1999                                                         ///
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
        )if sample_all==1, robust cluster(province)

summ $y_pop_den_1999 if sample_all==1

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
    $y_pop_den                                                              ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_pop_den if sample_all==1

// (2)
regress                                                                     ///
    $y_pop_den                                                              ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust                    
    
summ $y_pop_den                                                             /// 
    if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $y_pop_den                                                              ///  
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_pop_den if sample_all==1


// PANEL B
//--------

// (1)
regress                                                                     ///
    $y_pop_gro                                                              ///  
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_pop_gro if sample_all==1

// (2)
regress                                                                     ///
    $y_pop_gro                                                              /// 
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust

summ $y_pop_gro                                                             ///  
    if (provincename~="Quang Tri") & sample_all==1

// (3)
regress                                                                     ///
    $y_pop_gro                                                              /// 
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ $y_pop_gro if sample_all==1


// PANEL C
//--------

// (1)
regress                                                                     ///
    nbhere                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ nbhere if sample_all==1

// (2)
regress                                                                     ///
    nbhere                                                                  ///
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
    nbhere                                                                  ///
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
    $y_bom                                                                 ///
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
    $y_pov                                                                 ///
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
    saving(fig2, replace)

/*-----------
FIGURE 3
-------------

STATE INVESTMENTS,
RATIO OF MORE HEAVILY
BOMBED TO LESS HEAVILY
BOMBED
-----------*/

cwf province

gen tot_bmr_q1 = (tot_bmr_per>=0 & tot_bmr_per < 3.5)
gen tot_bmr_q2 = (tot_bmr_per>=3.5 & tot_bmr_per < 12.3)
gen tot_bmr_q3 = (tot_bmr_per>=12.3 & tot_bmr_per < 39.6)
gen tot_bmr_q4 = (tot_bmr_per>=39.6 & tot_bmr_per ~=.)

// Q1

frame copy province invest_q1

cwf invest_q1

collapse (sum) pop_85 invest_76-invest_85                                   ///
    if tot_bmr_q1==1    

foreach num in                                                              ///
    76 77 78 79 80 81 82 83 84 85{
        replace invest_`num' = invest_`num'/pop_85
        rename invest_`num' q1_`num'
    }
    
gen temp=1
reshape long q1_, i(temp) j(year)
drop temp
sort year


// Q2

frame copy province invest_q2
cwf invest_q2

collapse (sum)                                                              ///
    pop_85 invest_76-invest_85                                              ///
    if tot_bmr_q2==1    

foreach num in                                                              ///
    76 77 78 79 80 81 82 83 84 85{
        replace invest_`num' = invest_`num'/pop_85
        rename invest_`num' q2_`num'
    }

gen temp=1
reshape long q2_, i(temp) j(year)
drop temp
sort year


// Q3

frame copy province invest_q3
cwf invest_q3

collapse (sum)                                                              ///
    pop_85 invest_76-invest_85                                              ///
    if tot_bmr_q3==1    

foreach num in                                                              ///
    76 77 78 79 80 81 82 83 84 85{
        replace invest_`num' = invest_`num'/pop_85
        rename invest_`num' q3_`num'
    }

gen temp=1
reshape long q3_, i(temp) j(year)
drop temp
sort year


// Q4

frame copy province invest_q4

cwf invest_q4

collapse (sum)                                                              ///
    pop_85 invest_76-invest_85                                              ///
    if tot_bmr_q4==1    

foreach num in                                                              ///
    76 77 78 79 80 81 82 83 84 85{
        replace invest_`num' = invest_`num'/pop_85
        rename invest_`num' q4_`num'
    }

gen temp=1
reshape long q4_, i(temp) j(year)
drop temp
sort year

// Join into one dataframe
frame copy invest_q1 invest
cwf invest
frlink 1:1 year, frame(invest_q2)
frget q2_, from(invest_q2)
frlink 1:1 year, frame(invest_q3)
frget q3_, from(invest_q3)
frlink 1:1 year, frame(invest_q4)
frget q4_, from(invest_q4)
sort year

gen lab1 = 1
gen lab2 = 2
gen lab3 = 3
gen lab4 = 4

gen ratio34 = (q3_+q4_)/(q2_+q1_)

// Labels

label var ratio34 "Ratio Above/Below Median"
label var q1_ "Quartile 1"                                                        
label var q2_ "Quartile 2"
label var q3_ "Quartile 3"
label var q4_ "Quartile 4"
label var year "Year"

twoway                                                                      ///
    (connected ratio34 year, mlabp(12)),                                    ///
    ylabel(0.8(0.2)1.6)                                                     ///
    l1title("State investment")                                             ///
    saving(fig3, replace)



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



