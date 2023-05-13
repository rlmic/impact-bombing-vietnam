/*-----------------------------------
FOLDER STRUCTURE
-----------------------------------*/


global data = "$dir/data"

global output = "$dir/outputs"

global logs = "$dir/logs"

global figures = "$output/figures"

global code = "$dir/src"

global tables = "$output/tables"

global meas = "fmt(%15.2fc)"

/*-----------------------------------
NAMES OF ELEMENTS IN TABLES
-----------------------------------*/
    
global                                                                      /// 
    title_tab1a_stats =                                                     ///
    "Summary statistics — U.S. ordenance data, 1965–75. \\ Panel A: District-level data."
    
global                                                                      /// 
    note_tab1a_stats =                                                      ///
    "Notes: The summary statistics are not weighted by population."
    
global                                                                      /// 
    title_tab1a_corr =                                                      ///
    "Correlation with general purpose bombs. \\ Panel A: District-level data."

global                                                                      /// 
    title_tab1b_stats =                                                     ///
    "Summary statistics — U.S. ordenance data, 1965–75. \\ Panel B: Province-level data."

global                                                                      /// 
    note_tab1b_stats =                                                      ///
    "Notes: The summary statistics are not weighted by population."

global                                                                      /// 
    title_tab2a_stats =                                                     ///
    "Summary statistics — economic, demographic, climatic, and geographic data. \\ Panel A: District-level data."

global                                                                      /// 
    note_tab2b_stats =                                                      ///
    "Notes: The summary statistics are not weighted by population."

global                                                                      /// 
    title_tab2b_stats =                                                     ///
    "Summary statistics — economic, demographic, climatic, and geographic data. \\ Panel B: Province-level data."

global                                                                      /// 
    note_tab2b_stats =                                                      ///
    "Notes: The summary statistics are not weighted by population."
    
global                                                                      /// 
    title_tab3_sreg =                                                       ///
    "Predicting bombing intensity"

global                                                                      /// 
    title_tab4_reg =                                                        ///
    "Local bombing impacts on estimated 1999 poverty rate"    
    
global                                                                      /// 
    title_tab5_reg =                                                        ///    
    "Local bombing impacts on estimated 1999 poverty rate — alternative specifications"
    
global                                                                      /// 
    title_tab8_reg =                                                        ///    
    "Local bombing impacts on 1999 population density"    
    
global                                                                      /// 
    title_tab9_reg =                                                        ///        
    "Local war impacts on other population characteristics."
    
global                                                                      ///
    foot_pane =                                                             ///
    "\hline\hline \multicolumn{5}{l}{\footnotesize Standard errors in parentheses}\\\multicolumn{3}{l}{\footnotesize \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)}\\ \end{tabular} \\ \end{table}"
    
global                                                                      ///
    title_tab6_reg =                                                        ///
    "Local war impacts on consumption expenditures and growth (VLSS data)"

global                                                                      ///
    title_tab7_reg =                                                        ///
    "Local war impacts on physical infrastructure and human capital"

/*-----------------------------------
CONTROL AND DEPENDANT 
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
    north_lat_corrected

global                                                                      ///
    south                                                                   ///
    south_corrected

global                                                                      ///
    x_diff                                                                  ///
    diff_17
    
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
    Missile                                                                 ///
    Rocket                                                                  ///
    Cannon_Artillery
    
global                                                                      ///
    ord2                                                                    ///
    Incendiary                                                              ///
    WP
    
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
PATH TO SOURCE DATA
-----------------------------------*/

global                                                                      ///
    district_data                                                           /// 
    "$data/clean/district_bombing_corrected.dta"

global                                                                      ///
    province_data                                                           /// 
    "$data/clean/province_bombing_corrected.dta"

global source = "correted_south"
