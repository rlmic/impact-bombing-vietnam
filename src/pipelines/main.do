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

/*-----------------------------------
DEFINE NAMES OF ELEMENTS IN TABLLES
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
CREATED CORRECTED LATITUDES
-----------------------------------*/

do "$code/pipelines/correct_degree.do"

/*-----------------------------------
RUN ANALYSIS
-----------------------------------*/

foreach province_data in                                                    ///
    "$data/external/dataverse/war_data_province.dta"                        ///
    "$data/external/archives/war_data_province_sep09.dta"                   ///
    "$data/external/archives/war_data_province_aug05.dta"                   ///
    "$data/external/hochiminh/war_data_province_huynh.dta"                  ///
    "$data/external/exposition/war_data_province_malesk.dta"{
    if "`province_data'" == "$data/external/archives/war_data_province_sep09.dta" {
        local district_data = "$data/external/archives/war_data_district_sep09.dta"
        global source = "archives_sep09"
        }
    else if "`province_data'" == "$data/external/archives/war_data_province_aug05.dta" {
        local district_data = "$data/external/archives/war_data_district_aug05.dta"
        global source = "archives_aug05"
        }          
    else if "`province_data'" ==  "$data/external/dataverse/war_data_province.dta"{
        local district_data = "$data/external/dataverse/war_data_district.dta"
        global source = "dataverse"
        }
    else if "`province_data'" ==  "$data/external/hochiminh/war_data_province_huynh.dta"{
        local district_data = "$data/external/dataverse/war_data_district.dta"
        global source = "hochiminh"
        }
    else {
        local district_data = "$data/external/dataverse/war_data_district.dta"
        global source = "malesky"
        
    }  
    // Start log file and date
    log using "$logs/log_$source.txt", replace text
    
    /*-----------------------------------
    LOAD DATASETS AS FRAMES
    -----------------------------------*/
    // District Level

    frames reset
    frame create district
    cwf district
    use "$data/external/dataverse/war_data_district.dta", clear

    // Label variables for display
    label var                                                                ///
        south                                                                ///
        "Former South Vietnam"
    label var                                                                ///
        area_251_500m                                                        ///
        "Prop. of land area 250–500 m"
    label var                                                                ///
        area_501_1000m                                                       ///
        "Prop. of land area 500–1000 m"
    label var                                                                ///
        area_over_1000m                                                      ///
        "Prop. of land area over 1000 m"
    label var                                                                ///
        tmp_avg                                                              ///
        "Average temperature (C $°$)"
    label var                                                                ///
        pre_avg                                                              ///
        "Average precipitation (cm)"
    label var                                                                ///
        diff_17                                                              ///
        "\|Latitude - 17 $°$ N\|"
    label var                                                                ///
        $x_gis                                                               ///
        "Latitude (°N)"
    label var                                                                ///
        popdensity1999                                                       ///
        "Population density, 1999"
    label var                                                                ///
        area_tot_km2                                                         ///
        "District land area (km$^2$)"
    label var                                                                ///
        tot_bmr_per                                                          ///
        "U.S. bombs, missiles, and rockets per km$^2$"
    label var                                                                ///
        tot_bmr_per_2                                                        ///
        "(U.S. bombs, missiles, and rockets per km$^2$)$^2$ ÷ 100"
    label var                                                                ///
        tot_bmr_hi                                                           ///
        "U.S. bombs, missiles, and rockets per km$^2$ (top 10\% districts)"

    // Province Level
    frame create province
    cwf province
    use "$data/external/dataverse/war_data_province.dta"
    gen nbhere=(1-bornhere)
    frame drop default

    // Label variables for display
    label var                                                                ///
        south                                                                ///
        "Former South Vietnam"
    label var                                                                ///
        area_251_500m                                                        ///
        "Prop. of land area 250–500 m"
    label var                                                                ///
        area_501_1000m                                                       ///
        "Prop. of land area 500–1000 m"
    label var                                                                ///
        area_over_1000m                                                      ///
        "Prop. of land area over 1000 m"
    label var                                                                ///
        tmp_avg                                                              ///
        "Average temperature (C $°$)"
    label var                                                                ///
        pre_avg                                                              ///
        "Average precipitation (cm)"
    label var                                                                ///
        diff_17                                                              ///
        "\|Latitude - 17 $°$ N\|"
    label var                                                                ///
        $x_gis                                                               ///
        "Latitude (°N)"
    label var                                                                ///
        $y_pop_den                                                           ///
        "Population density, 1985"
    label var                                                                ///
        popdensity1999                                                       ///
        "Population density, 1999"
    label var                                                                ///
        ch_popdensity_20001985                                               ///
        "Change in population density, 1985–2000"
    label var                                                                ///
        exppc93r98                                                           ///
        "Per capita consumption expenditures, 1992/93 (in 1998 Dong)"
    label var                                                                ///
        exppc02r98                                                           ///
        "Per capita consumption expenditures, 2002(in 1998 Dong)"
    label var                                                                ///
        consgrowth_9302                                                      ///
        "Growth in per capita consumption expenditures 1992/93–2002"
    label var                                                                ///
        nbhere                                                               ///
        "Proportion not born in current village, 1997/98"
    label var                                                                ///
        tot_bmr_per                                                          ///
        "U.S. bombs, missiles, and rockets per km$^2$"
    label var                                                                ///
        tot_bmr_per_2                                                        ///
        "(U.S. bombs, missiles, and rockets per km$^2$)$^2$ ÷ 100"
    label var                                                                ///
        tot_bmr_hi                                                           ///
        "U.S. bombs, missiles, and rockets per km$^2$ (top 10\% districts)"
        
    do "$code/pipelines/produce_tables.do"
    log c
    clear

    }
