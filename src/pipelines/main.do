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
RUN ANALYSIS
-----------------------------------*/

foreach province_data in                                                    ///
    "$data/external/dataverse/war_data_province.dta"                        ///
    "$data/external/archives/war_data_province_sep09.dta"                   ///
    "$data/external/archives/war_data_province_aug05.dta"                   ///
    "$data/external/hochiminh/war_data_province_huynh .dta"                 ///
    "$data/external/exposition/war_data_province_barce.dta"                 ///
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
    else if "`province_data'" ==  "$data/external/exposition/war_data_province_barce.dta"{
        local district_data = "$data/external/dataverse/war_data_district.dta"
        global source = "barcelo"
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
    use "`district_data'", clear
    
    // Province Level
    frame create province
    cwf province
    use "`province_data'"
    frame drop default
    do "$code/pipelines/produce_analysis.do"
    log c
    clear

    }
