/*

MAIN ANALYSIS

------------------------------------------

*/

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

eststo clear

estpost summ                                                                ///
    tot_bmr_per                                                             ///
    tot_bmr                                                                 ///
    $ord1                                                                   ///
    $ord2                                                                   ///
    $ord0                                                                   ///
    if sample_all==1
    
esttab using "$tables/tab1a_stats_$source.tex", replace                     ///
    cells(                                                                  ///
    "mean($meas) sd($meas) max($meas) count()"                              ///
    )                                                                       ///
    nonumber                                                                ///
    nomtitle                                                                ///
    nonote                                                                  ///
    noobs label booktabs                                                    ///                                        
    title($title_tab1a_stats)                                               ///
    addnotes($note_tab1a_stats)                                             ///
    collabels("Mean" "S.D." "Max." "Obs.")
    
// Correlation with general purpose bombs

estpost correlate                                                           ///
    $ord1                                                                   ///
    tot_bmr                                                                 ///
    tot_bmr_per                                                             ///
    $ord2                                                                   ///
    $ord0                                                                   /// 
    if sample_all==1                                                        ///
    [aw=pop_tot]
    
esttab using "$tables/tab1a_corr_$source.tex",                              ///
    replace                                                                 /// 
    nonote                                                                  ///
    noobs label booktabs                                                    ///
    compress                                                                ///
    cells("b($meas)")                                                       ///
    title($title_tab1a_corr)                                                ///
    collabels("Correlation")                                                ///
    star(* 0.10 ** 0.05 *** 0.01)
/*
PANEL B
*/

cwf province

estpost summ                                                                ///
    tot_bmr_per                                                             ///
    if sample_all==1  

esttab using "$tables/tab1b_stats_$source.tex", replace                     ///
    cells(                                                                  ///
    "mean($meas) sd($meas) max($meas) count()"                              ///
    )                                                                       ///
    nonumber                                                                ///
    nomtitle                                                                ///
    nonote                                                                  ///
    noobs label    booktabs                                                 ///                                        
    title($title_tab1b_stats)                                               ///
    addnotes($note_tab1b_stats)                                             ///
    collabels("Mean" "S.D." "Max." "Obs.")
    
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

eststo clear

estpost summ                                                                ///
    poverty_p0                                                              ///
    popdensity1999                                                          ///
    elec_rate                                                               ///
    lit_rate                                                                ///
    $x_elev                                                                 ///
    area_tot_km2                                                            ///
    $x_weather                                                              ///
    $south                                                                  ///
    $x_gis                                                                  ///
    $x_diff                                                                 ///
    if sample_all==1

esttab using "$tables/tab2a_stats_$source.tex", replace                     ///
    cells(                                                                  ///
    "mean($meas) sd($meas) min($meas) max($meas) count()"                   ///
    )                                                                       ///
    nonumber                                                                ///
    nomtitle                                                                ///
    nonote                                                                  ///
    noobs label    booktabs                                                 ///                                        
    title($title_tab2a_stats)                                               ///
    addnotes($note_tab2a_stats)                                             ///
    collabels("Mean" "S.D." "Min" "Max." "Obs.")

/*
PANEL B
*/

cwf province

estpost summ                                                                ///
    popdensity6061                                                          ///
    popdensity1985                                                          ///
    popdensity1999                                                          ///
    ch_popdensity_20001985                                                  ///
    nbhere                                                                  ///
    exppc93r98                                                              ///
    exppc02r98                                                              ///
    consgrowth_9302                                                         ///
    $x_gis                                                                  ///
    $x_diff                                                                 ///
    poverty_p0                                                              ///
    $south                                                                  ///
    $x_weather                                                              ///
    $x_elev                                                                 ///
    if sample_all==1
    
esttab using "$tables/tab2b_stats_$source.tex", replace                     ///
    cells(                                                                  ///
    "mean($meas) sd($meas) min($meas) max($meas) count()"                   ///
    )                                                                       ///
    nonumber                                                                ///
    nomtitle                                                                ///
    nonote                                                                  ///
    noobs label    booktabs                                                 ///                                        
    title($title_tab2b_stats)                                               ///
    addnotes($note_tab2b_stats)                                             ///
    collabels("Mean" "S.D." "Min" "Max." "Obs.")


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

eststo clear

eststo tab31: regress                                                       ///
    $y_bom                                                                  ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust
    
estadd local has_soil "No"

