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
global x_oth = "area_tot_km2 area_tot_km2_2";

/*-----------------------------------
LOAD DATASETS AS FRAMES
-----------------------------------*/

// District Level

frames reset
frame create district
cwf district
use "../archives/war_data_district_sep09.dta", clear

// Province Level

frame create province
cwf province
use "../archives/war_data_province_sep09.dta"

frame dir

/*-----------------------------------
FIGURES, TABLES, CODEBOOK
-----------------------------------*/

/*-----------
NAME
----

TYPE
----
CODEBOOK

DESCRIPTION
-----------

-----------*/

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

/*-----------
TABLE 1
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
    lit_rate                                                                ///
    elec_rate                                                               ///
    pcexp_99                                                                ///
    gini                                                                    ///
    [aw=pop_tot]                                                            ///
    if sample_all==1


/*
PANEL B
*/
cwf province
gen nbhere=(1-bornhere);
summ  
    popdensity6061 popdensity1985 popdensity1999 
    ch_popdensity_20001985 nbhere exppc93r98 exppc02r98 consgrowth_9302
    north_lat diff_17
    if sample_all==1;


/*-----------
TABLE 3
PREDICTING BOMBING
INTENSITY
-----------*/

/*
NOTES
-------
Regions:
- 1=RED RIVER DELTA, 
- 2=NORTHEAST,
- 3=NORTHWEST,
- 8=MEKONG RIVER DELTA
- 4=NORTH CENTRAL COAST,
- 5=SOUTH CENTRAL COAST,
- 6=CENTRAL HIGHLANDS,
- 7=NORTHEAST SOUTH
*/

cwf province

// Excludes soil controls due to problems
// with degrees of freedom

regress                                                                     ///
    `vio'                                                                   ///
    south                                                                   ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ                                                                        ///
    `vio'                                                                   ///
    if sample_all==1

regress                                                                     ///
    `vio'                                                                   ///
    diff_17                                                                 ///
    south                                                                   ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
summ                                                                        ///
    `vio'                                                                   ///
    if sample_all==1

/* INCLUDE 1951-1960 COHORT AVERAGE HEIGHT AS BASELINE SES CONTROL */;
regress `vio'
    diff_17
    south
    popdensity6061
    height_5156
    $x_elev $x_gis $x_weather
    if sample_all==1, robust;
summ `vio' if sample_all==1;

/* INCLUDE 1967 HAMLA MEASURE AS BASELINE SES CONTROL - SOUTH ONLY */;
regress `vio'
    diff_17
    south
    popdensity6061
    hamla_dev_score
    $x_elev $x_gis $x_weather
    if sample_all==1, robust;
summ `vio' if sample_all==1 & hamla_dev_score~=.;

regress `vio'
    diff_17
    south
    popdensity6061
    hamla_dev_score
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if sample_all==1 & hamla_dev_score<100, robust;
summ `vio' if sample_all==1 & hamla_dev_score~=. & hamla_dev_score<100;


/* CENTRAL REGION */;
regress `vio'
    diff_17
    south
    popdensity6061
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if central==1 & sample_all==1, robust;
summ `vio' if central==1 & sample_all==1;

/* EXCLUDE QUANG TRI */;
regress `vio'
    diff_17
    south
    popdensity6061
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if (provincename~="Quang Tri") & sample_all==1, robust;
summ `vio' if (provincename~="Quang Tri") & sample_all==1;

twoway (scatter popdensity6061 `vio' if sample_all==1, mlabel(provincename) mlabp(12)) /*(lfit popdensity6061 `vio')*/, saving(popdensity_lin_`vio', replace);
clear;

cwf district
/* DISTRICT LEVEL */;
use war_data_district_sep09;
regress `vio'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);
summ `vio' if sample_all==1;
test popdensity6061 $x_weather /* $x_oth */ $x_elev $x_gis $x_soil1 $x_soil2;

/* IV FIRST STAGE */;

/* NOTES: DIFF_17 SQUARED NOT SIGNIFICANT IN THE FIRST STAGE 
    EITHER FOR ALL VIETNAM OR CENTRAL REGION */;
