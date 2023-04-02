clear
capture log close
set more off
set mem 100m
set matsize 800

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
    "$data/external/dataverse/war_data_province.dta"                        ///
    "$data/external/archives/war_data_province_sep09.dta"                   ///
    "$data/external/archives/war_data_province_aug05.dta"                   ///
    "$data/external/hochiminh/war_data_province_huynh.dta"                  ///
    "$data/external/exposition/war_data_province_malesk.dta"{
    if "`province_data'" == "$data/external/archives/war_data_province_sep09.dta" {
        local district_data = "$data/external/archives/war_data_district_sep09.dta"
        global source = "archives_sep09"
        }
    else if "`province_data'" == "$data/external/archives/war_data_province_aug05.dta"{
        local district_data = "$data/external/archives/war_data_district_aug05.dta"
        global source = "archives_aug05"
        }          
    else if "`province_data'" ==  "$data/external/dataverse/war_data_province.dta" {
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