estadd local exc_qua "No"

summ                                                                        ///
    $y_bom                                                                  ///
    if sample_all==1


// Column 2: District level: All

cwf district

eststo tab32: regress                                                       ///
    $y_bom                                                                  ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province)

estadd local has_soil "Yes"

estadd local exc_qua "No"

summ                                                                        ///
    $y_bom                                                                  ///
    if sample_all==1

// Column 3: District level: Exclude Quang Tri

eststo tab33: regress                                                       ///
    $y_bom                                                                  ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1 & provincename~="Quang Tri", robust cluster(province)

estadd local has_soil "Yes"

estadd local exc_qua "Yes"

summ                                                                        ///
    $y_bom                                                                  ///
    if sample_all==1 & provincename~="Quang Tri"
    
// Produce regression table

local tab3 tab31 tab32 tab33

esttab `tab3' using "$tables/tab3_reg_$source.tex", replace                 ///
    nomtitle label star(* 0.10 ** 0.05 *** 0.01)                            ///
    booktabs nonotes                                                        ///
    scalars(                                                                ///
        "has_soil District soil"                                            ///
        "exc_qua Exclude Quang Tri"                                         ///
        )                                                                   ///
    sfmt(%14.5fc) r2 b(%12.4f) se(%12.4f)                                   ///
    mgroups("Total U.S. bombs, missiles and rockets per km$^2$",            ///
    pattern(1 0 0 )                                                         ///
    prefix(\multicolumn{@span}{c}{)                                         ///
    suffix(}) span                                                          ///
    erepeat(\cmidrule(lr){@span}))                                          ///
    alignment(D{.}{.}{-1})                                                  ///
    drop(_cons soil*)                                                       ///
    title($title_tab3_reg)                                                

/*-----------
TABLE 4
-------------

LOCAL BOMBING
IMPACTS ON ESTIMATED
1999 POVERTY RATE

-----------*/

// (OLS 1)
cwf province

eststo clear

eststo: regress                                                             ///
    $y_pov                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust

est sto tab41

estadd local has_soil "No"

estadd local exc_qua "No"

estadd local has_fe "No"

summ                                                                        ///
    $y_pov                                                                  ///
    if sample_all==1

// (OLS 2)
cwf district

eststo: regress                                                             ///
    $y_pov                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2,                                                               ///
    robust cluster(province)

est sto tab42

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pov                                                                 

// (OLS 3)
eststo: areg                                                                ///
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

est sto tab43

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "Yes"

summ                                                                        ///
    $y_pov                                                                  ///
    if sample_all==1

// (OLS 4)
eststo tab44: regress                                                       ///
    $y_pov                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if provincename~="Quang Tri" & sample_all==1,                           ///
    robust cluster(province)

estadd local has_soil "Yes"

estadd local exc_qua "Yes"

estadd local has_fe "No"

summ                                                                        ///
    $y_pov                                                                  ///
    if provincename~="Quang Tri" & sample_all==1

// (OLS 5)
eststo tab45: regress                                                       ///
    $y_pov                                                                  ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province)

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pov if sample_all==1

// (IV-2SLS 6)
eststo tab46: regress                                                       ///
   $y_pov                                                                   ///
   tot_bmr_per                                                              ///
   popdensity6061                                                           ///
   $south                                                                   ///
   $x_elev                                                                  ///
   $x_gis                                                                   ///
   $x_weather                                                               ///
   $x_soil1                                                                 ///
   $x_soil2                                                                 ///
   ($x_diff                                                                 ///
   popdensity6061                                                           ///
   $south                                                                   ///
   $x_elev                                                                  ///
   $x_gis                                                                   ///
   $x_weather                                                               ///
   $x_soil1                                                                 ///
   $x_soil2)                                                                ///
   if sample_all==1, robust cluster(province)
   
   
estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pov if sample_all==1

local tab4 tab41 tab42 tab43 tab44 tab45 tab46

esttab `tab4' using "$tables/tab4_reg_$source.tex", replace                 ///
   nomtitle label star(* 0.10 ** 0.05 *** 0.01)                             ///
   booktabs nonotes                                                         ///
    scalars(                                                                ///
        "has_soil District soil"                                            ///
        "exc_qua Exclude Quang Tri"                                         ///
        "has_fe Fixed Effects"                                              ///
        )                                                                   ///
    sfmt(0) r2 b(%8.6f) se(%8.6f)                                           ///
   mgroups("Estimated poverty rate, 1999",                                  ///
   pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                          ///
   suffix(}) span erepeat(\cmidrule(lr){@span}))                            ///
   alignment(D{.}{.}{-1})                                                   ///
   drop(soil* _cons)                                                        ///
   title($title_tab4_reg)    
   
   
