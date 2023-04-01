/*

MAIN ANALYSIS
------------------------------------------

*/
clear
capture log close
set more off
set mem 100m
set matsize 800

/*-----------------------------------
FOLDER STRUCTURE
-----------------------------------*/

global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"

global data = "$dir/data"

global output = "$dir/outputs"

global logs = "$dir/logs"

global figures = "$output/figures"

global code = "$dir/src"

global tables = "$output/tables"

global meas = "fmt(%9.2fc)"

global																		/// 
	title_tab1a_stats = 													///
	"Summary statistics — U.S. ordenance data, 1965–75. \\ Panel A: District-level data.\label{tab1a_stats}"
	
global																		/// 
	note_tab1a_stats = 														///
	"Notes: The summary statistics are not weighted by population."
	
global																		/// 
	title_tab1a_corr = 													    ///
	"Correlation with general purpose bombs. \\ Panel A: District-level data.\label{tab1a_corr}"

global																		/// 
	title_tab1b_stats = 												    ///
	"Summary statistics — U.S. ordenance data, 1965–75. \\ Panel B: Province-level data.\label{tab1b_stats}"

global																		/// 
	note_tab1b_stats = 														///
	"Notes: The summary statistics are not weighted by population."

global																		/// 
	title_tab2a_stats = 												    ///
	"Summary statistics — economic, demographic, climatic, and geographic data. \\ Panel A: District-level data.\label{tab2a_stats}"

global																		/// 
	note_tab2b_stats = 														///
	"Notes: The summary statistics are not weighted by population."

global																		/// 
	title_tab2b_stats = 												    ///
	"Summary statistics — economic, demographic, climatic, and geographic data. \\ Panel B: Province-level data.\label{tab2b_stats}"

global																		/// 
	note_tab2b_stats = 														///
	"Notes: The summary statistics are not weighted by population."
	
global																		/// 
	title_tab3_sreg = 												        ///
	"Predicting bombing intensity"

global																		/// 
	title_tab4_reg = 												        ///
	"Local bombing impacts on estimated 1999 poverty rate"	
	
global																		/// 
	title_tab5_reg = 												        ///	
	"Local bombing impacts on estimated 1999 poverty rate — alternative specifications"
	
global																		/// 
	title_tab8_reg = 												        ///	
	"Local bombing impacts on 1999 population density"	
	
global																		/// 
	title_tab9_reg = 												        ///		
	"Local war impacts on other population characteristics."
	
global 																		///
	foot_pane =																///
	"\hline\hline \multicolumn{5}{l}{\footnotesize Standard errors in parentheses}\\\multicolumn{3}{l}{\footnotesize \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)}\\ \end{tabular} \\ \end{table}"
	
global 																		///
	title_tab6_reg =														///
	"Local war impacts on consumption expenditures and growth (VLSS data)"

global 																		///
	title_tab7_reg =														///
	"Local war impacts on physical infrastructure and human capital"
	
/*-----------------------------------
DEFINE CONTROL SETS AND DEPENDANT 
VARIABLES FOR ANALYSIS 
-----------------------------------*/

global                                                                      ///
    x_elev                                                                  ///
    area_251                                                                ///
    area_501                                                                ///
    area_over_1000m                                                         ///
    
global                                                                      ///
    x_slope                                                                 ///
    slp_c2                                                                  ///
    slp_c3                                                                  ///
    slp_c45                                                                    

global                                                                      ///
    x_soil1                                                                 ///
    soil_1                                                                  ///
    soil_3                                                                  ///
    soil_6                                                                  ///
    soil_7                                                                  ///
    soil_8                                                                  ///
    soil_9                                                                  ///
    soil_10                                                                 ///
    soil_11                                                                 ///
    soil_12
    
global                                                                      ///
    x_soil2                                                                 ///
    soil_14                                                                 ///
    soil_24                                                                 ///
    soil_26                                                                 ///
    soil_33                                                                 /// 
    soil_34                                                                 ///
    soil_35                                                                 ///
    soil_39                                                                 ///
    soil_40                                                                 ///
    soil_41                                                                  
    
