/*
APPENDIX


ROBUSTNESS CHECKS 
(NOT SHOWN IN TABLES IN OF 
MAIN PAPER)

-----------------------------------*/


/*-----------
ALT. TO TABLE 4
SPECIFICATIONS:
- 1 & 2
-------------

LOCAL BOMBING
IMPACTS ON ESTIMATED
1999 POVERTY RATE
CONSIDERING:
- INTENSITY OF GENERAL
  PURPOSE BOMBS
- MAJOR ORDNANCE CATEGORY 
- LOG TRANSFORMATION OF TOTAL
  BOMBING INTENSITY

-----------*/

foreach ind in                                                              ///
    General_Purpose                                                         ///
    log_tot_bmr{

    // (OLS 1)
    cwf province

    eststo clear

    eststo: regress                                                         ///
        $y_pov                                                              ///
        `ind'                                                               /// 
        popdensity6061                                                      ///
        $south                                                               ///
        $x_elev                                                             ///
        $x_weather                                                          ///
        $x_gis                                                              ///
        if sample_all==1, robust

    est sto tab41a

    estadd local has_soil "No"

    estadd local exc_qua "No"

    estadd local has_fe "No"

    summ                                                                    ///
        $y_pov                                                              ///
        if sample_all==1

    // (OLS 2)
    cwf district

    eststo: regress                                                         ///
        $y_pov                                                              ///
        `ind'                                                               /// 
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_weather                                                          ///
        $x_gis                                                              ///
        $x_soil1                                                            ///
        $x_soil2,                                                           ///
        robust cluster(province)

    est sto tab42a

    estadd local has_soil "Yes"

    estadd local exc_qua "No"

    estadd local has_fe "No"

    summ $y_pov                                                                 

    local app_tab4 tab41a tab42a

    esttab `app_tab4' using "$tables/app_tab4_`ind'_reg_$source.tex",       ///
    replace nomtitle label star(* 0.10 ** 0.05 *** 0.01)                    ///
    booktabs nonotes                                                        ///
        scalars(                                                            ///
            "has_soil District soil"                                        ///
            "exc_qua Exclude Quang Tri"                                     ///
            "has_fe Fixed Effects"                                          ///
            )                                                               ///
        sfmt(0) r2 b(%8.6f) se(%8.6f)                                       ///
    mgroups("Estimated poverty rate, 1999",                                 ///
    pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                         ///
    suffix(}) span erepeat(\cmidrule(lr){@span}))                           ///
    alignment(D{.}{.}{-1})                                                  ///
    drop(soil* _cons)    
    }

/*-----------
ALT. TO TABLE 5
ALTERNATIVES  
DISTRICT-LEVEL
WELFARE MEASURES
-------------

LOCAL BOMBING
IMPACTS ON 
- AVG PER CAPITA 
  CONSUMPTION LEVEL
  District per capita consumption expenditures, 1999
- GINI COEFICIENT IN 
  CONSUMPTION

-----------*/

cwf district