/*-----------
TABLE 5
-------------

LOCAL BOMBING
IMPACTS ON ESTIMATED
1999 POVERTY RATE
ALTERNATIVE 
SPECIFICATIONS
-----------*/

eststo clear

// (1) (2)
    
levelsof $south, local(sud)

foreach level of local sud {
    eststo: regress                                                         ///
        $y_pov                                                              ///
        tot_bmr_per                                                         ///
        popdensity6061                                                      ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        if sample_all==1 & $south==`level',                                 ///
        robust cluster(province)
    est sto tab5`level'_south
    estadd local has_control "Yes"

}

bys $south: summ $y_pov if sample_all==1

// (3) (4)
gen urban_6061 = (popdensity6061>200 & popdensity6061~=.)

levelsof urban_6061, local(urbano)

foreach level of local urbano {                                                
    eststo: regress                                                         ///
        $y_pov                                                              ///
        tot_bmr_per                                                         ///
        popdensity6061                                                      ///
        $south                                                              ///
        $x_elev                                                             ///
        $x_gis                                                              ///
        $x_weather                                                          ///
        $x_soil1                                                            ///
        $x_soil2                                                            ///
        if sample_all==1 & urban_6061==`level',                             ///
        robust cluster(province)
    est sto tab5`level'_urban
    estadd local has_control "Yes"

}
   
bys urban_6061: summ $y_pov if sample_all==1

drop urban_6061

// (5)
eststo tab55: regress poverty_p0 tot_bmr_per tot_bmr_per_2                 ///
   popdensity6061                                                          ///
   $x_weather $x_elev $x_gis                                               ///
   $x_soil1 $x_soil2                                                       ///
   $south                                                                  ///
   if sample_all==1,                                                       ///
   robust cluster(province)

estadd local has_control "Yes"

summ $y_pov if sample_all==1

// (6)
eststo tab56: regress                                                       ///
    $y_pov                                                                  ///
    tot_bmr_hi                                                              ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    $south                                                                  ///
    if sample_all==1,                                                       ///
    robust cluster(province)
     
estadd local has_control "Yes"

summ $y_pov if sample_all==1

local tab5 tab50_south tab51_south tab50_urban tab51_urban tab55 tab56

esttab `tab5' using "$tables/tab5_reg_$source.tex", replace                 ///
   label star(* 0.10 ** 0.05 *** 0.01)                                      ///
   booktabs nonotes                                                         ///
   scalars("has_control District demographic, geographic, soil controls")   ///
   sfmt(0) r2 b(%12.7f) se(%12.7f)                                          ///
   mgroups("Estimated poverty rate, 1999",                                  ///
   pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)                          ///
   suffix(}) span erepeat(\cmidrule(lr){@span}))                            ///
   alignment(D{.}{.}{-1})                                                   ///
   mtitles("Ex-North" "Ex-South" "Rural" "Urban" "All Vietnam" "All Vietnam" ) ///
   keep(tot_bmr_hi tot_bmr_per tot_bmr_per_2)                               ///
   title($title_tab5_reg)

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
eststo tab6a1: regress                                                      ///
    $y_consum_2002                                                          ///
    tot_bmr_per                                                             ///                
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

estadd local exc_qua "No"

summ $y_consum_2002 if sample_all==1

// (2)
eststo tab6a2: regress                                                      ///
    $y_consum_2002                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
 
estadd local exc_qua "Yes"

summ $y_consum_2002 if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo tab6a3: regress                                                      ///
    $y_consum_2002                                                          ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

estadd local exc_qua "No"

summ $y_consum_2002 if sample_all==1

local tab6a tab6a1 tab6a2 tab6a3

esttab `tab6a' using "$tables/tab6_reg_$source.tex",                        ///    
    prehead("\begin{table}[htbp]\centering \\ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \\ \caption{$title_tab6_reg} \\ \begin{tabular}{l*{3}{c}} \hline\hline")                                                                            ///
    posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel A: 2002 per capita consumption expenditures}} \\\\[-1ex]") ///
    fragment                                                                ///
    scalars(                                                                ///
        "exc_qua Exclude Quang Tri"                                         ///
        )                                                                   ///    
    sfmt(0) r2 b(%8.5f) se(%8.5f) nomtitles                                 ///
    keep(tot_bmr_per $x_diff) label replace