/* DIFF_17 PREDICTS BOTH LOG BOMBS AND 1(HIGH BOMBS) WELL */;
/* DIFF_17 PREDICTS BOMBING AT THE PROVINCE OR DISTRICT LEVELS,
    AND WITH OR WITHOUT QT PROVINCE; BUT NOT WELL WITH PROV FE */;

regress `vio'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);
summ `vio' if sample_all==1;

/* INCLUDE 1951-1960 COHORT AVERAGE HEIGHT AS BASELINE SES CONTROL */;
regress `vio'
    diff_17
    popdensity6061
    height_5156
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);

/* INCLUDE 1967 HAMLA MEASURE AS BASELINE SES CONTROL - SOUTH ONLY */;
regress `vio'
    diff_17
    popdensity6061
    hamla_dev_score
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);
summ `vio' if sample_all==1 & hamla_dev_score~=.;

/* SOME CHECKS */;
regress `vio'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);

regress `vio'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    area_tot_km2
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);

regress `vio'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    area_tot_km2 area_tot_km2_2
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);


/* CONLEY S.E. */;
gen const=1;
gen cutoff1=3;
gen cutoff2=3;
x_ols north_lat east_long cutoff1 cutoff2
    `vio'
    const
    diff_17
    popdensity6061
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    south,
    xreg(28) coord(2);
regress `vio'
    diff_17
    popdensity6061
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    south
    if sample_all==1, robust cluster(province);