global                                                                      ///
    x_gis                                                                   ///
    north_lat
    
global                                                                      /// 
    x_weather                                                               ///
    pre_avg                                                                 ///
    tmp_avg                                                                    
    
global                                                                      /// 
    ord0                                                                    ///
    Ammunition
    
global                                                                      ///
    ord1                                                                    ///
    General_Purpose                                                         ///
    Cluster_Bomb                                                            ///
    Missile Rocket                                                          ///
    Cannon_Artillery
    
global                                                                      ///
    ord2                                                                    ///
    Incendiary WP
    
global                                                                      ///
    ord3                                                                    ///
    Mine                                                                    
    
global                                                                      ///
    y_bom                                                                   ///
    tot_bmr_per
    
global                                                                      ///
    y_pov                                                                   ///
    poverty_p0

global                                                                      ///
    y_pop_den                                                               ///
    popdensity1985
    
global                                                                      ///
    y_pop_gro                                                               ///
    ch_popdensity_20001985
    
global                                                                      ///
    y_pop_den_1999                                                          /// 
    popdensity1999
    
global                                                                      ///
    y_consum_2002                                                           ///
    exppc02r98
    
global                                                                      /// 
    y_consum_1992                                                           ///
    exppc93r98
    
global                                                                      ///
    y_consum_gro                                                            ///
    consgrowth_9302                                                            
    
global                                                                      ///
    y_acc_elec                                                              ///
    elec_rate                                                                
    
global                                                                      /// 
    y_lit                                                                   ///
    lit_rate                                                                

	
/*-----------------------------------
LOAD DATASETS AS FRAMES
-----------------------------------*/
// District Level
frames reset
frame create district
cwf district
use "$data/external/dataverse/war_data_district.dta", clear

// Province Level
frame create province
cwf province
use "$data/external/dataverse/war_data_province.dta"
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

eststo clear

estpost summ                                                                ///
    tot_bmr_per                                                             ///
    tot_bmr                                                                 ///
    $ord1                                                                   ///
    $ord2                                                                   ///
    $ord0                                                                   ///
    if sample_all==1
	
esttab using "$tables/tab1a_stats.tex", replace			    		    	///
	cells(														            ///
	"mean($meas) sd($meas) max($meas) count()"                              ///
	) 																		///
	nonumber 																///
	nomtitle 																///
	nonote																	///
	noobs label	booktabs													///										
	title($title_tab1a_stats) 												///
	addnotes($note_tab1a_stats)  											///
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
	
esttab using "$tables/tab1a_corr.tex", 										///
	replace																	/// 
	nonote 																	///
	noobs label booktabs 													///
	compress																///
	cells("b($meas)")	    										 		///
	title($title_tab1a_corr)                                         		///
	collabels("Correlation")												///
	star(* 0.10 ** 0.05 *** 0.01)
/*
PANEL B
*/

cwf province

estpost summ                                                                ///
    tot_bmr_per                                                             ///
    if sample_all==1  

esttab using "$tables/tab1b_stats.tex", replace			    		    	///
	cells(														            ///
	"mean($meas) sd($meas) max($meas) count()"                              ///
	) 																		///
	nonumber 																///
	nomtitle 																///
	nonote																	///
	noobs label	booktabs													///										
	title($title_tab1b_stats) 												///
	addnotes($note_tab1b_stats)  											///
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
    south                                                                   ///
    $x_gis                                                                  ///
    diff_17                                                                 ///
    if sample_all==1

esttab using "$tables/tab2a_stats.tex", replace			    		    	///
	cells(														            ///
	"mean($meas) sd($meas) min($meas) max($meas) count()"                   ///
	) 																		///
	nonumber 																///
	nomtitle 																///
	nonote																	///
	noobs label	booktabs													///										
	title($title_tab2a_stats) 												///
	addnotes($note_tab2a_stats)  											///
	collabels("Mean" "S.D." "Min" "Max." "Obs.")

/*
PANEL B
*/

cwf province

gen nbhere=(1-bornhere)
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
    diff_17                                                                 ///
    if sample_all==1
	