/*
PANEL B
*/

// (1)
eststo tab6b1: regress                                                      ///
    $y_consum_1992                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
estadd local exc_qua "No"

summ $y_consum_1992 if sample_all==1

// (2)
eststo tab6b2: regress                                                      ///
    $y_consum_1992                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
estadd local exc_qua "Yes"

summ $y_consum_1992 if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo tab6b3: regress                                                      ///
    $y_consum_1992                                                          ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
estadd local exc_qua "No"

summ $y_consum_1992 if sample_all==1

local tab6b tab6b1 tab6b2 tab6b3

esttab `tab6b' using "$tables/tab6_reg_$source.tex",                        ///
    posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel B: 1992-93 per capita consumption expenditures}} \\\\[-1ex]") ///
    fragment append                                                         ///
    scalars(                                                                ///
        "exc_qua Exclude Quang Tri"                                         ///
        )                                                                   ///
    sfmt(0) r2 b(%8.5f) se(%8.5f) nomtitles nonumbers                       ///
    keep(tot_bmr_per $x_diff) label

/*
PANEL C
*/

// (1)
eststo tab6c1: regress                                                      ///
    $y_consum_gro                                                           ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
estadd local exc_qua "No"

summ $y_consum_gro if sample_all==1

// (2)
eststo tab6c2: regress                                                      ///
    $y_consum_gro                                                           ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
 
estadd local exc_qua "Yes"

summ $y_consum_gro                                                          ///
    if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo tab6c3: regress                                                      ///
    $y_consum_gro                                                           ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
 
estadd local exc_qua "No"

summ $y_consum_gro if sample_all==1


local tab6c tab6c1 tab6c2 tab6c3

esttab `tab6c' using "$tables/tab6_reg_$source.tex",                        ///
    posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel C: Growth in consumption, 1992/93–2002}} \\\\[-1ex]") ///
    prefoot("\hline")                                                       ///
    postfoot($foot_pane)                                                    ///
    fragment append                                                         ///
    scalars(                                                                ///
        "exc_qua Exclude Quang Tri"                                         ///
        )                                                                   ///
    sfmt($meas) r2 b(%8.5f) se(%8.5f) nomtitles nonumbers                   ///
    keep(tot_bmr_per $x_diff) label

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
eststo tab7_a1: regress                                                     /// 
    $y_acc_elec                                                             ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
estadd local has_soil "No"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_acc_elec if sample_all==1

// (2)
cwf district
eststo tab7_a2: regress                                                     /// 
    $y_acc_elec                                                             ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2,                                                               ///
    robust cluster(province)

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_acc_elec

// (3)
eststo tab7_a3: areg                                                        ///
    $y_acc_elec                                                             ///
    tot_bmr_per                                                             ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1,                                                       ///
    a(province) robust cluster(province)

estadd local has_soil "Yes"

estadd local has_fe "Yes"

estadd local exc_qua "No"

summ $y_acc_elec if sample_all==1

// (4)
eststo tab7_a4: regress                                                     ///
    $y_acc_elec                                                             ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if provincename~="Quang Tri" & sample_all==1,                           ///
    robust cluster(province)

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "Yes"

summ $y_acc_elec if provincename~="Quang Tri" & sample_all==1

// (5)
eststo tab7_a5: regress                                                     ///
    $y_acc_elec                                                             ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province) 

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_acc_elec if sample_all==1

// (6)
eststo tab7_a6: regress                                                    ///
   $y_acc_elec                                                             /// 
   tot_bmr_per                                                             ///
   popdensity6061                                                          ///
   $south                                                                  ///
   $x_elev                                                                 /// 
   $x_gis                                                                  ///
   $x_weather                                                              ///
   $x_soil1                                                                ///
   $x_soil2                                                                ///
   ($x_diff                                                                ///
   popdensity6061                                                          ///
   $south                                                                  ///
   $x_elev                                                                 ///
   $x_gis                                                                  ///
   $x_weather                                                              ///
   $x_soil1                                                                ///
   $x_soil2)                                                               ///
   if sample_all==1, robust cluster(province)
 
estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_acc_elec if sample_all==1

local tab7_a tab7_a1 tab7_a2 tab7_a3 tab7_a4 tab7_a5 tab7_a6