summ `vio' if sample_all==1;
drop cutoff1 cutoff2 const;


/* PROVINCE FE */;
areg `vio'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if sample_all==1, a(province) robust cluster(province);
summ `vio' if sample_all==1;

/* CENTRAL REGION */;
regress `vio'
    diff_17 
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if central==1, robust cluster(province);
summ `vio' if central==1;

/* EXCLUDE QUANG TRI */;
regress `vio'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if sample_all==1 & provincename~="Quang Tri", robust cluster(province);
summ `vio' if sample_all==1 & provincename~="Quang Tri";

clear;
};



foreach vio in
    tot_bmr_per /* tot_bmr tot_bmr_hi General_Purpose war_f1 */
{;
use war_data_district_sep09;
/* NON-PARAMETRIC DENSITY */;
*kdensity `vio', epanechnikov
    title("Non-parametric kernel density")
    saving(k_`vio', replace);
*kdensity `vio' if central==1, epanechnikov
    title("Non-parametric kernel density")
    saving(k_`vio'C, replace);
clear;

/* POST-WAR ANALYSIS */;
/* EFFECTS OF BOMBING ON POVERTY RATES, CONSUMPTION, ETC */;

foreach var in
    /* CENSUS DATA */
    poverty_p0
    pcexp_99 gini
    popdensity1999
    elec_rate lit_rate

{;

use war_data_district_sep09;

/* QUANG TRI LABEL */;
gen qt = provincename;
replace qt = "" if qt~="Quang Tri";


/* GRAPHICAL RELATIONSHIPS */;

/* FIGURES 4 & 5 */;
/* POPULATION DENSITY AND POVERTY RATES BY TOTAL BOMBS */;

/* DISTRICT LEVEL */;
/* OVERALL */;
twoway (scatter `var' `vio', mlabel(qt) mlabp(12)) (lfit `var' `vio' /*[aw=pop_tot]*/), saving(`var'_`vio'_lin, replace);
*twoway (scatter `var' `vio', mlabel(qt) mlabp(12)) (lfit `var' `vio' /*[aw=pop_tot]*/) if central==1, saving(`var'_`vio'_linC, replace);

/* WITHIN PROVINCE */;
quietly regress `vio' Iprovince*;
predict `vio'_w, residual;
label var `vio'_w "Within province variation, `vio'";

quietly regress `var' Iprovince*;
predict `var'_w, residual;
label var `var'_w "Within province variation, `var'";

twoway (scatter `var'_w `vio'_w, mlabel(qt) mlabp(12)) (lfit `var'_w `vio'_w /* [aw=pop_tot] */), saving(`var'_`vio'_lin_w, replace);
*twoway (scatter `var'_w `vio'_w, mlabel(qt) mlabp(12)) (lfit `var'_w `vio'_w /* [aw=pop_tot] */) if central==1, saving(`var'_`vio'_linC_w, replace);
drop *_w;


/* CONDITIONAL ON ALL DISTRICT CONTROLS */;
quietly regress `vio' popdensity6061 south $x_weather $x_elev $x_gis /* $x_oth */ $x_soil1 $x_soil2;
predict `vio'_dc, residual;

quietly regress `var' popdensity6061 south $x_weather $x_elev $x_gis /* $x_oth */ $x_soil1 $x_soil2;
predict `var'_dc, residual;

twoway (scatter `var'_dc `vio'_dc, mlabel(qt) mlabp(12)) (lfit `var'_dc `vio'_dc /* [aw=pop_tot] */), saving(`var'_`vio'_lin_dc, replace);
*twoway (scatter `var'_dc2 `vio'_dc2, mlabel(qt) mlabp(12)) (lfit `var'_dc2 `vio'_dc2 /* [aw=pop_tot] */) if central==1, saving(`var'_`vio'_linC_dc, replace);
drop *_dc;


/* BETWEEN PROVINCE */;
clear;
use war_data_province_sep09;
/* PROVINCE LEVEL */;
*label var `vio' "Between province variation, `vio'";
*label var `var' "Between province variation, `var'";

twoway (scatter `var' `vio', mlabel(provincename) mlabp(12)) (lfit `var' `vio' /* [aw=pop_prov] */), saving(`var'_`vio'_lin_b, replace);
*twoway (scatter `var' `vio', mlabel(provincename) mlabp(12)) (lfit `var' `vio' /* [aw=pop_prov] */) if central==1, saving(`var'_`vio'_linC_b, replace);

/* CONDITIONAL ON POPULATION DENSITY, SOUTH */;
quietly regress `vio' popdensity6061 south;
predict `vio'_bpd, residual;
*label var `vio'_bpd "Cond. on Log 1960-1 Pop. Density, `vio'";

quietly regress `var' popdensity6061 south;
predict `var'_bpd, residual;
*label var `var'_bpd "Cond. on Log 1960-1 Pop. Density, `var'";

*twoway (scatter `var'_bpd `vio'_bpd, mlabel(provincename) mlabp(12)) (lfit `var'_bpd `vio'_bpd /*[aw=pop_prov]*/), saving(`var'_`vio'_lin_bpd, replace);
*twoway (scatter `var'_bpd `vio'_bpd, mlabel(provincename) mlabp(12)) (lfit `var'_bpd `vio'_bpd /*[aw=pop_prov]*/) if central==1, saving(`var'_`vio'_linC_bpd, replace);
drop *_bpd;

clear;


use war_data_district_sep09;
/* REGRESSION ANALYSIS */;

/* TABLE 4 AND 5 - ESTIMATED BOMBING IMPACTS - ON POVERTY */;
/* PLUS, TABLES 7 AND 8 */;
/* EFFECTS OF BOMBING ON ELECTRICITY ACCESS & LITERACY (TBL 7) */;
/* AND POPULATION DENSITY (TBL 8) */;

/* DISTRICT LEVEL */;
/* OVERALL */;
regress `var' `vio' /* [aw=pop_tot] */, robust cluster(province);
summ `var';

regress `var' `vio' /* [aw=pop_tot] */ if central==1, robust cluster(province);
summ `var' if central==1;

/* WITHIN PROVINCE */;
areg `var' `vio'
    /* [aw=pop_tot] */, a(province) robust cluster(province);
summ `var';

areg `var' `vio'
    /* [aw=pop_tot] */ if central==1,
    a(province) robust cluster(province);
summ `var' if central==1;


/* DETAILED DISTRICT GEOGRAPHIC, CLIMATIC CONTROLS */;
regress `var' `vio'
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */,
    robust cluster(province);
summ `var';


/* CONLEY S.E. */;
gen const=1;
gen cutoff1=3;
gen cutoff2=3;
x_ols north_lat east_long cutoff1 cutoff2
    `var'
    const `vio'
    popdensity6061
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    south,
    xreg(28) coord(2);
regress `var'
    `vio'
    diff_17
    popdensity6061
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    south
    if sample_all==1, robust cluster(province);
summ `vio' if sample_all==1;
drop cutoff1 cutoff2 const;


/* INCLUDE HEIGHT OF 1951-60 BIRTH COHORTS AS A BASELINE SES CONTROL */;
regress `var' `vio'
    popdensity6061
    height_5156
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */,
    robust cluster(province);
summ `var';

/* INCLUDE 1967 HAMLA MEASURE AS A BASELINE SES CONTROL */;
regress `var' `vio'
    popdensity6061
    hamla_dev_score
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */,
    robust cluster(province);
summ `var';

/* PROVINCE FE */;
areg `var' `vio' 
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_tot] */
    if sample_all==1,
    a(province) robust cluster(province);
summ `var' if sample_all==1;

/* CENTRAL REGION */;
regress `var' `vio'
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if central==1 & sample_all==1,
    robust cluster(province);
summ `var' if central==1 & sample_all==1;

/* EXCLUDE QUANG TRI */;
regress `var' `vio'
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if provincename~="Quang Tri" & sample_all==1,
    robust cluster(province);
summ `var' if provincename~="Quang Tri" & sample_all==1;

/* LAND MINE IMPACTS */;
regress `var' tot_bmr_per mine_per
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
summ `var' if sample_all==1;

/* NORTH VERSUS SOUTH */;
bys south: regress `var' `vio'
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
bys south: summ `var' if sample_all==1;

/* URBAN VERSUS RURAL: WHERE TO MAKE THIS CUT? AT 200/KM2? */;
gen urban_6061 = (popdensity6061>200 & popdensity6061~=.);
bys urban_6061: regress `var' `vio'
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
bys urban_6061: summ `var' if sample_all==1;
drop urban_6061;

/* WITH POPULATION WEIGHTS */;
regress `var' `vio'
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    [aw=pop_tot]
    if sample_all==1,
    robust cluster(province);
summ `var' [aw=pop_tot] if sample_all==1;

/* ALTERNATIVE MEASURES OF BOMBING IMPACTS */;
/* TOP 10% OF DISTRICTS */;
regress `var' tot_bmr_hi
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
summ `var' if sample_all==1;

/* LOG (TOT_BMR_PER) */;
regress `var' log_tot_bmr
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
summ `var' if sample_all==1;

/* QUADRATIC TERM */;
regress `var' `vio' `vio'_2
    popdensity6061
    $x_weather $x_elev $x_gis /* $x_oth */
    $x_soil1 $x_soil2
    south
    /* [aw=pop_tot] */
    if sample_all==1,
    robust cluster(province);
summ `var' if sample_all==1;

/* OTHER MILITARY MEASURES TYPICALLY DO NOT HAVE MUCH PREDICTIVE POWER */;

/**** IV, RF REGRESSIONS ****/;
/* REDUCED FORM */;
regress `var'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if sample_all==1, robust cluster(province);
summ `var' if sample_all==1;

/* CENTRAL REGION */;
regress `var'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if central==1 & sample_all==1, robust cluster(province);
summ `var' if central==1 & sample_all==1;

/* EXCLUDE QUANG TRI */;
regress `var'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    $x_soil1 $x_soil2
    /* [aw=pop_prov] */
    if (sample_all==1 & provincename~="Quang Tri"), robust cluster(province);
summ `var' if (sample_all==1 & provincename~="Quang Tri");

/* IV-2SLS */;
regress `var' 
    `vio'                                                            ///
    popdensity6061                                                            ///
    south
    $x_elev 
    $x_gis
    $x_weather
    $x_soil1
    $x_soil2
    (diff_17 popdensity6061 south $x_elev $x_gis $x_weather $x_soil1 $x_soil2)
    if sample_all==1, robust cluster(province);
summ `var' 
    if sample_all==1;

/* CENTRAL REGION */;
regress `var' `vio'
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
    if central==1 & sample_all==1, robust cluster(province);
summ `var' if central==1 & sample_all==1;

/* EXCLUDE QUANG TRI */;
regress `var' `vio'
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
    if (sample_all==1 & provincename~="Quang Tri"), robust cluster(province);
summ `var' if (sample_all==1 & provincename~="Quang Tri");

/* ALTERNATIVE BOMBING MEASURE */;
regress `var' tot_bmr_hi
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
summ `var' if sample_all==1;

/*************/;

clear;
};

/* ADD ANALYSIS OF CONSUMPTION, GROWTH, AND OTHER POPULATION CHARS. */;
/* USED IN TABLES 6 AND 9 */;
/* PROVINCE LEVEL */;
foreach var in
    /* CENSUS DATA */
    poverty_p0
    gini
    popdensity1999
    elec_rate lit_rate

    /* VLSS DATA - ONLY ANALYZE AT PROVINCE LEVEL */
    rlpcex1 exppc93r98 exppc02r98
    consgrowth_9398 consgrowth_9302
    bornhere93 bornhere 

    anysalary_all93 anysalary_all
    educyrself93 educyrself    
    dliterate_all93 dliterate_all dliterate_all02
    dnumerate_all93 dnumerate_all

    educyrfather93 educyr98father
    educyrmother93 educyr98mother
    dkinh93 dkinh dkinh02
    disabled93 disabled invalids02
    vetassoc
    hhsize hhsize02

    /* HEIGHTS BY COHORT */
    height_f1931 height_m1931
    height_f1936 height_m1936
    height_f1941 height_m1941
    height_f1946 height_m1946
    height_f1951 height_m1951
    height_f1956 height_m1956
    height_f1961 height_m1961
    height_f1966 height_m1966
    height_f1971 height_m1971
    height_f1976 height_m1976

    /* irr_frac93 */ irr_frac
    delectricity93 delectricity delectricity02        

    /* YEARBOOK DATA */
    popdensity1985 popdensity1990 popdensity2000
    ch_popdensity_20001990 ch_popdensity_20001985

    popdensity1976 popdensity1980

    /* popdensity1992 popdensity1994 popdensity1996 popdensity1998 */
    /* phones_00 classrooms_99 industry_00 */

    invest_76 invest_78 invest_80 invest_82 invest_85

    invest_85_per
    output_85_per
    food2_85_per
    pupils_85_per

{;
use war_data_province_sep09;

regress `var' `vio' south /* [aw=pop_prov] */ if sample_all, robust;
regress `var' `vio' south /* [aw=pop_prov] */ if central==1, robust;

/* MAIN OLS SPECIFICATIONS */;
regress `var' `vio'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if sample_all==1, robust;
summ `var' if sample_all==1;

/* INCLUDE 1951-1960 BIRTH COHORT HEIGHTS AS A BASELINE SES CONTROL */;
regress `var' `vio'
    popdensity6061
    height_5156
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if sample_all==1, robust;
summ `var' if sample_all==1;

/* INCLUDE 1967 HAMLA MEASURE AS A BASELINE SES CONTROL */;
regress `var' `vio'
    popdensity6061
    hamla_dev_score
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if sample_all==1, robust;
summ `var' if sample_all==1;

/* WITHOUT QUANG TRI */;
regress `var' `vio'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if (provincename~="Quang Tri") & sample_all==1, robust;
summ `var' if (provincename~="Quang Tri") & sample_all==1;

/* CENTRAL REGION */;
regress `var' `vio'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if central==1 & sample_all==1, robust;
summ `var' if central==1 & sample_all==1;

/* REDUCED FORM */;
regress `var'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if sample_all==1, robust;
summ `var' if sample_all==1;

/* CENTRAL REGION */;
regress `var'
    diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    /* [aw=pop_prov] */
    if central==1 & sample_all==1, robust;
summ `var' if central==1 & sample_all==1;

/* IV-2SLS */;
regress `var' `vio'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    (diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */)
    /* [aw=pop_prov] */
    if sample_all==1, robust;
summ `var' if sample_all==1;

regress `var' `vio'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    (diff_17
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */)
    /* [aw=pop_prov] */
    if central==1 & sample_all==1, robust;
summ `var' if central==1 & sample_all==1;

};

clear;



/* HEIGHT ONLY, RE-WEIGHTED (BY HNUM_M1931, etc.) */;
/* NO DIFFERENCE FROM ABOVE */;

foreach varnum in

    /* HEIGHTS BY COHORT */
    1931 1936 1941 1946
    1951 1956 1961 1966 1971 1976

    3136 4146 5156 6166 7176

    4146_3136 5156_3136 6166_3136 7176_3136
    5156_4146 6166_4146 7176_4146
    6166_5156 7176_5156
{;
use war_data_province_sep09;

regress height_`varnum' `vio' prop_`varnum' south if sample_all, robust;
regress height_`varnum' `vio' prop_`varnum' south if central==1, robust;

/* MAIN OLS SPECIFICATIONS */;
regress height_`varnum' `vio'
    prop_`varnum'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    if sample_all==1, robust;
summ height_`varnum' if sample_all==1;

/* WITHOUT QUANG TRI */;
regress height_`varnum' `vio'
    prop_`varnum'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    if (provincename~="Quang Tri") & sample_all==1, robust;
summ height_`varnum' if (provincename~="Quang Tri") & sample_all==1;

/* CENTRAL REGION */;
regress height_`varnum' `vio'
    prop_`varnum'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    if central==1 & sample_all==1, robust;
summ height_`varnum' if central==1 & sample_all==1;

/* REDUCED FORM */;
regress height_`varnum' 
    diff_17
    prop_`varnum'
    popdensity6061
    south
    $x_elev $x_gis $x_weather /* $x_oth */
    /* $x_soil1 $x_soil2 */
    if sample_all==1, robust;
summ height_`varnum' if sample_all==1;


};

/* Heights by gender */;
summ height_f3136 height_m3136 height_f4146 height_m4146
    height_f5156 height_m5156 height_f6166 height_m6166
    height_f7176 height_m7176;

collapse (sum) hnum_3136 hnum_4146 hnum_5156 hnum_6166 hnum_7176;
summ;

clear;


};


/* PLOT OUT POPULATION DENSITY, CONSUMPTION FOR BOMBED, OTHER PROVINCES */;
/* MEDIAN BOMBING PROVINCE DENSITY = 12, TOP 10% > 90 */;

/* BEGIN ANALYSIS FOR FIGURES 6 AND 7 */;
/* STATE INVESTMENT AND POPULATION DENSITY */;
/* BY MORE VERSUS LESS HEAVILY BOMBED PROVINES */;

use war_data_province_sep09;
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

twoway (connected q1_ year, ml(lab1) mlabp(12)) (connected q2_ year, ml(lab2) mlabp(12)) (connected q3_ year, ml(lab3) mlabp(12)) (connected q4_ year, ml(lab4) mlabp(12)), ylabel(0(100)600) l1title("Population density") saving(ch_popdensity_20001985, replace);

twoway (connected ratio2 year, ml(lab2) mlabp(12)) (connected ratio3 year, ml(lab3) mlabp(12)) (connected ratio4 year, ml(lab4) mlabp(12)),
    /* ylabel(0(100)600) */ l1title("Population density ratio") saving(popdensity_ratio_20001985, replace);

twoway (connected ratio34 year, mlabp(12)),
    ylabel(1(0.2)1.6) l1title("Population density") saving(popdensity_median_20001985, replace);

clear;


/* POST-WAR INVESTMENT PATTERNS OVER TIME */;
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

twoway (connected q1_ year, ml(lab1) mlabp(12)) (connected q2_ year, ml(lab2) mlabp(12)) (connected q3_ year, ml(lab3) mlabp(12)) (connected q4_ year, ml(lab4) mlabp(12)),
    /*ylabel(0(100)600)*/ l1title("Investment (in current Dong)") saving(invest_19851976, replace);

twoway (connected ratio2 year, ml(lab2) mlabp(12)) (connected ratio3 year, ml(lab3) mlabp(12)) (connected ratio4 year, ml(lab4) mlabp(12)),
    /* ylabel(0(100)600) */ l1title("Investment ratio (in current Dong)") saving(invest_ratio_19851976, replace);

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

log c;