foreach dep in                                                              ///
    rlpcex1_9398                                                            ///
    gini{ 
    // (5)
    eststo tab5a5: regress                                                  ///
        `dep'                                                               ///
        tot_bmr_per                                                         ///
        tot_bmr_per_2                                                       ///
        popdensity6061                                                      ///
        $x_weather $x_elev $x_gis                                           ///
        $x_soil1 $x_soil2                                                   ///
        $south                                                              ///
        if sample_all==1,                                                   ///
        robust cluster(province)

    estadd local has_control "Yes"

    summ `dep' if sample_all==1

    local app_tab5 tab5a5

    esttab `app_tab5' using "$tables/app_tab5_`dep'_reg_$source.tex",       ///
    replace label star(* 0.10 ** 0.05 *** 0.01)                             ///
    booktabs nonotes                                                        ///
    scalars("has_control District demographic, geographic, soil controls")  ///
    sfmt(0) r2 b(%12.7f) se(%12.7f)                                         ///
    mgroups(`dep',                                                          ///
    pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                         ///
    suffix(}) span erepeat(\cmidrule(lr){@span}))                           ///
    alignment(D{.}{.}{-1})                                                  ///
    mtitles("All Vietnam" )                                                 ///
    keep(tot_bmr_per tot_bmr_per_2)                               
                              
    }

/*-----------
ALT. TO TABLE 6
ALTERNATIVES  
PROVINCE-LEVEL
-------------
LOCAL WAR IMPACTS
ON:
- MEMBERSHIP IN WAR
  WAR VETERANS
  ASSOCIATIONS
- 2002 DISABILITY 
  RATES
-----------*/

foreach dep in                                                             ///
    invalids02                                                             ///
	vetassoc{

    cwf province
    /*
    PANEL A
    */

    // (1)
    eststo app_tab6a_`dep': regress                                        ///
        `dep'                                                              ///
        tot_bmr_per                                                        ///                
        popdensity6061                                                     ///
        $south                                                             ///
        $x_elev                                                            ///
        $x_gis                                                             ///
        $x_weather                                                         ///
        if sample_all==1, robust

    estadd local exc_qua "No"

    summ `dep' if sample_all==1

    } 
local app_tab6a app_tab6a_invalids02 app_tab6a_vetassoc
esttab `app_tab6a' using "$tables/app_tab6a_reg_$source.tex",              ///    
replace label star(* 0.10 ** 0.05 *** 0.01)                                ///
booktabs nonotes                                                           ///
scalars(                                                                   ///
    "exc_qua Exclude Quang Tri"                                            ///
    )                                                                      ///    
sfmt(0) r2 b(%8.5f) se(%8.5f)                                              ///                                                             
mtitles("2002 disability rates" "War veterans' associations" )             ///
keep(tot_bmr_per)

/*-----------
ALT. TO TABLE 6
ALTERNATIVES  
PROVINCE-LEVEL
-------------
LOCAL WAR IMPACTS
ON:
- STATE INVESTMENT
DURING 1976 TO 1985
-----------*/


foreach dep in                                                              ///
    invest_76                                                               ///
    invest_78                                                               ///
    invest_80                                                               ///
    invest_82                                                               ///
    invest_85_per{ 

    cwf province
    /*
    PANEL A
    */

    // (1)
    eststo app_tab6b_`dep': regress                                         ///
        `dep'                                                               ///
        tot_bmr_per                                                         ///                
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        if sample_all==1, robust

    estadd local exc_qua "No"

    summ `dep' if sample_all==1

    }

local                                                                       ///
    app_tab6b                                                               /// 
    app_tab6b_invest_76                                                     ///
    app_tab6b_invest_78                                                     ///
    app_tab6b_invest_80                                                     ///
    app_tab6b_invest_82                                                     ///
    app_tab6b_invest_85_per                                                 ///