esttab using "$tables/tab2b_stats.tex", replace			    		    	///
	cells(														            ///
	"mean($meas) sd($meas) min($meas) max($meas) count()"                   ///
	) 																		///
	nonumber 																///
	nomtitle 																///
	nonote																	///
	noobs label	booktabs													///										
	title($title_tab2b_stats) 												///
	addnotes($note_tab2b_stats)  											///
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

eststo: regress                                                             ///
    $y_bom                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust
	
estadd local has_soil "No"

estadd local exc_qua "No"

est sto tab31

summ                                                                        ///
    $y_bom                                                                  ///
    if sample_all==1


// Column 2: District level: All

cwf district

eststo: regress                                                             ///
    $y_bom                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1, robust cluster(province)

estadd local has_soil "Yes"

estadd local exc_qua "No"

est sto tab32

summ                                                                        ///
    $y_bom                                                                  ///
    if sample_all==1

// Column 3: District level: Exclude Quang Tri

eststo: regress                                                             ///
    $y_bom                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_weather                                                              ///
    $x_gis                                                                  ///
    if sample_all==1 & provincename~="Quang Tri", robust cluster(province)

estadd local has_soil "Yes"

estadd local exc_qua "Yes"

est sto tab33

summ                                                                        ///
    $y_bom                                                                  ///
    if sample_all==1 & provincename~="Quang Tri"

local tab3 tab31 tab32 tab33

esttab `tab3' using "$tables/tab3_reg.tex", replace 						///
   nomtitle label star(* 0.10 ** 0.05 *** 0.01)								///
   booktabs nonotes 														///
   scalars("has_soil District soil controls" "exc_qua Exclude Quang Tri")   ///
   sfmt(0) r2 																///
   mgroups("Total U.S. bombs, missiles and rockets per km$^2$", 			///
   pattern(1 0 0 ) 															///
   prefix(\multicolumn{@span}{c}{)											///
   suffix(})																///
   span																		///
   erepeat(\cmidrule(lr){@span}))											///
   alignment(D{.}{.}{-1})													///
   drop(_cons)	         	    									     	///
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
    south                                                                   ///
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
    south                                                                   ///
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
eststo: regress                                                             ///
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
  
est sto tab44

estadd local has_soil "Yes"

estadd local exc_qua "Yes"

estadd local has_fe "No"

summ                                                                        ///
    $y_pov                                                                  ///
    if provincename~="Quang Tri" & sample_all==1

// (OLS 5)
eststo: regress                                                             ///
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
  
est sto tab45

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pov if sample_all==1

// (IV-2SLS 6)
eststo: regress                                                             ///
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
 
est sto tab46

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pov if sample_all==1

local tab4 tab41 tab42 tab43 tab44 tab45 tab46

esttab `tab4' using "$tables/tab4_reg.tex", replace 						///
   nomtitle label star(* 0.10 ** 0.05 *** 0.01)								///
   booktabs nonotes 														///
   scalars("has_soil District soil controls" "exc_qua Exclude Quang Tri" "has_fe Province fixed effects") ///
   sfmt(0) r2 																///
   mgroups("Estimated poverty rate, 1999", 									///
   pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)							///
   suffix(}) span erepeat(\cmidrule(lr){@span}))						    ///
   alignment(D{.}{.}{-1})													///
   drop(soil* _cons)		    									     	///
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
	
levelsof south, local(sud)

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
		if sample_all==1 & south==`level',                                  ///
		robust cluster(province)
    est sto tab5_`level'_south
	estadd local has_control "Yes"

}

bys south: summ $y_pov if sample_all==1


// (3) (4)
gen urban_6061 = (popdensity6061>200 & popdensity6061~=.)

levelsof urban_6061, local(urbano)

foreach level of local urbano {												
	eststo: regress                                                         ///
		$y_pov                                                              ///
		tot_bmr_per                                                         ///
		popdensity6061                                                      ///
		south 																///
		$x_elev                                                             ///
		$x_gis                                                              ///
		$x_weather                                                          ///
		$x_soil1                                                            ///
		$x_soil2                                                            ///
		if sample_all==1 & urban_6061==`level',                             ///
		robust cluster(province)
    est sto tab5_`level'_urban
	estadd local has_control "Yes"

}
   