esttab `tab7_a' using "$tables/tab7_reg_$source.tex",                       ///    
    prehead("\begin{table}[htbp]\centering \\ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \\ \caption{$title_tab7_reg} \\ \begin{tabular}{l*{6}{c}} \hline\hline")                                                                            ///
    posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel A: Proportion of households with access to electricity, 1999}} \\\\[-1ex]") ///
    fragment                                                                ///
    scalars(                                                                ///
        "has_soil District soil"                                            ///
        "exc_qua Exclude Quang Tri"                                         ///
        "has_fe Fixed Effects"                                              ///
        )                                                                   ///
    sfmt($meas) r2 b(%8.5f) se(%8.5f) nomtitles                             ///
    keep(tot_bmr_per $x_diff) label replace

/*
PANEL B
*/

// (1)
cwf province

eststo tab7_b1: regress                                                     ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

estadd local has_soil "No"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_lit if sample_all==1

// (2)
cwf district

eststo tab7_b2: regress                                                     ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    $south,                                                                 ///
    robust cluster(province)

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_lit

// (3)
eststo tab7_b3: areg                                                        ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             ///
    $x_weather                                                              ///          
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, a(province) robust cluster(province)

estadd local has_soil "Yes"

estadd local has_fe "Yes"

estadd local exc_qua "No"

summ $y_lit if sample_all==1

// (4)
eststo tab7_b4: regress                                                     ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    $south                                                                  ///
    if provincename~="Quang Tri" & sample_all==1, robust cluster(province)

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "Yes"

summ $y_lit if provincename~="Quang Tri" & sample_all==1

// (5)
eststo tab7_b5: regress                                                     ///
    $y_lit                                                                  ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province)     
    
estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_lit if sample_all==1

// (6)
eststo tab7_b6: regress                                                     ///
   $y_lit                                                                   ///
   tot_bmr_per                                                              ///
   popdensity6061                                                           ///
   $south                                                                   ///
   $x_elev                                                                  ///
   $x_gis                                                                   ///
   $x_weather                                                               ///
   $x_soil1                                                                 ///
   $x_soil2                                                                 ///
   ($x_diff                                                                 ///
   popdensity6061                                                           ///
   $south                                                                   ///
   $x_elev                                                                  ///
   $x_gis                                                                   ///
   $x_weather                                                               ///
   $x_soil1                                                                 ///
   $x_soil2)                                                                ///
   if sample_all==1, robust cluster(province)
    
estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_lit if sample_all==1

local tab7_b tab7_b1 tab7_b2 tab7_b3 tab7_b4 tab7_b5 tab7_b6

esttab `tab7_b' using "$tables/tab7_reg_$source.tex",                       ///
    posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel B: Proportion of literate respondents, 1999}} \\\\[-1ex]") ///
    prefoot("\hline")                                                       ///
    postfoot($foot_pane)                                                    ///
    fragment append                                                         ///
    scalars(                                                                ///
        "has_soil District soil"                                            ///
        "exc_qua Exclude Quang Tri"                                         ///
        "has_fe Fixed Effects"                                              ///
        )                                                                   ///
    sfmt($meas) r2 b(%8.5f) se(%8.5f) nomtitles nonumbers                   ///
    keep(tot_bmr_per $x_diff) label

/*-----------
TABLE 8
-------------

LOCAL WAR IMPACTS
ON POPULATION 
DENSITY

-----------*/

// (1)
cwf province

eststo: regress                                                             ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust

est sto tab8_1

estadd local has_soil "No"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pop_den_1999 if sample_all==1

// (2)
cwf district

eststo: regress                                                             ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    $x_gis,                                                                 ///
    robust cluster(province)
   
est sto tab8_2

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pop_den_1999

// (3)

eststo: areg                                                                ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    $x_gis                                                                  ///
    if sample_all==1,                                                       ///
    a(province) robust cluster(province)

est sto tab8_3

estadd local has_soil "Yes"

estadd local exc_qua "Yes"

estadd local has_fe "No"

summ $y_pop_den_1999 if sample_all==1

// (4)

eststo: regress                                                             ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    $south                                                                  ///
    if provincename~="Quang Tri" & sample_all==1,                           ///
    robust cluster(province)

est sto tab8_4

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "Yes"

summ $y_pop_den_1999 if provincename~="Quang Tri" & sample_all==1

// (5)

eststo: regress                                                             ///
    $y_pop_den_1999                                                         ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province)