esttab `app_tab6b' using "$tables/app_tab6b_reg_$source.tex",               ///    
replace label star(* 0.10 ** 0.05 *** 0.01)                                 ///
booktabs nonotes                                                            ///
scalars(                                                                    ///
    "exc_qua Exclude Quang Tri"                                             ///
    )                                                                       ///    
sfmt(0) r2 b(%8.4f) se(%8.4f)                                               /// 
mgroups("STATE INVESTMENT",                                                 ///
pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                             ///
suffix(}) span erepeat(\cmidrule(lr){@span}))                               ///
alignment(D{.}{.}{-1})                                                      ///
mtitles("1976" "1978" "1980" "1982" "1985" )                                ///
keep(tot_bmr_per)

/*-----------
ALT. TO TABLE 7
ALTERNATIVES  
PROVINCE-LEVEL
-------------
LOCAL WAR IMPACTS
ON:
- OTHER 1990s 
  HUMAN CAPITAL 
  MEASURES
-----------*/

foreach dep in                                                              ///
    educyr98father                                                          ///
    educyr98mother                                                          ///
	educyr98_head{

    /*
    PANEL B
    */

    // (1)
    cwf province

    eststo tab7_b1: regress                                                 ///
        `dep'                                                               ///
        tot_bmr_per                                                         /// 
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        if sample_all==1, robust

    estadd local has_soil "No"

    estadd local has_fe "No"

    estadd local exc_qua "No"

    summ `dep' if sample_all==1

    // (2)
    cwf district

    eststo tab7_b2: regress                                                 ///
        `dep'                                                               ///
        tot_bmr_per                                                         /// 
        popdensity6061                                                      ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        $south,                                                             ///
        robust cluster(province)

    estadd local has_soil "Yes"

    estadd local has_fe "No"

    estadd local exc_qua "No"

    summ `dep'

    // (3)
    eststo tab7_b3: areg                                                    ///
        `dep'                                                               ///
        tot_bmr_per                                                         ///
        $x_weather                                                          ///          
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        if sample_all==1, a(province) robust cluster(province)

    estadd local has_soil "Yes"

    estadd local has_fe "Yes"

    estadd local exc_qua "No"

    summ `dep' if sample_all==1

    // (4)
    eststo tab7_b4: regress                                                 ///
        `dep'                                                               ///
        tot_bmr_per                                                         ///
        popdensity6061                                                      ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///          
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        $south                                                              ///
        if provincename~="Quang Tri" & sample_all==1, robust cluster(province)

    estadd local has_soil "Yes"

    estadd local has_fe "No"

    estadd local exc_qua "Yes"

    summ `dep' if provincename~="Quang Tri" & sample_all==1

    // (5)
    eststo tab7_b5: regress                                                 ///
        `dep'                                                               ///
        $x_diff                                                             ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///          
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        if sample_all==1, robust cluster(province)     
        
    estadd local has_soil "Yes"

    estadd local has_fe "No"

    estadd local exc_qua "No"

    summ `dep' if sample_all==1

    // (6)
    eststo tab7_b6: regress                                                 ///
        `dep'                                                               ///
        tot_bmr_per                                                         ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        ($x_diff                                                            ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2)                                                           ///
        if sample_all==1, robust cluster(province)
        
    estadd local has_soil "Yes"

    estadd local has_fe "No"

    estadd local exc_qua "No"

    summ `dep' if sample_all==1

    local app_tab7 tab7_b1 tab7_b2 tab7_b3 tab7_b4 tab7_b5 tab7_b6

    esttab `app_tab7' using "$tables/app_tab7_`dep'_reg_$source.tex",       ///
    star(* 0.10 ** 0.05 *** 0.01)                                           ///
    booktabs nonotes                                                        ///
    scalars(                                                                ///
        "has_soil District soil"                                            ///
        "exc_qua Exclude Quang Tri"                                         ///
        "has_fe Fixed Effects"                                              ///
        )                                                                   ///
    sfmt(0) r2 b(%12.5f) se(%12.5f)                                         ///
    nomtitle                                                                ///
    mgroups(`dep',                                                          ///
    pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                         ///
    suffix(}) span erepeat(\cmidrule(lr){@span}))                           ///
    alignment(D{.}{.}{-1})                                                  ///
    keep(tot_bmr_per $x_diff) label replace
    }

/*-----------
ALT. TO TABLE 8
ALTERNATIVES  
DISTRICT-LEVEL
-------------
LOCAL WAR IMPACTS
ON POPULATION 
DENSITY
SUBSAMPLES
- NORTH VIETNAM
- SOUTH VIETNAM
- RURAL AREAS
- URBAN AREAS
-----------*/

cwf district

eststo clear

// (1) (2)

levelsof $south, local(sud)
    
foreach level of local sud {

    eststo: regress                                                         ///
        $y_pop_den_1999                                                     ///
        tot_bmr_per                                                         ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        $x_gis                                                              ///
        if sample_all==1 & $south==`level',                                 ///
        robust cluster(province)
   
    est sto app_tab82`level'_south

    estadd local has_soil "Yes"

    estadd local exc_qua "No"

    estadd local has_fe "No"

}

bys $south: summ $y_pop_den_1999 if sample_all==1

gen urban_6061 = (popdensity6061>200 & popdensity6061~=.)

levelsof urban_6061, local(urbano)

foreach level of local urbano {                                                

    eststo: regress                                                         ///
        $y_pop_den_1999                                                     ///
        tot_bmr_per                                                         ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        $x_gis                                                              ///
        if sample_all==1  & urban_6061==`level',                            ///
        robust cluster(province)
   
    est sto app_tab82`level'_urban

    estadd local has_soil "Yes"

    estadd local exc_qua "No"

    estadd local has_fe "No"

}
bys urban_6061: summ $y_pop_den_1999 if sample_all==1


local app_tab82 app_tab820_south app_tab821_south app_tab820_urban app_tab821_urban

esttab `app_tab82' using "$tables/app_tab82_reg_$source.tex", replace       ///
    label star(* 0.10 ** 0.05 *** 0.01)                                     ///
    booktabs nonotes                                                        ///
    scalars(                                                                ///
        "has_soil District soil"                                            ///
        "exc_qua Exclude Quang Tri"                                         ///
        "has_fe Fixed Effects"                                              ///
        )                                                                   ///
    sfmt(0) r2 b(%12.2f) se(%12.2f)                                         ///
    mgroups("Population density, 1999",                                     ///
    pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                         ///
    suffix(}) span erepeat(\cmidrule(lr){@span}))                           ///
    alignment(D{.}{.}{-1})                                                  ///
    mtitles("Ex-North" "Ex-South" "Rural" "Urban" )                         ///
    drop(soil* _cons)                                                      