bys urban_6061: summ $y_pov if sample_all==1

drop urban_6061

// (5)
eststo: regress                                                             ///
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

est sto tab5_5

estadd local has_control "Yes"

summ $y_pov if sample_all==1

// (6)
eststo: regress                                                             ///
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
	
est sto tab5_6
 
estadd local has_control "Yes"

summ $y_pov if sample_all==1

local tab5 tab5_0_south tab5_1_south tab5_0_urban tab5_1_urban tab5_5 tab5_6

esttab `tab5' using "$tables/tab5_reg.tex", replace 						///
   label star(* 0.10 ** 0.05 *** 0.01)										///
   booktabs nonotes 														///
   scalars("has_control District demographic, geographic, soil controls")   ///
   sfmt(0) r2 																///
   mgroups("Estimated poverty rate, 1999", 									///
   pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)							///
   suffix(}) span erepeat(\cmidrule(lr){@span}))						    ///
   alignment(D{.}{.}{-1})													///
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
eststo: regress                                                             ///
    $y_consum_2002                                                          ///
    tot_bmr_per                                                             ///                
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

est sto tab6_a1

estadd local exc_qua "No"

summ $y_consum_2002 if sample_all==1

// (2)
eststo: regress                                                             ///
    $y_consum_2002                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
  
est sto tab6_a2

estadd local exc_qua "Yes"

summ $y_consum_2002 if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo: regress                                                             ///
    $y_consum_2002                                                          ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

est sto tab6_a3

estadd local exc_qua "No"

summ $y_consum_2002 if sample_all==1

local tab6_a tab6_a1 tab6_a2 tab6_a3

esttab `tab6_a' using "$tables/tab6_reg.tex", 								///	
    prehead("\begin{table}[htbp]\centering \\ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \\ \caption{$title_tab6_reg} \\ \begin{tabular}{l*{3}{c}} \hline\hline") 																///
	posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel A: 2002 per capita consumption expenditures}} \\\\[-1ex]") ///
	fragment       														    ///
	scalars("exc_qua Exclude Quang Tri") 									///
	sfmt(0) r2 nomtitles    											    ///
	keep(tot_bmr_per diff_17) label replace

/*
PANEL B
*/

// (1)
eststo: regress                                                             ///
    $y_consum_1992                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
est sto tab6_b1

estadd local exc_qua "No"

summ $y_consum_1992 if sample_all==1

// (2)
eststo: regress                                                             ///
    $y_consum_1992                                                          ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
    
est sto tab6_b2

estadd local exc_qua "Yes"

summ $y_consum_1992 if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo: regress                                                             ///
    $y_consum_1992                                                          ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
est sto tab6_b3

estadd local exc_qua "No"

summ $y_consum_1992 if sample_all==1

local tab6_b tab9_b1 tab6_b2 tab6_b3

esttab `tab6_b' using "$tables/tab6_reg.tex", 							    ///
	posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel B: 1992/93 per capita consumption expenditures}} \\\\[-1ex]") ///
	fragment append  														///
	scalars("exc_qua Exclude Quang Tri") 									///
	sfmt(0) r2 nomtitles nonumbers 											///
	keep(tot_bmr_per diff_17) label

/*
PANEL C
*/

// (1)
eststo: regress                                                             ///
    $y_consum_gro                                                           ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
    
est sto tab6_c1

estadd local exc_qua "No"

summ $y_consum_gro if sample_all==1

// (2)
eststo: regress                                                             ///
    $y_consum_gro                                                           ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
 
est sto tab6_c2

estadd local exc_qua "Yes"

summ $y_consum_gro                                                          ///
    if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo: regress                                                             ///
    $y_consum_gro                                                           ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
 
est sto tab6_c3

estadd local exc_qua "No"

summ $y_consum_gro if sample_all==1


local tab6_c tab9_c1 tab6_c2 tab6_c3

esttab `tab6_c' using "$tables/tab6_reg.tex", 								 ///
   	posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel C: Growth in consumption, 1992/93–2002}} \\\\[-1ex]") ///
	prefoot("\hline") 														 ///
	postfoot($foot_pane) 										             ///
	fragment append  														 ///
	scalars("exc_qua Exclude Quang Tri") 									 ///
	sfmt(0) r2 nomtitles nonumbers 											 ///
	keep(tot_bmr_per diff_17) label
	
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
	
