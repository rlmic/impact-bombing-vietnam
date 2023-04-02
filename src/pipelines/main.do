clear
capture log close
set more off

global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"

/*-----------------------------------
LOAD CONSTANTS AND VARIABLES
-----------------------------------*/

do "$dir/src/general/constants.do"


/*-----------------------------------
CREATE CORRECTED LATITUDES
-----------------------------------*/

do "$code/pipelines/correct_degree.do"

/*-----------------------------------
RUN ANALYSIS
-----------------------------------*/

foreach province_data in                                                    ///
    "$dave_prov"                                                            ///
    "$sept_prov"                                                            ///
    "$augu_prov"                                                            ///
    "$huyn_prov"                                                            ///
    "$males_prov"{
    if "`province_data'" == "$sept_prov" {
        local district_data = "$sept_dist"
        global source = "archives_sep09"
        }
    else if "`province_data'" == "$augu_prov"{
        local district_data = "$augu_dist"
        global source = "archives_aug05"
        }          
    else if "`province_data'" ==  "$dave_prov" {
        local district_data = "$dave_dist"
        global source = "dataverse"
        }
    else if "`province_data'" ==  "$huyn_prov"{
        local district_data = "$dave_dist"
        global source = "hochiminh"
        }
    else {
        local district_data = "$dave_dist"
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
    do "$code/general/lab_dis.do"

    // Province Level
    
    frame create province
    cwf province
    use "`province_data'"
    gen nbhere=(1-bornhere)
    frame drop default
    do "$code/general/lab_pro.do"
    
    /*-----------------------------------
    PRODUCE TABLES
    -----------------------------------*/    
    do "$code/pipelines/produce_tables.do"
    log c
    clear

    }