est sto tab8_5

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pop_den_1999 if sample_all==1

// (6)
eststo: regress                                                             ///
    $y_pop_den_1999                                                         ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    ($x_diff                                                                ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    $x_soil1                                                                ///
    $x_soil2)                                                               ///
    if sample_all==1, robust cluster(province)
   

est sto tab8_6

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pop_den_1999 if sample_all==1

local tab8 tab8_*

esttab `tab8' using "$tables/tab8_reg_$source.tex", replace                 ///
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
    mtitles("OLS" "OLS" "OLS" "OLS" "OLS" "IV-2SLS" )                       ///
    drop(soil* _cons)                                                       ///
    title($title_tab8_reg)

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

eststo tab9a1: regress                                                      ///
    $y_pop_den                                                              ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
estadd local exc_qua "No"

summ $y_pop_den if sample_all==1

// (2)
eststo tab9a2: regress                                                      ///
    $y_pop_den                                                              ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust                    

estadd local exc_qua "Yes"

summ $y_pop_den                                                             /// 
    if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo tab9a3: regress                                                      ///
    $y_pop_den                                                              ///  
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
 
estadd local exc_qua "No"

summ $y_pop_den if sample_all==1

local tab9a tab9a1 tab9a2 tab9a3

esttab `tab9a' using "$tables/tab9_reg_$source.tex",                        ///    
    prehead("\begin{table}[htbp]\centering \\ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \\ \caption{$title_tab9_reg} \\ \begin{tabular}{l*{3}{c}} \hline\hline")                                                                 ///
    posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel A: Population density, 1985}} \\\\[-1ex]") ///
    fragment                                                                ///
    scalars(                                                                ///
        "exc_qua Exclude Quang Tri"                                         ///
        )                                                                   ///
    sfmt(0) r2 b(%8.5f) se(%8.5f) nomtitles                                 ///
    keep(tot_bmr_per $x_diff) label replace
        

// PANEL B
//--------

// (1)
eststo tab9b1: regress                                                      ///
    $y_pop_gro                                                              ///  
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
 
estadd local exc_qua "No"

summ $y_pop_gro if sample_all==1

// (2)
eststo tab9b2: regress                                                      ///
    $y_pop_gro                                                              /// 
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust

estadd local exc_qua "Yes"

summ $y_pop_gro                                                             ///  
    if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo tab9b3: regress                                                      ///
    $y_pop_gro                                                              /// 
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
  
estadd local exc_qua "No"

summ $y_pop_gro if sample_all==1

local tab9b tab9b1 tab9b2 tab9b3

esttab `tab9b' using "$tables/tab9_reg_$source.tex",                        ///
    posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel B: Growth in population density, 1985 to 2000}} \\\\[-1ex]") ///
    fragment append                                                         ///
    scalars(                                                                ///
        "exc_qua Exclude Quang Tri"                                         ///
        )                                                                   ///
    sfmt(0) r2 b(%8.5f) se(%8.5f) nomtitles nonumbers                       ///
    keep(tot_bmr_per $x_diff) label


    
// PANEL C
//--------

// (1)
eststo tab9c1: regress                                                      ///
    nbhere                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

estadd local exc_qua "No"

summ nbhere if sample_all==1

// (2)
eststo tab9c2: regress                                                      ///
    nbhere                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
 
estadd local exc_qua "Yes"

summ nbhere if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo tab9c3: regress                                                      ///
    nbhere                                                                  ///
    $x_diff                                                                 ///
    popdensity6061                                                          ///
    $south                                                                  ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

estadd local exc_qua "No"

summ nbhere if sample_all==1

local tab9c tab9c1 tab9c2 tab9c3

esttab `tab9c' using "$tables/tab9_reg_$source.tex",                        ///
       posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel C: 1997/98 proportion not born in current village}} \\\\[-1ex]") ///
    prefoot("\hline")                                                       ///
    postfoot($foot_pane)                                                    ///
    fragment append                                                         ///
    scalars(                                                                ///
        "exc_qua Exclude Quang Tri"                                         ///
        )                                                                   ///
    sfmt(0) r2 b(%8.5f) se(%8.5f) nomtitles nonumbers                       ///
    keep(tot_bmr_per $x_diff) label


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
    $south                                                                 ///
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
    $south                                                                 ///
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
    saving("$figures/fig2_$source", replace)

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
    saving("$figures/fig3_$source", replace)


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