est sto tab7_a1

estadd local has_soil "No"

estadd local has_fe "No"

estadd local exc_qua "No"

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

est sto tab7_a2

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

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

est sto tab7_a3

estadd local has_soil "Yes"

estadd local has_fe "Yes"

estadd local exc_qua "No"

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

est sto tab7_a4

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "Yes"

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

est sto tab7_a5

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

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
 
est sto tab7_a6

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_acc_elec if sample_all==1

local tab7_a tab7_a1 tab7_a2 tab7_a3 tab7_a4 tab7_a5 tab7_a6

esttab `tab7_a' using "$tables/tab7_reg.tex", 								///	
    prehead("\begin{table}[htbp]\centering \\ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \\ \caption{$title_tab7_reg} \\ \begin{tabular}{l*{6}{c}} \hline\hline") 																///
	posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel A: Proportion of households with access to electricity, 1999}} \\\\[-1ex]") ///
	fragment       														    ///
    scalars("has_soil District soil controls" "exc_qua Exclude Quang Tri" "has_fe Province fixed effects")  ///
	sfmt(0) r2 nomtitles    											    ///
	keep(tot_bmr_per diff_17) label replace

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
	
est sto tab7_b1

estadd local has_soil "No"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_lit if sample_all==1

// (2)
cwf district
eststo: regress                                                             ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    south,                                                                  ///
    robust cluster(province)

est sto tab7_b2

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_lit

// (3)
eststo: areg                                                                ///
    $y_lit                                                                  ///
    tot_bmr_per                                                             ///
    $x_weather                                                              ///          
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, a(province) robust cluster(province)

est sto tab7_b3

estadd local has_soil "Yes"

estadd local has_fe "Yes"

estadd local exc_qua "No"

summ $y_lit if sample_all==1

// (4)
eststo: regress                                                             ///
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

est sto tab7_b4

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "Yes"

summ $y_lit if provincename~="Quang Tri" & sample_all==1

// (5)
eststo: regress                                                             ///
    $y_lit                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///          
    $x_soil1                                                                ///
    $x_soil2                                                                ///
    if sample_all==1, robust cluster(province)     
	
est sto tab7_b5

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_lit if sample_all==1

// (6)
eststo: regress                                                             ///
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
	
est sto tab7_b6

estadd local has_soil "Yes"

estadd local has_fe "No"

estadd local exc_qua "No"

summ $y_lit if sample_all==1

local tab7_b tab7_b1 tab7_b2 tab7_b3 tab7_b4 tab7_b5 tab7_b6

esttab `tab7_b' using "$tables/tab7_reg.tex", 								 ///
   	posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel B: Proportion of literate respondents, 1999}} \\\\[-1ex]") ///
	prefoot("\hline") 														 ///
	postfoot($foot_pane) 										             ///
	fragment append  														 ///
    scalars("has_soil District soil controls" "exc_qua Exclude Quang Tri" "has_fe Province fixed effects")  ///
	sfmt(0) r2 nomtitles nonumbers 											 ///
	keep(tot_bmr_per diff_17) label

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
    south                                                                   ///
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
    south                                                                   ///
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
    south                                                                   ///
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
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
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

est sto tab8_6

estadd local has_soil "Yes"

estadd local exc_qua "No"

estadd local has_fe "No"

summ $y_pop_den_1999 if sample_all==1

local tab8 tab8_*

