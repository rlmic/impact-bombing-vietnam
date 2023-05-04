/*-----------------------------------
APPENDIX
ALTERNATIVE 
SPECIFICATIONS
-----------------------------------*/

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
- GINI COEFICIENT IN 
  CONSUMPTION

-----------*/

foreach dep in                                                              ///
	pcexp_99                                                                ///
    gini{ 

    // (1) (2)
    levelsof south, local(sud)

    foreach level of local sud {
        eststo: regress                                                     ///
            `dep'                                                           ///
            tot_bmr_per                                                     ///
            popdensity6061                                                  ///
            $x_elev                                                         ///
            $x_gis                                                          ///
            $x_weather                                                      ///
            $x_soil1                                                        ///
            $x_soil2                                                        ///
            if sample_all==1 & south==`level',                              ///
            robust cluster(province)
        est sto app1`level'_south
        estadd local has_control "Yes"

    }

    bys south: summ $y_pov if sample_all==1

    // (3) (4)
    gen urban_6061 = (popdensity6061>200 & popdensity6061~=.)

    levelsof urban_6061, local(urbano)

    foreach level of local urbano {                                                
        eststo: regress                                                    ///
            `dep'                                                          ///
            tot_bmr_per                                                    ///
            popdensity6061                                                 ///
            south                                                          ///
            $x_elev                                                        ///
            $x_gis                                                         ///
            $x_weather                                                     ///
            $x_soil1                                                       ///
            $x_soil2                                                       ///
            if sample_all==1 & urban_6061==`level',                        ///
            robust cluster(province)
        est sto app1`level'_urban
        estadd local has_control "Yes"

    }
    
    bys urban_6061: summ $y_pov if sample_all==1

    drop urban_6061

    // (5)
    eststo app15: regress $dep tot_bmr_per tot_bmr_per_2                    ///
    popdensity6061                                                          ///
    $x_weather $x_elev $x_gis                                               ///
    $x_soil1 $x_soil2                                                       ///
    south                                                                   ///
    if sample_all==1,                                                       ///
    robust cluster(province)

    estadd local has_control "Yes"

    summ $y_pov if sample_all==1

    // (6)
    eststo app16: regress                                                   ///
        `dep'                                                               ///
        tot_bmr_hi                                                          ///
        popdensity6061                                                      ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        south                                                               ///
        if sample_all==1,                                                   ///
        robust cluster(province)
        
    estadd local has_control "Yes"

    summ $y_pov if sample_all==1

    local app1 app10_south app11_south app10_urban app11_urban app15 app16

    esttab `app1' using "$tables/app1_reg_`dep'_$source.tex", replace        ///
    label star(* 0.10 ** 0.05 *** 0.01)                                      ///
    booktabs nonotes                                                         ///
    scalars("has_control District demographic, geographic, soil controls")   ///
    sfmt(0) r2 b(%12.7f) se(%12.7f)                                          ///
    mgroups(`dep',                                                           ///
    pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                          ///
    suffix(}) span erepeat(\cmidrule(lr){@span}))                            ///
    alignment(D{.}{.}{-1})                                                   ///
    mtitles("Ex-North" "Ex-South" "Rural" "Urban" "All Vietnam" "All Vietnam" ) ///
    keep(tot_bmr_hi tot_bmr_per tot_bmr_per_2)                               
    }


/*-----------
ALT. TO TABLE 6
ALTERNATIVES  
PROVINCE-LEVEL
STATE INVESTMENT
DURING 1976 TO 198

-----------*/


foreach dep in                                                              ///
	invest_76                                                               ///
    invest_78                                                               ///
    invest_80                                                               ///
    invest_82                                                               ///
    invest_85                                                               ///
    invest_85_per{    

	invest_85_per
	output_85_per
	food2_85_per
	pupils_85_per