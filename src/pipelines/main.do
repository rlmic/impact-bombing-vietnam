clear
capture log close
set more off

// Change this path
global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"

/*-----------------------------------
LOAD CONSTANTS AND VARIABLES
-----------------------------------*/

do "$dir/src/general/constants.do"

/*-----------------------------------
RUN ANALYSIS
-----------------------------------*/
  
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

//gen south_corrected = north_lat_corrected < 17 if !missing(north_lat_corrected)
//replace south_corrected = 1 if inlist(province, 411, 409)
//save "$data/clean/district_bombing_corrected.dta", replace

// Province Level

frame create province
cwf province
use "$province_data", clear
gen nbhere=(1-bornhere)
frame drop default
do "$code/general/lab_pro.do"

//gen south_corrected = north_lat_corrected < 17 if !missing(north_lat_corrected)
//save "$data/clean/province_bombing_corrected.dta", replace


/*-----------------------------------
PRODUCE PAPER TABLES
-----------------------------------*/    
do "$code/pipelines/analysis_corrected.do"

/*-----------------------------------
PRODUCE ALTERNATIVE ANALYSIS
-----------------------------------*/    
do "$code/pipelines/analysis_alterna.do"

/*-----------------------------------
PRODUCE APPENDIX ANALYSIS OF CORRIGENDUM
-----------------------------------*/  

do "$code/pipelines/append_corrigen.do"
log c
clear