// (3)

foreach level of local sud {

    eststo: areg                                                            ///
        $y_pop_den_1999                                                     ///
        tot_bmr_per                                                         ///
        $x_elev                                                             ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        $x_gis                                                              ///
        if sample_all==1 & south==`level',                                  ///
        a(province) robust cluster(province)

    est sto app_tab83`level'_south

    estadd local has_soil "Yes"

    estadd local exc_qua "Yes"

    estadd local has_fe "No"

}

bys $south: summ $y_pop_den_1999 if sample_all==1

foreach level of local urbano {   
        eststo: areg                                                        ///
        $y_pop_den_1999                                                     ///
        tot_bmr_per                                                         ///
        $x_elev                                                             ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        $x_gis                                                              ///
        if sample_all==1 & urban_6061==`level',                             ///
        a(province) robust cluster(province)

    est sto app_tab83`level'_urban

    estadd local has_soil "Yes"

    estadd local exc_qua "Yes"

    estadd local has_fe "No"

}

bys urban_6061: summ $y_pop_den_1999 if sample_all==1


local app_tab83 app_tab830_south app_tab831_south app_tab830_urban app_tab831_urban

esttab `app_tab83' using "$tables/app_tab83_reg_$source.tex", replace       ///
    label star(* 0.10 ** 0.05 *** 0.01)                                     ///
    booktabs nonotes                                                        ///
    scalars(                                                                ///
        "has_soil District soil"                                            ///
        "exc_qua Exclude Quang Tri"                                         ///
        "has_fe Fixed Effects"                                              ///
        )                                                                   ///
    sfmt(0) r2 b(%12.2f) se(%12.2f)                                         ///
    mgroups("Population density, 1999",                                     ///
    pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                         ///
    suffix(}) span erepeat(\cmidrule(lr){@span}))                           ///
    alignment(D{.}{.}{-1})                                                  ///
    mtitles("Ex-North" "Ex-South" "Rural" "Urban" )                         ///
    drop(soil* _cons)                                                       


/*-----------
ALT. TO TABLE 9
ALTERNATIVES  
PROVINCE-LEVEL
-------------
LOCAL WAR IMPACTS
ON:
- POPULATION 1990
- POPULATION 1992
- POPULATION 1994
- POPULATION 1996
- POPULATION 1998
- POPULATION 2000
-----------*/

foreach dep in                                                              ///
    popdensity1990                                                          ///
    popdensity1992                                                          ///
    popdensity1994                                                          ///
    popdensity1996                                                          ///
    popdensity1998                                                          ///
    popdensity2000{

    // PANEL A
    //--------

    // (1)
    cwf province

    eststo tab9a1_app: regress                                              ///
        `dep'                                                               ///
        tot_bmr_per                                                         ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        if sample_all==1, robust
        
    estadd local exc_qua "No"

    summ `dep' if sample_all==1

    // (2)
    eststo tab9a2_app: regress                                              ///
        `dep'                                                               ///
        tot_bmr_per                                                         ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        if (provincename~="Quang Tri") & sample_all==1, robust                    

    estadd local exc_qua "Yes"

    summ `dep'                                                              /// 
        if (provincename~="Quang Tri") & sample_all==1

    // (3)
    eststo tab9a3_app: regress                                              ///
        `dep'                                                               ///
        $x_diff                                                             ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        if sample_all==1, robust
    
    estadd local exc_qua "No"

    summ `dep' if sample_all==1

    local app_tab9 tab9a1_app tab9a2_app tab9a3_app

    esttab `app_tab9' using "$tables/app_tab9_`dep'_reg_$source.tex",       ///    
    replace label star(* 0.10 ** 0.05 *** 0.01)                             ///
    booktabs nonotes                                                        ///
    scalars(                                                                ///
        "exc_qua Exclude Quang Tri"                                         ///
        )                                                                   ///    
    sfmt(0) r2 b(%8.2f) se(%8.2f)                                           /// 
    nomtitle                                                                ///
    mgroups(`dep' ,                                                         ///
    pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                         ///
    suffix(}) span erepeat(\cmidrule(lr){@span}))                           ///
    alignment(D{.}{.}{-1})                                                  ///
    keep(tot_bmr_per $x_diff)
    }    