esttab `tab8' using "$tables/tab8_reg.tex", replace 						///
   label star(* 0.10 ** 0.05 *** 0.01)										///
   booktabs nonotes 														///
   scalars("has_soil District soil controls" "exc_qua Exclude Quang Tri" "has_fe Province fixed effects") ///
   sfmt(0) r2 																///
   mgroups("Population density, 1999", 									    ///
   pattern(1 0 0 ) prefix(\multicolumn{@span}{c}{)							///
   suffix(}) span erepeat(\cmidrule(lr){@span}))						    ///
   alignment(D{.}{.}{-1})													///
   mtitles("OLS" "OLS" "OLS" "OLS" "OLS" "IV-2SLS" )                        ///
   drop(soil* _cons)		    									     	///
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

eststo: regress                                                             ///
    $y_pop_den                                                              ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
	
est sto tab9_a1

estadd local exc_qua "No"

summ $y_pop_den if sample_all==1

// (2)
eststo: regress                                                             ///
    $y_pop_den                                                              ///
    tot_bmr_per                                                             ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust                    

est sto tab9_a2

estadd local exc_qua "Yes"

summ $y_pop_den                                                             /// 
    if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo: regress                                                             ///
    $y_pop_den                                                              ///  
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
 
est sto tab9_a3

estadd local exc_qua "No"

summ $y_pop_den if sample_all==1

local tab9_a tab9_a1 tab9_a2 tab9_a3

esttab `tab9_a' using "$tables/tab9_reg.tex", 								///	
    prehead("\begin{table}[htbp]\centering \\ \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi} \\ \caption{$title_tab9_reg} \\ \begin{tabular}{l*{3}{c}} \hline\hline") 																///
	posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel A: Population density, 1985}} \\\\[-1ex]") ///
	fragment       														    ///
	scalars("exc_qua Exclude Quang Tri") 									///
	sfmt(0) r2 nomtitles    											    ///
	keep(tot_bmr_per diff_17) label replace
		

// PANEL B
//--------

// (1)
eststo: regress                                                             ///
    $y_pop_gro                                                              ///  
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
 
est sto tab9_b1

estadd local exc_qua "No"

summ $y_pop_gro if sample_all==1

// (2)
eststo: regress                                                             ///
    $y_pop_gro                                                              /// 
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust

est sto tab9_b2

estadd local exc_qua "Yes"

summ $y_pop_gro                                                             ///  
    if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo: regress                                                             ///
    $y_pop_gro                                                              /// 
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust
  
est sto tab9_b3

estadd local exc_qua "No"

summ $y_pop_gro if sample_all==1

local tab9_b tab9_b1 tab9_b2 tab9_b3

esttab `tab9_b' using "$tables/tab9_reg.tex", 							    ///
	posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel B: Growth in population density, 1985 to 2000}} \\\\[-1ex]") ///
	fragment append  														///
	scalars("exc_qua Exclude Quang Tri") 									///
	sfmt(0) r2 nomtitles nonumbers 											///
	keep(tot_bmr_per diff_17) label


	
// PANEL C
//--------

// (1)
eststo: regress                                                             ///
    nbhere                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

est sto tab9_c1

estadd local exc_qua "No"

summ nbhere if sample_all==1

// (2)
eststo: regress                                                             ///
    nbhere                                                                  ///
    tot_bmr_per                                                             /// 
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if (provincename~="Quang Tri") & sample_all==1, robust
 
est sto tab9_c2

estadd local exc_qua "Yes"

summ nbhere if (provincename~="Quang Tri") & sample_all==1

// (3)
eststo: regress                                                             ///
    nbhere                                                                  ///
    diff_17                                                                 ///
    popdensity6061                                                          ///
    south                                                                   ///
    $x_elev                                                                 ///
    $x_gis                                                                  ///
    $x_weather                                                              ///
    if sample_all==1, robust

est sto tab9_c3

estadd local exc_qua "No"

summ nbhere if sample_all==1

local tab9_c tab9_c1 tab9_c2 tab9_c3

esttab `tab9_c' using "$tables/tab9_reg.tex", 								 ///
   	posthead("\hline \\ \multicolumn{2}{c}{\emph{Panel C: 1997/98 proportion not born in current village}} \\\\[-1ex]") ///
	prefoot("\hline") 														 ///
	postfoot($foot_pane) 										             ///
	fragment append  														 ///
	scalars("exc_qua Exclude Quang Tri") 									 ///
	sfmt(0) r2 nomtitles nonumbers 											 ///
	keep(tot_bmr_per diff_17) label


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



