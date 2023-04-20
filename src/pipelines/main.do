clear
capture log close
set more off

global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"

/*-----------------------------------
LOAD CONSTANTS AND VARIABLES
-----------------------------------*/

do "$dir/src/general/constants.do"


/*-----------------------------------
CREATE DATASETS
-----------------------------------*/

do "$code/pipelines/combine_datasets.do"

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
    "$males_prov"                                                           ///
   "$main_prov"                                                             ///
   "$main_prov_correc"{                                       
    if "`province_data'" == "$sept_prov" {
      global province_data = "$sept_prov"
        global district_data = "$sept_dist"
        global source = "archives_sep09"
        }
    else if "`province_data'" == "$augu_prov"{
      global province_data = "$augu_prov"
        global district_data = "$augu_dist"
        global source = "archives_aug05"
        }          
    else if "`province_data'" ==  "$dave_prov" {
      global province_data = "$dave_prov"
        global district_data = "$dave_dist"
        global source = "dataverse"
        }
    else if "`province_data'" ==  "$huyn_prov"{
      global province_data = "$huyn_prov"
        global district_data = "$dave_dist"
        global source = "hochiminh"
        }
   else if "`province_data'" ==  "$main_prov"{
      global province_data = "$main_prov"
      global district_data = "$main_dist"
        global source = "clean"
      }
   else if "`province_data'" ==  "$main_prov_correc"{
      global province_data = "$main_prov_correc"
      global district_data = "$main_dist_correc"
        global source = "clean_correted"
      }
    else {
      global province_data = "$dave_prov"
        global district_data = "$dave_dist"
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
    use "$district_data", clear
    do "$code/general/lab_dis.do"

    // Province Level
    
    frame create province
    cwf province
    use "$province_data", clear
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
