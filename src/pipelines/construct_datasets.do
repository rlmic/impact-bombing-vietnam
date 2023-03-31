/*

COMBINED ALL DATA CONSTRUCTION FILES FOR VIETNAM 
BOMBING PROJECT INTO TWO FINAL DATA FILES THAT
ARE THEN USED IN THE DATA ANALYSIS
------------------------------------------

*/

clear
capture log close
set more off
set mem 200m
set matsize 800

global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"
global data = "$dir/data"
global output = "$dir/outputs"
global logs = "$dir/logs"
global figures = "$output/figures"

global                                                                      ///
    stats1959                                                               ///
    area1959                                                                ///
    population1959                                                          ///
    popdensity1959                                                          ///
    birthsmale1958															///
    birthsfemale1958  														///
    birthsmale1959    														/// 
    birthsfemale1959  														///
    deathsmale1958    														///
    deathsfemale1958  														///                                                     
    deathsmale1959   														///
    deathsfemale1959 														///
    paddyarea1959    														///
    paddyproduction1959                                                     ///
    paddyyieldperhectare1959												///
    rubberplanted1958                                                       ///
    rubberworkable1958                                                      ///
    rubberworked1958														/// 
    rubberworkedtoworkable1958 												///
    rubberplanted1959														///
    rubberworkable1959														///
	rubberworked1959														///
	rubberworkedtoworkable1959												///
	tobaccoarea1958															///
	tobaccoarea1959 														///
    tobaccoproduction1958													///
	tobaccoproduction1959													///
	tobaccoyieldperha1958													///
	Tobaccoyieldperha1959													///
	coconutarea1958 														///
    coconutarea1959 														///
	coconutproduction1958													///
	coconutproduction1959													///
	coconutyieldperha1958													///
	coconutyieldperha1959													/// 
    canearea1958															///
	canearea1959															///
	caneproduction1958														///
	caneproduction1959														///
	caneyieldperha1958														///
	caneyieldperha1959


global																		///
	stats1961																///
	provincecity1961														///
	area1961																///
	population1961															///
	popdensity1961															///
	birthsmale1960															///
	birthsfemale1960														///
	birthsmale1961  														///
    birthsfemale1961														///
	deathsmale1960  														///
	deathsfemale1960														///
	deathsmale1961  														///
	deathsfemale1961														///
	paddyarea1961 															///
	paddyproduction1961 													///
    paddyarea1962															///
	paddyproduction1962														///
	canearea1960															///
	canearea1961															///
	caneproduction1960														///
	caneproduction1961														///
	coconutarea1960 														///
    coconutarea1961															///
	coconutproduction1960													///
	coconutproduction1961													///
	tobaccoarea1960															///
	tobaccoarea1961															///
	tobaccoproduction1960													/// 
    tobaccoproduction1961													///
	paddyyieldperhectare1961												///
	paddyyieldperhectare1962												///
	caneyieldperha1960														///
	caneyieldperha1961														/// 
    coconutyieldperha1960													///
	coconutyieldperha1961													///
	tobaccoyieldperha1960													///
	tobaccoyieldperha1961

global																		///
	stats1962																///
	provincecity1962														///
	birthsmale1961															///
	birthsfemale1961														/// 
	birthsmale1962  														///
	birthsfemale1962														///
	deathsmale1961  														///
	deathsfemale1961														///
	deathsmale1962
	deathsfemale1962
	paddyarea1_1963
	paddyarea2_1963 paddyproduction1_1963 
    paddyproduction2_1963
    rubberplanted1961
    rubberworkable1961
    rubberworked1961
    rubberplanted1962
    rubberworkable1962 
    rubberworked1962
    tobaccoarea1961 
	tobaccoarea1962
	tobaccoproduction1961
	tobaccoproduction1962
	coconutarea1961 
    coconutarea1962
    coconutproduction1961
    coconutproduction1962
 global stats1962 "provincecity1962 area1962 birthsmale1961 birthsfemale1961 birthsmale1962 birthsfemale1962 deathsmale1961 
    deathsfemale1961 deathsmale1962 deathsfemale1962 paddyarea1963 paddyproduction1963 
    rubberplanted1961 rubberworkable1961 rubberworked1961 rubberplanted1962 rubberworkable1962 
    rubberworked1962 tobaccoarea1961 tobaccoarea1962 tobaccoproduction1961 tobaccoproduction1962 coconutarea1961 
    coconutarea1962 coconutproduction1961 coconutproduction1962 paddyyieldperhectare1963 rubberworkedtoworkable1961
    rubberworkedtoworkable1962 coconutyieldperha1961 coconutyieldperha1962 tobaccoyieldperha1961 tobaccoyieldperha1962";
**/////////////////////////////////////////////////////////////////////////**;
**// TABLE OF CONTENTS;
**// I.     CREATION OF PREWAR DATA FILE (PREWARDTSVIET);
**//         i.     ADDITION OF NORTH VIETNAMESE DATA (PREWARDTNVIET);
**// II.    CREATION OF DSCADATA - DATA ON BOMBING MEASURES (DSCABOMB);
**// III.    CREATION OF VLSS DATA FILES: PROVINCE AND COMMUNE LEVEL (VLSSDATA);
**//        i.    CREATION OF VLSS PANEL COLLAPSED TO PROVINCE LEVEL (PROVPAN);
**//        ii.    CREATION OF COMMUNE LEVEL VLSS DATA (doesn't exist);
**// IV.    COMBINATION OF DATA FILES TO CREATE ANALYSIS FILES (DATCON);
**//        i.    COLLAPSING TO PROVINCE LEVEL (PROVCREATE);
**/////////////////////////////////////////////////////////////////////////**;             


/*-----------------------------------
PRE-WAR DATA
-----------------------------------*/
/*ALL FIGURES EXTRACTED AS PER-UNIT-AREA FROM PROVINCE-LEVEL PRE-WAR TABLES, ALLOW FOR SHIFTING BOUNDARIES*/
/*SAME PROCESS FOR ALL YEARS 1959, 1961-3, 1965, & 1960/65 IN NViet (accompanying do-file)*/
/*ALL PRE-WAR PROVINCES CONSTITUTING <=5% OF TOTAL DISTRICT AREA IGNORED, DECREASE NOISE GENERATED BY 
    MAP PROJECTION DIFFS*/

// 1959
cd "$data/internal/raw/prewar"

insheet using                                                               ///
    Data1959.txt
    
replace                                                                     ///
    rubberworkedtoworkable1958 = rubberworkedtoworkable1958/100 

replace                                                                     ///
    rubberworkedtoworkable1959 = rubberworkedtoworkable1959/100

label var 
    area1959
    "Area 1959, km2"
    
label var
    popdensity1959
    "Population Density 1959, per km2"
    
label var 
	paddyarea1959
	"Planted Area of Paddy, 1958-9, hectars"
label var
	paddyproduction1959
	"Production of Paddy, 1958-9, tons";
label var paddyyieldperhectare1959 "Paddy Yield per Hectare, 1958-9";
label var rubberplanted1958 "Planted Area of Rubber as of 12-31-58";
label var rubberplanted1959 "Planted Area of Rubber as of 12-31-59";
label var coconutproduction1958 "Coconut Production 1958, mtrc tns of nuts";
label var caneproduction1958 "Cane Production 1958, tons";
sort provincecode1959
drop if missing(provincecode1959)
    
/*MAKE LANDMASS INVARIANT*/
quietly for var
	population1959
	birthsmale1958
	birthsfemale1958
	birthsmale1959
	birthsfemale1959
	deathsmale1958
	deathsfemale1958 
    deathsmale1959
	deathsfemale1959
	paddyarea1959
	paddyproduction1959
	rubberplanted1958
	rubberworkable1958 
    rubberworked1958
	rubberplanted1959
	rubberworkable1959
	rubberworked1959
	tobaccoarea1958
	tobaccoarea1959 
    tobaccoproduction1958
	tobaccoproduction1959
	coconutarea1958 coconutarea1959 coconutproduction1958 
    coconutproduction1959 canearea1958 canearea1959 caneproduction1958 caneproduction1959:
    replace X=X/area1959;
save Tmp1959, replace;
clear;
/*MATCH TO PRE-WAR PROVINCES, CONTAINED IN districtcodesprewarmatchedw.txt*/
insheet using districtcodesprewarmatchedw.txt;
rename provinceone1959 provincecode1959;
sort provincecode1959;
merge provincecode1959 using Tmp1959.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1959: rename X X_1;
rename provincecode1959 provinceone1959;
rename provincetwo1959 provincecode1959;
sort provincecode1959;
merge provincecode1959 using Tmp1959.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1959: rename X X_2;
rename provincecode1959 provincetwo1959;
rename provincethree1959 provincecode1959;
sort provincecode1959;
merge provincecode1959 using Tmp1959.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1959: rename X X_3;
rename provincecode1959 provincethree1959;

/*NOTE: FIGURES STILL PER-UNIT-AREA*/
/*GEN DISTRICT PRE-WAR STATS AS WEIGHTED AVERAGE OF CONTAINING PROVINCES' STATS*/
quietly for any $stats1959: gen X=X_1*provinceone1959w+X_2*provincetwo1959w+X_3*provincethree1959w if provincethree1959w~=. & provincethree1959w>0.05;
quietly for any $stats1959: replace X=X_1*provinceone1959w+X_2*provincetwo1959w if (provincethree1959w==. | provincethree1959w<=0.05) & provincetwo1959w~=. & provincetwo1959w>0.05;
quietly for any $stats1959: replace X=X_1 if provincetwo1959w==. | provincetwo1959w<=0.05;
label var popdensity1959 "Population Density 1959, per km2";
label var paddyarea1959 "Planted Area of Paddy, 1958-9, hectars";
label var paddyproduction1959 "Production of Paddy, 1958-9, tons";
label var paddyyieldperhectare1959 "Paddy Yield per Hectare, 1958-9";
label var rubberplanted1958 "Planted Area of Rubber as of 12-31-58";
label var rubberplanted1959 "Planted Area of Rubber as of 12-31-59";
label var coconutproduction1958 "Coconut Production 1958, mtrc tns of nuts";
label var caneproduction1958 "Cane Production 1958, tons";
drop urban;

keep districtname provincename regionname district province region area1959 population1959 popdensity1959 birthsmale1958 birthsfemale1958 birthsmale1959 birthsfemale1959 deathsmale1958 deathsfemale1958 deathsmale1959 deathsfemale1959 paddyarea1959 paddyproduction1959 paddyyieldperhectare1959 rubberplanted1958  rubberworkable1958 rubberworked1958 rubberworkedtoworkable1958 rubberplanted1959 rubberworkable1959 rubberworked1959 rubberworkedtoworkable1959 tobaccoarea1958 tobaccoarea1959 tobaccoproduction1958 tobaccoproduction1959 tobaccoyieldperha1958 tobaccoyieldperha1959 coconutarea1958 coconutarea1959 coconutproduction1958 coconutproduction1959 coconutyieldperha1958 coconutyieldperha1959  canearea1958 canearea1959 caneproduction1958 caneproduction1959 caneyieldperha1958 caneyieldperha1959;
order districtname provincename regionname district province region area1959 population1959 popdensity1959 birthsmale1958 birthsfemale1958 birthsmale1959 birthsfemale1959 deathsmale1958 deathsfemale1958 deathsmale1959 deathsfemale1959 paddyarea1959 paddyproduction1959 paddyyieldperhectare1959 rubberplanted1958  rubberworkable1958 rubberworked1958 rubberworkedtoworkable1958 rubberplanted1959 rubberworkable1959 rubberworked1959 rubberworkedtoworkable1959 tobaccoarea1958 tobaccoarea1959 tobaccoproduction1958 tobaccoproduction1959 tobaccoyieldperha1958 tobaccoyieldperha1959 coconutarea1958 coconutarea1959 coconutproduction1958 coconutproduction1959 coconutyieldperha1958 coconutyieldperha1959  canearea1958 canearea1959 caneproduction1958 caneproduction1959 caneyieldperha1958 caneyieldperha1959;
sort district;
save prewardt.dta, replace;

**//1961;

clear;
insheet using Data1961.txt;
label var area1961 "Area 1961, km2";
label var popdensity1961 "Population Density 1961, per km2";
label var paddyarea1_1961 "Planted Area of Paddy, 1960-1 First Crop, hectars";
label var paddyarea2_1961 "Planted Area of Paddy, 1960-1 Second Crop, hectars";
label var paddyproduction1_1961 "Production of Paddy, 1960-1 First Crop, tons";
label var paddyproduction2_1961 "Production of Paddy, 1960-1 Second Crop, tons";
label var canearea1960 "Planted Area of Sugar Cane 1960, hectars";
label var canearea1961 "Planted Area of Sugar Cane 1961, hectars";
label var caneproduction1960 "Production of Sugar Cane 1960, tons";
label var caneproduction1961 "Production of Sugar Cane 1961, tons";
label var coconutproduction1960 "Coconut Production 1960, 1000 nuts";
label var coconutproduction1961 "Coconut Production 1961, 1000 nuts";
sort provincecode1961;
drop if provincecode1961==.;
foreach part in paddyarea paddyproduction {;
    gen `part'1962=`part'1_1962+`part'2_1962;
    gen `part'1961=`part'1_1961+`part'2_1961;
    drop `part'1_* `part'2_*;
};
quietly for num 1961 1962: gen paddyyieldperhectareX=paddyproductionX/paddyareaX;
quietly for num 1960 1961: gen caneyieldperhaX=caneproductionX/caneareaX\
    gen coconutyieldperhaX=coconutproductionX/coconutareaX\
    gen tobaccoyieldperhaX=tobaccoproductionX/tobaccoareaX;
quietly for var population1961 birthsmale1960 birthsfemale1960 birthsmale1961 birthsfemale1961 deathsmale1960 
    deathsfemale1960 deathsmale1961 deathsfemale1961 paddyarea1961 paddyproduction1961 paddyarea1962 paddyproduction1962 
    canearea1960 canearea1961 caneproduction1960 caneproduction1961 coconutarea1960 coconutarea1961 coconutproduction1960 
    coconutproduction1961 tobaccoarea1960 tobaccoarea1961 tobaccoproduction1960 tobaccoproduction1961:
    replace X=X/area1961;
save Tmp1961, replace;
clear;
insheet using districtcodesprewarmatchedw.txt;
rename provinceone1961 provincecode1961;
sort provincecode1961;
merge provincecode1961 using Tmp1961.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1961: rename X X_1;
rename provincecode1961 provinceone1961;
rename provincetwo1961 provincecode1961;
sort provincecode1961;
merge provincecode1961 using Tmp1961.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1961: rename X X_2;
rename provincecode1961 provincetwo1961;
rename provincethree1961 provincecode1961;
sort provincecode1961;
merge provincecode1961 using Tmp1961.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1961: rename X X_3;
rename provincecode1961 provincethree1961;
rename provincefour1961 provincecode1961;
sort provincecode1961;
merge provincecode1961 using Tmp1961.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1961: rename X X_4;
rename provincecode1961 provincefour1961;


quietly for any $stats1961: gen X=X_1*provinceone1961w+X_2*provincetwo1961w+X_3*provincethree1961w+X_4*provincefour1961w if provincefour1961w~=. & provincefour1961w>0.05;
quietly for any $stats1961: replace X=X_1*provinceone1961w+X_2*provincetwo1961w+X_3*provincethree1961w if (provincefour1961w==. | provincefour1961w<=0.05) & provincethree1961w~=. & provincethree1961w>0.05;
quietly for any $stats1961: replace X=X_1*provinceone1961w+X_2*provincetwo1961w if (provincethree1961w==. | provincethree1961w<=0.05) & provincetwo1961w~=. & provincetwo1961w>0.05;
quietly for any $stats1961: replace X=X_1 if provincetwo1961w==. | provincetwo1961w<=0.05;

drop urban;
keep districtname provincename regionname district province region $stats1961;
order districtname provincename regionname district province region $stats1961;
sort district;
merge district using prewardt.dta;
tab _merge;
drop _merge;
save prewardt.dta, replace;

**//1962;
clear; insheet using Data1963.txt; sort provincecode1963; save Tmp1963.dta, replace;
insheet using Data1962.txt, clear; drop if provincecode1962==.; sort provincecode1962;
/* HAVE TO PULL area1962 FROM THE Data1963 FILE */;
rename provincecode1962 provincecode1963; merge provincecode1963 using Tmp1963.dta; tab _merge; drop _merge;
    keep provincecode1963 area1962 $stats1962; rename provincecode1963 provincecode1962;
foreach part in paddyarea paddyproduction {;
    gen `part'1963=`part'1_1963+`part'2_1963;
    drop `part'1_1963 `part'2_1963;
};
gen paddyyieldperhectare1963=paddyproduction1963/paddyarea1963;
quietly for num 1961 1962: gen rubberworkedtoworkableX=rubberworkedX/rubberworkableX\
    gen coconutyieldperhaX=coconutproductionX/coconutareaX\
    gen tobaccoyieldperhaX=tobaccoproductionX/tobaccoareaX;
quietly for var birthsmale1961 birthsfemale1961 birthsmale1962 birthsfemale1962 deathsmale1961 deathsfemale1961 
    deathsmale1962 deathsfemale1962 paddyarea1963 paddyproduction1963 rubberplanted1961 rubberworkable1961 
    rubberworked1961 rubberplanted1962 rubberworkable1962 rubberworked1962 tobaccoarea1961 tobaccoarea1962 
    tobaccoproduction1961 tobaccoproduction1962 coconutarea1961 coconutarea1962 coconutproduction1961 
    coconutproduction1962:
    replace X=X/area1962;
sort provincecode1962;
save Tmp1962, replace;
clear;
insheet using districtcodesprewarmatchedw.txt;
rename provinceone1962 provincecode1962;
sort provincecode1962;
merge provincecode1962 using Tmp1962.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1962: rename X X_1;
rename provincecode1962 provinceone1962;
rename provincetwo1962 provincecode1962;
sort provincecode1962;
merge provincecode1962 using Tmp1962.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1962: rename X X_2;
rename provincecode1962 provincetwo1962;
rename provincethree1962 provincecode1962;
sort provincecode1962;
merge provincecode1962 using Tmp1962.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1962: rename X X_3;
rename provincecode1962 provincethree1962;
rename provincefour1962 provincecode1962;
sort provincecode1962;
merge provincecode1962 using Tmp1962.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1962: rename X X_4;
rename provincecode1962 provincefour1962;

global stats1962 "area1962 birthsmale1961 birthsfemale1961 birthsmale1962 birthsfemale1962 deathsmale1961 
    deathsfemale1961 deathsmale1962 deathsfemale1962 paddyarea1963 paddyproduction1963 
    rubberplanted1961 rubberworkable1961 rubberworked1961 rubberplanted1962 rubberworkable1962 
    rubberworked1962 tobaccoarea1961 tobaccoarea1962 tobaccoproduction1961 tobaccoproduction1962 coconutarea1961 
    coconutarea1962 coconutproduction1961 coconutproduction1962 paddyyieldperhectare1963 rubberworkedtoworkable1961
    rubberworkedtoworkable1962 coconutyieldperha1961 coconutyieldperha1962 tobaccoyieldperha1961 tobaccoyieldperha1962";

quietly for any $stats1962: gen X=X_1*provinceone1962w+X_2*provincetwo1962w+X_3*provincethree1962w+X_4*provincefour1962w if provincefour1962w~=. & provincefour1962w>0.05;
quietly for any $stats1962: replace X=X_1*provinceone1962w+X_2*provincetwo1962w+X_3*provincethree1962w if (provincefour1962w==. | provincefour1962w<=0.05) & provincethree1962w~=. & provincethree1962w>0.05;
quietly for any $stats1962: replace X=X_1*provinceone1962w+X_2*provincetwo1962w if (provincethree1962w==. | provincethree1962w<=0.05) & provincetwo1962w~=. & provincetwo1962w>0.05;
quietly for any $stats1962: replace X=X_1 if provincetwo1962w==. | provincetwo1962w<=0.05;

drop urban;

keep districtname provincename regionname district province region $stats1962;
order districtname provincename regionname district province region $stats1962;
sort district;
merge using prewardt.dta;
tab _merge;
drop _merge;
sort district;
save prewardt.dta, replace;


**//1963: USES MAP MATCHING/PROVINCE CODES FROM 1962, ONLY AVAILABLE;

clear;
insheet using Data1963.txt;
sort provincecode1963;
drop if provincecode1963==.;
quietly for num 1963 1964: gen paddyyieldperhectareX=paddyproductionX/paddyareaX;
quietly for num 1962 1963: gen caneyieldperhaX=caneproductionX/caneareaX\
    gen rubberworkedtoworkableX=rubberworkedX/rubberworkableX\
    gen coconutyieldperhaX=coconutproductionX/coconutareaX\
    gen tobaccoyieldperhaX=tobaccoproductionX/tobaccoareaX;
quietly for var population1962 birthsmale1962 birthsfemale1962 birthsmale1963 birthsfemale1963 deathsmale1962 
    deathsfemale1962 deathsmale1963 deathsfemale1963 paddyarea1963 paddyarea1964 paddyproduction1963 paddyproduction1964 
    rubberplanted1962 rubberworkable1962 rubberworked1962 rubberplanted1963 rubberworkable1963 rubberworked1963 
    canearea1962 canearea1963 caneproduction1962 caneproduction1963 coconutarea1962 coconutarea1963 coconutproduction1962 
    coconutproduction1963 tobaccoarea1962 tobaccoarea1963 tobaccoproduction1962 tobaccoproduction1963:
    replace X=X/area1962;
save Tmp1963, replace;
clear;
insheet using districtcodesprewarmatchedw.txt;
rename provinceone1962 provincecode1963;
sort provincecode1963;
merge provincecode1963 using Tmp1963.dta, update replace nokeep;
tab _merge;
drop _merge;
global stats1963 "provincecity1963 population1962 area1962 popdensity1962 birthsmale1962 birthsfemale1962 birthsmale1963 
    birthsfemale1963 deathsmale1962 deathsfemale1962 deathsmale1963 deathsfemale1963 paddyarea1963 paddyarea1964 
    paddyproduction1963 paddyproduction1964 rubberplanted1962 rubberworkable1962 rubberworked1962 rubberplanted1963 
    rubberworkable1963 rubberworked1963 canearea1962 canearea1963 caneproduction1962 caneproduction1963 coconutarea1962 
    coconutarea1963 coconutproduction1962 coconutproduction1963 tobaccoarea1962 tobaccoarea1963 tobaccoproduction1962 
    tobaccoproduction1963 paddyyieldperhectare1963 paddyyieldperhectare1964 caneyieldperha1962 caneyieldperha1963 
    rubberworkedtoworkable1962 rubberworkedtoworkable1963 coconutyieldperha1962 coconutyieldperha1963 
    tobaccoyieldperha1962 tobaccoyieldperha1963";
quietly for var $stats1963: rename X X_1;
rename provincecode1963 provinceone1962;
rename provincetwo1962 provincecode1963;
sort provincecode1963;
merge provincecode1963 using Tmp1963.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1963: rename X X_2;
rename provincecode1963 provincetwo1962;
rename provincethree1962 provincecode1963;
sort provincecode1963;
merge provincecode1963 using Tmp1963.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1963: rename X X_3;
rename provincecode1963 provincethree1962;
rename provincefour1962 provincecode1963;
sort provincecode1963;
merge provincecode1963 using Tmp1963.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1963: rename X X_4;
rename provincecode1963 provincefour1962;

global stats1963 "population1962 area1962 popdensity1962 birthsmale1962 birthsfemale1962 birthsmale1963 
    birthsfemale1963 deathsmale1962 deathsfemale1962 deathsmale1963 deathsfemale1963 paddyarea1963 paddyarea1964 
    paddyproduction1963 paddyproduction1964 rubberplanted1962 rubberworkable1962 rubberworked1962 rubberplanted1963 
    rubberworkable1963 rubberworked1963 canearea1962 canearea1963 caneproduction1962 caneproduction1963 coconutarea1962 
    coconutarea1963 coconutproduction1962 coconutproduction1963 tobaccoarea1962 tobaccoarea1963 tobaccoproduction1962 
    tobaccoproduction1963 paddyyieldperhectare1963 paddyyieldperhectare1964 caneyieldperha1962 caneyieldperha1963 
    rubberworkedtoworkable1962 rubberworkedtoworkable1963 coconutyieldperha1962 coconutyieldperha1963 
    tobaccoyieldperha1962 tobaccoyieldperha1963";

quietly for any $stats1963: gen X=X_1*provinceone1962w+X_2*provincetwo1962w+X_3*provincethree1962w+X_4*provincefour1962w if provincefour1962w~=. & provincefour1962w>0.05;
quietly for any $stats1963: replace X=X_1*provinceone1962w+X_2*provincetwo1962w+X_3*provincethree1962w if (provincefour1962w==. | provincefour1962w<=0.05) & provincethree1962w~=. & provincethree1962w>0.05;
quietly for any $stats1963: replace X=X_1*provinceone1962w+X_2*provincetwo1962w if (provincethree1962w==. | provincethree1962w<=0.05) & provincetwo1962w~=. & provincetwo1962w>0.05;
quietly for any $stats1963: replace X=X_1 if provincetwo1962w==. | provincetwo1962w<=0.05;

drop urban;

keep districtname provincename regionname district province region $stats1963;
order districtname provincename regionname district province region $stats1963;
sort district;
merge district using prewardt.dta;
tab _merge;
drop _merge;
sort district;
save prewardt.dta, replace;

**//1965;

clear;
insheet using Data1965.txt;
sort provincecode1965;
drop if provincecode1965==.;
quietly for num 1964 1965 1966: gen paddyyieldperhectareX=paddyproductionX/paddyareaX;
quietly for num 1962 1963 1964 1965: gen caneyieldperhaX=caneproductionX/caneareaX\
    gen cornyieldperhaX=cornproductionX/cornareaX\
    gen coconutyieldperhaX=coconutproductionX/coconutareaX\
    gen maniocyieldperhaX=maniocproductionX/maniocareaX\
    gen swtpotatoyieldperhaX=swtpotatoproductionX/swtpotatoareaX\
    gen tobaccoyieldperhaX=tobaccoproductionX/tobaccoareaX;
quietly for var population1963 population1964 birthsmale1964 birthsfemale1964 deathsmale1964 deathsfemale1964 paddyarea1964 paddyarea1965 
    paddyarea1966 paddyproduction1964 paddyproduction1965 paddyproduction1966 swtpotatoarea1962 swtpotatoarea1963 swtpotatoarea1964 
    swtpotatoarea1965 swtpotatoproduction1962 swtpotatoproduction1963 swtpotatoproduction1964 swtpotatoproduction1965 coconutarea1962 
    coconutarea1963 coconutarea1964 coconutarea1965 coconutproduction1962 coconutproduction1963 coconutproduction1964 
    coconutproduction1965 canearea1962 canearea1963 canearea1964 canearea1965 caneproduction1962 caneproduction1963 caneproduction1964 
    caneproduction1965 tobaccoarea1962 tobaccoarea1963 tobaccoarea1964 tobaccoarea1965 tobaccoproduction1962 tobaccoproduction1963 
    tobaccoproduction1964 tobaccoproduction1965 maniocarea1962 maniocarea1963 maniocarea1964 maniocarea1965 maniocproduction1962 
    maniocproduction1963 maniocproduction1964 maniocproduction1965 cornarea1962 cornarea1963 cornarea1964 cornarea1965 cornproduction1962 
    cornproduction1963 cornproduction1964 cornproduction1965:
    replace X=X/area1963;
save Tmp1965, replace;
clear;
insheet using districtcodesprewarmatchedw.txt;
rename provinceone1965 provincecode1965;
sort provincecode1965;
merge provincecode1965 using Tmp1965.dta, update replace nokeep;
tab _merge;
drop _merge;
global stats1965 "provincecity1965 area1963 population1963 popdensity1963 population1964 birthsmale1964 birthsfemale1964 deathsmale1964 deathsfemale1964 paddyarea1964 paddyarea1965 
    paddyarea1966 paddyproduction1964 paddyproduction1965 paddyproduction1966 swtpotatoarea1962 swtpotatoarea1963 swtpotatoarea1964 
    swtpotatoarea1965 swtpotatoproduction1962 swtpotatoproduction1963 swtpotatoproduction1964 swtpotatoproduction1965 coconutarea1962 
    coconutarea1963 coconutarea1964 coconutarea1965 coconutproduction1962 coconutproduction1963 coconutproduction1964 
    coconutproduction1965 canearea1962 canearea1963 canearea1964 canearea1965 caneproduction1962 caneproduction1963 caneproduction1964 
    caneproduction1965 tobaccoarea1962 tobaccoarea1963 tobaccoarea1964 tobaccoarea1965 tobaccoproduction1962 tobaccoproduction1963 
    tobaccoproduction1964 tobaccoproduction1965 maniocarea1962 maniocarea1963 maniocarea1964 maniocarea1965 maniocproduction1962 
    maniocproduction1963 maniocproduction1964 maniocproduction1965 cornarea1962 cornarea1963 cornarea1964 cornarea1965 cornproduction1962 
    cornproduction1963 cornproduction1964 cornproduction1965 paddyyieldperhectare1964 paddyyieldperhectare1965 paddyyieldperhectare1966
    caneyieldperha1962 caneyieldperha1963 caneyieldperha1964 caneyieldperha1965 cornyieldperha1962 cornyieldperha1963 cornyieldperha1964
    cornyieldperha1965 coconutyieldperha1962 coconutyieldperha1963 coconutyieldperha1964 coconutyieldperha1965 maniocyieldperha1962
    maniocyieldperha1963 maniocyieldperha1964 maniocyieldperha1965 swtpotatoyieldperha1962 swtpotatoyieldperha1963 swtpotatoyieldperha1964
    swtpotatoyieldperha1965 tobaccoyieldperha1962 tobaccoyieldperha1963 tobaccoyieldperha1964 tobaccoyieldperha1965";
quietly for var $stats1965: rename X X_1;
rename provincecode1965 provinceone1965;
rename provincetwo1965 provincecode1965;
sort provincecode1965;
merge provincecode1965 using Tmp1965.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1965: rename X X_2;
rename provincecode1965 provincetwo1965;
rename provincethree1965 provincecode1965;
sort provincecode1965;
merge provincecode1965 using Tmp1965.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1965: rename X X_3;
rename provincecode1965 provincethree1965;
rename provincefour1965 provincecode1965;
sort provincecode1965;
merge provincecode1965 using Tmp1965.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $stats1965: rename X X_4;
rename provincecode1965 provincefour1965;

global stats1965 "area1963 population1963 popdensity1963 population1964 birthsmale1964 birthsfemale1964 deathsmale1964 deathsfemale1964 paddyarea1964 paddyarea1965 
    paddyarea1966 paddyproduction1964 paddyproduction1965 paddyproduction1966 swtpotatoarea1962 swtpotatoarea1963 swtpotatoarea1964 
    swtpotatoarea1965 swtpotatoproduction1962 swtpotatoproduction1963 swtpotatoproduction1964 swtpotatoproduction1965 coconutarea1962 
    coconutarea1963 coconutarea1964 coconutarea1965 coconutproduction1962 coconutproduction1963 coconutproduction1964 
    coconutproduction1965 canearea1962 canearea1963 canearea1964 canearea1965 caneproduction1962 caneproduction1963 caneproduction1964 
    caneproduction1965 tobaccoarea1962 tobaccoarea1963 tobaccoarea1964 tobaccoarea1965 tobaccoproduction1962 tobaccoproduction1963 
    tobaccoproduction1964 tobaccoproduction1965 maniocarea1962 maniocarea1963 maniocarea1964 maniocarea1965 maniocproduction1962 
    maniocproduction1963 maniocproduction1964 maniocproduction1965 cornarea1962 cornarea1963 cornarea1964 cornarea1965 cornproduction1962 
    cornproduction1963 cornproduction1964 cornproduction1965 paddyyieldperhectare1964 paddyyieldperhectare1965 paddyyieldperhectare1966
    caneyieldperha1962 caneyieldperha1963 caneyieldperha1964 caneyieldperha1965 cornyieldperha1962 cornyieldperha1963 cornyieldperha1964
    cornyieldperha1965 coconutyieldperha1962 coconutyieldperha1963 coconutyieldperha1964 coconutyieldperha1965 maniocyieldperha1962
    maniocyieldperha1963 maniocyieldperha1964 maniocyieldperha1965 swtpotatoyieldperha1962 swtpotatoyieldperha1963 swtpotatoyieldperha1964
    swtpotatoyieldperha1965 tobaccoyieldperha1962 tobaccoyieldperha1963 tobaccoyieldperha1964 tobaccoyieldperha1965";

quietly for any $stats1965: gen X=X_1*provinceone1965w+X_2*provincetwo1965w+X_3*provincethree1965w+X_4*provincefour1965w if provincefour1965w~=. & provincefour1965w>0.05;
quietly for any $stats1965: replace X=X_1*provinceone1965w+X_2*provincetwo1965w+X_3*provincethree1965w if (provincefour1965w==. | provincefour1965w<=0.05) & provincethree1965w~=. & provincethree1965w>0.05;
quietly for any $stats1965: replace X=X_1*provinceone1965w+X_2*provincetwo1965w if (provincethree1965w==. | provincethree1965w<=0.05) & provincetwo1965w~=. & provincetwo1965w>0.05;
quietly for any $stats1965: replace X=X_1 if provincetwo1965w==. | provincetwo1965w<=0.05;

drop urban;

keep districtname provincename regionname district province region $stats1965;
order districtname provincename regionname district province region $stats1965;
sort district;
merge district using prewardt.dta;
tab _merge;
drop _merge;
sort district;
save prewardt.dta, replace;

**//N.Viet. 1960, 1965;
/*****NOTE: ALL APPROPRIATE FIGURES (ALL YRS, N/S) MULTIPLIED BY DIST AREA, IN ACCOMPANYING NViet do-file, 
    TO GENERATE DIST-LEVEL ESTIMATES*****/


**//NORTH VIETNAMESE DATA CONSTRUCTION (PREWARDTNVIET)
(LONG AND SHITTY, B/C MUST AGREE WITH S VIETNAMESE FIGURES);

clear;
insheet using DataNViet.txt;
sort provincecoden;

/*MAKE PER UNIT AREA*/

quietly for num 1960 1965 1970: gen cropyield_nonpad_tonsphaX=cropprod_nonpad_1000tonsX/croparea_nonpad_1000haX;
quietly for var

    hhagrocoop_thousands1960 hhagrocoop_thousands1965 hhagrocoop_thousands1970 hhagrocoop_thousands1976 hhagrocoop_thousands1977 
    hhagrocoop_thousands1978 hhagrocoop_thousands1979 hhagrocoop_thousands1980 

    hhagrocoop_vsagro_pct1960 hhagrocoop_vsagro_pct1965 hhagrocoop_vsagro_pct1970 
    agrocoops_no1960 agrocoops_no1965 agrocoops_no1970 
    area_cult_thousandha1960 area_cult_thousandha1965 area_cult_thousandha1970 area_cult_thousandha1976 area_cult_thousandha1977 
    area_cult_thousandha1978 area_cult_thousandha1979 area_cult_thousandha1980 

    area_cult_crops_thousandha1960 area_cult_crops_thousandha1965 area_cult_crops_thousandha1970 
    cerealprod_padval_1000tons1960 cerealprod_padval_1000tons1965 cerealprod_padval_1000tons1970 
    cerealprod_padval_1000tons1976 cerealprod_padval_1000tons1977 cerealprod_padval_1000tons1978 cerealprod_padval_1000tons1979 
    cerealprod_padval_1000tons1980 

    cerealprodpercap_pv_kgper1960 cerealprodpercap_pv_kgper1965 cerealprodpercap_pv_kgper1970 
    paddyarea_thousandha1955 paddyarea_thousandha1960 paddyarea_thousandha1965 paddyarea_thousandha1970 
    paddyarea_thousandha1976 paddyarea_thousandha1977 paddyarea_thousandha1978 paddyarea_thousandha1979 paddyarea_thousandha1980  

    paddyprod_1000tons1955 paddyprod_1000tons1960  paddyprod_1000tons1965 paddyprod_1000tons1970 
    paddyprod_1000tons1976 paddyprod_1000tons1977 paddyprod_1000tons1978 paddyprod_1000tons1979 paddyprod_1000tons1980 

    paddypdpercap_kgperperson1960  paddypdpercap_kgperperson1965 paddypdpercap_kgperperson1970 paddypdpercap_kgperperson1976 
    paddypdpercap_kgperperson1977 paddypdpercap_kgperperson1978 paddypdpercap_kgperperson1979 paddypdpercap_kgperperson1980 

    croparea_nonpad_1000ha1960 croparea_nonpad_1000ha1965 croparea_nonpad_1000ha1970 
    cropprod_nonpad_1000tons1960 cropprod_nonpad_1000tons1965 cropprod_nonpad_1000tons1970 cropprod_nonpad_1000tons1976 
    cropprod_nonpad_1000tons1977 cropprod_nonpad_1000tons1978 cropprod_nonpad_1000tons1979 cropprod_nonpad_1000tons1980 

    cornarea_thousandha1960 cornarea_thousandha1965 cornarea_thousandha1970 
    cornprod_thousandtons1960 cornprod_thousandtons1965 cornprod_thousandtons1970 
    swtpotatoarea_thousandha1960 swtpotatoarea_thousandha1965 swtpotatoarea_thousandha1970  
    swtpotatoprod_thousandtons1960 swtpotatoprod_thousandtons1965 swtpotatoprod_thousandtons1970 
    cassavaarea_thousandha1960 cassavaarea_thousandha1965 cassavaarea_thousandha1970 
    cassavaprod_thousandtons1960 cassavaprod_thousandtons1965 cassavaprod_thousandtons1970 
    peanutarea_thousandha1960 peanutarea_thousandha1965 peanutarea_thousandha1970 
    peanutprod_thousandtons1960 peanutprod_thousandtons1965 peanutprod_thousandtons1970 
    canearea_thousandha1960 canearea_thousandha1965 canearea_thousandha1970 
    caneprod_thousandtons1960 caneprod_thousandtons1965 caneprod_thousandtons1970 caneprod_thousandtons1976 caneprod_thousandtons1977 
    caneprod_thousandtons1978  caneprod_thousandtons1979 caneprod_thousandtons1980 

    buffalos_thousand1955 buffalos_thousand1960 buffalos_thousand1965 buffalos_thousand1970 buffalos_thousand1976 buffalos_thousand1977 
    buffalos_thousand1978 buffalos_thousand1979 buffalos_thousand1980 
    buffalos_plow_thousand1960 buffalos_plow_thousand1965 buffalos_plow_thousand1970 
    buffalos_she_thousand1960 buffalos_she_thousand1965 buffalos_she_thousand1970 buffalos_she_thousand1976 buffalos_she_thousand1977 
    buffalos_she_thousand1978 buffalos_she_thousand1979 buffalos_she_thousand1980 

    oxen_thousand1955 oxen_thousand1960 oxen_thousand1965 oxen_thousand1970 
    oxen_plow_thousand1960 oxen_plow_thousand1965 oxen_plow_thousand1970 oxen_plow_thousand1976 oxen_plow_thousand1977 
    oxen_plow_thousand1978 oxen_plow_thousand1979 oxen_plow_thousand1980 

    oxen_she_thousand1960 oxen_she_thousand1965 oxen_she_thousand1970 
    pigs_nonsuckling_thousand1955 pigs_nonsuckling_thousand1960 pigs_nonsuckling_thousand1965 pigs_nonsuckling_thousand1970 
    pigs_nonsuckling_thousand1976 pigs_nonsuckling_thousand1977 pigs_nonsuckling_thousand1978 
    pigs_nonsuckling_thousand1979 pigs_nonsuckling_thousand1980 

    pigs_she_thousand1960 pigs_she_thousand1965 pigs_she_thousand1970 
    pigs_forfood_thousand1960 pigs_forfood_thousand1965 pigs_forfood_thousand1970 pigs_forfood_thousand1976 pigs_forfood_thousand1977 
    pigs_forfood_thousand1978 pigs_forfood_thousand1979 pigs_forfood_thousand1980:

replace X=X/arean;

/*KEEP INTERESTING VARS*/

keep 
    provincecityn provincecoden arean
    popdensity1960n popdensity1965n popdens_pctdis1960n popdens_pctdis1965n

    area_cult_thousandha1960 area_cult_thousandha1965 

    area_cult_crops_thousandha1960 area_cult_crops_thousandha1965 
    cerealprod_padval_1000tons1960 cerealprod_padval_1000tons1965 

    cerealprodpercap_pv_kgper1960 cerealprodpercap_pv_kgper1965 
    paddyarea_thousandha1955 paddyarea_thousandha1960 paddyarea_thousandha1965

    paddyprod_1000tons1955 paddyprod_1000tons1960  paddyprod_1000tons1965 

    paddypdpercap_kgperperson1960  paddypdpercap_kgperperson1965 

    croparea_nonpad_1000ha1960 croparea_nonpad_1000ha1965
    cropprod_nonpad_1000tons1960 cropprod_nonpad_1000tons1965 

    cornarea_thousandha1960 cornarea_thousandha1965 
    cornprod_thousandtons1960 cornprod_thousandtons1965 
    swtpotatoarea_thousandha1960 swtpotatoarea_thousandha1965 
    swtpotatoprod_thousandtons1960 swtpotatoprod_thousandtons1965 
    cassavaarea_thousandha1960 cassavaarea_thousandha1965 
    cassavaprod_thousandtons1960 cassavaprod_thousandtons1965 
    peanutarea_thousandha1960 peanutarea_thousandha1965 
    peanutprod_thousandtons1960 peanutprod_thousandtons1965 
    canearea_thousandha1960 canearea_thousandha1965 
    caneprod_thousandtons1960 caneprod_thousandtons1965 

    buffalos_thousand1955 buffalos_thousand1960 buffalos_thousand1965 
    buffalos_plow_thousand1960 buffalos_plow_thousand1965 
    buffalos_she_thousand1960 buffalos_she_thousand1965 

    oxen_thousand1955 oxen_thousand1960 oxen_thousand1965 
    oxen_plow_thousand1960 oxen_plow_thousand1965 

    oxen_she_thousand1960 oxen_she_thousand1965 
    pigs_nonsuckling_thousand1955 pigs_nonsuckling_thousand1960 pigs_nonsuckling_thousand1965 

    pigs_she_thousand1960 pigs_she_thousand1965
    pigs_forfood_thousand1960 pigs_forfood_thousand1965

    /*YIELDS*/
     paddyyield_hundredkgperha1955 paddyyield_hundredkgperha1960 paddyyield_hundredkgperha1965 /*paddyyield_hundredkgperha1970*/
    cornyield_hundredkgperha1960 cornyield_hundredkgperha1965 /*cornyield_hundredkgperha1970 cornyield_hundredkgperha1976 
    cornyield_hundredkgperha1977 cornyield_hundredkgperha1978 cornyield_hundredkgperha1979 cornyield_hundredkgperha1980*/
    swtpotatoyield_100kgperha1960 swtpotatoyield_100kgperha1965 /*swtpotatoyield_100kgperha1970*/
    cassavayield_100kgperha1960 cassavayield_100kgperha1965 /*cassavayield_100kgperha1970*/ peanutyield_hundredkgperha1960 
    peanutyield_hundredkgperha1965 /*peanutyield_hundredkgperha1970*/ caneyield_hundredkgperha1960 caneyield_hundredkgperha1965 
    /*caneyield_hundredkgperha1970*/ cropyield_nonpad_tonspha1960 cropyield_nonpad_tonspha1965 /*cropyield_nonpad_tonspha1970*/;

save tmpn, replace;
clear;

/*MATCH DATA TO PRE-WAR PROVINCES OF THE DISTRICTS, IN districtcodesprewarmatchedN.txt*/
insheet using districtcodesprewarmatchedN.txt;
rename provinceonen provincecoden;
sort provincecoden;
merge provincecoden using tmpn.dta, update replace nokeep;
tab _merge;
drop _merge;
global statsn

    "provincecityn arean
    popdensity1960n popdensity1965n popdens_pctdis1960n popdens_pctdis1965n

    area_cult_thousandha1960 area_cult_thousandha1965 

    area_cult_crops_thousandha1960 area_cult_crops_thousandha1965 
    cerealprod_padval_1000tons1960 cerealprod_padval_1000tons1965 

    cerealprodpercap_pv_kgper1960 cerealprodpercap_pv_kgper1965 
    paddyarea_thousandha1955 paddyarea_thousandha1960 paddyarea_thousandha1965

    paddyprod_1000tons1955 paddyprod_1000tons1960  paddyprod_1000tons1965 

    paddypdpercap_kgperperson1960  paddypdpercap_kgperperson1965 

    croparea_nonpad_1000ha1960 croparea_nonpad_1000ha1965
    cropprod_nonpad_1000tons1960 cropprod_nonpad_1000tons1965 

    cornarea_thousandha1960 cornarea_thousandha1965 
    cornprod_thousandtons1960 cornprod_thousandtons1965 
    swtpotatoarea_thousandha1960 swtpotatoarea_thousandha1965 
    swtpotatoprod_thousandtons1960 swtpotatoprod_thousandtons1965 
    cassavaarea_thousandha1960 cassavaarea_thousandha1965 
    cassavaprod_thousandtons1960 cassavaprod_thousandtons1965 
    peanutarea_thousandha1960 peanutarea_thousandha1965 
    peanutprod_thousandtons1960 peanutprod_thousandtons1965 
    canearea_thousandha1960 canearea_thousandha1965 
    caneprod_thousandtons1960 caneprod_thousandtons1965 

    buffalos_thousand1955 buffalos_thousand1960 buffalos_thousand1965 
    buffalos_plow_thousand1960 buffalos_plow_thousand1965 
    buffalos_she_thousand1960 buffalos_she_thousand1965 

    oxen_thousand1955 oxen_thousand1960 oxen_thousand1965 
    oxen_plow_thousand1960 oxen_plow_thousand1965 

    oxen_she_thousand1960 oxen_she_thousand1965 
    pigs_nonsuckling_thousand1955 pigs_nonsuckling_thousand1960 pigs_nonsuckling_thousand1965 

    pigs_she_thousand1960 pigs_she_thousand1965
    pigs_forfood_thousand1960 pigs_forfood_thousand1965

     paddyyield_hundredkgperha1955 paddyyield_hundredkgperha1960 paddyyield_hundredkgperha1965 
    cornyield_hundredkgperha1960 cornyield_hundredkgperha1965
    swtpotatoyield_100kgperha1960 swtpotatoyield_100kgperha1965
    cassavayield_100kgperha1960 cassavayield_100kgperha1965 peanutyield_hundredkgperha1960 
    peanutyield_hundredkgperha1965 caneyield_hundredkgperha1960 caneyield_hundredkgperha1965 
    cropyield_nonpad_tonspha1960 cropyield_nonpad_tonspha1965";

quietly for var $statsn: rename X X_1;
rename provincecoden provinceonen;
rename provincetwon provincecoden;
sort provincecoden;
merge provincecoden using Tmpn.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $statsn: rename X X_2;
rename provincecoden provincetwon;
rename provincethreen provincecoden;
sort provincecoden;
merge provincecoden using tmpn.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $statsn: rename X X_3;
rename provincecoden provincethreen;
rename provincefourn provincecoden;
sort provincecoden;
merge provincecoden using tmpn.dta, update replace nokeep;
tab _merge;
drop _merge;
quietly for var $statsn: rename X X_4;
rename provincecoden provincefourn;

/*GEN DISTRICT PRE-WAR STATS AS WEIGHTED AVERAGE OF CONTAINING PROVINCES' STATS*/

global statsn

    "arean
    area_cult_thousandha1960 area_cult_thousandha1965 
    popdensity1960n popdensity1965n popdens_pctdis1960n popdens_pctdis1965n

    area_cult_crops_thousandha1960 area_cult_crops_thousandha1965 
    cerealprod_padval_1000tons1960 cerealprod_padval_1000tons1965 

    cerealprodpercap_pv_kgper1960 cerealprodpercap_pv_kgper1965 
    paddyarea_thousandha1955 paddyarea_thousandha1960 paddyarea_thousandha1965

    paddyprod_1000tons1955 paddyprod_1000tons1960  paddyprod_1000tons1965 

    paddypdpercap_kgperperson1960  paddypdpercap_kgperperson1965 

    croparea_nonpad_1000ha1960 croparea_nonpad_1000ha1965
    cropprod_nonpad_1000tons1960 cropprod_nonpad_1000tons1965 

    cornarea_thousandha1960 cornarea_thousandha1965 
    cornprod_thousandtons1960 cornprod_thousandtons1965 
    swtpotatoarea_thousandha1960 swtpotatoarea_thousandha1965 
    swtpotatoprod_thousandtons1960 swtpotatoprod_thousandtons1965 
    cassavaarea_thousandha1960 cassavaarea_thousandha1965 
    cassavaprod_thousandtons1960 cassavaprod_thousandtons1965 
    peanutarea_thousandha1960 peanutarea_thousandha1965 
    peanutprod_thousandtons1960 peanutprod_thousandtons1965 
    canearea_thousandha1960 canearea_thousandha1965 
    caneprod_thousandtons1960 caneprod_thousandtons1965 

    buffalos_thousand1955 buffalos_thousand1960 buffalos_thousand1965 
    buffalos_plow_thousand1960 buffalos_plow_thousand1965 
    buffalos_she_thousand1960 buffalos_she_thousand1965 

    oxen_thousand1955 oxen_thousand1960 oxen_thousand1965 
    oxen_plow_thousand1960 oxen_plow_thousand1965 

    oxen_she_thousand1960 oxen_she_thousand1965 
    pigs_nonsuckling_thousand1955 pigs_nonsuckling_thousand1960 pigs_nonsuckling_thousand1965 

    pigs_she_thousand1960 pigs_she_thousand1965
    pigs_forfood_thousand1960 pigs_forfood_thousand1965

     paddyyield_hundredkgperha1955 paddyyield_hundredkgperha1960 paddyyield_hundredkgperha1965 
    cornyield_hundredkgperha1960 cornyield_hundredkgperha1965
    swtpotatoyield_100kgperha1960 swtpotatoyield_100kgperha1965
    cassavayield_100kgperha1960 cassavayield_100kgperha1965 peanutyield_hundredkgperha1960 
    peanutyield_hundredkgperha1965 caneyield_hundredkgperha1960 caneyield_hundredkgperha1965 
    cropyield_nonpad_tonspha1960 cropyield_nonpad_tonspha1965";

quietly for any $statsn: gen X=X_1*provinceonenw+X_2*provincetwonw+X_3*provincethreenw+X_4*provincefournw if provincefournw~=. & provincefournw>0.05;
quietly for any $statsn: replace X=X_1*provinceonenw+X_2*provincetwonw+X_3*provincethreenw if (provincefournw==. | provincefournw<=0.05) & provincethreenw~=. & provincethreenw>0.05;
quietly for any $statsn: replace X=X_1*provinceonenw+X_2*provincetwonw if (provincethreenw==. | provincethreenw<=0.05) & provincetwonw~=. & provincetwonw>0.05;
quietly for any $statsn: replace X=X_1 if provincetwonw==. | provincetwonw<=0.05;

keep districtname provincename regionname district province region $statsn;
order districtname provincename regionname district province region $statsn;

**//RESETTING THE UNITS TO AGREE WITH SOUTH VIETNAMESE PREWAR DATA;

foreach var in 
    area_cult_thousandha1960 area_cult_thousandha1965 

    area_cult_crops_thousandha1960 area_cult_crops_thousandha1965 
    cerealprod_padval_1000tons1960 cerealprod_padval_1000tons1965 

    /*cerealprodpercap_pv_kgper1960 cerealprodpercap_pv_kgper1965 WOULD NEED TO MULTIPLY BY POPULATION, DON'T HAVE*/
    paddyarea_thousandha1955 paddyarea_thousandha1960 paddyarea_thousandha1965

    paddyprod_1000tons1955 paddyprod_1000tons1960  paddyprod_1000tons1965 

    /*paddypdpercap_kgperperson1960  paddypdpercap_kgperperson1965*/ 

    croparea_nonpad_1000ha1960 croparea_nonpad_1000ha1965
    cropprod_nonpad_1000tons1960 cropprod_nonpad_1000tons1965 

    cornarea_thousandha1960 cornarea_thousandha1965 
    cornprod_thousandtons1960 cornprod_thousandtons1965 
    swtpotatoarea_thousandha1960 swtpotatoarea_thousandha1965 
    swtpotatoprod_thousandtons1960 swtpotatoprod_thousandtons1965 
    cassavaarea_thousandha1960 cassavaarea_thousandha1965 
    cassavaprod_thousandtons1960 cassavaprod_thousandtons1965 
    peanutarea_thousandha1960 peanutarea_thousandha1965 
    peanutprod_thousandtons1960 peanutprod_thousandtons1965 
    canearea_thousandha1960 canearea_thousandha1965 
    caneprod_thousandtons1960 caneprod_thousandtons1965 

    buffalos_thousand1955 buffalos_thousand1960 buffalos_thousand1965 
    buffalos_plow_thousand1960 buffalos_plow_thousand1965 
    buffalos_she_thousand1960 buffalos_she_thousand1965 

    oxen_thousand1955 oxen_thousand1960 oxen_thousand1965 
    oxen_plow_thousand1960 oxen_plow_thousand1965 

    oxen_she_thousand1960 oxen_she_thousand1965 
    pigs_nonsuckling_thousand1955 pigs_nonsuckling_thousand1960 pigs_nonsuckling_thousand1965 

    pigs_she_thousand1960 pigs_she_thousand1965
    pigs_forfood_thousand1960 pigs_forfood_thousand1965{;

        replace `var'=`var'*1000;};

foreach var in 
     paddyyield_hundredkgperha1955 paddyyield_hundredkgperha1960 paddyyield_hundredkgperha1965 
    cornyield_hundredkgperha1960 cornyield_hundredkgperha1965
    swtpotatoyield_100kgperha1960 swtpotatoyield_100kgperha1965
    cassavayield_100kgperha1960 cassavayield_100kgperha1965 peanutyield_hundredkgperha1960 
    peanutyield_hundredkgperha1965 caneyield_hundredkgperha1960 caneyield_hundredkgperha1965{; 

        replace `var'=`var'/10;};

**//RENAMING TO REFLECT UNIT CHANGE;

rename area_cult_thousandha1960 plantedarea_total1960n;
rename area_cult_thousandha1965 plantedarea_total1965n;
rename     area_cult_crops_thousandha1960 plantedarea_crop1960n;
rename area_cult_crops_thousandha1965 plantedarea_crop1965n;

rename paddyprod_1000tons1955 paddyproduction1955n;

foreach varpart in cerealprod_padval paddyprod cropprod_nonpad {;
    rename `varpart'_1000tons1960 `varpart'1960n; 
    rename `varpart'_1000tons1965 `varpart'1965n;};

rename croparea_nonpad_1000ha1960 plantedarea_nonpadc1960n; rename croparea_nonpad_1000ha1965 plantedarea_nonpadc1965n;

    /*cerealprodpercap_pv_kgper1960 cerealprodpercap_pv_kgper1965*/
    /*paddypdpercap_kgperperson1960  paddypdpercap_kgperperson1965*/

rename paddyarea_thousandha1955 paddyarea1955n;
foreach varpart in
    paddyarea cornarea swtpotatoarea cassavaarea peanutarea canearea{;
    rename `varpart'_thousandha1960 `varpart'1960n;
    rename `varpart'_thousandha1965 `varpart'1965n;};
foreach varpart in 
    cornprod swtpotatoprod cassavaprod peanutprod caneprod{;
    rename `varpart'_thousandtons1960 `varpart'1960n;
    rename `varpart'_thousandtons1965 `varpart'1965n;};
foreach varpart in buffalos pigs_nonsuckling oxen{;
    rename `varpart'_thousand1955 `varpart'1955n;};
foreach varpart in 
    buffalos buffalos_plow buffalos_she oxen oxen_plow oxen_she pigs_nonsuckling pigs_she pigs_forfood{;
    rename `varpart'_thousand1960 `varpart'1960n;
    rename `varpart'_thousand1965 `varpart'1965n;};
rename paddyyield_hundredkgperha1955 paddyyield1955n;
foreach varpart in 
     paddyyield cornyield peanutyield caneyield{;
    rename `varpart'_hundredkgperha1960 `varpart'1960n;
    rename `varpart'_hundredkgperha1965 `varpart'1965n;};
foreach varpart in 
    swtpotatoyield cassavayield{; rename `varpart'_100kgperha1960 `varpart'1960n; rename `varpart'_100kgperha1965 `varpart'1965n;};
rename cropyield_nonpad_tonspha1960 cropyield_nonpad1960; rename cropyield_nonpad_tonspha1965 cropyield_nonpad1965;

sort district;
merge district using prewardt.dta;
tab _merge;
drop _merge;
sort district;
/*DROP USELESS VARS*/ 
drop arean area1961 area1962 area1963 area1959;
save prewardt.dta, replace;

**//NOTE: ALL OF THESE FIGURES ARE STILL PER UNIT AREA. HERE, GET DISTRICT AREA AND MULTIPLY FOR ALL YEARS, BOTH N/S VIETNAM;

cd ..; cd IFPRI; insheet using SES-data.csv, clear; keep district area_tot_km2; sort district; 
cd ..; cd "Pre-war data"; merge district using prewardt.dta; tab _merge; drop _merge;
foreach var in 
    plantedarea_total1960n plantedarea_total1965n plantedarea_crop1960n plantedarea_crop1965n cerealprod_padval1960n
    cerealprod_padval1965n cerealprodpercap_pv_kgper1960 cerealprodpercap_pv_kgper1965 paddyarea1955n paddyarea1960n 
    paddyarea1965n paddyproduction1955n paddyprod1960n paddyprod1965n paddypdpercap_kgperperson1960 
    paddypdpercap_kgperperson1965 plantedarea_nonpadc1960n plantedarea_nonpadc1965n cropprod_nonpad1960n 
    cropprod_nonpad1965n cornarea1960n cornarea1965n cornprod1960n cornprod1965n swtpotatoarea1960n 
    swtpotatoarea1965n swtpotatoprod1960n swtpotatoprod1965n cassavaarea1960n cassavaarea1965n cassavaprod1960n 
    cassavaprod1965n peanutarea1960n peanutarea1965n peanutprod1960n peanutprod1965n canearea1960n canearea1965n 
    caneprod1960n caneprod1965n buffalos1955n buffalos1960n buffalos1965n buffalos_plow1960n buffalos_plow1965n 
    buffalos_she1960n  buffalos_she1965n oxen1955n oxen1960n oxen1965n oxen_plow1960n oxen_plow1965n oxen_she1960n 
    oxen_she1965n pigs_nonsuckling1955n pigs_nonsuckling1960n pigs_nonsuckling1965n pigs_she1960n pigs_she1965n 
    pigs_forfood1960n pigs_forfood1965n population1963  population1964 birthsmale1964 birthsfemale1964 deathsmale1964 
    deathsfemale1964 paddyarea1964 paddyarea1965 paddyarea1966 paddyproduction1964 paddyproduction1965 
    paddyproduction1966 swtpotatoarea1962 swtpotatoarea1963 swtpotatoarea1964 swtpotatoarea1965 swtpotatoproduction1962 
    swtpotatoproduction1963 swtpotatoproduction1964 swtpotatoproduction1965 coconutarea1962 coconutarea1963 coconutarea1964 
    coconutarea1965 coconutproduction1962 coconutproduction1963 coconutproduction1964 coconutproduction1965 canearea1962 
    canearea1963 canearea1964 canearea1965 caneproduction1962  caneproduction1963 caneproduction1964 caneproduction1965 
    tobaccoarea1962 tobaccoarea1963 tobaccoarea1964 tobaccoarea1965 tobaccoproduction1962 tobaccoproduction1963 
    tobaccoproduction1964 tobaccoproduction1965 maniocarea1962 maniocarea1963 maniocarea1964 maniocarea1965 
    maniocproduction1962 maniocproduction1963 maniocproduction1964 maniocproduction1965 cornarea1962 cornarea1963 
    cornarea1964 cornarea1965 cornproduction1962 cornproduction1963 cornproduction1964 cornproduction1965 population1962 
    birthsmale1962 birthsfemale1962 birthsmale1963 birthsfemale1963 deathsmale1962 deathsfemale1962 deathsmale1963 
    deathsfemale1963 paddyarea1963 paddyproduction1963 rubberplanted1962 rubberworkable1962 rubberworked1962 
    rubberplanted1963 rubberworkable1963 rubberworked1963 birthsmale1961 birthsfemale1961 deathsmale1961 deathsfemale1961 
    rubberplanted1961 rubberworkable1961 rubberworked1961 tobaccoarea1961 tobaccoproduction1961 coconutarea1961 
    coconutproduction1961 population1961 birthsmale1960 birthsfemale1960 deathsmale1960 deathsfemale1960 paddyarea1961 
    paddyproduction1961 paddyarea1962 paddyproduction1962 canearea1960 canearea1961 caneproduction1960 caneproduction1961 
    coconutarea1960 coconutproduction1960 tobaccoarea1960 tobaccoproduction1960 population1959  birthsmale1958 
    birthsfemale1958 birthsmale1959 birthsfemale1959 deathsmale1958 deathsfemale1958 deathsmale1959 deathsfemale1959 
    paddyarea1959 paddyproduction1959 rubberplanted1958 rubberworkable1958 rubberworked1958 rubberplanted1959 rubberworkable1959 
    rubberworked1959 tobaccoarea1958 tobaccoarea1959 tobaccoproduction1958 tobaccoproduction1959 coconutarea1958 coconutarea1959 
    coconutproduction1958 coconutproduction1959 canearea1958 canearea1959 caneproduction1958 caneproduction1959{;
        replace `var'=`var'*area_tot_km2;};


**//MATCH VARNAMES;
foreach varpart in plantedarea_total1960 plantedarea_total1965 popdensity1960 popdensity1965 popdens_pctdis1960 
    popdens_pctdis1965 plantedarea_crop1960 plantedarea_crop1965 cerealprod_padval1960 cerealprod_padval1965 paddyarea1955 
    paddyarea1960 paddyarea1965 paddyproduction1955 paddyprod1960 paddyprod1965 plantedarea_nonpadc1960 
    plantedarea_nonpadc1965 cropprod_nonpad1960 cropprod_nonpad1965 cornarea1960 cornarea1965 cornprod1960 
    cornprod1965 swtpotatoarea1960 swtpotatoarea1965 swtpotatoprod1960 swtpotatoprod1965 cassavaarea1960 cassavaarea1965 
    cassavaprod1960 cassavaprod1965 peanutarea1960 peanutarea1965 peanutprod1960 peanutprod1965 canearea1960 canearea1965 
    caneprod1960 caneprod1965 buffalos1955 buffalos1960 buffalos1965 buffalos_plow1960 buffalos_plow1965 buffalos_she1960 
    buffalos_she1965 oxen1955 oxen1960 oxen1965 oxen_plow1960 oxen_plow1965 oxen_she1960 oxen_she1965 pigs_nonsuckling1955 
    pigs_nonsuckling1960 pigs_nonsuckling1965 pigs_she1960 pigs_she1965  pigs_forfood1960 pigs_forfood1965 paddyyield1955 
    paddyyield1960 paddyyield1965 cornyield1960 cornyield1965 swtpotatoyield1960 swtpotatoyield1965 
    cassavayield1960 cassavayield1965 peanutyield1960 peanutyield1965 caneyield1960 caneyield1965 {;
        rename `varpart'n `varpart'_n;};
foreach var in cerealprodpercap_pv_kgper1960 cerealprodpercap_pv_kgper1965 paddypdpercap_kgperperson1960 
    paddypdpercap_kgperperson1965 cropyield_nonpad1960 cropyield_nonpad1965 {;
    rename `var' `var'_n;};
foreach year in 1960 1965 {;
    rename caneyield`year'_n caneyieldperha`year'_n;
    rename cornyield`year'_n cornyieldperha`year'_n;
    rename paddyyield`year'_n paddyyieldperhectare`year'_n;
    rename swtpotatoyield`year'_n swtpotatoyieldperha`year'_n;
    rename cassavayield`year'_n cassavayieldperha`year'_n;
    rename peanutyield`year'_n peanutyieldperha`year'_n;};
rename paddyyield1955_n paddyyieldperhectare1955_n;
foreach year in 1960_n 1965_n {;
    rename cornprod`year' cornproduction`year';
    rename paddyprod`year' paddyproduction`year';
    rename peanutprod`year' peanutproduction`year';
    rename cassavaprod`year' cassavaproduction`year';
    rename caneprod`year' caneproduction`year';
    rename swtpotatoprod`year' swtpotatoproduction`year';};
aorder; order regionname provincename districtname region province district;
sort district;
save prewardt.dta, replace;

clear;


**//THIS PORTION OF FILE CONSTRUCTS DSCADATA - DATA ON BOMBING
TAKEN FROM DSCADATAWORK.DO (DSCABOMB);

cd ..; cd DSCA;
insheet using NAVY_SUM2.txt;
replace category="UNLABELEDUSN" if category==".";
replace category="MK07" if category=="MK-07";
replace category="MK8" if category=="MK-8";
replace category="MK10" if category=="MK-10";
replace category="MK12" if category=="MK-12";
replace category="MK7" if category=="MK-7";
replace category="MK70" if category=="MK-70";
replace category="P0" if category=="P   0";
tab district category if quantity==.;
**// 40325 RAGON, 40709 RAGON, 50505 A;

reshape wide quantity, i(district) j(category) s;
quietly for any A AAC AC ACC AP COM COMM CVT HC HCC HCP HCPD HCVT HE HECVT HEPD HP HVTF ILL ILLUM ILUM MK MK07 MK10 MK12 MK7 MK70 MK8 P P0 RAGON RAP SHRKE UNLABELEDUSN VC VT VTN VTNSD VTSD W WP: rename quantityX X;
quietly for any A AAC AC ACC AP COM COMM CVT HC HCC HCP HCPD HCVT HE HECVT HEPD HP HVTF ILL ILLUM ILUM MK MK07 MK10 MK12 MK7 MK70 MK8 P P0 RAGON RAP SHRKE UNLABELEDUSN VC VT VTN VTNSD VTSD W WP: replace X=0 if X==.;

label var AAC "Anti-Aircraft, Common";
label var AP "Armor Piercing";
label var COM "no ordnance can be identified";
label var CVT "no ordnance can be identified. May refer to a training vessel, e.g., the USS Lexington, CVT-16";
label var HC "Smoke Compound - filler for pyrotechnics. OR High Capacity Projectile (e.g., 16 inch)";
label var HCPD "Smoke Round";
label var HE "High Explosive";
label var HECVT "High Explosive?";
label var HEPD "High Explosive, Point Detonating";
label var ILLUM "Illumination";
label var MK10 "MK10 & MK12 may refer to aircraft ejection seat (hard to say since there are so many different MK numbers for things like torpedos, etc.)";
label var MK12 "MK10 & MK12 may refer to aircraft ejection seat (hard to say since there are so many different MK numbers for things like torpedos, etc.)";
label var MK7 "16 Inch Gun; Primary armament on Iowa Class battleships.";
label var RAGON "Man Portable Anti-Tank Missle";
label var RAP "Rocket Assisted Projectile. Uses a rocket motor in the base to gain extra range.";
label var SHRKE "Anti-Radiation Air to Ground Missle (shot at radar sites and mounted above the ASROC launchers on some ships in 1971-72)";
label var VT "Variable Time Fuse";
label var VTNSD "Maybe ... Variable Time, Non-Self-Destruct (Fuzing)";
label var WP "White Phosphorous";

sort district;
save DSCAdata.dta, replace;

clear;
insheet using "AIR_SUM.txt";
replace category="UnlabeledUSAF" if category=="";
tab district category if quantity==.;
reshape wide quantity, i(district) j(category) s;
quietly for any Ammunition Cannon_Artillery Chemical Cluster_Bomb Flare Fuel_Air_Explosive General_Purpose Grenade Incendiary Mine Missile UnlabeledUSAF Other Rocket Submunition Torpedo Unknown: rename quantityX X;
quietly for any Ammunition Cannon_Artillery Chemical Cluster_Bomb Flare Fuel_Air_Explosive General_Purpose Grenade Incendiary Mine Missile UnlabeledUSAF Other Rocket Submunition Torpedo Unknown: replace X=0 if X==.;

sort district;
merge district using DSCAdata.dta;
tab _merge;
rename _merge _merge_USN_USAF;
quietly for var Ammunition Cannon_Artillery Chemical Cluster_Bomb Flare Fuel_Air_Explosive General_Purpose Grenade Incendiary Mine Missile Other Rocket Submunition Torpedo UnlabeledUSAF Unknown A AAC AC ACC AP COM COMM CVT HC HCC HCP HCPD HCVT HE HECVT HEPD HP HVTF ILL ILLUM ILUM MK MK07 MK10 MK12 MK7 MK70 MK8 P P0 RAGON RAP SHRKE UNLABELEDUSN VC VT VTN VTNSD VTSD W WP: replace X=0 if X==.;
replace A=. if district==50505;
replace RAGON=. if district==40325 | district==40709;
sort district;
save DSCAdata.dta, replace;

clear;
insheet using "Geo Codes for Vietnam.txt";
rename districtcode district;
drop regioncode provincecode districtcodea;
gen province=district/100;
replace province=int(province);
gen region=province/100;
replace region=int(region);

gen str1 provincename=".";
replace provincename="Ha Noi (City)" if province==101;
replace provincename="Hai Phong (City)" if province==103;
**//Note this change from the GSO Listing: 104 --> 219 (from Red River Delta to Northeast Region);
replace provincename="Vinh Phuc" if province==219;
**//One of the districts in that province has been renumbered as well.;
replace provincename="Ha Tay" if province==105;
replace provincename="Hai Duong" if province==107;
replace provincename="Hung Yen" if province==109;
replace provincename="Ha Nam" if province==111;
replace provincename="Nam Dinh" if province==113;
replace provincename="Thai Binh" if province==115;
replace provincename="Ninh Binh" if province==117;
replace provincename="Ha Giang" if province==201;
replace provincename="Cao Bang" if province==203;
replace provincename="Lao Cai" if province==205;
replace provincename="Bac Kan" if province==207;
replace provincename="Lang Son" if province==209;
replace provincename="Tuyen Quang" if province==211;
replace provincename="Yen Bai" if province==213;
replace provincename="Thai Nguyen" if province==215;
replace provincename="Phu Tho" if province==217;
replace provincename="Bac Giang" if province==221;
replace provincename="Bac Ninh" if province==223;
replace provincename="Quang Ninh" if province==225;
replace provincename="Lai Chau" if province==301;
replace provincename="Son La" if province==303;
replace provincename="Hoa Binh" if province==305;
replace provincename="Thanh Hoa" if province==401;
replace provincename="Nghe An" if province==403;
replace provincename="Ha Tinh" if province==405;
replace provincename="Quang Binh" if province==407;
replace provincename="Quang Tri" if province==409;
replace provincename="Thuathien-Hue" if province==411;

replace provincename="Da Nang (City)" if province==501;
replace provincename="Quang Nam" if province==503;
replace provincename="Quang Ngai" if province==505;
replace provincename="Binh Dinh" if province==507;
replace provincename="Phu Yen" if province==509;
replace provincename="Khanh Hoa" if province==511;
replace provincename="Kon Tum" if province==601;
replace provincename="Gia Lai" if province==603;
replace provincename="Dak Lak" if province==605;
replace provincename="Ho Chi Minh (City)" if province==701;
replace provincename="Lam Dong" if province==703;
replace provincename="Ninh Thuan" if province==705;
replace provincename="Binh Phuoc" if province==707;
replace provincename="Tay Ninh" if province==709;
replace provincename="Binh Duong" if province==711;
replace provincename="Dong Nai" if province==713;
replace provincename="Binh Thuan" if province==715;
replace provincename="Ba Ria" if province==717;
replace provincename="Long An" if province==801;
replace provincename="Dong Thap" if province==803;
replace provincename="An Giang" if province==805;
replace provincename="Tien Giang" if province==807;
replace provincename="Vinh Long" if province==809;
replace provincename="Ben Tre" if province==811;
replace provincename="Kien Giang" if province==813;
replace provincename="Can Tho" if province==815;
replace provincename="Tra Vinh" if province==817;
replace provincename="Soc Trang" if province==819;
replace provincename="Bac Lieu" if province==821;
replace provincename="Ca Mau" if province==823;
gen urban=0;
**//This urban variable gets dropped later since GSO has better measure;
replace urban=1 if province==101 | province==103 | province==501 | province==701;
gen str1 regionname=".";
replace regionname="Red River Delta" if region==1;
replace regionname="Northeast" if region==2;
replace regionname="Northwest" if region==3;
replace regionname="North Central Coast" if region==4;
replace regionname="South Central Coast" if region==5;
replace regionname="Central Highlands" if region==6;
replace regionname="Northeast South" if region==7;
replace regionname="Mekong River Delta" if region==8;

sort district;
merge district using DSCAdata.dta;
tab _merge;
rename _merge _merge_distcodes;
sort district;
save DSCAdata.dta, replace;

**//The next portion creates hhVLSSallcollapse_province_panel and SHOULD create VLSScommune - but doesn't yet - more programs may need to be run first (VLSSDATA);

**//THIS FILE EXTRACTS AND LABELS VARIABLES FROM VLSS HOUSEHOLD AND COMMUNE SURVEYS AND MINOT'S EXPENDITURE FILES.
IT GENERATES THE FOLLOWING FILES:
HHVLSS93 - CONTAINS HH-LEVEL DATA FOR '93, AT THE HH LEVEL
HHVLSS98 - CONTAINS HH-LEVEL DATA FOR '98, AT THE HH LEVEL
HHVLSS02 - CONTAINS HH-LEVEL DATA FOR '02, AT THE HH LEVEL
COMVLSS98 - CONTAINS COMMUNE-LEVEL DATA FOR '98, AT THE COMMUNE LEVEL
VLSS98HHCOM - CONTAINS HH AND COMMUNE LEVEL DATA FOR '98, AT THE HH LEVEL
HHVLSS98_93 - CONTAINS HH AND COMMUNE DATA FOR '98, PLUS HH LEVEL DATA FOR '93, ALL AT THE HH LEVEL
COMVLSS98COLLAPSE - CONTAINS COMMUNE DATA, COLLAPSED BY DISTRICT, FOR '98    
HHVLSS9893COLLAPSE - CONTAINS DATA IN HHVLSS98_93, COLLAPSED TO THE DISTRICT LEVEL
HHVLSS02COLLAPSE - CONTAINS DATA IN HHVLSS02,COLLAPSED TO THE DISTRICT     LEVEL
HHVLSSALLCOLLAPSE - CONTAINS DATA FROM ALL YEARS COLLAPSED TO THE DISTRICT LEVEL
HHVLSS93COLLAPSE_PROVINCE - CONTAINS DATA IN HHVLSS98_93, COLLAPSED WITHOUT WEIGHTS FOR 1993 DATA TO PROVINCE LEVEL
HHVLSS98COLLAPSE_PROVINCE - CONTAINS DATA IN HHVLSS98_93, COLLAPSED WITH WEIGHTS FOR 1998 DATA TO PROVINCE LEVEL
HHVLSS9893COLLAPSE_PROVINCE - CONTAINS THE MERGED HHVLSS93COLLAPSE_PROVINCE AND HHVLSS98COLLAPSE_PROVINCE FILES
HHVLSS02COLLAPSE_PROVINCE - CONTAINS DATA IN HHVLSS02,COLLAPSED TO THE PROVINCE LEVEL
HHVLSSALLCOLLAPSE_PROVINCE - CONTAINS DATA FROM ALL YEARS COLLAPSED TO THE PROVINCE LEVEL
HHVLSSALLCOLLAPSE_PANEL - CONTAINS DATA FORM ALL YEARS, ONLY FOR DISTRICTS IN ALL YEARS, COLLAPSED TO DISTRICT LEVEL
HHVLSSALLCOLLAPSE_PROVINCE_PANEL - CONTAINS DATA FORM ALL YEARS, ONLY FOR PROVINCES IN ALL YEARS, COLLAPSED TO PROVINCE LEVEL;

**//OTHER IMPORTANT FILES USED BY THIS FILE ARE:
93EXP - '93 EXPENDITURE FILE FROM MINOT    
HHEXP98N - '98 EXPENDITURE FILE FROM MINOT
COMVLSSMATCH - CREATED BY BUB TO MATCH COMMUNE CODES IN '98 TO DISTRICT CODES IN '98;

cd ..; 
cd VLSS\VLSS98\DATA\HOUSEHOLD;

**//FIRST PREPARE CERTAIN FILES FOR MERGING;
use SCR09A12;
egen totplotland = sum( s9a1q04), by(househol); /*total plot land*/;
gen qualitywgt = s9a1q04/totplotland;
gen wtdqualitycrop = s9a1q07* qualitywgt;
collapse (count) cluster (sum)  s9a1q04 s9a1q05 wtdqualitycrop, by(househol);
rename cluster numplots_crop;
save 9A1_cropland.dta, replace;

use SCR09A22;
egen totplotland = sum( s9a2q03), by(househol); /*total plot land*/;
gen qualitywgt = s9a2q03/totplotland;
gen wtdqualityother = s9a2q07* qualitywgt;
collapse (count) cluster (sum)  s9a2q03 s9a2q04 wtdqualityother, by(househol);
rename cluster numplots_other;
save 9A2_otherland, replace;

use SCR09A32;
egen totplotland = sum( s9a3q03), by(househol); /*total plot land*/;
gen qualitywgt = s9a3q03/totplotland;
gen wtdqualityrentin = s9a3q07* qualitywgt;
collapse (count) cluster (sum)  s9a3q03 s9a3q04 wtdqualityrentin, by(househol);
rename cluster numplots_rentin;
save 9A3_rentedinland, replace;

use SCR09A42;
egen totplotland = sum(s9a4q05), by(househol); /*total plot land*/;
gen qualitywgt = s9a4q05/totplotland;
gen wtdqualityrentout = s9a4q09* qualitywgt;
collapse (count) cluster (sum)  s9a4q05 s9a4q06 wtdqualityrentout, by(househol);
rename cluster numplots_rentout;
save 9A4_rentedoutland, replace;



**//NOW MERGE FILES THAT ARE IDENTIFIED BY HOUSEHOLD AND IDCODE;

**//sort files to merge by househol and idcode;
quietly foreach x in SCR01A2 SCR01B SCR01D SCR02A SCR02B SCR02E SCR036 SCR04A SCR04B1 SCR04B2 SCR04B3 SCR04C SCR04D1 SCR04E SCR04G SCR04H SCR05 SCR15 SCR031{;
use `x'.dta;
sort househol idcode;
save `x'_temp.dta, replace;
};


**//base file;
use SCR01A2_temp.dta;


**//merge files by househol & idcode;
quietly foreach x in SCR01B SCR01D SCR02A SCR02B SCR02E SCR036 SCR04A SCR04B1 SCR04B2 SCR04B3 SCR04C SCR04D1 SCR04E SCR04G SCR04H SCR05 SCR15 SCR031 {;
merge househol idcode using `x'_temp.dta;
drop _merge;
sort househol idcode;
save hhvlss98.dta, replace;
erase `x'_temp.dta;
};

erase SCR01A2_temp.dta;


**//NOW MERGE FILES THAT ARE IDENTIFIED BY HOUSEHOLD ONLY;

**//Sort files by househol;
**// NOTE: RP removed from the househol merge because it needs to be reshaped by s8aorde and collapsed before merging;
quietly foreach x in SCR00A SCR08A2 SCR00B SCR06A SCR06B1 SCR06B2 SCR06C SCR08A1 SCR08A3 SCR09A11 9A1_cropland SCR09A21 9A2_otherland SCR09A31 9A3_rentedinland SCR09A41 9A4_rentedoutland  {;
use `x'.dta;
sort househol;
save `x'_temp.dta, replace;
};


**//base file;
use hhvlss98.dta;
sort househol;

**//merge files by househol;
quietly foreach x in SCR00A SCR08A2 SCR00B SCR06A SCR06B1 SCR06B2 SCR06C SCR08A1 SCR08A3 SCR09A11 9A1_cropland SCR09A21 9A2_otherland SCR09A31 9A3_rentedinland SCR09A41 9A4_rentedoutland {;
merge househol using `x'_temp.dta;
drop _merge;
sort househol;
save hhconst98.dta, replace;
erase `x'_temp.dta;
};


**//Note: SCR08A2 also codes the birth order (s8aorde) of the children in question.
    And SCR08A1 codes the idcode of the fertile woman in question (s8idc).;
**//NOTE: s8aorde s8aq05d s8aq05m s8aq05y s8aq09t s8aq09u s8aq10
    were all removed from the and order commands because file SCR08A2 needs to be manipulated before merging (see above)
    these variables are all eliminated later (see next keep command), so this is unimportant for now;

**//KEEP ONLY "POSSIBLE OUTCOME MEASURES";
keep househol cluster idcode s0bq01 s0bq02 s0bq021 vlsscode s1aq02 s1aq03 s1aq04 s1aq05d s1aq05m s1aq05y s1aq06y s1aq06m 
    s1bq01 s1bq02 s1bq03 s1bq04 s1bq05 s1bq06 s1bq07 s1bq08 s1bq09 s1bq10 s1bq11 s1bq12 s1bq13 s1bq14 s1bq15 s1bq16 
    s2aq01 s2aq02 s2aq03 s2aq04 s2aq05 s2aq06 s2aq07 s2aq08f s2aq08s s2aq08t s2aq09f s2aq09s s2aq09t s2aq11 s2aq12 s2aq13m 
    s2aq13y s2aq15 s2aq16 s2aq17y s2aq17m s2aq18 s2aq19 s2aq20 s2aq21m s2aq21y s2aq22 s2bq01 s2bq02 s2bq03 s2bq07 s2bq11 s2bq12f s2bq12s 
    s2bq12t s2eq01 s2eq02
    s2eq03 s2eq04 s2eq05 s3q01 s3q05 s3q06 s3q07 s3q45 s3q46
    s4aq02 s4aq03 s4aq04 s4aq05 s4aq06 s4aq07 s4aq08 s4aq14 
    s4bq01 s4bq02 s4bq03y s4bq03m s4bq07 s4bq08 s4bq09 s4bq10 s4bq20
    s4cq01 s4cq02 s4cq03y s4cq03m s4cq12 s4cq14  s4bq21a s4bq21u s4bq22ia s4bq22iu 
    s4dq01 s4dq02 s4dq03 s4dq04y s4dq04m s4dq06 s4dq12 s4dq13a s4dq13u s4dq14ia s4dq14iu 
    s4gq09 s4gq10
    s5q01 s5q02 
    s5q03 s5q04 s5q05 s5q06 s5q7y s5q7m s5q08 s5q09 s6aq02 s6bq01 s6bq17 s6bq21a s6bq21u s6bq25 s6bq26a s6bq26u s6bq31 s6bq33 s6cuar s6clar
    s8idc s8aq02 s8aq03  s8aq13 s8aq14 s8aq19 s8aq25 s8aq26 s8aq27 s8aq30 
    s15yrs s15mth s15q04 s15q05 s15q06 s15q07 numplots_crop numplots_other numplots_rentin numplots_rentout tribe s4aq09 s4aq10     
    s4aq11     s4aq12    s4dq10 s4dq11 s4dq12 s4eq01 s4eq02 s4eq03 s4eq09 s4eq10    s4eq11 s4hq08f s4hq08s s4hq08t s9a1q01 s9a1q02 s9a2q01 s9a3q01 
    s9a4q01 s9a1q04    s9a1q05    wtdqualitycrop    s9a2q03    s9a2q04    wtdqualityother    s9a3q03    s9a3q04    wtdqualityrentin s9a4q05 s9a4q06
    wtdqualityrentout
    s15yrs s15mth s15q01 s15q02 s15q03d s15q03m s15q03y s15q04 s15q05 s15q06 s15q07 s15q08 ;

**//order househol cluster idcode s0bq01 s0bq02 s0bq021 vlsscode s1aq02 s1aq03 s1aq04 s1aq05d s1aq05m s1aq05y s1aq06y s1aq06m s1bq04 s1bq05 s1bq06 s1bq07 
    s1bq08 s1bq12 s1bq13 s1bq14 s1bq15 s1bq16 s2aq02 s2aq03 s2aq04 s2aq06 s2aq07 s2aq08f s2aq08s s2aq08t s2aq11 s2aq12 s2aq13m s2aq13y 
    s2aq15 s2aq16 s2aq17y s2aq17m s2aq19 s2aq20 s2aq21m s2aq21y s2bq01 s2bq02 s2bq07 s2bq11 s2bq12f s2bq12s s2bq12t s2eq01 s2eq02 s2eq03 
    s2eq04 s2eq05 s3q01 s3q05 s3q06 s3q07 s3q45 s3q46 s4aq02 s4aq03 s4aq04 s4aq05 s4aq06 s4aq07 s4aq08 s4aq14 s4bq01 s4bq02 s4bq21a 
    s4bq21u s4bq22ia s4bq22iu s4dq01 s4dq02 s4dq04y s4dq04m s4dq06 s4dq12 s4dq13a s4dq13u s4dq14ia s4dq14iu s4gq09 s4gq10 s5q01 s5q02 
    s5q03 s5q04 s5q05 s5q06 s5q7y s5q7m s5q08 s5q09 s6aq02 s6bq01 s6bq17 s6bq21a s6bq21u s6bq25 s6bq26a s6bq26u s6bq31 s6bq33 s6cuar s6clar
    s8idc s8aq02 s8aq03 s8aq13 s8aq14 s8aq19 s8aq25 s8aq26 s8aq27 s8aq30 
    s15yrs s15mth s15q04 s15q05 s15q06 s15q07 numplots_crop numplots_other numplots_rentin numplots_rentout tribe s4aq09 s4aq10     
    s4aq11     s4aq12    s4dq10 s4dq11 s4dq12 s4eq01 s4eq02 s4eq03 s4eq09 s4eq10    s4eq11 s4hq08f s4hq08s s4hq08t s9a1q01 s9a1q02 s9a2q01 s9a3q01 
    s9a4q01 s9a1q04    s9a1q05    wtdqualitycrop    s9a2q03    s9a2q04    wtdqualityother    s9a3q03    s9a3q04    wtdqualityrentin s9a4q05 s9a4q06 
    wtdqualityrentout;


**//SORT AND SAVE '98 DATAFILE;
sort househol;
save hhvlss98.dta, replace;


**//MERGE W/ CONSTRUCTED EXPENDITURE DATA; 
use HHEXP98N.dta;
sort househol;
save HHEXP98N_temp.dta, replace;

use hhvlss98.dta;
merge househol using HHEXP98N.DTA; drop _merge;


**//KEEP ONLY SELECT "POSSIBLE OUTCOME MEASURES" SO THAT THE FILE ISN'T TOO BIG;
keep househol cluster idcode vlssmphs vlsscode sex age agegroup comped98 educyr98 farm urban98 urban92 wt hhsize hhsizewt commune ricexpd 
    nonrice totnfdx1 totnfdhp totnfdh1 food nonfood1 hhexp1 pcexp1 pcfdex1 rlfood rlnfd1 rlhhex1 rlpcex1 rlpcfdex nonfood2 hhexp2 pcexp2
    rlhhex2 rlpcex2 s0bq01 s0bq02 s0bq021 s1aq02 s1aq03 s1aq05d s1aq05m s1aq05y s1aq06y s1aq06m s1bq01 s1bq02 s1bq04 s1bq05 s1bq06 s1bq07 s1bq08 s1bq09 s1bq10 
    s1bq12 s1bq13 s1bq14 s1bq15 s1bq16 s2aq02 s2aq03 s2aq04 s2aq05 s2aq06 s2aq07 s2aq08f s2aq08s s2aq08t s2aq09f s2aq09s 
    s2aq09t  s2aq11 s2aq12 s2aq15 s2aq16 s2aq19 s2aq20 s2aq21m s2aq21y s2aq22 s2bq01 s2bq02 s2bq03 s2bq07 s2bq11 s2bq12f s2bq12s 
    s2bq12t s2eq01 s2eq02 s2eq03 s3q05 s3q06 s3q07 s3q45 s3q46 
    s4aq08 s4bq01 s4bq02 s4bq03y s4bq03m s4bq07 s4bq08 s4bq09 s4bq10 s4bq20
    s4cq01 s4cq02 s4cq03y s4cq03m s4cq12 s4cq14
    s4aq14 s4dq01 s4dq02 s4dq03 s4dq04y s4dq04m s4dq06 s4dq12 
    s5q01 s5q03 s5q06 s5q7y s5q7m s5q08 s5q09 s6aq02 s6bq01 s6bq17 s6bq21a s6bq21u s6bq25 s6bq26a s6bq26u s6bq31 s6bq33 
    numplots_crop numplots_other numplots_rentin numplots_rentout tribe s4aq09 s4aq10     
    s4aq11     s4aq12    s4dq10 s4dq11 s4dq12 s4eq01 s4eq02 s4eq03 s4eq09 s4eq10    s4eq11 s4hq08f s4hq08s s4hq08t s9a1q01 s9a1q02 s9a2q01 s9a3q01 
    s9a4q01 s9a1q04    s9a1q05    wtdqualitycrop    s9a2q03    s9a2q04    wtdqualityother    s9a3q03    s9a3q04    wtdqualityrentin s9a4q05 s9a4q06 
    wtdqualityrentout
    /*s15yrs s15mth s15q01 */ s15q02 s15q03d s15q03m s15q03y s15q04 s15q05 s15q06 s15q07 s15q08;


**//RENAME AND LABEL ALL VARIABLES;
**// IN HHEXP98N, ONLY HOUSEHOLD HEADS ARE LISTED, SO THE FOLLOWING LINE RENAMES VARIABLES APPROPRIATELY;
rename sex sex_head;
rename age age_head;
rename agegroup agegroup_head;
rename comped98 comped98_head;
rename educyr98 educyr98_head;
/*later we create some of the above variables on our own, for all members, not just head*/


**//NOTE THAT COMMUNE IS NOT THE SAME AS CLUSTER HERE;
replace commune=int((int(househol/100)+1)/2) /*THIS IS JUST TO GIVE THE 10HH NOT IN HHEXP98N.DTA A COMMUNE CODE*/;


**//CREATE CODES;
/*TRANSLATING DIPLOMA LABELS, AS TRANSLATED BY KHUYEN - these labels are for Minot's comped98 variable*/ 
label define diploma 0 Never 1 "Nhatre = Kindergarten" 
    2 "<cap I = <primary" 3 "Cap I = Primary" 4 "Cap II = Lower Sec" 5 "Cap III = Higher Sec" 6 "Nghe SC = Voc Training" 
    7 "THCN = Secondary Voc Training" 8 DHDC 9 "DHCD = Bachelors" 10 "Thac sy = Masters" 11 "PTS = PhD Candidate" 
    12 "TS = PhD", modify;

/*FOR FEMALE*/
label define female 0 male 1 female; 
/*FOR RELTOHEAD*/
label define reltohead 1 head 2 spouse 3 child 4 "child-in-law" 5 grandch 6 parent 7 "parent-in-law" 8 sibling 9 grandpar 10 "niece/nephew" 11 "other relative" 12 "adoptee/stepchild" 13 "other, not related"; 
/*MOTHER and FATHER EDUC*/
label define diploma0 0 none 1 prim 2 lowsec 3 hisec 4 certif 5 training 6 "tech/prof.sec" 7 jc 8 assoc 9 bach 10 mast 11 "sub-doc" 12 phd 13 "don't know"; 
/*PROFESSION CODES*/
label define profession 10 leader 20 professional 30 professional 40 professional 50 "personal-svc/protection/sales" 60 "agro/for/fish" 70 skillmanual 80 "assemb/machinist" 90 unskill 99 "other(inc.gen-militar)"; 
/*FOR SCHOOLLEVEL*/
label define schoollevel 1 pre 2 prim 3 lowsec 4 hisec 5 voc 6 univ; 
/*FOR OWN EDUC*/
label define diploma1 0 none 1 jc 2 ass 3 bach 4 mas 5 "sub-doc" 6 phd; 
/*FOR LITERATE (refers to re-coding, see below)*/
label define literate 3 "yes w/o difficulty" 2 "yes w/ difficulty" 1 "only in other lang" 0 no; 
/*FOR NUMERATE (refers to re-coding, see below)*/
label define numerate 2 "yes w/o difficulty" 1 "yes w/ difficulty" 0 no;
/*INDUSTRY CODES*/
label define industry 1 agro 10 mine 15 industry 20 industry 30 industry 40 "elec/water/construction" 50 commerce 60 "trans/comm" 65 finance 70 othersvc 80 othersvc 90 othersvc; 
/*TOILETTYPE*/
label define toilettype 1 "flush w/ septic/sewage" 2 "double vault compost latrine" 3 simple 4 "toilet directly over water" 5 other 6 "no toilet";
/*LIGHTINGSOURCE*/
label define lightingsource 1 electricity 2 "battery lamp" 3 "gas/oil/kerosene" 4 "resin torches" 5 other;
/*WATERSOURCE*/
label define watersource 1 "inside pvt tap" 2 "outside pvt tap" 3 "public standpipe" 4 "deep drill well w/ pump" 5 "hand-dug/constructed well" 6 "filtered spring water" 7 "other well" 8 rain 9 "river/lake/pond" 10 "container water" 11 other;
/*WHYMOVE*/
label define whymove 1 "follow/join family" 2 "work related" 3 marriage 4 school 5 "join army" 6 "move to new economic zone" 7 "forced relocation" 8 war 9 "natural disaster/fire" 10 "adventure/chance" 11 "family conflict" 12 "look for work" 13 "customs/common practice" 14 other;
/*WHYNOWORK*/
label define whynowork  1 illness 2 "HH member ill" 3 "home for other reasons" 4 vacation 5 "strike or similar" 6 "job is seasonal" 7 "maternity leave" 8 "other reason";
/*WHYNOLOOK*/
label define whynolook 1 illness 2 disabled 3 "too old/retired" 4 "Don't want to" 5 "student" 6 "housework/childcare" 7 "too young" 8 "waiting for seasonal job" 9 "waiting to start new job" 10 "Don't have work" 11 "Don't know how to look" 12 Other;
/*WORKFOR*/
label define workfor 1 "gov't admin, police, military" 2 "state enterprise" 3 "communist party, social org" 4 cooperative 5 "private enterprise" 6 "small hh entrep." 7 "limited liability company" 8 "100% foreign enterprise" 9 "joint venture with gov't" 10 "JV with collective" 11 "JV with private" 12 "JV with individual" 13 "JV with domestic joint co." 14 other;
/*ORG*/
label define org 1 "youth union" 2 "women's union" 3 "farmer's union" 4 "old people's assoc." 5 "veteran's assoc." 6 "red cross" 7 "fatherland front" 8 "other";


**//A few more specific codes are interspersed within the rename/label coding;

**//RENAME/LABEL;
rename s0bq01 vlss93; label var vlss93 "HH: Interviewed in 92/93?";
rename s0bq02 vlss93cluster; label var vlss93cluster "HH: Cluster Code from 92/93";
rename s0bq021 vlss93hh; label var vlss93hh "HH: HHID from 92/93";
rename vlsscode vlss93idc; label var vlss93idc "HH: IDCODE from 92/93";
rename s1aq02 female; label var female "ID: 0=male, 1=female"; label val female female;
rename s1aq03 reltohead; label var reltohead "ID: Relationship to Head"; label val reltohead reltohead;
rename s1aq05d birthday; label var birthday "ID: Day of birth";
rename s1aq05m birthmonth; label var birthmonth "ID: Month of birth";
rename s1aq05y birthyear; label var birthyear "ID: Year of birth";
rename s1aq06y ageyrs; label var ageyrs "ID: Age, full years";
rename s1aq06m agemos; label var agemos "ID: Age, months, if ageyrs < 10yrs";
rename s1bq01 fatherinhouse; label var fatherinhouse "EDPAR: Is father living in the household? (If yes, skip edfath. questions.)";
rename s1bq02 fatheridcode; label var fatheridcode "EDPAR: IDCODE of father if living in household.";
rename s1bq04 fatherschool; label var fatherschool "EDPAR: Did father attend school?"; 
rename s1bq05 fatheredgrade; replace fatheredgrade = . if fatheredgrade==13; label var fatheredgrade "EDPAR: Father's highest completed grade (0-12)";
rename s1bq06 fatheredpostsec; label var fatheredpostsec "EDPAR: Father's highest completed voc/tech/uni/coll/pg yr (0-16)";
rename s1bq07 comped98father; replace comped98father = . if comped98father==13; label var comped98father "EDPAR: Father's highest diploma, ~=93"; label val comped98father diploma0;
rename s1bq08 fatherwork; label var fatherwork "EMPPAR: Father's work, most of life."; label val fatherwork profession;
rename s1bq09 motherinhouse; label var motherinhouse "EMPPAR: Is mother living in the household? (If yes, skip edmoth. questions.)";
rename s1bq10 motheridcode; label var motheridcode "EMPAR: IDCODE of mother if living in household";
rename s1bq12 motherschool; label var motherschool "ED: Did mother attend school?"; 
rename s1bq13 motheredgrade; replace motheredgrade=. if motheredgrade==13; label var motheredgrade "EDPAR: Mother's highest completed grade (0-12)";
rename s1bq14 motheredpostsec; label var motheredpostsec "EDPAR: Mother's highest completed voc/tech/uni/coll/pg yr (0-16)";
rename s1bq15 comped98mother; replace comped98mother=. if comped98mother==13; label var comped98mother "EDPAR: Mother's highest diploma, ~=93"; label val comped98mother diploma0;
rename s1bq16 motherwork; label var motherwork "EMPPAR: Mother's work, most of life."; label val motherwork profession;

/*OWN EDUCATION VARIABLES*/
rename s2aq02 school; label var school "ED: Attend school ever?";
rename s2aq03 currentattend; label var currentattend "ED: Currently attending school? (If yes, skip to part B)";
rename s2aq04 schoollevel; label var schoollevel "ED: Level of school last attended."; label val schoollevel schoollevel;
rename s2aq05 schooltype; label var schooltype "ED: Which type of school did you complete before voc. school?";
rename s2aq06 edyrspreschool; label var edyrspreschool "ED: How many years did you attend preschool?";
rename s2aq07 edyrspostsec; label var edyrspostsec "ED: How many years did you attend jc, univ, pg school?";
rename s2aq08f diploma1; label var diploma1 "ED: What diplomas did you obtain?"; label value diploma1 diploma1;
rename s2aq08s diploma2; label var diploma2 "ED: Diploma2"; label value diploma2 diploma1;
rename s2aq08t diploma3; label var diploma3 "ED: Diploma3"; label value diploma3 diploma1;
rename s2aq11 upsecdiploma; label var upsecdiploma "ED: Did you graduate from upper secondary school and receive a diploma?";
rename s2aq12 higradepreupsec; label var higradepreupsec "ED: Highest grade completed before quitting upper sec.";
rename s2aq15 lowsecdiploma; label var lowsecdiploma "ED: Did you graduate from lower sec. school and receive a diploma?";
rename s2aq16 higradeprelowsec; label var higradeprelowsec "ED: Highest grade completed before quitting lower sec.";
rename s2aq19 primarydiploma; label var primarydiploma "ED: Did you graduate from primary sch. and receive a diploma?";
rename s2aq20 higradepreprim; label var higradepreprim "ED: Highest grade completed before quitting primary scho.";

rename s2bq01 currentsch; label var currentsch "ED: 2b: Type of school currently attending.";
rename s2bq02 b_edyrspresch; label var b_edyrspresch "ED: 2b: If currently in presch, how many years attended?";
rename s2bq03 b_liveathome; label var b_liveathome "ED: 2b: Live at home while attending sch.?  If no, skip questions.";
rename s2bq07 b_gradeenrolled; label var b_gradeenrolled "ED: 2b: What grade are you currently enrolled in?";
rename s2bq11 b_college; label var b_college "ED: 2b: How many years attending college or univ. before this one?";
rename s2bq12f b_diploma1; label var b_diploma1 "ED: 2b: What diplomas obtained in junior coll. or univ.? Diploma 1"; label value b_diploma1 diploma1;
rename s2bq12s b_diploma2; label var b_diploma2 "ED: 2b: What diplomas obtained in junior coll. or univ.? Diploma 2"; label value b_diploma2 diploma1;
rename s2bq12t b_diploma3; label var b_diploma3 "ED: 2b: What diplomas obtained in junior coll. or univ.? Diploma 3"; label value b_diploma3 diploma1; 
rename s2eq01 abovelowsec; label var abovelowsec "ED: Educ. higher than lower sec.?  If yes, no literate or numerate question.";
rename s2eq02 literate; /*NOTE: LABEL DESCRIBES POST-TRANSFORMATION VAR. SEE BELOW*/ label var literate "ED: Can you read this sentence?"; label val literate literate;

rename s2eq03 numerate; /*NOTE: LABEL DESCRIBES POST-TRANSFORMATION VAR. SEE BELOW*/ label var numerate "ED: Can you do these calculations?";  label val numerate numerate;
rename s3q05 ill4wks; label var ill4wks "HEALTH: Any illness or injury reported in past 4 wks?";
rename s3q06 ill4wks_days; label var ill4wks_days "HEALTH: How many days ill/injured in past 4 wks?";
rename s3q07 ill4wks_daysoff; label var ill4wks_daysoff "HEALTH: How many days unable to do normal activities in past 4wks b/c of illness/injury?";
rename s3q45 hospital12mths; label var hospital12mths "HEALTH: Night in hospital the past 12 months?";
rename s3q46 hospital12mths_days; label var hospital12mths_days "HEALTH: How many nights in hospital in past 12 months?";

rename s4aq08 workedpast7d;  label var workedpast7d "EMP: Have you worked (for pay, at your farm, self-employed) in past 7 days?";
rename s4bq01 mainjob7d; label var mainjob7d "EMP: In past 7 days, what was main job?"; label val mainjob7d profession;
rename s4bq02 industry7d; label var industry7d "EMP: What industry is mainjob connected with?"; label val industry7d industry;
rename s4bq03y yearsinwork7d; label var yearsinwork7d "EMP: How many years have you been doing mainjob7d?";
rename s4bq03m monthsinwork7d; label var yearsinwork7d "EMP: How many months, in addition to yearsinwork (if <=5) have you been doing mainjob7d?";
rename s4bq07 wksworkedlastyear7d; label var wksworkedlastyear7d "EMP: How many weeks in past 12mo did you do mainjob?";
rename s4bq08 seasonal7d; label var seasonal7d "EMP: If wksworkedlast year <40, Is this work seasonal?";
rename s4bq09 daysperwk7d; label var daysperwk7d "EMP: Days per working week usu. worked";
rename s4bq10 hrsperday7d; label var hrsperday7d "EMP: Hours usu. worked per working day";
rename s4bq20 salary7d; label var salary7d "EMP: Did you receive a salary or wage for mainjob7d?";

rename s4aq14 workedpast12mo; label var workedpast12mo "EMP: Have you worked (for pay, at your farm, self-employed) in past 12 mo?";
rename s4dq01 mainjob;  label var mainjob "EMP: If no mainjob7d, but worked past 12mo, what was main job past 12mo?"; label val mainjob profession;
rename s4dq02 industry; label var industry "EMP: (If no mainjob7d) What industry is mainjob connected with?"; label val industry industry;
rename s4dq03 sameasmain; label var sameasmain "EMP: mainjob last 12 mos. same as main in last 7d (=1), as second in last 7d (=2), other job (=3)";
rename s4dq04y yearsinwork; label var yearsinwork "EMP: (If no mainjob7d) How many years have you been doing mainjob?";
rename s4dq04m monthsinwork; label var monthsinwork "EMP: (If no mainjob7d) How many months, in addition to yearsinwork (if yearsinwork<=5), have you been doing mainjob?";
rename s4dq06 wksworkedlastyear; label var wksworkedlastyear "EMP: (If no mainjob7d) How many weeks in past 12mo did you do mainjob?";
rename s4dq12 salary; label var salary "EMP: (If no mainjob7d) Have you ever or will you receive salary or wage for mainjob, inc. pay-in-kind?";

rename s5q01 bornhere; label var bornhere "IMM: Born in current district?";
rename s5q03 provinceborn; label var provinceborn "IMM: What province were you born in?  See province codes.";
rename s5q06 reasonleft; label var reasonleft "IMM: Why did you leave birthplace?";  label val reasonleft whymove;
rename s5q7y yrshere; label var yrshere "IMM: How many years have you lived in current residence?";
rename s5q7m monthshere; label var monthshere "IMM: If yrshere<1, how many months have you lived in current residence?";
rename s5q08 reasoncame; label var reasoncame "IMM: Why came to current residence?"; label val reasoncame whymove;
rename s5q09 provinceprev; label var provinceprev "IMM: What province did you live in immediately before current residence?";
rename s6aq02 dwellingshared; label var dwellingshared "HOUSE: Does your hh share dwelling with another?";
rename s6bq01 dwellingowned; label var dwellingowned "HOUSE: Does a member of your hh own all or part of dwelling? 0=none,1=part,2=all";
rename s6bq17 watersource_cookdrink; label var watersource_cookdrink "HOUSE: Main source cook/drink water?";  label val watersource_cookdrink watersource;
rename s6bq21a watersource_cookdrink_dist; label var watersource_cookdrink_dist "HOUSE: How far is watersource_cookdrink? Units: see watersource_cookdrink_distunit";
rename s6bq21u watersource_cookdrink_distunit; label var watersource_cookdrink_distunit "HOUSE: 1=meters, 2=kilometers";
rename s6bq25 watersource_laundbath; label var watersource_laundbath "HOUSE: Main source laundry/bathing water?"; label val watersource_laundbath watersource;
rename s6bq26a watersource_laundbath_dist; label var watersource_laundbath_dist "HOUSE: How far is watersource_laundbath? Units: see watersource_laundbath_distunit";
rename s6bq26u watersource_laundbath_distunit; label var watersource_laundbath_distunit "HOUSE: 1=meters, 2=kilometers";
rename s6bq31 toilettype; label var toilettype "HOUSE: Type of toilet?";  label val toilettype toilettype;
rename s6bq33 lightingsource; label var lightingsource "HOUSE: Main source of lighting?";  label val lightingsource lightingsource;

**//rename s15yrs ageyrs_s15;
**//rename s15mth agemth_s15;
**//rename s15q01 sex_s15;
rename s15q02 pregnant;
rename s15q03d daymeas;
rename s15q03m momeas;
rename s15q03y yrmeas;
rename s15q04 armcirc;
rename s15q05 height;
rename s15q06 standing;
rename s15q07 weight;
rename s15q08 whynomeas;



**//VARIABLES ORIGINALLY IN THE "MOREVARS98" FILE;
rename s9a1q04 landarea_crop;
rename s9a1q05 irrarea_crop;
rename wtdqualitycrop quality_crop;
rename s9a2q03 landarea_other;
rename s9a2q04 irrarea_other;
rename wtdqualityother quality_other;
rename s9a3q03 landarea_rentin;
rename s9a3q04 irrarea_rentin;
rename wtdqualityrentin quality_rentin;
rename s9a4q05 landarea_rentout;
rename s9a4q06 irrarea_rentout;
rename wtdqualityrentout quality_rentout;
rename  s4aq09 lookedforwork;
rename  s4aq10 stablejob;
rename  s4aq11 whynowork;
rename  s4aq12 whynolook;
rename s4dq10 selfemp;
rename  s4dq11 workfor;

rename  s4eq01 secjob;
rename  s4eq02 secindustry;
rename  s4eq03 secsameasmain;
rename  s4eq09 secselfemp;
rename  s4eq10 secworkfor;
rename  s4eq11 secsalary;

rename s4cq01 secjob7d; 
rename s4cq02 secindustry7d;
rename s4cq03y secyearsinwork7d;
rename s4cq03m secmonthsinwork7d;
rename s4cq12 secworkfor7d;
rename s4cq14 secsalary7d;


rename  s4hq08f org1;
rename  s4hq08s org2;
rename  s4hq08t org3;
rename  s9a1q01 agr_activity;
rename  s9a1q02 cropland;
rename  s9a2q01 otherland;
rename s9a3q01 rentinland;
rename s9a4q01 rentoutland;

label var househol "HH: Household";
label var idcode "idcode";
label var landarea_crop "total area of all cropland owned and used";
label var irrarea_crop "irrigated area of all cropland owned and used";
label var quality_crop "Wtd (by land area) average quality of cropland owned and used";
label var  landarea_other "total area of other land owned and used";
label var  irrarea_other "Irrigated area of other land owned and used";
label var  quality_other "Wtd (by land area) average quality of other land owned and used";
label var  landarea_rentin "Total area of all cropland rented in and used";
label var  irrarea_rentin "Total irrigated area of all cropland rented in and used";
label var  quality_rentin "Wtd  (by land area) average quality of all cropland rented in and used";
label var  landarea_rentout "Total area of all cropland rented out";
label var  irrarea_rentout "Irrigated area of all cropland rented out";
label var  quality_rentout "Wtd (by land area) average quality of all area rented out";

label var lookedforwork "Have you looked for work in the past 7 days?";
label var stablejob "Stable job even though you didn't work last 7 days?";
label var whynowork "Why didn't you work at your stable job for the last 7 days?";
label var whynolook "Why did you not look for work in the past 7 days?";
label var selfemp "Were you self employed?";
label var workfor "Employer (govt, state, Private enterprise, etc.)";

label var secjob "Secondary job, past 12 months?";
label var secindustry "Industry of secjob (last 12 months)";
label var secsameasmain "Is secjob last 12 mos. the same as main (=1) or secondary (=2) job in last 7 days? (if yes, skip ahead)";
label var secselfemp "Were you self-employed in secondary job (last 12 months)?";
label var secworkfor "If not self employed, for whom did you work in secondary job (last 12 months)?";
label var secsalary "Have you received a salary, or other pay for secondary job (last 12 months)?";

label var secjob7d "Secondary job, last 7 days";
label var secindustry7d "Industry of secjob7d";
label var secyearsinwork7d "Years doing secjob7d";
label var secmonthsinwork7d "Months doing secjob7d (if years <=5)";
label var secworkfor7d "If not self employed, for whom did you work in secondary job (last 7 days)?";
label var secsalary7d "Have you received a salary, or other pay for secondary job (last 7 days)?";


label var org1 "Organization belonged to? (Org. 1)";
label var org2 "Organization belonged to? (Org. 2)";
label var org3 "Organization belonged to? (Org. 3)";
label var agr_activity "Agr, forestry activities in last 12 months?";
label var cropland "HH member worked on annual crop land belonging to HH?";
label var otherland "Any other land used by HH member? (other land used)";
label var rentinland "Has HH rented or borrowed land, last 12 months?";
label var rentoutland "Has HH rented/lent out land in past 12 months?";
label var numplots_crop "number of plots owned used for cropland";
label var numplots_other "number of plots owned used for other";
label var numplots_rentin "number of plots rented in";
label var numplots_rentout "number of plots rented out - if rented < 12 months, could overlap with other numplots vars";


label var pregnant "pregnant=1 breastfeeding=2 other=3";
label var daymeas "day measured";
label var momeas "month measured";
label var yrmeas "year measured";
label var armcirc "arm circumference in cm";
label var height "height in cm";
label var standing "Was height measured standing or lying down?";
label var weight "weight in kg";
label var whynomeas "Reason not measured?";


label val whynowork whynowork;
label val whynolook whynolook;
label val workfor workfor;
label val secworkfor workfor;
label val org1 org;
label val org2 org;
label val org3 org;



**//REPLACING {1,2} binary vars with {0,1} binary vars;
foreach var in vlss93 fatherschool motherschool school ill4wks hospital12mths workedpast12mo salary salary7d secsalary7d bornhere dwellingshared {;
replace `var'=0 if `var'==2;};
replace female=0 if female==1; replace female=1 if female==2;
replace sex_head=0 if sex_head==1; replace sex_head=1 if sex_head==2; rename sex_head sex_head_female;

replace lookedforwork = 0 if lookedforwork ==2;
replace stablejob = 0 if stablejob ==2;
replace selfemp = 0 if selfemp ==2;
replace secselfemp = 0 if secselfemp ==2;
replace secsalary = 0 if secsalary ==2;
replace agr_activity = 0 if agr_activity ==2;
replace cropland = 0 if cropland ==2;
replace otherland = 0 if otherland ==2;
replace rentinland = 0 if rentinland ==2;
replace rentoutland = 0 if rentoutland ==2;


**//CREATING NEW VARIABLES FOR '98;
**//Generating new variables/dummies;
/*ETHNICITY DUMMIES*/
gen dkinh = 1 if tribe ==1; replace dkinh = 0 if dkinh ==.; label var dkinh "1 if tribe = kinh (1)";
gen dtay =1 if tribe ==2; replace dtay =0 if dtay ==.; label var dtay "1 if tribe = tay (2)";
gen dthai = 1 if tribe ==3; replace dthai = 0 if dthai ==.; label var dthai "1 if tribe = thai (3)";
gen dchinese = 1 if tribe ==4; replace dchinese = 0 if dchinese ==.; label var dchinese "1 if tribe = chinese (4)";
gen dkhmer =1 if tribe ==5; replace dkhmer = 0 if dkhmer ==.; label var dkhmer "1 if tribe = khmer (5)";
gen dmuong = 1 if tribe ==6; replace dmuong = 0 if dmuong ==.; label var dmuong "1 if tribe = muong (6)";
gen dnung = 1 if tribe ==7; replace dnung = 0 if dnung ==.; label var dnung "1 if tribe = nung (7)";
gen dotherrace = 1 if tribe !=1 & tribe !=2 & tribe !=3 & tribe !=4 & tribe !=5 & tribe !=6 & tribe !=7 ; replace dotherrace=0 if dotherrace==.; label var dotherrace "1 if tribe != 1 thru 7";

/*DISABLED AND VETERAN DUMMIES*/
gen disabled = 1 if whynolook ==2;
replace disabled = 0 if disabled ==.;
label var disabled "1 if whynolook ==2 (disabled)";

gen vetassoc = 1 if (org1 ==5 | org2 ==5 | org3 ==5); replace vetassoc = 0 if vetassoc ==.; label var vetassoc "1 if person belongs to a veteran's assoc.";

/*DUMMIES FOR OTHER NON-BINARY VARIABLES*/
gen dliterate_all = 1 if literate ==1;
replace dliterate_all=1 if abovelowsec ==1; /*Literacy question not asked if a person has above lower sec. education*/
replace dliterate_all=0 if dliterate_all==.;
label var dliterate_all "1 if person can read given sentence with no difficulty";

gen delectricity = 1 if lightingsource ==1;
replace delectricity = 0 if delectricity ==.;
label var delectricity "1 if lightingsource is electricity";

gen dflushtoilet = 1 if toilettype ==1;
replace dflushtoilet=0 if dflushtoilet ==.;
label var dflushtoilet "1 if toilettype is flush w/septic sewage";

gen dnumerate = 1 if numerate ==1;
replace dnumerate = 0 if dnumerate ==.;
label var dnumerate "1 if person can do given calculations with no difficulty";

gen dnumerate_all = 1 if numerate ==1;
replace dnumerate_all = 1 if abovelowsec==1;/*Numeracy question not asked if a person has above lower sec. education*/
replace dnumerate_all = 0 if dnumerate_all==.;
label var dnumerate_all "1 if person can do given calculations with no difficulty";

**//DO YOU LIKE THIS CODING OF LITERACY/NUMERACY/DWELLING OWNED? (Note: literate_all, above, is binary - probably more useful);
replace dwellingowned=0 if dwellingowned==3; replace dwellingowned=.5 if dwellingowned==2; replace dwellingowned=2 if dwellingowned==1; replace dwellingowned=1 if dwellingowned==.5;
replace literate=0 if literate==3; replace literate=.25 if literate==4; replace literate=3 if literate==1; replace literate=1 if literate==.25;
replace numerate=0 if numerate==3; replace numerate=0.5 if numerate==2; replace numerate=2 if numerate==1; replace numerate=1 if numerate==0.5;



/*BETTER VARIABLES FOR WORKING PAST 12 MONTHS*/

gen workedpast12mo_all = workedpast12mo;
replace workedpast12mo_all = 1 if workedpast7d ==1;
label var workedpast12mo_all "=1 if workedpast12mo = 1 or workedpast7d ==1";

/*PRIMARY JOB*/
/*Mainjob & industry are answered for last 12 months whether or not person has a job in last 7 days*/

/*Yearsinwork is only answered for the last 12 months if the mainjob in the last 12 months is not the same as that in the last 7 days*/
gen yearsinwork_all = yearsinwork;
replace yearsinwork_all = yearsinwork7d if sameasmain ==1; /*if mainjob in last 12 mos is same as mainjob in last 7 days*/
replace yearsinwork_all = secyearsinwork7d if sameasmain ==2;/*if mainjob in last 12 mos is same as secjob in last 7 days*/
label var yearsinwork_all "yearsinwork, or yearsinwork7d (secyearsinwork7d) if sameasmain==1 (2)";

gen monthsinwork_all = monthsinwork;
replace monthsinwork_all = monthsinwork7d if sameasmain==1;/*if mainjob in last 12 mos is same as mainjob in last 7 days*/
replace monthsinwork_all = secmonthsinwork7d if sameasmain ==2;/*if mainjob in last 12 mos is same as secjob in last 7 days*/
label var monthsinwork_all "monthsinwork, or monthsinwork7d (secmonthsinwork7d) if sameasmain==1 (2)";

gen salary_all = salary;
replace salary_all = salary7d if sameasmain ==1;/*if mainjob in last 12 mos is same as mainjob in last 7 days*/
replace salary_all = secsalary7d if sameasmain ==2;/*if mainjob in last 12 mos is same as secjob in last 7 days*/
label var salary_all "salary, or salary7d (secsalary7d)  if sameasmain ==1 (2)";

/*SECONDARY JOB*/
gen secsalary_all = secsalary;
replace secsalary_all = salary7d if secsameasmain ==1;/*if secjob in last 12 mos is same as mainjob in last 7 days*/
replace secsalary_all = secsalary7d if secsameasmain ==2;/*if secjob in last 12 mos is same as secjob in last 7 days*/
label var secsalary_all "secsalary, or salary7d (secsalary7d)  if secsameasmain ==1 (2)";


/*DUMMY FOR RECEIVING A SALARY*/
gen anysalary_all = 1 if salary_all ==1;
replace anysalary_all = 1 if secsalary_all==1;
replace anysalary_all = 0 if anysalary_all ==.;
label var anysalary_all "1 if person receives salary, main or sec. job (past 12 mos.,complete), 0=no job or no salary.";


/*ILLNESS VARIABLES*/
gen avg_ill4wks=ill4wks*ill4wks_days; 
replace avg_ill4wks = 0 if ill4wks ==0;
label var avg_ill4wks "ill4wks*ill4wks_days (no. days ill in past 4 weeks); 0 if ill4wks = 0";

gen avg_hospital12mths=hospital12mths*hospital12mths_days; 
replace avg_hospital12mths=0 if hospital12mths ==0;
label var avg_hospital12mths "hospital12mths*hospital12mths_days (number of days in hospital in last 12 mos), 0 if hospital12mths==0";

/*EDUC VARIABLES*/
/***********************/
gen educyrself = .;

**//if schoollevel ==1 {; /*last attended pre-school*/
  replace educyrself = 0 if schoollevel==1; /*counting pre-school as zero years of schooling*/
  

**//if schoollevel ==2 {; /*last attended primary school*/
  **//if primarydiploma == 1|2{; /*finished primary w/ or w/o diploma */
    replace educyrself = 5 if schoollevel ==2 & primarydiploma == 1|2; /*highest primary grade*/
     replace educyrself = higradepreprim if schoollevel ==2 & primarydiploma != 1|2;

**//if schoollevel ==3 {; /*last attended lower secondary school*/
 **// if lowsecdiploma ==1|2 {; /*finished lower secondary w/ or w/o diploma*/
    replace educyrself = 9 if schoollevel ==3 & lowsecdiploma ==1|2; /*highest lower secondary grade*/
    replace educyrself = higradeprelowsec if schoollevel ==3 & lowsecdiploma !=1|2;

**//if schoollevel ==4 {;/*last attended upper secondary school*/
  **//if upsecdiploma == 1|2 {; /*finished upper secondary w/ or w/o diploma*/
    replace educyrself = 12 if schoollevel ==4 & upsecdiploma ==1|2; /*highest uppse secondary grade*/
      replace educyrself = higradepreupsec if schoollevel ==4 & upsecdiploma !=1|2;
  
**//if schoollevel ==5 {; /*last attended vocational school */
  **//if schooltype == 2 {; /*if attended primary school before vocational school*/
    **//if primarydiploma == 1|2{; /*finished primary w/ or w/o diploma */
        replace educyrself = 5 if schoollevel ==5 & schooltype ==2 & primarydiploma ==1|2; /*highest primary grade*/
        replace educyrself = higradepreprim if schoollevel ==5 & schooltype ==2 & primarydiploma !=1|2;
  
  **//if schooltype ==3 {; /*if attended lower sec. before vocational school*/
        **//if lowsecdiploma ==1|2 {; /*finished lower secondary w/ or w/o diploma*/
        replace educyrself = 9 if schoollevel ==5 & schooltype ==3 & lowsecdiploma ==1|2; /*highest lower secondary grade*/
            replace educyrself = higradeprelowsec if schoollevel ==5 & schooltype ==3 & lowsecdiploma !=1|2;
        
  **//if schooltype ==4 {; /*if attended upper sec before vocational school*/
    **//if upsecdiploma == 1|2 {; /*finished upper secondary w/ or w/o diploma*/
        replace educyrself = 12 if schoollevel ==5 & schooltype ==4 & upsecdiploma ==1|2; /*highest uppse secondary grade*/
          replace educyrself = higradepreupsec if schoollevel ==5 & schooltype ==4 & upsecdiploma !=1|2;
      
  **//if schooltype ==5 {; /*if attended university before vocational school*/
    replace educyrself = 12 if schoollevel ==5 & schooltype ==5; /*must have also completed the highest grade of upper secondary school*/

**//if schoollevel ==6 {; /*last attended university*/
   replace educyrself = 12 if schoollevel ==6; /*must have also completed highest grade of upper secondary*/

gen edgrade = educyrself;
label var edgrade "ED: Highest grade completed, 98";

replace educyrself = educyrself + edyrspostsec if edyrspostsec !=.;
label var educyrself "ED: edgrade + years in jr. coll., univ, or grad. - no vocational sch. incl.";

/*See also Minot's comped98_head variable, with codes: label define diploma 0 Never 1 "Nhatre = Kindergarten" 
    2 "<cap I = <primary" 3 "Cap I = Primary" 4 "Cap II = Lower Sec" 5 "Cap III = Higher Sec" 6 "Nghe SC = Voc Training" 
    7 "THCN = Secondary Voc Training" 8 DHDC 9 "DHCD = Bachelors" 10 "Thac sy = Masters" 11 "PTS = PhD Candidate" 
    12 "TS = PhD", modify; */

/*This variable is currently only created for household head*/



/************************/

/*PARENT EDUC VARIABLES: See also comped98father and comped98mother, which has completed degree*/
gen educyr98father=fatheredgrade + fatheredpostsec; /*fatheredgrade = . for fatheredgrade = 13 (DK)*/
label var educyr98father "EDPAR: Father's yrs school = fatheredgrade+fatheredpostsec (fatheredgrade=13(dk) removed), ~=93";

gen educyr98father_comp = educyr98father;
replace educyr98father_comp = 22 if educyr98father >22; /*to make comparable to '93*/
label var educyr98father_comp "EDPAR: Father's yrs sch = fatheredgrade+fatheredpostsec, no postsec above U/C7, comp. to '93";

gen educyr98mother=motheredgrade + motheredpostsec; /*motheredgrade = . for motheredgrade = 13 (DK)*/
label var educyr98mother "EDPAR: Mother's yrs school = motheredgrade+motheredpostsec, ~=93";

gen educyr98mother_comp = educyr98mother;
replace educyr98mother_comp = 22 if educyr98mother >22; /*to make comparable to '93*/
label var educyr98mother_comp "EDPAR: Mother's yrs sch = motheredgrade+motheredpostsec, no postsec above U/C7";

/*DWELLING DUMMIES (see also dwellingshared = 1 if shared)*/
gen ddwellingfullyowned = 1 if dwellingowned ==2;
replace ddwellingfullyowned = 0 if ddwellingfullyowned == .;
label var ddwellingfullyowned "1 if dwellingowned ==2 (fully owned)";

gen ddwellingpartowned = 1 if dwellingowned ==1;
replace ddwellingpartowned = 0 if ddwellingpartowned ==.;
label var ddwellingpartowned "1 if dwellingowned ==1 (part owned)";


/* GENERATE FRACTION OF OWN LAND IRRIGATED */;
gen irr_frac_old = (irrarea_crop+irrarea_other)/(landarea_crop+landarea_other);
label var irr_frac_old "Proportion own land irrigated 1998";

gen irr_frac = (irrarea_crop/landarea_crop);
label var irr_frac "Proportion own cropland irrigated 1998";


save hhvlss98.dta, replace;


**//Collapse to get number of people in hh with a salaried job;
collapse (sum) anysalary_all (count) idcode, by(househol);
rename idcode hhnum;
rename anysalary_all numanysalary_all;
label var numanysalary_all "number in hh with any salaried job (main or secondary)";
gen salaryfrac_all = numanysalary_all/hhnum;
label var salaryfrac_all "fraction in hh with salaried job (main or secondary)";
drop hhnum;
sort househol;
save collapse_salaried.dta, replace;

/*MERGING INTO HHVLSS98*/
use hhvlss98.dta;
sort househol;
merge househol using collapse_salaried.dta;
drop _merge;
save hhvlss98.dta, replace;


cd ..\..\..;
save hhvlss98.dta, replace; /*SAVING HHVLSS98 IN THE MAIN FILE.*/
cd VLSS98\DATA\HOUSEHOLD;
erase hhvlss98.dta;

**//Generate district codes for observations that don't have them;
cd ..\..\..; 
use comVLSSmatch.dta;
rename districtcode district;
keep district commune communecode;/*Note that communecode can be compared to that created in '02*/
sort commune;
save comVLSSmatch_temp.dta, replace;

use hhvlss98.dta;
sort commune;
merge commune using comVLSSmatch_temp.dta, nokeep;
label var communecode "Province: 1st 3 dig. District: 1st 5 dig. Commune: All dig.";
gen province =  int(communecode/10000);
label var province "int(communecode/10000), for collapsing";
drop _merge;

erase comVLSSmatch_temp.dta; 

sort vlss93cluster vlss93hh vlss93idc;
save hhvlss98.dta, replace;





/*****************************************************************************************************************************************/
**//GET ALL RELEVANT VARIABLES IN '93;
/*GET INTO CORRECT FILE*/
cd VLSS9293;

**//PREPARE FILES FOR MERGING;
use SCR041;
drop in 12780; /*this appears to be a duplicate observation of 12779*/;
drop if ln == (1|4|8); /*these categories are sums of the other ones, e.g. land area with quality = 1 is the sum of that with quality = 2 or 3*/
egen totplotland = sum( s9q29b), by(hholdno); /*total plot land*/;
gen qualitywgt = s9q29b/totplotland;
gen wtdquality93 = ln* qualitywgt;
collapse (sum)  s9q29b s9q29c wtdquality93, by(hholdno);
save 9A1_cropland93.dta, replace;


/*SORT FILES TO MERGE BY HHOLDNO AND IDC*/
foreach x in SCR004 SCR005 SCR008 SCR011 SCR012 SCR013 SCR014 SCR017 SCR018 SCR019 SCR020 SCR024 SCR026 {;
use `x'.dta;
sort hholdno idc;
save `x'_temp.dta, replace;
};


/*base file*/
use SCR004_temp.dta;

/*merge files by hholdno and idc*/
foreach x in SCR005 SCR008 SCR011 SCR012 SCR013 SCR014 SCR017 SCR018 SCR019 SCR020 SCR024 SCR026  {;
merge hholdno idc using `x'_temp.dta;
drop _merge;
sort hholdno idc;
save hhvlss93.dta, replace;
erase `x'_temp.dta;
};

erase SCR004_temp.dta;


/*SORT FILES TO MERGE BY HHOLDNO ONLY*/
foreach x in 9A1_cropland93 SCR001 SCR027 SCR028 SCR030 SCR037 SCR038 SCR039 {;
use `x'.dta;
sort hholdno;
save `x'_temp.dta, replace;
};

/*base file*/
use hhvlss93.dta;
sort hholdno;

/*MERGE FILES BY HHOLDNO (NO IDC FOR THESE FILES)*/
foreach x in 9A1_cropland93 SCR001 SCR027 SCR028 SCR030 SCR037 SCR038 SCR039 {;
merge hholdno using `x'_temp.dta;
sort hholdno;
drop _merge;
save hhvlss93.dta, replace;
erase `x'_temp.dta;
};


**//KEEP ONLY "POSSIBLE OUTCOME MEASURES" ;
keep hholdno idc s1aq02    s1aq03 s1aq06y s1bq04 s1bq05 s1bq06 s1bq07 s1bq11 s1bq12 s1bq13 s1bq14 s1bq15 s1bq16 s2q05 s2q06 s2q07 s2q08 s2q01 s2q02 
    s3q01 s3q05 s3q06 s5q01 s5q03 s5q06 s5q07y s5q07m s5q08 s5q09 
    s6aq02 s6bq01
    s6bq27 s6bq29 tribe 
    s4aq08  s4aq09 s4aq12 s4aq14 
    s4bq01 s4bq02 s4bq05 s4bq06 s4bq07y s4bq07m s4bq16
    s4cq01 s4cq02 s4cq07y s4cq07m s4cq09 s4cq10 
    s4dq01 s4dq02
    s4eq01    s4eq02    s4eq03 s4eq07y    s4eq07m    s4eq04    s4eq08    s4eq09    s4eq15    
    s4gq01    s4gq02    s4gq03    s4gq07    s4gq08    s4gq09
    s9q1    s9q4    s9q5a    s9q5b    s9q17    s9q6a    
    s9q6b    s9q11 s9q12 s9q18 s9q29b s9q29c wtdquality93;



**//order [insert variables here in desired order];


**//RENAME;
rename s1aq02 female93;
rename s1aq03 reltohead93;
rename s1aq06y ageyrs93;
rename s1bq04 fatherschool93;
rename s1bq05 fatheredgrade93;
rename s1bq06 fatheredpostsec93;
rename s1bq07 compedfather93;
rename s1bq11 fatherwork93;
rename s1bq12 motherschool93;
rename s1bq13 motheredgrade93;
rename s1bq14 motheredpostsec93;
rename s1bq15 compedmother93;
rename s1bq16 motherwork93;
rename s2q05 school93;
rename s2q06 edgrade93;
rename s2q07 edyrspostsec93;
rename s2q08 diploma93;
rename s2q01 literate93;
rename s2q02 numerate93;
rename s3q01 ill4wks93;
rename s3q05 ill4wks_days93;
rename s3q06 ill4wks_daysof93;
rename s5q01 bornhere93;
rename s5q03 provinceborn93;
rename s5q06 reasonleft93;
rename s5q07y yrshere93;
rename s5q07m monthshere93;
rename s5q08 reasoncame93;

rename s5q09 provinceprev93;
rename s6bq27 toilettype93;
rename s6bq29 lightingsource93;
rename s6aq02 dwellingshared93;
rename s6bq01 dwellingowned93;


rename tribe tribe93;
rename s4aq08 workedpast7d93;
rename s4aq09 lookedforwork93;
rename s4aq12 whynolook93;
rename s4aq14 workedpast12mo93;
rename s4bq01 mainjob7d93;
rename s4bq02 industry7d93;
rename s4bq05 wksworkedlastyear7d93;
rename s4bq06 hrsperwk7d93;
rename s4bq07y yearsinwork7d93;
rename s4bq07m monthsinwork7d93;
rename s4bq16 salary7d93;
rename s4cq01 secjob7d93;
rename s4cq02 secindustry7d93; 
rename s4cq07y secyearsinwork7d93; 
rename s4cq07m secmonthsinwork7d93;
rename s4cq09 secworkfor7d93; 
rename s4cq10 secsalary7d93; 
rename s4eq01 mainjob93;
rename s4eq02 industry93;
rename s4eq03 sameasmain93;
rename s4eq07y yearsinwork93;
rename s4eq07m monthsinwork93;
rename s4eq04 wksworkedlastyear93;
rename s4eq08 selfemp93;
rename s4eq09 workfor93;
rename s4eq15 salary93;
rename s4gq01 secjob93;
rename s4gq02 secindustry93;
rename s4gq03 secsameasmain93;
rename s4gq07 secselfemp93;
rename s4gq08 secworkfor93;
rename s4gq09 secsalary93;


rename s9q1 agr_activity93;
rename s9q4 cropland93;
rename s9q5a allocated_crop93;
rename s9q5b longterm_crop93;
rename s9q17 owned_crop93;
rename s9q6a allocated_crop_irr93;
rename s9q6b longterm_crop_irr93;
rename s9q18 owned_crop_irr93;
rename s9q29b farmed_crop93;
rename s9q29c farmed_crop_irr93;
rename s9q11 auctioned_crop93;
rename s9q12 auctioned_crop_irr93;

/* CHECK THE CODING FIRST - CAN'T FIGURE OUT THE QUESTION NUMBERS*/
/*rename s15q02 pregnant;
rename s15q03d daymeas;
rename s15q03m momeas;
rename s15q03y yrmeas;
rename s15q04 armcirc;
rename s15q05 height;
rename s15q06 standing;
rename s15q07 weight;
rename s15q08 whynomeas;
*/

**//LABELS;
label var female93 "ID: 0=male, 1=female ";
label var reltohead93 "ID: Relationship to Head ";
label var ageyrs93 "ID: Age, full years ";
label var fatherschool93 "EDPAR: Did father attend school? ";
label var fatheredgrade93 "EDPAR: Father's highest completed grade (0-12)"; replace fatheredgrade93=. if fatheredgrade93==13;
label var fatheredpostsec93 "EDPAR: Father's highest completed voc/tech/uni/coll/pg yr: only goes up to 10 (no masters or PhD) [~=98]";
label var compedfather93 "EDPAR: Father's highest diploma  ";
label var fatherwork93 "EMPPAR: Father's work, most of life. ";
label var motherschool93 "ED: Did mother attend school? ";
label var motheredgrade93 "EDPAR: Mother's highest completed grade (0-12)"; replace motheredgrade93=. if motheredgrade93==13;
label var motheredpostsec93 "EDPAR:Mother's highest completed voc/tech/uni/coll/pg yr: only goes up to 10 (no masters or PhD) [~=98]";
label var compedmother93 "EDPAR: Mother's highest diploma  ";
label var motherwork93 "EMPPAR: Mother's work, most of life. ";

label var school93 "ED: Attend school now or ever? [approx. = '98]";
label var edgrade93 "ED: Highest grade completed (1-12)";
label var edyrspostsec93 "ED: How many years did you attend jc, univ, pg school? ";
label var diploma93 "ED: Highest Diploma or Degree obtained? [~=98]";

label var literate93 "ED: Can person read/write? [~=98]";
label var numerate93 "ED: Can person do written calculations? [~=98]";
label var ill4wks93 "HEALTH: Any illness or injury reported in past 4 wks? ";
label var ill4wks_days93 "HEALTH: How many days ill/injured in past 4 wks? ";
label var ill4wks_daysof93 "HEALTH: How many days unable to do normal activities in past 4wks b/c of illness ";
label var bornhere93 "IMM: Born in current district? ";
label var provinceborn93 "IMM: What province were you born in?  See province codes. ";
label var reasonleft93 "IMM: Why did you leave birthplace? ";
label var yrshere93 "IMM: How many years have you lived in current residence? ";
label var monthshere93 "IMM: If yrshere<1, how many months have you lived in current residence? ";
label var reasoncame93 "IMM: Why came to current residence? [approx. = '98]";
label var provinceprev93 "IMM: What province did you live in immediately before current residence? ";
label var toilettype93 "HOUSE: Type of toilet? ";
label var lightingsource93 "HOUSE: Main source of lighting? "; 
label var dwellingshared93 "HOUSE: Does household share dwellingn nwith another household?";
label var dwellingowned93 "HOUSE: Does this dwelling belong to a member of your household?";


/*VARIABLES ORIGINALLY FROM MOREVARS_93*/
label var tribe93 "Ethnic group of head??";

label var workedpast7d93 "EMP: Have you worked (for pay, at your farm, self-employed) in past 7 days?";
label var lookedforwork93 "Have you looked for work in the past 7 days?";
label var whynolook93 "Why did you not look for work in the past 7 days?";
label var workedpast12mo93 "EMP: Have you worked (for pay, at your farm, self-employed) in past 12 months?";
label var mainjob7d93 "EMP: In past 7 days, what was main job?";
label var industry7d93 "EMP: What industry is mainjob connected with?";
label var wksworkedlastyear7d93 "EMP: How many weeks in past 12mo did you do mainjob?";
label var hrsperwk7d93 "EMP: Hours usu. worked per working day";
label var yearsinwork7d93 "EMP: How many years have you been doing mainjob7d?";
label var monthsinwork7d93 "EMP: How many months, in addition to yearsinwork (if <=5) have you been doing mainjob7d?";
label var salary7d93 "EMP: Did you receive a salary or wage for mainjob7d?";
label var secjob7d93 "EMP: Secondary job, last 7 days";
label var secindustry7d93 "EMP: Industry of secjob7d" ; 
label var secyearsinwork7d93 "EMP: Years of doing secjob7d93"; 
label var secmonthsinwork7d93 "EMP: Months doingn secjob7d93 (if years <=5)";
label var secworkfor7d93 "EMP: If not self employed, for whome did you work in secjob7d93?"; 
label var secsalary7d93 "EMP: Have you received money or value in kind for this work?"; 
label var mainjob93 "EMP: Main job past 12 months";
label var industry93 "EMP: Industry of mainjob93";
label var sameasmain93 "EMP: main past 12 mos. same as main in last 7d (=1), as second in last 7d (=2), other job (=3)" ;
label var yearsinwork93 "Total amt of time doing mainjob93 - yrs";
label var monthsinwork93 "Total amt of time doing mainjob93 - mths";
label var wksworkedlastyear93 "Wks in past 12 mos worked at mainjob93";
label var selfemp93 "In mainjob93, self-employed in non-farm business belonging to HH?";
label var workfor93 "Mainjob93 employer (govt, state, Private enterprise, etc.) last 12 mos [ ~=98]";
label var salary93 "Do you receive salary for mainjob93?";
label var secjob93 "Secondary job, past 12 months?";
label var secindustry93 "Industry of second job";
label var secsameasmain93 "Is secjob past 12 mos. the same as main (=1) or sec. job (=2) in last 7 days? (if yes, skip ahead)";
label var secselfemp93 "Were you self-employed in secondary job?";
label var secworkfor93 "If not self employed, for whom did you work in secondary job (last 12 months) [~=98]?";
label var secsalary93 "Have you received a salary, or other pay for secondary job (last 12 months)?";


label var agr_activity93 "Has any HH member had the right to any land?";
label var cropland93 "HH member worked on annual crop land belongingn to HH?";
label var allocated_crop93 "How much of crop land is allocated?";
label var longterm_crop93 "How much of crop land is for long term use?";
label var owned_crop93 "How many square m. of private annual crop land are owned by HH?";
label var allocated_crop_irr93 "How much of crop land is irrigated? (allocated land)";
label var longterm_crop_irr93 "How much of crop land is irrigated? (land for long term use)";
label var owned_crop_irr93 "How many square m. of private annual crop land are irrigated?";
label var farmed_crop93 "Sum of How much of the crop land is of quality type ___? over all types.";
label var farmed_crop_irr93 "Sum of How many square meters of this land are irrigated? over all types.";
label var wtdquality93 "Wtd. (by land area) sum of quality rating of land farmed by household.";
label var auctioned_crop93 "How many square m. of annual crop land is auctioned?";
label var auctioned_crop_irr93 "How many square m. of auctioned annual crop land is irrigated?";


/* CHECK THE CODING FIRST - CAN'T FIGURE OUT THE QUESTION NUMBERS*/
/*label var pregnant93 "pregnant=1 breastfeeding=2 other=3";
label var daymeas93 "day measured";
label var momeas93 "month measured";
label var yrmeas93 "year measured";
label var armcirc93 "arm circumference in cm";
label var height93 "height in cm";
label var standing93 "Was height measured standing or lying down?";
label var weight93 "weight in kg";
label var whynomeas93 "Reason not measured?";
*/


**//CREATE CODES;
/*FOR FEMALE*/
label define female93 0 male 1 female; 
/*FOR RELTOHEAD - diff from '98*/
label define reltohead93 1 head 2 spouse 3 child 4 grandch 5 "niece/nephew" 6 parent 7 sibling 8 "child-in-law" 9 "sibling-in-law" 10 grandpar 11 "parent-in-law" 12 "other relative" 13 "servant or rel. of serv." 14 "tenant or rel. of ten." 15 "other, not related"; 
/*MOTHER and FATHER COMPED - diff from '98*/
label define diploma093 0 none 1 prim 2 lowsec 3 hisec 4 tech.worker 5 highsch 6 undergrad 7 mast 8 "sub-doc" 9 phd; 
/*PROFESSION CODES*/
**//label define profession 10 leader 20 professional 30 professional 40 professional 50 "personal-svc/protection/sales" 60 "agro/for/fish" 70 skillmanual 80 "assemb/machinist" 90 unskill 99 "other(inc.gen-militar)"; 
/*FOR SCHOOLLEVEL*/
**//label define schoollevel 1 pre 2 prim 3 lowsec 4 hisec 5 voc 6 univ; 
/*FOR OWN EDUC - diff from '98*/
label define diploma193 0 none 1 prim 2 lowsec 3 hisec 4 tech.worker 5 highsch 6 undergrad 7 mast 8 "sub-doc" 9 phd; 
/*FOR LITERATE - diff from '98*/
label define literate93 3 "neither" 2 "read only" 1 "both"; 
/*FOR NUMERATE - diff from '98*/
label define numerate93 2 "no" 1 "yes";
/*INDUSTRY CODES*/
**//label define industry 1 agro 10 mine 15 industry 20 industry 30 industry 40 "elec/water/construction" 50 commerce 60 "trans/comm" 65 finance 70 othersvc 80 othersvc 90 othersvc; 
/*TOILETTYPE*/
label define toilettype93 1 "flush w/ septic/sewage" 2 "double vault compost latrine" 3 simple 4 "toilet directly over water" 5 other 6 "no toilet";
/*LIGHTINGSOURCE*/
label define lightingsource93 1 electricity 2 "battery lamp" 3 "gas/oil/kerosene" 4 "resin torches" 5 other;
/*WATERSOURCE*/
**//label define watersource93 1 "inside pvt tap" 2 "outside pvt tap" 3 "public standpipe" 4 "deep drill well w/ pump" 5 "hand-dug/constructed well" 6 "filtered spring water" 7 "other well" 8 rain 9 "river/lake/pond" 10 "container water" 11 other;
/*REASONLEFT*/
label define whymove93 1 "follow/join family" 2 "work related" 3 marriage 4 school 5 "join army" 6 "move to new economic zone" 7 "forced relocation" 8 war 9 "natural disaster/fire" 10 "adventure/chance" 11 "family conflict" 12 "look for work" 13 "customs/common practice" 14 other;
/*REASONCAME - in '93, slightly different than '98 (see #5 and #8)*/
label define whycome93 1 "follow/join family" 2 "work related" 3 marriage 4 school 5 "demobilization" 6 "move to new economic zone" 7 "forced relocation" 8 fighting 9 "natural disaster/fire" 10 "adventure/chance" 11 "family conflict" 12 "look for work" 13 "customs/common practice" 14 other;
/*WORKFOR*/
label define workfor93 1 "communist party, govt or army" 2 "social organization" 3 "state owned company" 4 "mixed gov't/state owned enterprise" 5 "joint venture company" 6 "100% foreign investment" 7 "cooperative" 8 "private co. or HH" 9 other;


**//CODE VARIABLES;
label val female93 female93;
label val reltohead93 reltohead93;
label val compedfather93 diploma093;
label val compedmother93 diploma093;
label val motherwork93 profession93;
label val fatherwork93 profession93;
label val diploma93 diploma193;
label val literate93 literate93;
label val numerate93 numerate93;
label val reasonleft93 whymove93;
label val reasoncame93 whycome93;
label val toilettype93 toilettype93;
label val lightingsource93 lightingsource93;
label val workfor93 workfor93;
label val secworkfor93 workfor93;


**//REPLACING {1,2} binary vars with {0,1} binary vars (note: mother and fatherschool have 3=don't know);
foreach var in fatherschool93 motherschool93 school93 ill4wks93 bornhere93 dwellingowned93 dwellingshared93 workedpast12mo workedpast7d{;
replace `var'=0 if `var'==2;
replace `var'=. if `var'==3;
};

replace female93=0 if female93==1; 
replace female93=1 if female93==2;
replace selfemp93 = 0 if selfemp93 ==2;
replace salary93 = 0 if salary93 ==2;
replace salary7d93 = 0 if salary7d93 ==2;
replace secsalary7d93 = 0 if secsalary7d93 ==2;
replace secselfemp93 = 0 if secselfemp93 ==2;
replace secsalary93 = 0 if secsalary93 ==2;
replace agr_activity93 = 0 if agr_activity93 ==2;
replace cropland93 = 0 if cropland93 ==2;
replace lookedforwork93 = 0 if lookedforwork ==2;


/*generate a whynolook variable to make comparable to '98*/
gen whynolook93c = whynolook93;
label define whynolook93 1 illness 2 disabled 3 "too old/retired" 4 "Don't want to" 5 "student" 6 "housework/childcare" 7 "too young" 8 "on vacation" 9 "waiting to start new job" 10 "Don't have work" 11 "Don't know how to look" 12 Other;
label val whynolook93 whynolook93;
replace whynolook93c = 13 if whynolook93==8; /*8 is vacation in 93, "waiting for seasonal job" in 98", so I made up a new code for vacation*/;
label define whynolook93c 1 illness 2 disabled 3 "too old/retired" 4 "Don't want to" 5 "student" 6 "housework/childcare" 7 "too young" 13 "on vacation" 9 "waiting to start new job" 10 "Don't have work" 11 "Don't know how to look" 12 Other;
label val whynolook93c whynolook93c;
label var whynolook93c "Why did you not look for work in the past 7 days? Codes comparable to '98.";

/*EDUCATION VARIABLES: SELF*/
gen educyrself93 = edgrade93 + edyrspostsec93;
replace educyrself93 = 0 if school93==.; /*person never attended school*/
label var educyrself93 "ED: edgrade93 (1-12) plus edyrspostsec93 (univ. or vocat. sch. yrs) [~=98]";

/*Note: diploma93 is highest degree obained - also a useful variable*/


/*generate mother and father's education variables that are comparable to '98*/

/*EDUC VARIABLES: See also comped98father and comped98mother, which has completed degree*/
gen educyrfather93=fatheredgrade93 + fatheredpostsec93; /*fatheredgrade93 has . for 13 (DK)*/
label var educyrfather93 "EDPAR: Father's yrs school = fatheredgrade93+fatheredpostsec93 (fatheredgrade=13(dk) removed)";

gen educyrmother93=motheredgrade93 + motheredpostsec93; /*fatheredgrade93 has . for 13 (DK)*/
label var educyrmother93 "EDPAR: Mother's yrs school = motheredgrade93+motheredpostsec93";


**//need to generate a workfor variable that is comparable to '98;
**//gen workfor93c = workfor93; /*generate a variable to make comparable to '98*/;
**//label define workfor93c 1 "gov't admin, police, military" 2 "state enterprise" 3 "communist party, social org" 4 cooperative 5 "private enterprise" 6 "small hh entrep." 7 "limited liability company" 8 "100% foreign enterprise" 9 "joint venture with gov't" 10 "JV with collective" 11 "JV with private" 12 "JV with individual" 13 "JV with domestic joint co." 14 other;
**//label val workfor93c workfor93c;



**//GENERATING NEW VARIABLES FOR '93;
gen dkinh93 = 1 if tribe93 ==1; replace dkinh93 = 0 if dkinh93 ==.; label var dkinh93 "1 if tribe93 = kinh (1)";
gen dtay93 =1 if tribe93 ==2; replace dtay93 =0 if dtay93 ==.; label var dtay93 "1 if tribe93 = tay (2)";
gen dthai93 = 1 if tribe93 ==3; replace dthai93 = 0 if dthai93 ==.; label var dthai93 "1 if tribe93 = thai (3)";
gen dchinese93 = 1 if tribe93 ==4; replace dchinese93 = 0 if dchinese93 ==.; label var dchinese93 "1 if tribe93 = chinese (4)";
gen dkhmer93 =1 if tribe93 ==5; replace dkhmer93 = 0 if dkhmer93 ==.; label var dkhmer93 "1 if tribe93 = khome (5) - assumed to equal khmer in '98";
gen dmuong93 = 1 if tribe93 ==6; replace dmuong93 = 0 if dmuong93 ==.; label var dmuong93 "1 if tribe93 = muong (6)";
gen dnung93 = 1 if tribe93 ==7; replace dnung93 = 0 if dnung93 ==.; label var dnung93 "1 if tribe93 = nung (7)";
gen dotherrace93 = 1 if tribe93 !=1 & tribe93 !=2 & tribe93 !=3 & tribe93 !=4 & tribe93 !=5 & tribe93 !=6 & tribe93 !=7 ; replace dotherrace93=0 if dotherrace93==.; label var dotherrace93 "1 if tribe93 != 1 thru 7";

gen disabled93 = 1 if whynolook93 ==2;
replace disabled93 = 0 if disabled93 ==.;
label var disabled93 "1 if whynolook93 ==2 (disabled) (Only available if person had no job)";

/*BETTER VARIABLE FOR WORKING PAST 12 MONTHS*/
gen workedpast12mo_all93 = workedpast12mo93;
replace workedpast12mo_all93 = 1 if workedpast7d93 ==1;
label var workedpast12mo_all93 "=1 if workedpast12mo93 = 1 or workedpast7d93 ==1";


/*PRIMARY JOB*/
/*Mainjob & industry are answered for last 12 months whether or not person has a job in last 7 days*/

/*Yearsinwork is only answered for the last 12 months if the mainjob in the last 12 months is not the same as that in the last 7 days*/
gen yearsinwork_all93 = yearsinwork93;
replace yearsinwork_all93 = yearsinwork7d93 if sameasmain93 ==1; /*if mainjob in last 12 mos is same as mainjob in last 7 days*/
replace yearsinwork_all93 = secyearsinwork7d93 if sameasmain93 ==2;/*if mainjob in last 12 mos is same as secjob in last 7 days*/
label var yearsinwork_all93 "yearsinwork93, or yearsinwork7d93 (secyearsinwork7d93) if sameasmain93==1 (2)";

gen monthsinwork_all93 = monthsinwork93;
replace monthsinwork_all93 = monthsinwork7d93 if sameasmain93==1;/*if mainjob in last 12 mos is same as mainjob in last 7 days*/
replace monthsinwork_all93 = secmonthsinwork7d93 if sameasmain93 ==2;/*if mainjob in last 12 mos is same as secjob in last 7 days*/
label var monthsinwork_all93 "monthsinwork93, or monthsinwork7d93 (secmonthsinwork7d93) if sameasmain93==1 (2)";

gen salary_all93 = salary93;
replace salary_all93 = salary7d93 if sameasmain93 ==1;/*if mainjob93 in last 12 mos is same as mainjob93 in last 7 days*/
replace salary_all93 = secsalary7d93 if sameasmain93 ==2;/*if mainjob93 in last 12 mos is same as secjob93 in last 7 days*/
label var salary_all93 "salary93, or salary7d93 (secsalary7d93)  if sameasmain93 ==1 (2)";

/*SECONDARY JOB*/
gen secsalary_all93 = secsalary93;
replace secsalary_all93 = salary7d93 if secsameasmain93 ==1;/*if secjob93 in last 12 mos is same as mainjob93 in last 7 days*/
replace secsalary_all93 = secsalary7d93 if secsameasmain93 ==2;/*if secjob93 in last 12 mos is same as secjob93 in last 7 days*/
label var secsalary_all93 "secsalary93, or salary7d93 (secsalary7d93)  if secsameasmain93 ==1 (2)";


/*DUMMY FOR RECEIVING A SALARY*/
gen anysalary_all93 = 1 if salary_all93 ==1;
replace anysalary_all93 = 1 if secsalary_all93==1;
replace anysalary_all93 = 0 if anysalary_all93 ==.;
label var anysalary_all93 "1 if person receives salary, main or sec. job (past 12 mos.,complete), 0=no job or no salary.";



/*GENERATE IRRIGATION VARIABLE*/
gen irr_frac93 = (allocated_crop_irr93 +longterm_crop_irr93 + auctioned_crop_irr93 + owned_crop_irr93)/
        (allocated_crop93 + longterm_crop93 + auctioned_crop93 + owned_crop93);
label var irr_frac93 "***Proportion own cropland irrigated 1993: this should be checked because questionnaire is unclear.";


gen irr_frac_alt93 = farmed_crop93/farmed_crop_irr93;
label var irr_frac_alt93 "farmed_crop93/farmed_crop_irr93: proportion of cultivated cropland that is irrigated - should be checked";


/*DUMMIES FOR OTHER NON-BINARY VARIABLES*/
gen dliterate_all93 = 1 if literate93 ==1; /*There is no literate_all var for '93, since there is no skip pattern to take into account*/
replace dliterate_all93=0 if dliterate_all93==.;
label var dliterate_all93 "1 if person can read and write";

gen delectricity93 = 1 if lightingsource93 ==1;
replace delectricity93 = 0 if delectricity93 ==.;
label var delectricity93 "1 if lightingsource93 is electricity";

gen dflushtoilet93 = 1 if toilettype93 ==1;
replace dflushtoilet93=0 if dflushtoilet93 ==.;
label var dflushtoilet93 "1 if toilettype93 is flush w/septic sewage";

gen dnumerate_all93 = 1 if numerate93 ==1;/*There is no numerate_all var for '93, since there is no skip pattern to take into account*/
replace dnumerate_all93 = 0 if dnumerate_all93 ==.;
label var dnumerate_all93 "1 if person can do written calculations";

/*ILLNESS VARIABLES  (no hospital12month variable in '93)*/
gen avg_ill4wks93 =ill4wks93*ill4wks_days93; 
replace avg_ill4wks93 = 0 if ill4wks93 ==0;
label var avg_ill4wks93 "ill4wks93*ill4wks_days93 (no. days ill in past 4 weeks), 0 if ill4wks93 = 0";


/*No hospital12mths or hospital12mths_days variables for '93*/

**//GENERATE ID for merging with '98 data;
gen vlss93cluster = int(hholdno/100);
gen vlss93hh = mod(hholdno,100);
rename idc vlss93idc;

label var hholdno "HH: Cluster (first 3 digits) and HH (last 2 digits)";
label var vlss93cluster "HH: Cluster";
label var vlss93hh "HH: Household";
label var vlss93idc "HH: ID for individual";

move vlss93cluster vlss93idc;
move vlss93hh vlss93cluster;


cd ..;

sort vlss93cluster;
save hhvlss93.dta, replace;

/*Merge in province codes for 1993.   Province codes were imputed by looking at commune and prov. codes in 1998 and 2002.*/
use vlss93provinces.dta;
sort vlss93cluster;
save vlss93provinces, replace;

use hhvlss93.dta;
sort vlss93cluster;
merge vlss93cluster using vlss93provinces.dta;
drop _merge;

sort vlss93cluster vlss93hh vlss93idc;
save hhvlss93.dta, replace;


**//Merge in district codes - need to figure out how to do this - '93 commune codes do not match those in '98, so can't be matched to
districts using these commune codes;


**//Collapse to get number of people in hh with a salaried job;
collapse (sum) anysalary_all93 (count) vlss93idc, by(vlss93hh);
rename vlss93idc hhnum93;
rename anysalary_all93 numanysalary_all93;
label var numanysalary_all93 "number in hh with any salaried job (main or secondary)";
gen salaryfrac_all93 = numanysalary_all93/hhnum93;
label var salaryfrac_all93 "fraction in hh with salaried job (main or secondary),'93";
drop hhnum93;
sort vlss93hh;
save collapse_salaried93.dta, replace;

/*MERGING INTO HHVLSS93*/
use hhvlss93.dta;
sort vlss93hh;
merge vlss93hh using collapse_salaried93.dta;
drop _merge;

save hhvlss93.dta, replace;


cd vlss9293;
erase hhvlss93.dta;

**//MERGE HH-LEVEL EXPENDITURE DATA, FROM MINOT **************************************************************************************;

use SCR001.DTA, clear; /*NEED THIS FILE TO GET MONTH DEFLATORS FOR 93*/
    gen day93=int(date6/10000); gen month93=int(date6/100)-day93*100; gen year93=date6-100*month93-10000*day93;
    gen vlss93cluster=int(hholdn/100); gen vlss93hh=hholdn-vlss93cluster*100;
    keep vlss93cluster vlss93hh month93 year93;
    sort vlss93cluster vlss93hh;
cd ..; save temphh.dta, replace;

use hhvlss93.dta, clear;
sort vlss93cluster vlss93hh;
merge vlss93cluster vlss93hh using 93EXP.dta;
tab _merge; drop _merge;
    sort vlss93cluster vlss93hh; merge vlss93cluster vlss93hh using temphh.dta; tab _merge; drop _merge;
label var exp93 "consumption expenditure 93";
label var expb93 "cons. exp. bought/bartered 93";
label var exph93 "cons. exp. hh product 93";
label var exppc93 "exp/hhsize";
label var fexp "cons. exp. food only 93";
label var fpct "fexp/exp";
label var hfpct "fraction of food expenditure hhproduct";
replace sexhead93=0 if sexhead93==1; replace sexhead93=1 if sexhead93==2; rename sexhead93 sex_head_female_93;
label var ricevb93 "Value of bought rice 1000VND";
label var ricevh93 "Value of home produced rice 1000VND";
label var riceqb93 "Quantity of bought rice kg?";
label var riceqh93 "Quantity of home produced rice kg?";
label var maizev93 "Value of maize 1000VND";
label var maizeq93 "Quantity of maize kg?";
label var maniocv93 "Value of manioc 1000VND";
label var maniocq93 "Quantity of manioc kg?";
label var swpotv93 "Value of sweet potatoes 1000VND";
label var swpotq93 "Quantity of sweet potatoes kg?";
/*INPUTTING PRICE DEFLATORS FROM VLSS93 DOCUMENTATION*/
gen rcpi93=.; label var rcpi93 "Regional Price Deflator, 93";
    replace rcpi93=.9692 if urb93==0 & region93==1; 
    replace rcpi93=.8954 if urb93==0 & region93==2; 
    replace rcpi93=.9813 if urb93==0 & region93==3; 
    replace rcpi93=.9764 if urb93==0 & region93==4; 
    replace rcpi93=1.0638 if urb93==0 & region93==5; 
    replace rcpi93=1.1153 if urb93==0 & region93==6; 
    replace rcpi93=1.0196 if urb93==0 & region93==7; 
    replace rcpi93=1.0815 if urb93==1 & region93==1; 
    replace rcpi93=1.0658 if urb93==1 & region93==2; 
    replace rcpi93=1.0112 if urb93==1 & region93==3; 
    replace rcpi93=1.0554 if urb93==1 & region93==4; 
    replace rcpi93=1.2315 if urb93==1 & region93==6; 
    replace rcpi93=1.0929 if urb93==1 & region93==7; 
gen mcpi93=.; label var mcpi93 "Monthly price deflator 93 (based on mo of 2nd rd survey), Jan93=1";
    replace mcpi93=.9524 if month93==9 & year93==92;
    replace mcpi93=.9507 if month93==10 & year93==92;
    replace mcpi93=.9699 if month93==11 & year93==92;
    replace mcpi93=.9833 if month93==12 & year93==92;
    replace mcpi93=1 if month93==1 & year93==93;
    replace mcpi93=1.0190 if month93==2 & year93==93;
    replace mcpi93=1.0139 if month93==3 & year93==93;
    replace mcpi93=1.0119 if month93==4 & year93==93;
    replace mcpi93=1.0271 if month93==5 & year93==93;
    replace mcpi93=1.0240 if month93==6 & year93==93;
    replace mcpi93=1.0240 if month93==7 & year93==93;
    replace mcpi93=1.0219 if month93==8 & year93==93;
    replace mcpi93=1.0270 if month93==9 & year93==93;
    replace mcpi93=1.0260 if month93==10 & year93==93;
    drop month93 year93;
gen exp93r98=(exp93/(rcpi93*mcpi93))*1.456; label var exp93r98 "real cons exp 93, in 98 1000VND, adj for reg/mo price diff";
gen exppc93r98=(exppc93/(rcpi93*mcpi93))*1.456; label var exppc93r98 "real cons exp per cap 93, in 98 1000VND, adj for reg/mo price diff";
gen ricexpd93=ricevb93+ricevh93; 
gen nonrice93=fexp93-ricexpd93; 
gen totnfdx193=expb93-(1-hfpct93)*fexp93; 
gen totnfdh193=exph93-(hfpct93*fexp93); 
gen nonfood193=exp93-fexp93; 
gen pcfdex193=exppc93*fpct93; 



label var ricexpd93 "Expenditure on rice 1000VND, 93";
label var nonrice93 "Expenditure on food, no rice 1000VND, 93";
label var totnfdx193 "Expenditure on non-food purchased/bartered 1000VND, 93";
label var totnfdh193 "Value of home production of non-food, 93";
label var nonfood193 "Avg non-food expenditure, current 1000VND, 93";
label var pcfdex193 "Exp per cap on food(stuffs), current price 1000VND 93";


/*NOTE: 1.456 is ratio between 1/98 CPI and 1/93 CPI, provided by GSO*/

sort vlss93cluster vlss93hh vlss93idc;
save hhvlss93.dta, replace;

/*END OF '93 EXPENDITURE DATA MERGING *******************************************************************************************/


**//NOTE: AT THIS POINT, THE FILES HHVLSS93 AND HHVLSS98 HAVE BEEN CREATED;




**//GET ALL RELEVANT VARIABLES IN '02;
/*Get into correct file*/
cd VLSS02\Database_stata\hhold;

/*sort files to merge by qui tinh huyen xa diaban hoso matv (quarter province district commune location household idcode)*/
foreach x in  qt000q0_d qt000q0_g qt000q0_v {;
use `x'.dta;
sort qui tinh huyen xa diaban hoso matv;
save `x'_temp.dta, replace;
};


/*base file*/
use qt000q0_d_temp.dta;

/*merge files by hoso matv etc.*/
foreach x in qt000q0_g qt000q0_v {;
merge  qui tinh huyen xa diaban hoso matv using `x'_temp.dta;
drop _merge;
sort qui tinh huyen xa diaban hoso matv;
save hhvlss02.dta, replace;
erase `x'_temp.dta;
};

erase qt000q0_d_temp.dta;


/*sort files to merge by hholdno only*/
/*this file is in a different shape, and thus must be manipulated*/
/*Keep only relevant variables to keep merged files from getting too big*/

use qt000q0_k.dta;
drop if muc!="5B1"; /*keeps only questions from relevant section (muc = section)*/
keep tinh huyen xa diaban hoso qui c2 c3 c7 c8;
    foreach y in c2 c3 c7 c8 {;
    rename `y' `y'_5B1;
    };
sort tinh huyen xa diaban hoso qui;
save 5B1_temp.dta, replace;

use qt000q0_k.dta;
drop if muc!="5B4"; /*keeps only questions from relevant section*/
keep tinh huyen xa diaban hoso qui c7 c39;
    foreach y in c7 c39 {;
    rename `y' `y'_5B4;
    };
sort tinh huyen xa diaban hoso qui;
save 5B4_temp.dta, replace;

/*Each of the above temp files is now identified by tinh huyen xa diaban hoso qui, i.e. household and quarter are the most specific identifiers*/
use hhvlss02.dta;
sort tinh huyen xa diaban hoso qui;

foreach x in 5B1 5B4 {;
merge tinh huyen xa diaban hoso qui using `x'_temp.dta;
drop _merge;
sort tinh huyen xa diaban hoso qui;
save hhvlss02.dta, replace;
erase `x'_temp.dta;
};


/*This file uses survey date (ngaydt) instead of quarter (qui), so it must be converted*/
use qt000q0_h.dta;
gen qui = quarter(ngaydt);
sort tinh huyen xa diaban hoso qui;
save qt000q0_h_temp.dta, replace;

use hhvlss02.dta;
merge tinh huyen xa diaban hoso qui using qt000q0_h_temp.dta;
sort tinh huyen xa diaban hoso qui;
drop _merge;
save hhvlss02.dta, replace;
erase qt000q0_h_temp.dta;


**//KEEP ONLY "POSSIBLE OUTCOME MEASURES" ;
keep tinh huyen xa diaban hoso matv qui ngaydt    m1c2    m1c3    m1c5    m2c4    m2c1    m2c3    m2c2 m3c1a    m3c1b    m3c1c    m3c2     m3c4    m3c5 m3c6    m3c7   m3c8    m3c9       m3c12    m3c13    m8c7    m8c23    m8c27    m8c28    t26    t27    t37    t40    ch_dantoc        m3c1c    m9c1    m9c2    c2_5B1 c3_5B1 c7_5B1 c8_5B1 c7_5B4 c39_5B4;

sort tinh;
save hhvlss02.dta, replace;

/*Get urban variable from commune file*/
cd ..;
use commune\h000.dta, clear;
cd hhold;
keep tinh kv; /*kv is 1 = urban 2 = rural*/
rename kv urb02;
replace urb02 = 0 if urb02 ==2;
label var urb02 "1 = urban, 0 = rural";
sort tinh;
save hhvlss02_urb_temp.dta, replace;

use hhvlss02.dta, replace;
merge tinh using hhvlss02_urb_temp.dta;
tab _merge;
drop _merge;

erase hhvlss02_urb_temp.dta;

/*Get commune measures*/

**//order [insert variables here in desired order];


**//RENAME;
rename m1c2 female02;
rename m1c3 reltohead02;
rename m1c5 ageyrs02;
rename m2c4 school02;
rename m2c1 edgrade02;
rename m2c3 diploma02;
rename m2c2 literate02;

rename m3c1a workforother02;
rename m3c1b workonownfield02;
rename m3c1c selfemp02;
rename m3c2 havework02;
rename m3c4 lookedforwork02;
rename m3c5 whynolook02;
rename m3c6 mainjob02;
rename m3c7 organiz02;
rename m3c8 workfor02;
rename m3c9 mosworkedlastyr02;
rename m3c12 secjob02;
rename m3c13 mosworkedlastyrall02;


rename m8c7 dwellingowned02;
rename m8c23 watersource_drink02;
rename m8c27 toilettype02;
rename m8c28 lightingsource02;
rename t26 food02;
rename t27 nonfood02;
rename t37 hhexp02;
rename t40 pcexp02;
rename ch_dantoc tribe02;
rename m9c1 invalids02;
rename m9c2 elderly02;
rename c2_5B1 agr_activity02;
rename c3_5B1 agrland02;
rename c7_5B1 cropland02;
rename c8_5B1 longterm_crop02;
rename c7_5B4 irrinc02;
rename c39_5B4 irrexp02;

**//LABELS;
label var female02 "Equals 1 for female";
label var reltohead02 "Relationship to head of household";
label var ageyrs02 "Age";
label var school02 "Attend school in the past 12 months";
label var edgrade02 "Grade";
label var diploma02 "Highest degree";
label var literate02 "Read and write (no response if edgrade02 > = 5)";

label var workforother02 "receive salary, wage";
label var workonownfield02 "do the agricultural, forestry & aquacultural work on their own";
label var selfemp02 "do non-farm production and services";
label var havework02 "Have work? (Currently employed?)";
label var lookedforwork02 "Looked for work ?";
label var whynolook02 "Reason for not having look for work";
label var mainjob02 "Most time consuming work (see svy for codes) ";
label var organiz02 "Name of organization of this work (see svy for codes)";
label var mosworkedlastyr02 "Months in last 12 months doing mainjob";
label var mosworkedlastyrall02 "Months in last 12 months doing all jobs";
label var workfor02 "For whom did you work?";
label var secjob02 "Two or more jobs at the same time? past 12 mos";

label var dwellingowned02 "Does this house belong to you (1=all, 2=part, 3=no)";
label var watersource_drink02 "What is the main source of your drinking water";
label var toilettype02 "What type of toilet do your hh have";
label var lightingsource02 "What is your main source of lighting";
label var food02 "Expenditure on regular food";
label var nonfood02 "Expenditure on no-food and non-food stuff ";
label var hhexp02 " IV. Expenditure              [Code 16 + 17 + 25 + 26 + 27 + 28 + 32 + 35]";
label var pcexp02 " VII. Average Expenditure/person/month [Indicator IV/ (quan'ty of hhold members  x 12)]";
label var tribe02 "Ethnic group";
label var invalids02 "Are you a family of invalids, sick war veterans, martyr, Vietnamese heroic mothers";
label var elderly02 "Are you a family of lonely elderly, disabled who receive regular social subsidy";
label var agr_activity02 "Manage and use agricultural, syvilcutural and aquacultural land";
label var agrland02 "Total area of agricultural land (m2)";
label var cropland02 "Total area of land for annual crop (m2)";
label var longterm_crop02 "Area of land for annual crop used for long (m2)";
label var irrinc02 "Total income from irrigation";
label var irrexp02 "Total expense of irrigation";


**//PRICE DEFLATORS FOR EXPENDITURE INDICES;
gen region02=int(tinh/100); /*Paul Glewwe told me how to do this*/


/*Note reg8 is coded as follows: (See regional deflators in 8vung_cpi_from_Glewwe_regional.xls)
1 - Red River Delta
2 - East Northern Mountains
3 - West Northern Mountains
4 - North Central Coast
5 - South Central Coast
6 - Central Highlands
7 - Southeast
8 - Mekong Delta */

/*Note: Whole country = 100*/
gen rcpi02=.; label var rcpi02 "Regional Price Deflator, 02";
replace rcpi = 107.296610979769 if region02 == 1 & urb02 == 1;
replace rcpi = 95.4052256338648 if region02 == 2 & urb02 == 1;
replace rcpi = 100.336227582958 if region02 == 3 & urb02 == 1;
replace rcpi = 95.6466200116548 if region02 == 4 & urb02 == 1;
replace rcpi = 98.4169743816382 if region02 == 5 & urb02 == 1;
replace rcpi = 102.878881501704 if region02 == 6 & urb02 == 1;
replace rcpi = 115.892363497526 if region02 == 7 & urb02 == 1;
replace rcpi = 101.095012914349 if region02 == 8 & urb02 == 1;
replace rcpi = 99.8035490713154 if region02 == 1 & urb02 == 0;
replace rcpi = 95.5976049307006 if region02 == 2 & urb02 == 0;
replace rcpi = 97.4380368479806 if region02 == 3 & urb02 == 0;
replace rcpi = 93.1181638170448 if region02 == 4 & urb02 == 0;
replace rcpi = 95.2272848409931 if region02 == 5 & urb02 == 0;
replace rcpi = 101.054440672242 if region02 == 6 & urb02 == 0;
replace rcpi = 105.07914190995 if region02 == 7 & urb02 == 0;
replace rcpi = 98.0895194814418 if region02 == 8 & urb02 == 0;


gen month02 = month(ngaydt);
label var month02 "month of survey";
/*Note: All surveys were conducted in 2002, so all monthly deflator data is from 2002*/

gen mcpi02=.; label var mcpi02 "Monthly price deflator 02 (based on mo. of ngaydt (interviewer date)), Jan02=1";            
    replace mcpi02 = 1.0000 if month02==1;        
    replace mcpi02 = 1.0160 if month02==2;        
    replace mcpi02 = 1.0048 if month02==3;        
    replace mcpi02 = 0.9978 if month02==4;        
    replace mcpi02 = 0.9918 if month02==5;        
    replace mcpi02 = 0.9868 if month02==6;        
    replace mcpi02 = 0.9809 if month02==7;        
    replace mcpi02 = 0.9819 if month02==8;        
    replace mcpi02 = 0.9799 if month02==9;        
    replace mcpi02 = 0.9809 if month02==10;        
    replace mcpi02 = 0.9897 if month02==11;        
    replace mcpi02 = 0.9907 if month02==12;        
    drop month02;
    
/*Note: Source for monthly data is GSO CPI data.  See CPI_data.xls.*/


**//GENERATING REAL EXPENDITURE VARIABLES;
gen pcexp02yr = pcexp02*12; /*multiply by 12 to keep in yearly measures - pcexp02 had been divided by 12 to get monthly per capita*/
label var pcexp02yr "pcexp02*12 = per person yearly expenditures, comp. to '93 & '98";

/*gen exp02r98_oldold = hhexp02*0.945196526; label var exp02r98_old "real cons exp 02, in 98 1000VND, NOT adj for reg/mo price diff";*/
/*gen exppc02r98_oldold =pcexp02yr*0.945196526; label var exppc02r98_old "real yrly cons exp per cap 02, in 98 1000VND,NOT adj for reg/mo price diff";*/

/*gen exp02r98_old = (hhexp02/mcpi02)*0.918168097; label var exp02r98 "real cons exp 02, in 98 1000VND, adj for mnth but not reg. price diff";*/
/*gen exppc02r98_old =(pcexp02yr/mcpi02)*0.918168097; label var exppc02r98 "real yrly cons exp per cap 02, in 98 1000VND,adj for mnth but not reg. price diff";*/

gen exp02r98 = (hhexp02/(rcpi02*mcpi02))*0.918168097; label var exp02r98 "real cons exp 02, in 98 1000VND, adj for mnth/reg. price diff";
gen exppc02r98 =(pcexp02yr/(rcpi02*mcpi02))*0.918168097; label var exppc02r98 "real yrly cons exp per cap 02, in 98 1000VND,adj for mnth/reg. price diff";


/*NOTE: 0.945196526 is the CPI for 1998 divided by that for 2002, from the WDI database.  0.918168097
 is 1/98 divided by 1/02 CPI from the GSO.  See the file CPI_data.xls, sheet "GSO_CPS_monthly" for calculations*/


**//REPLACING {1,2} binary vars with {0,1} binary vars;
foreach x in school02 literate02 workforother02 workonownfield02 lookedforwork02 selfemp02
    secjob02 invalids02 elderly02 agr_activity02 havework02 {;
replace `x' = 0 if `x' ==2;
};

/*MAKE FEMALE02 A DUMMY FOR FEMALE*/
replace female02 = 0 if female02 ==1;
replace female02 = 1 if female02 ==2;

**//CREATE LITERATE VARIABLE TO TAKE INTO ACCOUNT edgrade02 >=5;
gen dliterate_all02 = literate02;
replace dliterate_all02 = 1 if edgrade02 >=5;
label var dliterate_all02 "1 if edgrade02 >=5 or literate02 =1, (1 if can read & write)";
move dliterate_all02 literate02;


/*GENERATE OTHER DUMMIES*/
gen delectricity02 = 1 if lightingsource02 ==1;
replace delectricity02 = 0 if delectricity02 ==.;
label var delectricity02 "1 if lightingsource02 is electricity";

gen dflushtoilet02 = 1 if toilettype02 ==1;
replace dflushtoilet02=0 if dflushtoilet02 ==.;
label var dflushtoilet02 "1 if toilettype02 is flush w/septic sewage";


**//RECODING VARIABLES WITH SIMILAR DEFINITIONS;
/*enter later if needed*/


**//CREATE CODES;
/*FOR FEMALE*/
label define female02 0 male 1 female;
/*FOR RELTOHEAD - diff from '98*/
label define reltohead02 1 head 2 spouse 3 child 4 childinlaw 5 parent 6 sibling 7 grandparent 8 grandchild 9 "other relationship"; 
/*FOR HIGHEST DEGREE*/
label define diploma02 0 none 1 primary 2 lowsec 3 hisec 4 techworker 5 profsec 6 "jr. college" 7 bachelor 8 masters 9 "candidate/doctor"; 
/*FOR WORKFOR*/
label define workfor02 0 selfemp 1 "work for other households" 2 "government, police, military" 3 "communist party, social org." 4  "state owned
    enterprise" 5 "other state econ. sector" 6 "collective econ. sector" 7 "private capitalist econ. sector" 8 "state capitalist econ. sector" 9 "foreign shared enterprise";
/*FOR WHYNOLOOK*/
label define whynolook02 1 studying 2 housework 3 "not able to work" 4 "have a job" 5 "don't know where to find job" 6 other;
/*FOR DWELLINGOWNED*/
label define dwellingowned02 1 "yes, totally" 2 "yes, partly" 3 no;
/*TOILETTYPE (diff from '98)*/
label define toilettype02 1 "flush w/ septic/sewage" 2 suilabh 3 "double vault compost latrine" 4 "toilet directly over water" 5 other 6 "no toilet";
/*LIGHTINGSOURCE (diff from '98)*/
label define lightingsource02 1 electricity 2 "battery lamp" 3 "gas/oil/kerosene" 4 other;
/*WATERSOURCE (diff from '98)*/
label define watersource02 1 "pvt tap" 2 "public tap" 3 "bought water" 4 "deep drill well w/ pump" 5 "hand-dug/constructed well" 6 "filtered spring water" 
    7 "deep well" 8 rain 9 "river/lake/pond" 10 other;



/*Generate dummies for ethnic group*/
destring tribe02, replace;
gen dkinh02 = 1 if tribe02 ==1; replace dkinh02 = 0 if dkinh02 ==.;
gen dtay02 = 1 if tribe02 ==2; replace dtay02 = 0 if dtay02 ==.;
gen dthai02 = 1 if tribe02 ==3; replace dthai02 = 0 if dthai02 ==.;
gen dhoa02 = 1 if tribe02 ==4; replace dhoa02 = 0 if dhoa02 ==.;
gen dkhmer02 = 1 if tribe02 ==5; replace dkhmer02 = 0 if dkhmer02 ==.;
gen dmuong02 = 1 if tribe02 ==6; replace dmuong02 = 0 if dmuong02 ==.;
gen dnung02 = 1 if tribe02 ==7; replace dnung02 = 0 if dnung02 ==.;
gen dotherrace02 = 1 if (tribe02 !=1 & tribe02 !=2 &tribe02 !=3 &tribe02 !=4 &tribe02 !=5 &tribe02 !=6 & tribe02 !=7 & tribe02 !=.); 
    replace dotherrace02 = 0 if dotherrace02 ==.;

label var dkinh02 "gen dkinh02 = 1 if tribe02 ==1";
label var dtay02 "gen dtay02 = 1 if tribe02 ==2"; 
label var dthai02 "gen dthai02 = 1 if tribe02 ==3";
label var dhoa02 "gen dhoa02 = 1 if tribe02 ==4 (hoa = chinese?)"; 
label var dkhmer02 "gen dkhmer02 = 1 if tribe02 ==5";
label var dmuong02 "gen dmuong02 = 1 if tribe02 ==6";
label var dnung02 "gen dnung02 = 1 if tribe02 ==7";
label var dotherrace02 "gen dotherrace02 = 1 if tribe02 !=1 to 7 or .";

/*For some reason this variable is in string form - must destring in order to code variables (below)*/
destring workfor02, replace;

**//CODE VARIABLES;
label val female02 female02;
label val reltohead02 reltohead02;
label val diploma02 diploma02;
label val workfor02 workfor02;
label val whynolook02 whynolook02;
label val dwellingowned02 dwellingowned02;
label val toilettype02 toilettype02;
label val lightingsource02 lightingsource02;
label val watersource_drink02 watersource02;



**//GENERATE ID for merging with '98 data;
/*DON'T KNOW HOW TO MERGE WITH '98 DATA BY HOUSEHOLD*/

label var tinh "Name of province (tinh)";
label var huyen "Name of district (huyen)";
label var xa "Name of commune (xa)";
label var diaban "Name of location (diaban)";
label var hoso "Household (hoso)";
label var matv "ID code (matv)";
label var qui "quarter of survey (qui)";

rename tinh province02;
rename huyen district02;
rename xa commune02;
rename diaban location02;
rename hoso househol02;
rename matv idcode02;
rename qui quarter02;

/*DWELLING DUMMIES (see also dwellingshared = 1 if shared)*/
gen ddwellingfullyowned02 = 1 if dwellingowned02 ==2;
replace ddwellingfullyowned02 = 0 if ddwellingfullyowned02 == .;
label var ddwellingfullyowned02 "1 if dwellingowned02 ==2 (fully owned)";

gen ddwellingpartowned02 = 1 if dwellingowned02 ==1;
replace ddwellingpartowned02 = 0 if ddwellingpartowned02 ==.;
label var ddwellingpartowned02 "1 if dwellingowned02 ==1 (part owned)";

move quarter02 female02;

gen communecode = province02*10000;
replace communecode = communecode+(district02*100);
replace communecode = communecode+commune02;
label var communecode "Province: 1st 3 dig. District: 1st 5 dig. Commune: All dig. (comp. to '98)";

save hhvlss02.dta, replace;

/*MERGE IN weights*/
use wt30.dta;
rename xa communecode;
save wt30_temp.dta, replace;

use hhvlss02.dta;
sort communecode;
merge communecode using wt30_temp.dta;
drop _merge;
sort province02 district02 commune02 househol02 quarter02;
save hhvlss02.dta, replace;

/*GENERATE HOUSEHOLDSIZE VARIABLE*/
collapse (count) idcode02, by(province02 district02 commune02 househol02 quarter02);
rename idcode02 hhsize02;
sort province02 district02 commune02 househol02 quarter02;
save hhvlss02_col_temp.dta, replace;

use hhvlss02.dta;
merge province02 district02 commune02 househol02 quarter02 using hhvlss02_col_temp.dta;
save hhvlss02.dta, replace;
erase hhvlss02_col_temp.dta;

/*SAVE IN MAIN FILE*/
cd ..\..\..;
save hhvlss02.dta, replace;

cd VLSS02\Database_stata\hhold;
erase hhvlss02.dta;

cd ..\..\..;

/****************************************************************************************************************************************/


**//CREATE A '98 COMMUNE-LEVEL DATA FILE;


**//THIS SECTION EXTRACTS AND LABELS VARIABLES FROM THE VLSS98 COMMUNE-LEVEL SURVEY.
    IT OUTPUTS comvlss98.dta AND comvlss98collapse.dta.
    comvlss98.dta INCLUDES RESPONSES FROM BOTH VILLAGES SURVEYED IN THE COMMUNE (IF APPLICABLE.)
    comvlss98collapse.dta COLLAPSES TO THE DISTRICT**-LEVEL, YIELDING UNWEIGHTED MEANS BETWEEN ALL OBS ACROSS THE COMMUNE.;  

**//THIS FILE ALSO MERGES BOTH HOUSEHOLD AND COMMUNE SURVEY OUTPUT INTO ONE FILE,VLSScommune.dta. (NOT DOING THIS AT THE MOMENT);

cd VLSS98\DATA\COMMUNE;
use CMT00B.DTA, clear;
quietly for any CMT011 CMT021 CMT032: merge cluster using X.DTA\
    tab _merge\
    drop _merge\
    sort cluster;
merge cluster using CMT033.DTA; rename idc factorycode; tab _merge; drop _merge; sort cluster;
quietly foreach file in CMT034 CMT0400 CMT0402 CMT0403 CMT0404 CMT0406 CMT061 CMT063 CMT082 CMT091 {;
    merge cluster using `file'.DTA; tab _merge; drop _merge; sort cluster;};

keep househol cluster s00bq02 s00bq04 s00bq06 s011q1 s011q2 s011q3 s021q011 s021q012 s021q013 s021q02 s021q031 s021q032 s021q033 s021q07 
    s021q09 s032q09 factorycode s033q11 s033q15 s034q18 s034q19 s0400q1 s402q05 s0403q11 s404typ s404q12 s404q13 s0406cct s0406q26 
    s0406q27 s061q1 s061q2 s063q20 s063q211 s063q212 s063q213 cap s082q10 s082q111 s082q112 s082q113 s091q11 s091q12 s091q13;
order househol cluster s00bq02 s00bq04 s00bq06 s011q1 s011q2 s011q3 s021q011 s021q012 s021q013 s021q02 s021q031 s021q032 s021q033 s021q07 
    s021q09 s032q09 factorycode s033q11 s033q15 s034q18 s034q19 s0400q1 s402q05 s0403q11 s404typ s404q12 s404q13 s0406cct s0406q26 
    s0406q27 s061q1 s061q2 s063q20 s063q211 s063q212 s063q213 cap s082q10 s082q111 s082q112 s082q113 s091q11 s091q12 s091q13;

label var househol "COM: HH";
label var cluster "COM: Cluster";
rename s00bq02 age_comhead;
rename s00bq04 position_comhead; label var position "COM: ID: Position in commune/ward"; label define position 1 chair 2 deputychair 3 "party secretary" 4 "chief/deputy chief commune police" 5 "finance officer" 6 "commune stat office" 7 "head of coop" 8 "school director" 9 "health worker" 10 "women's union cadre" 11 "farmer's union cadre" 12 "fatherland front cadre" 13 "village leader"; label val position position;
rename s00bq06 educyrs_comhead; label var educyrs "COM: ID: Yrs general/professional educ";
rename s011q1 popcomm; label var popcomm "COM: how many usually live in this commune/ward?";
rename s011q2 popcomm_year; label var popcomm_year "COM: What year is popcomm from?";
rename s011q3 geogtype; label var geogtype "COM: Geographical Region"; label define geogtype 1 coast 2 "inland delta" 3 "hills/midlands" 4 "low mts" 5 "hi mts"; label val geogtype geogtype;
rename s021q011 maininc1; label var maininc1 "COM: Three main sources of income"; label define maininc 1 agriculture 2 forestry 3 "aquatic products" 4 industry 5 handicrrafts 6 construction 7 trade 8 transport 9 services 10 other; label val maininc1 maininc;
rename s021q012 maininc2; label var maininc2 "COM: Three main sources of income"; label val maininc2 maininc;
rename s021q013 maininc3; label var maininc3 "COM: Three main sources of income"; label val maininc3 maininc;
rename s021q02 changelivstd; 
    
/*RECODING. APPROVE?*/ replace changelivstd=0 if changelivstd==3; replace changelivstd=-1 if changelivstd==2; 
label var changelivstd "COM: Has living std in comm/ward -1)declined 0)same 1)improved in past 5yrs?";
rename s021q031 changelivstdreason1; label var changelivstdreason1 "COM: Top 3 reasons living standard has (not) changed."; label define changelivstdreason 1 "changes in agro policy" 2 "expansion in non-agro production" 3 weather 4 disaster 5 inflation 6 "changes in ability to obtain educ" 7 "changes in ability to use health svc" 8 "changes in ability to use social svc" 9 other; label val changelivstdreason1 changelivstdreason;
rename s021q032 changelivstdreason2; label var changelivstdreason2 "COM: Top 3 reasons living standard has (not) changed."; label val changelivstdreason2 changelivstdreason;
rename s021q033 changelivstdreason3; label var changelivstdreason3 "COM: Top 3 reasons living standard has (not) changed."; label val changelivstdreason3 changelivstdreason;
rename s021q07 numpoorhh; label var numpoorhh "COM: How many hh in comm/ward certified poor by pvty alleviation pgm?";
rename s021q09 immigration; label var immigration "COM: Since 1992/1993, have more moved permanently in than out of commune?"; label define immigration 1 "more move in than out" 2 "more move out than in" 3 equal 4 "nobody moved in or out"; label val immigration immigration;
rename s032q09 factory; label var factory "COM: Are there factories w/i 10km that absorb labor from this comm/ward?";
label var factorycode "COM: Factory code, 1-5";
rename s033q11 factorydistance; label var factorydistance "COM: EMP: How far to factory from center of comm/ward? km";
rename s033q15 factorylabor; label var factorylabor "COM: EMP: How many people from this comm/ward work at that factory?";
rename s034q18 handicrafts; label var handicrafts "COM: Are there traditional occupations/handicrafts in comm/ward?";
rename s034q19 handicraftshh; label var handicraftshh "COM: How many hh participate in handicrafts?";
rename s0400q1 agriculture; label var agriculture "COM: Is agriculture an important source of income?";

**//WHAT KIND OF CROPS MIGHT WE BE INTERESTED IN?;
rename s402q05 maincrops; label var maincrops "COM: Main Crops: See Crop Codes";
    label define cropcodes 1 "Winter Rice" 2 "Autumn Rice" 3 "Winter Rice" 4 "Swidden Rice" 5 "Annual Rice" 6 "Glutinous Rice" 
    7 "Specialty Rice" 8 "Corn/Maize" 9 "Sweet Potatoes" 10 "Cassava/Manioc" 11 "Other Staple Crops" 12 Potatoes 
    13 "Kohlrabi, Cabbage, Cauliflower" 14 "Other Leafy Greens" 15 "Tomatoes" 16 "Water Morning Glory" 17 "Fresh Legumes (Beans)" 
    18 "Dried Legumes (Beans)" 19 "Herbs and Spices" 20 "Other Vegetables, Tubers, and Fruits" 21 "Soy Beans" 22 Peanuts 
    23 "Sesame Seeds" 24 "Sugar Cane" 25 Tobacco 26 Cotton 27 "Jute, Ramie" 28 "Rush (For Making Mats" 29 "Other Annual Industrial Crops" 
    30 "Other Annual Crops" 31 Tea 32 Coffee 33 Rubber 34 "Black Pepper" 35 "Coconut (For Oil, Copra)" 36 Mulberry 37 Cashew 
    38 "Other Perennial Industrial Crops" 39 "Oranges, Limes and Mandarins" 40 Pineapple 41 Bananas 42 Mango 43 Apple 44 Grapes 
    45 Plum 46 Papaya 47 "Litchi, Longan, Rambutan" 48 Sapodilla 49 "Custard Apple" 50 "Jackfruit, Durian" 51 Mangosteen 
    52 "Other Fruit Trees" 53 "Mu Oil Tree" 54 "Cinnamon Tree" 55 "Anise Tree" 56 "Pine Tree" 57 "Varnish Tree" 58 "tree for Wood" 
    59 Bamboo 60 "Fan Palm Tree" 61 "Water Coconut Palm" 62 "Other Silviculture Tree";
    label val maincrops cropcodes;
rename s0403q11 area_ha; label var area_ha "COM: Commune/ward area, hectares";

**//WHAT KIND OF AREA USE MIGHT WE BE INTERESTED IN?;
rename s404typ areausetype; label var areausetype "COM: Area Use Type"; label define areausetype 1 annualcrop 2 perennialcrop 3 watersurface 4 forest 5 residential 6 special 7 unused; label val areausetype areausetype;
rename s404q12 areause; label var areause "COM: Does this comm/ward have any areauseype?";
rename s404q13 areause_ha; label var areause_ha "COM What is the total area of this areausetype? ha";

**//WHAT KIND OF CROPS MIGHT WE BE INTERESTED IN?;
rename s0406cct croplandtype; label var croplandtype "COM: Crop Land Type"; label define croplandtype 1 rice 2 "other grain/tuber" 3 "other food crops" 4 "annual industrial" 5 "other annual" 6 "perennial industrial" 7 "fruit trees" 8 "other perennial" 9 forest; label val croplandtype croplandtype;
rename s0406q26 cropland; label var cropland "COM: Does commune cultivate croplandtype?";
rename s0406q27 cropland_ha; label var cropland_ha "COM: How much of the total area of this comm/ward is planted in croplandtype? ha";
rename s061q1 roadaccess; label var roadaccess "COM: Is there a road to this village that a car can travel on?";
rename s061q2 roaddistance; label var roaddistance "COM: How far away is the nearest road a car can travel on, km?";
rename s063q20 infra_imps; label var infra_imps "COM: Was there there infrastructure built/improved between 94/95-97/98?";
rename s063q211 infra_imps_type1; label var infra_imps_type1 "COM: Top 3 Infrastructure Buildings/Improvements 94/95-97/98"; label define infra_imps_type 1 road 2 "drinking water supply" 3 irrigation 4 "land reclamation" 5 "dryland converted to paddy" 6 school 7 "health ctr" 8 electricity 9 "other public inf" 10 other; label val infra_imps_type1 infra_imps_type;
rename s063q212 infra_imps_type2; label var infra_imps_type2 "COM: Top 3 Infrastructure Buildings/Improvements 94/95-97/98"; label val infra_imps_type2 infra_imps_type;
rename s063q213 infra_imps_type3; label var infra_imps_type3 "COM: Top 3 Infrastructure Buildings/Improvements 94/95-97/98"; label val infra_imps_type3 infra_imps_type;

**//SCHOOL LEVELS;
rename cap noschool_level; label var noschool_level "COM: Sch level 1)prim,2)lowsec,3)uppersec";
rename s082q10 noschool; label var noschool "COM: Are there school-age children who don't go to noschool_level?";
rename s082q111 noschool_reason1; label var noschool_reason1 "COM: Why don't children go to school? (Top 3)"; label define noschool_reason 1 distance 2 "economic difficulties" 3 "illness/handicap" 4 "don't want to" 5 crowding 6 "parents don't care" 7 "must work" 8 other; label val noschool_reason1 noschool_reason;
rename s082q112 noschool_reason2; label var noschool_reason2 "COM: Why don't children go to school? (Top 3)"; label val noschool_reason2 noschool_reason;
rename s082q113 noschool_reason3; label var noschool_reason3 "COM: Why don't children go to school? (Top 3)"; label val noschool_reason3 noschool_reason;

**//ILLNESS;
rename s091q11 illness1; label var illness1 "COM: Top 3 illnesses/diseases of concern in this commune?"; label define illness 1 malaria 2 leprosy 3 goiter 4 tuberculosis 5 "other respiratory" 6 "dengue fever" 7 "childhood illness (diph,measles,polio,tetanus)" 8 "diarrhea/dysentery" 9 "child malnutrition" 10 rabies 11 "accident/injury" 12 "complicated birth" 13 other; label val illness1 illness;
rename s091q12 illness2; label var illness2 "COM: Top 3 illnesses/diseases of concern in this commune?"; label val illness2 illness;
rename s091q13 illness3; label var illness3 "COM: Top 3 illnesses/diseases of concern in this commune?"; label val illness3 illness;


**//REPLACE BINARY{1,2} W/ BINARY{0,1);
foreach var in factory handicrafts agriculture areause roadaccess infra_imps cropland noschool {; 
replace `var'=0 if `var'==2;};


**//MERGE IN DATA MATCHING DISTRICT TO COMMUNE;
cd ..; cd ..; cd ..;
rename cluster commune;/*Strangely, the variable cluster in the commune file is equivalent to the variable commune in the household file*/
sort commune;
merge commune using comVLSSmatch.dta, nokeep; tab _merge; drop _merge; 
rename districtcode district; sort district;
save comvlss98.dta, replace;  /*THIS FILE IS COMMUNE-LEVEL DATA THAT INCLUDES DISTRICT CODES*/



/***********************************************************************************************************************************/
**//COLLAPSE COMMUNE DATA TO DISTRICT LEVEL FOR 1998;

**//RESHAPING WIDE & COLLAPSING TO DISTRICT-LEVEL OBS; **//KEEP ONLY ENTRIES WITH GOOD GSO CODE MATCH;
drop if district==.;
/*COLLAPSE COMVLSS98*/
collapse popcomm popcomm_year geogtype maininc1 maininc2 maininc3
    changelivstd changelivstdreason1 changelivstdreason2 changelivstdreason3
    numpoorhh immigration factory
    handicrafts handicraftshh agriculture area_ha roadaccess roaddistance infra_imps
    infra_imps_type1 infra_imps_type2 infra_imps_type3
    illness1 illness2 illness3, by(district);
    sort district; save comvlss98collapse.dta, replace;
/*GET MORE DATA FROM COMVLSS98, THEN MERGE IT INTO COMVLSS98COLLAPSE*/
use comvlss98.dta, clear; drop if district==.;
    collapse areause areause_ha, by(district areausetype); 
    keep if areausetype~=.;
    reshape wide areause areause_ha, i(district) j(areausetype); sort district; 
    merge district using comvlss98collapse.dta; tab _merge; drop _merge; sort district; save comvlss98collapse.dta, replace;
use comvlss98.dta, clear; drop if district==.;
    collapse cropland cropland_ha, by(district croplandtype); 
    keep if croplandtype~=.;
    reshape wide cropland cropland_ha, i(district) j(croplandtype); sort district; 
    merge district using comvlss98collapse.dta; tab _merge; drop _merge; sort district; save comvlss98collapse.dta, replace;
use comvlss98.dta, clear; drop if district==.;
    collapse noschool noschool_reason1 noschool_reason2 noschool_reason3, by(district noschool_level); 
    reshape wide noschool noschool_reason1 noschool_reason2 noschool_reason3, i(district) j(noschool_level); sort district; 
    merge district using comvlss98collapse.dta; tab _merge; drop _merge; sort district; save comvlss98collapse.dta, replace;
use comvlss98.dta, clear; drop if district==.;
    collapse factorydistance factorylabor, by(district factorycode); 
    reshape wide factorydistance factorylabor, i(district) j(factorycode); sort district; 
    merge district using comvlss98collapse.dta; tab _merge; drop _merge; sort district; save comvlss98collapse.dta, replace;
use comvlss98.dta, clear; drop if district==.;
    gen maincrop=maincrops; collapse maincrop, by(district maincrops); quietly by district: replace maincrops=_n;
    reshape wide maincrop, i(district) j(maincrops); sort district;
    merge district using comvlss98collapse.dta; tab _merge; drop _merge; sort district; save comvlss98collapse.dta, replace;

**//RENAME & RELABEL;
label var popcomm "COM: how many usually live in this commune/ward?";
label var popcomm_year "COM: What year is popcomm from?";
label var geogtype "COM: Geographical Region"; label val geogtype geogtype;
label var maininc1 "COM: Three main sources of income"; label val maininc1 maininc;
label var maininc2 "COM: Three main sources of income"; label val maininc2 maininc;
label var maininc3 "COM: Three main sources of income"; label val maininc3 maininc;
label var changelivstd "COM: Has living std in comm/ward -1)declined 0)same 1)improved in past 5yrs?";
label var changelivstdreason1 "COM: Top 3 reasons living standard has (not) changed."; label val changelivstdreason1 changelivstdreason;
label var changelivstdreason2 "COM: Top 3 reasons living standard has (not) changed."; label val changelivstdreason2 changelivstdreason;
label var changelivstdreason3 "COM: Top 3 reasons living standard has (not) changed."; label val changelivstdreason3 changelivstdreason;
label var numpoorhh "COM: How many hh in comm/ward certified poor by pvty alleviation pgm?";
label var immigration "COM: Since 1992/1993, have more moved permanently in than out of commune?"; label val immigration immigration;
label var factory "COM: Are there factories w/i 10km that absorb labor from this comm/ward?";

foreach label of varlist factorydistance* {; label var `label' "COM: EMP: How far to factory j from center of comm/ward? km";};
foreach label of varlist factorylabor* {; label var `label' "COM: EMP: How many people from this comm/ward work at factory j?";};
label var handicrafts "COM: Are there traditional occupations/handicrafts in comm/ward?";
label var handicraftshh "COM: How many hh participate in handicrafts?";
label var agriculture "COM: Is agriculture an important source of income?";

**//WHAT KIND OF CROPS MIGHT WE BE INTERESTED IN?;
foreach label of varlist maincrop* {; label var `label' "COM: Main Crops: See Crop Codes"; label val `label' cropcodes;};
label var area_ha "COM: Commune/ward area, hectares";

**//WHAT KIND OF AREA USE MIGHT WE BE INTERESTED IN?;
foreach string in areause areause_ha {; rename `string'1 `string'_annualcrop; rename `string'2 `string'_perennialcrop; 
    rename `string'3 `string'_watersurface; rename `string'4 `string'_forest; 
    rename `string'5 `string'_residential; rename `string'6 `string'_special; 
    rename `string'7 `string'_unused;};
foreach name of varlist areause_ha* {; label var `name' "COM: Does this comm/ward have any area of type j?";};
foreach name of varlist areause_a areause_p areause_w areause_f areause_r areause_s areause_u {; label var `name' "COM: What is the total area of this area of type j? ha";};

**//WHAT KIND OF CROPS MIGHT WE BE INTERESTED IN?;
foreach num of numlist 1/9 {; label var cropland`num' "COM: Does commune cultivate crop of type j?";};
foreach string in cropland cropland_ha {; rename `string'1 `string'_rice; rename `string'2 `string'_othergrtub; rename `string'3 `string'_othfood;
    rename `string'4 `string'_annind; rename `string'5 `string'_othann; rename `string'6 `string'_perenind; rename `string'7 `string'_fruittrees;
    rename `string'8 `string'_othperenn; rename `string'9 `string'_forest;};
foreach name of varlist cropland_ha* {; label var `name' "COM: How much of the total area of this comm/ward is planted in crop type j? ha";};
label var roadaccess "COM: Is there a road to this village that a car can travel on?";
label var roaddistance "COM: How far away is the nearest road a car can travel on, km?";
label var infra_imps "COM: Was there there infrastructure built/improved between 94/95-97/98?";
label var infra_imps_type1 "COM: Top 3 Infrastructure Buildings/Improvements 94/95-97/98"; label val infra_imps_type1 infra_imps_type;
label var infra_imps_type2 "COM: Top 3 Infrastructure Buildings/Improvements 94/95-97/98"; label val infra_imps_type2 infra_imps_type;
label var infra_imps_type3 "COM: Top 3 Infrastructure Buildings/Improvements 94/95-97/98"; label val infra_imps_type3 infra_imps_type;

**//SCHOOL LEVELS;
foreach num of numlist 1/3 {; label var noschool`num' "COM: Are there school-age children who don't go to school level j?";};
foreach name in noschool noschool_reason1 noschool_reason2 noschool_reason3 {; rename `name'1 `name'_prim; rename `name'2 `name'_lowsec; rename `name'3 `name'_uppersec;};
foreach name of varlist noschool_reason* {; 
    label var `name' "COM: Why don't children go to school at level j? (Top 3 Reasons)"; 
    label val `name' noschool_reason;};

**//ILLNESS;
label var illness1 "COM: Top 3 illnesses/diseases of concern in this commune?"; label val illness1 illness;
label var illness2 "COM: Top 3 illnesses/diseases of concern in this commune?"; label val illness2 illness;
label var illness3 "COM: Top 3 illnesses/diseases of concern in this commune?"; label val illness3 illness;

**//SIMPLIFICATION OF FACTORY VARIABLE;
egen factorydistance_min=rmin(factorydistance*);
egen factorylabor_sum=rsum(factorylabor*);

sort district;
save comvlss98collapse.dta, replace;  /*THIS FILE IS COMMUNE-LEVEL DATA COLLAPSED TO DISTRICT LEVEL*/


/*******************************************************************************************************************************/

**//CREATE A FILE WITH BOTH HOUSEHOLD AND COMMUNE DATA FOR '98, BY HOUSEHOLD;

use comvlss98.dta;
sort commune;
save comvlss98.dta, replace;

use hhvlss98.dta;
sort commune;
merge commune using comvlss98.dta;
drop _merge;


save vlss98hhcom, replace;

/************************************************************************************************************************************/

**//CREATE A FILE WITH '93 HH AND '98 HH & COMMUNE DATA, BY HOUSEHOLD;
sort vlss93cluster vlss93hh vlss93idc;
merge vlss93cluster vlss93hh vlss93idc using hhvlss93; /*NOKEEP NOT INCLUDED SO SOME DISTRICTS WON'T HAVE MATCHES BETWEEN YEARS*/
drop _merge;


gen CONSCHANGEHH=rlhhex1-exp93r98; label var CONSCHANGEHH "HH Cons Change 93-98, in 98 1000VND adj reg/mo price diffs";
gen CONSCHANGEPC=rlpcex1-exppc93r98; label var CONSCHANGEPC "HH Percap Cons Change 93-98, in 98 1000VND adj reg/mo price diffs";
gen CONSGROWTHHH=CONSCHANGEHH/exp93r98; label var CONSGROWTHHH "HH Cons %Change 93-98, adj reg/mo price diffs";
gen CONSGROWTHPC=CONSCHANGEPC/exppc93r98; label var CONSGROWTHPC "HH Percap Cons %Change 93-98, adj reg/mo price diffs";

gen provinceall = province;
replace provinceall = vlss93province if provinceall==.;
label var provinceall "province codes for 93 and 98 households";
rename province province98;
rename provinceall province;

save hhvlss98_93.dta, replace;







/**********************************************************************************************************************************/

**//COLLAPSE ALL FILES BY DISTRICT - district files are still collapsed using '98 district codes - fix this if possible;
/*hhvlss98_93 FILE*/
**//KEEP HEADS AND PANEL HOUSEHOLDS ONLY! KEEP ONLY OBS WITH GOOD GSO DISTRICT CODE MATCHES;
**//keep if reltohead==1 & vlss93==1; /*ONLY KEEP OBSERVATIONS WITH DATA IN BOTH YEARS*/ /*THIS LINE LEFT OUT FOR NOW*/

**//COLLAPSE BOTH '98 AND '93 DATA USING '98 WEIGHTS, BECAUSE WE ONLY HAVE DISTRICT DATA FOR '98.;
keep if reltohead==1;
duplicates drop; /*househol 18711 has two duplicate hhhead entries*/ 
drop if district==.;
sort district;

**//COLLAPSES TO DISTRICT LEVEL. SKETCHY WITH CATEGORICAL VARIABLES;
**//NOTE MEAN-COLLAPSE WEIGHTING: ALL RELEVANT VARIABLES WEIGHTED BY HHSIZEWT (# PERSONS REPRESENTED BY HOUSEHOLD,) 
    EXCEPT HHSIZE (AVG HOUSEHOLD SIZE,) WEIGHTED BY WT (# HH REPRESENTED BY HH)
    AND HHSIZEWT, WHICH IS SUMMED (NOT MEANED) UNWEIGHTED, TO GET # PERSONS REPRESENTED BY DISTRICT'S COMMUNES.;


**//NOTE: IT IS NOT CLEAR HOW TO WEIGHT THE '93 DATA, SO WE JUST USE '98 WEIGHTS;
collapse (mean) /*98 variables*/
        female   ageyrs   farm avg_ill4wks   ill4wks    avg_hospital12mths dliterate_all   dnumerate_all   bornhere   yrshere   
        dkinh   dchinese   disabled   vetassoc educyr98father educyr98father_comp educyr98mother educyr98mother_comp 
        irr_frac irr_frac_old
        dflushtoilet delectricity ddwellingfullyowned ddwellingpartowned workedpast12mo_all anysalary_all
        comped98father comped98mother educyrself edgrade salaryfrac_all
        
        /*93 variables*/
        female93 ageyrs93      avg_ill4wks93 ill4wks93    dliterate_all93 dnumerate_all93 bornhere93 yrshere93    
        dkinh93 dchinese93 disabled93 educyrfather93 educyrmother93 delectricity93 dflushtoilet93  irr_frac93 irr_frac_alt93 
        dwellingshared93
        dwellingowned93 workedpast12mo_all93 anysalary_all93 compedfather93 compedmother93 diploma93 educyrself93 edgrade93
        salaryfrac_all93 agr_activity93 cropland93 owned_crop93
        
        /*'98 expenditures*/
        ricexpd nonrice totnfdx1 totnfdhp totnfdh1 
        food nonfood1 hhexp1 pcexp1 pcfdex1
        rlfood rlnfd1 rlhhex1 rlpcex1 rlpcfdex nonfood2 hhexp2 pcexp2 rlhhex2 rlpcex2
        
        /*'93 expenditures*/
        com93 calpc93 calok93 expb93 exph93 exp93 exppc93 fexp93 fpct93 hfpct93 ricevb93 ricevh93 riceqb93 riceqh93 maizev93 
        maizeq93 maniocv93 maniocq93 swpotv93 swpotq93 rcpi93 mcpi93 exp93r98 exppc93r98 ricexpd93 nonrice93 totnfdx193 totnfdh193 
        nonfood193 pcfdex193 CONSCHANGEHH CONSCHANGEPC CONSGROWTHHH CONSGROWTHPC
        
        /*Other variables from Minot's files*/
        urban98 urban92 comped98_head educyr98_head
     (sum)  landarea_crop landarea_other     
    (count) count_hh=househol count_avgill4wks=avg_ill4wks 
        count_avghospital12mths=avg_hospital12mths count_ed98father=comped98father count_ed98mother=educyr98mother 
        count_workedpast12mo=workedpast12mo    count_yearsinwork=yearsinwork count_salary=salary count_bornhere=bornhere 
        count_yrshere=yrshere
        
        count_hh93 = vlss93hh count_avgill4wks93= avg_ill4wks93
        /*no hospital for '93*/
        /*add education variables*/
    [w=hhsizewt], by(district) fast;



sort district; save hhvlss9893collapse.dta, replace; 


**//COMMANDS FOR MERGING ADDITIONAL DATA INTO HHVLSS9893COLLAPSE;
use hhvlss98_93.dta, clear; sort district; keep if reltohead==1; duplicates drop; drop if district==.;
    collapse (mean) vlss93 [w=hhsizewt], by(district); rename vlss93 pctpanel;
    label var pctpanel "PANEL: % of 98 HHs in district that were surveyed in VLSS93";
    sort district; save temphh.dta, replace;
    use hhvlss9893collapse.dta, clear; merge district using temphh.dta, nokeep; tab _merge; drop _merge; sort district; save hhvlss9893collapse.dta, replace;
use hhvlss98_93.dta, clear; sort district; keep if reltohead==1; duplicates drop; drop if district==.;
    collapse (mean) hhsize [w=wt], by(district); 
    label var hhsize "HH: Avg HH size in district";
    sort district; save temphh.dta, replace;
    use hhvlss9893collapse.dta, clear; merge district using temphh.dta; tab _merge; drop _merge; sort district; save hhvlss9893collapse.dta, replace;
use hhvlss98_93.dta, clear; sort district; keep if reltohead==1; duplicates drop; drop if district==.;
    collapse (sum) hhsizewt, by(district); rename hhsizewt communeweight;
    label var communeweight "VLSS98: # persons represented by surveyed district (sum across district of hhsizewt)";
    sort district; save temphh.dta, replace;
    use hhvlss9893collapse.dta, clear; merge district using temphh.dta; tab _merge; drop _merge; sort district; save hhvlss9893collapse.dta, replace;



**//COLLAPSE 93 AND 98 BY PROVINCE;

use hhvlss98_93.dta;

**//KEEP HEADS AND PANEL HOUSEHOLDS ONLY! KEEP ONLY OBS WITH GOOD GSO DISTRICT CODE MATCHES;

**//replace province =  int(communecode/10000); /*just in case there are any new provinces, but I don't think there are*/
**//label var province "int(communecode/10000), for collapsing & merging w/02 data";
**//save hhvlss98_93.dta, replace;

/*1998 DATA ONLY*/
drop if province==.;
keep if reltohead==1;
duplicates drop; /*househol 18711 has two duplicate hhhead entries*/ 
sort province;

**//NOTE: USE 98 WEIGHTS FOR 98 DATA, NO WEIGHTS NEEDED FOR 93 DATA;
collapse (mean) /*98 variables*/
        female   ageyrs   farm avg_ill4wks   ill4wks    avg_hospital12mths dliterate_all   dnumerate_all   bornhere   yrshere   
        dkinh   dchinese   disabled   vetassoc educyr98father educyr98father_comp educyr98mother educyr98mother_comp 
        irr_frac irr_frac_old
        dflushtoilet delectricity ddwellingfullyowned ddwellingpartowned workedpast12mo_all anysalary_all 
        comped98father comped98mother educyrself edgrade salaryfrac_all
        
        
        /*'98 expenditures*/
        ricexpd nonrice totnfdx1 totnfdhp totnfdh1 
        food nonfood1 hhexp1 pcexp1 pcfdex1
        rlfood rlnfd1 rlhhex1 rlpcex1 rlpcfdex nonfood2 hhexp2 pcexp2 rlhhex2 rlpcex2
        
        CONSCHANGEHH CONSCHANGEPC CONSGROWTHHH CONSGROWTHPC
        
        /*Other variables from Minot's files*/
        urban98 /*urban92*/ comped98_head educyr98_head    
     (sum)  landarea_crop landarea_other     
    (count) count_hh=househol count_avgill4wks=avg_ill4wks 
        count_avghospital12mths=avg_hospital12mths count_ed98father=comped98father count_ed98mother=educyr98mother 
        count_workedpast12mo=workedpast12mo    count_yearsinwork=yearsinwork count_salary=salary count_bornhere=bornhere 
        count_yrshere=yrshere
        
        count_hh93 = vlss93hh
        /*no hospital for '93*/
        /*add education variables*/
    [w=hhsizewt], by(province) fast;




sort province; save hhvlss98collapse_province.dta, replace; 


**//COMMANDS FOR MERGING ADDITIONAL DATA INTO HHVLSS9893COLLAPSE_PROVINCE;
use hhvlss98_93.dta, clear; sort province; keep if reltohead==1; duplicates drop; drop if province==.;
    collapse (mean) vlss93 [w=hhsizewt], by(province); rename vlss93 pctpanel;
    label var pctpanel "PANEL: % of 98 HHs in province that were surveyed in VLSS93";
    sort province; save temphh.dta, replace;
    use hhvlss98collapse_province.dta, clear; merge province using temphh.dta, nokeep; tab _merge; drop _merge; sort province; save hhvlss98collapse_province.dta, replace;
use hhvlss98_93.dta, clear; sort province; keep if reltohead==1; duplicates drop; drop if province==.;
    collapse (mean) hhsize [w=wt], by(province); 
    label var hhsize "HH: Avg HH size in province";
    sort province; save temphh.dta, replace;
    use hhvlss98collapse_province.dta, clear; merge province using temphh.dta; tab _merge; drop _merge; sort province; save hhvlss98collapse_province.dta, replace;
use hhvlss98_93.dta, clear; sort province; keep if reltohead==1; duplicates drop; drop if province==.;
    collapse (sum) hhsizewt, by(province); rename hhsizewt communeweight;
    label var communeweight "VLSS98: # persons represented by surveyed province (sum across province of hhsizewt)";
    sort province; save temphh.dta, replace;
    use hhvlss98collapse_province.dta, clear; merge province using temphh.dta; tab _merge; drop _merge; sort province; save hhvlss98collapse_province.dta, replace;



use hhvlss98_93.dta;

**//KEEP HEADS AND PANEL HOUSEHOLDS ONLY! KEEP ONLY OBS WITH GOOD GSO DISTRICT CODE MATCHES;

**//replace province =  int(communecode/10000); /*just in case there are any new provinces, but I don't think there are*/
**//label var province "int(communecode/10000), for collapsing & merging w/02 data";
**//save hhvlss98_93.dta, replace;

/*1993 DATA ONLY*/
drop if province==.;
keep if reltohead93==1;
duplicates drop; /*househol 18711 has two duplicate hhhead entries*/ 
sort province;

**//NOTE: NO WEIGHTS NEEDED FOR 93 DATA;
collapse (mean) /*93 variables*/
        female93 ageyrs93      avg_ill4wks93 ill4wks93    dliterate_all93 dnumerate_all93 bornhere93 yrshere93    
        dkinh93 dchinese93 disabled93 educyrfather93 educyrmother93 delectricity93 dflushtoilet93  irr_frac93 irr_frac_alt93 
        dwellingshared93
        dwellingowned93 workedpast12mo_all93 anysalary_all93 compedfather93 compedmother93 diploma93 educyrself93 edgrade93
        salaryfrac_all93 agr_activity93 cropland93 owned_crop93
        
        /*'93 expenditures*/
        com93 calpc93 calok93 expb93 exph93 exp93 exppc93 fexp93 fpct93 hfpct93 ricevb93 ricevh93 riceqb93 riceqh93 maizev93 
        maizeq93 maniocv93 maniocq93 swpotv93 swpotq93 rcpi93 mcpi93 exp93r98 exppc93r98 ricexpd93 nonrice93 totnfdx193 totnfdh193 
        nonfood193 pcfdex193 CONSCHANGEHH CONSCHANGEPC CONSGROWTHHH CONSGROWTHPC
        
        /*Other variables from Minot's files*/
        urban92    
         (count) count_hh93 = vlss93hh count_avgill4wks93= avg_ill4wks93
        /*no hospital for '93*/
        /*add education variables*/
        , by(province) fast;




sort province; save hhvlss93collapse_province.dta, replace; 


**//COMMANDS FOR MERGING ADDITIONAL DATA INTO HHVLSS9893COLLAPSE_PROVINCE;
use hhvlss98_93.dta, clear; sort province; keep if reltohead==1; duplicates drop; drop if province==.;
    collapse (mean) hhsize93, by(province); 
    label var hhsize93 "HH: Avg HH size in province, 93";
    sort province; save temphh.dta, replace;
    use hhvlss93collapse_province.dta, clear; merge province using temphh.dta; tab _merge; drop _merge; sort province; save hhvlss93collapse_province.dta, replace;


/*MERGE THE 93 AND 98 FILES*/
use hhvlss98collapse_province;
merge province using hhvlss93collapse_province;
sort province;
drop _merge;
save hhvlss9893collapse_province, replace;


/*ADD LABELS TO BOTH COLLAPSED FILES*/
foreach filename in hhvlss9893collapse.dta hhvlss9893collapse_province.dta {;
use "`filename'", clear;

drop com93;

rename female sex_head_female;
rename ageyrs age_head;

label var sex_head_female "Percentage with female household heads in 98";
label var age_head "Average age of household head in 98";

label var dkinh "Proportion ethnic Vietnamese in 98";
label var dchinese "Proportion ethnic Chinese in 98";

label var comped98_head "From Minot: highest diploma completed";

**//Codes for comped98_head: 0 Never 1 "Nhatre = Kindergarten" 2 "<cap I = <primary" 3 "Cap I = Primary" 4 "Cap II = Lower Sec" 
    5 "Cap III = Higher Sec" 6 "Nghe SC = Voc Training" 7 "THCN = Secondary Voc Training" 8 DHDC 9 "DHCD = Bachelors" 
    10 "Thac sy = Masters" 11 "PTS = PhD Candidate" 12 "TS = PhD", modify;


label var comped98father "EDPAR: Father's highest diploma, ~=93"; 
label var comped98mother "EDPAR: Mother's highest diploma, ~=93"; 
label var bornhere "IMM: Born in current district?";
label var yrshere "IMM: How many years have you lived in current residence?";
label var landarea_crop "total area of all cropland owned and used";
label var landarea_other "total area of other land owned and used";
label var disabled "1 if whynolook ==2 (disabled)";
label var dliterate_all "1 if person can read given sentence with no difficulty";
label var delectricity "1 if lightingsource is electricity";
label var dflushtoilet "1 if toilettype is flush w/septic sewage";
label var dnumerate_all "1 if person can do given calculations with no difficulty";
label var workedpast12mo_all "=1 if workedpast12mo = 1 or workedpast7d ==1";
label var anysalary_all "1 if person receives salary, main or sec. job (past 12 mos.,complete), 0=no job or no salary.";
label var avg_ill4wks "ill4wks*ill4wks_days (no. days ill in past 4 weeks); 0 if ill4wks = 0";
label var avg_hospital12mths "hospital12mths*hospital12mths_days (number of days in hospital in last 12 mos), 0 if hospital12mths==0";
label var educyr98father "EDPAR: Father's yrs school = fatheredgrade+fatheredpostsec (fatheredgrade=13(dk) removed), ~=93";
label var educyr98father_comp "EDPAR: Father's yrs sch = fatheredgrade+fatheredpostsec, no postsec above U/C7, comp. to '93";
label var educyr98mother "EDPAR: Mother's yrs school = motheredgrade+motheredpostsec, ~=93";
label var educyr98mother_comp "EDPAR: Mother's yrs sch = motheredgrade+motheredpostsec, no postsec above U/C7";
label var ddwellingfullyowned "1 if dwellingowned ==2 (fully owned)";
label var ddwellingpartowned "1 if dwellingowned ==1 (part owned)";
label var irr_frac_old "Proportion own land irrigated 1998";
label var irr_frac "Proportion own cropland irrigated 1998";
label var educyrself "ED: edgrade + years in jr. coll., univ, or grad. - no vocational sch. incl.[~=93]";
label var edgrade "ED: Highest grade completed, 98";
label var salaryfrac_all "fraction per hh with salaried job (main or secondary)";


/*Labels from Minot's file*/
label var comped98_head "diploma    completed diploma HH.head";
label var educyr98_head "schooling year of HH.head (should equal educyrself)";
label var farm "loaiho     Type of HH (1:farm; 0:nonfarm)";
label var urban98 "urban      1:urban 98; 0:rural 98";
label var urban92 "urban      1:urban92; 0:rural92";
label var ricexpd "Value rice expenditures";
label var nonrice "Value food expenditures no rice";
label var totnfdx1 "Nonfood exp.purchase";
label var totnfdhp "Nonfood home production";
label var totnfdh1 "Nonfood home prod. drop 103";
**//label var hhexp12m "Medical expenditures (4W+12m)";
**//label var hhexp121 "Medical exp.12m drop insurance";
**//label var hhexp12i "Medical exp. 12m inc. insurance";
label var food "nominal food expenditures";
label var nonfood1 "comp.nominal nfood exp.";
label var hhexp1 "comp.nominal total exp.";
label var pcexp1 "comp.nominal pc exp.";
label var pcfdex1 "comp.nominal pc food exp.";
label var rlfood "comp.M&Reg price adj.food exp";
label var rlnfd1 "comp.M&Reg price adj.nfood exp";
label var rlhhex1 "comp.M&Reg price adj.tot exp";
label var rlpcex1 "comp.M&Reg price adj.pc tot exp";
label var rlpcfdex "comp.M&Reg price adj.pc food ex";
label var nonfood2 "B.value for 98 nominal nfood";
label var hhexp2 "B.value for 98 nominal tot exp";
label var pcexp2 "B.value for 98 nominal pc exp";
**//label var rlnfd2 "B.M&Reg price adj. nfood exp";
label var rlhhex2 "B.M&Reg price adj. tot exp";
label var rlpcex2 "B.M&Reg price adj. pc exp";

        

/*1993 labels*/
rename female93 sex_head_female93;
rename ageyrs93 age_head93;

label var sex_head_female93 "Percentage with female household heads in 93";
label var age_head93 "Average age of household head in 93";

label var dkinh93 "Proportion ethnic Vietnamese in 93";
label var dchinese93 "Proportion ethnic Chinese in 93";

label var sex_head_female93 "ID: 0=male, 1=female ";
label var age_head93 "ID: Age, full years ";
label var compedfather93 "EDPAR: Father's highest diploma  ";
label var compedmother93 "EDPAR: Mother's highest diploma  ";
label var ill4wks93 "HEALTH: Any illness or injury reported in past 4 wks? ";
label var bornhere93 "IMM: Born in current district? ";
label var dwellingshared93 "HOUSE: Does household share dwelling with another household?";
label var dwellingowned93 "HOUSE: Does this dwelling belong to a member of your household?";
label var agr_activity93 "Has any HH member had the right to any land?";
label var cropland93 "HH member worked on annual crop land belongingn to HH?";
label var owned_crop93 "How many square m. of private annual crop land are owned by HH?";
**//label var farmed_crop93 "Sum of How much of the crop land is of quality type ___? over all types.";
**//label var farmed_crop_irr93 "Sum of How many square meters of this land are irrigated? over all types.";
**//label var wtdquality93 "Wtd. (by land area) sum of quality rating of land farmed by household.";
label var dkinh93 "1 if tribe93 = kinh (1)";
label var dchinese93 "1 if tribe93 = chinese (4)";
label var disabled93 "1 if whynolook93 ==2 (disabled) (Only available if person had no job)";
label var workedpast12mo_all93 "=1 if workedpast12mo93 = 1 or workedpast7d93 ==1";
**//label var yearsinwork_all93 "yearsinwork93, or yearsinwork7d93 (secyearsinwork7d93) if sameasmain93==1 (2)";
**//label var monthsinwork_all93 "monthsinwork93, or monthsinwork7d93 (secmonthsinwork7d93) if sameasmain93==1 (2)";
**//label var salary_all93 "salary93, or salary7d93 (secsalary7d93)  if sameasmain93 ==1 (2)";
**//label var secsalary_all93 "secsalary93, or salary7d93 (secsalary7d93)  if secsameasmain93 ==1 (2)";
label var anysalary_all93 "1 if person receives salary, main or sec. job (past 12 mos.,complete), 0=no job or no salary..";
label var irr_frac93 "***Proportion own cropland irrigated 1993: this should be checked because questionnaire is unclear.";
label var irr_frac_alt93 "farmed_crop93/farmed_crop_irr93: proportion of cultivated cropland that is irrigated - should be checked";
label var dliterate_all93 "1 if person can read and write";
label var delectricity93 "1 if lightingsource93 is electricity";
label var dflushtoilet93 "1 if toilettype93 is flush w/septic sewage";
label var dnumerate_all93 "1 if person can do written calculations";
label var avg_ill4wks93 "ill4wks93*ill4wks_days93 (no. days ill in past 4 weeks), 0 if ill4wks93 = 0";
label var educyrself93 "ED: edgrade93 (1-12) plus edyrspostsec93 (univ. or vocat. sch. yrs) [~=98]";
label var edgrade93 "ED: Highest grade completed (1-12)";
label var diploma93 "ED: Highest diploma completed (similar, but not = comped98_head)";
label var salaryfrac_all93 "fraction per hh with salaried job (main or secondary)";

 


/*labels from Minot's file for 1993*/
label var exp93 "consumption expenditure 93";
label var expb93 "cons. exp. bought/bartered 93";
label var exph93 "cons. exp. hh product 93";
label var exppc93 "exp/hhsize";
label var fexp "cons. exp. food only 93";
label var fpct "fexp/exp";
label var hfpct "fraction of food expenditure hhproduct";
label var ricevb93 "Value of bought rice 1000VND";
label var ricevh93 "Value of home produced rice 1000VND";
label var riceqb93 "Quantity of bought rice kg?";
label var riceqh93 "Quantity of home produced rice kg?";
label var maizev93 "Value of maize 1000VND";
label var maizeq93 "Quantity of maize kg?";
label var maniocv93 "Value of manioc 1000VND";
label var maniocq93 "Quantity of manioc kg?";
label var swpotv93 "Value of sweet potatoes 1000VND";
label var swpotq93 "Quantity of sweet potatoes kg?";

label var ricexpd93 "Expenditure on rice 1000VND, 93: ricevb93+ricevh93";
label var nonrice93 "Expenditure on food, no rice 1000VND, 93: fexp93-ricexpd93";
label var totnfdx193 "Expenditure on non-food purchased/bartered 1000VND, 93: expb93-(1-hfpct93)*fexp93";
label var totnfdh193 "Value of home production of non-food, 93: exph93-(hfpct93*fexp93)";
label var nonfood193 "Avg non-food expenditure, current 1000VND, 93: exp93-fexp93";
label var pcfdex193 "Exp per cap on food(stuffs), current price 1000VND 93: exppc93*fpct93";
label var exp93r98 "real cons exp 93, in 98 1000VND, (adj for reg/mo price diff: (exp93/(rcpi93*mcpi93))*1.456)";
label var exppc93r98 "real cons exp per cap 93, in 98 1000VND, (adj for reg/mo price diff: (exppc93/(rcpi93*mcpi93))*1.456)";
label var rcpi93 "Regional Price Deflator, 93";
label var mcpi93 "Monthly price deflator 93 (based on mo of 2nd rd survey), Jan93=1";
label var CONSCHANGEHH "HH Cons Change 93-98, in 98 1000VND adj reg/mo price diffs: rlhhex1-exp93r98";
label var CONSCHANGEPC "HH Percap Cons Change 93-98, in 98 1000VND adj reg/mo price diffs: rlpcex1-exppc93r98";
label var CONSGROWTHHH "HH Cons %Change 93-98, adj reg/mo price diffs: CONSCHANGEHH/exp93r98";
label var CONSGROWTHPC "HH Percap Cons %Change 93-98, adj reg/mo price diffs: CONSCHANGEPC/exppc93r98";


/*Labels for calpc93 calok93?*/
        
save "`filename'", replace; 

};



/*02 FILE*/
/*THIS SEEMS TO BE THE WAY TO COLLAPSE BY DISTRICT*/
/*NOTE THAT THERE SEEM TO BE A LOT MORE DISTRICTS IN 02 THAN PREVIOUS YEARS, PRBLY BECAUSE SURVEY HAS A MUCH LARGER SAMPLE SIZE*/

/*KEEP ONLY HOUSEHOLD HEADS TO BE CONSISTENT WITH 93 & 98*/
use hhvlss02.dta;
gen hhsizewt02 = wt30*hhsize02;
gen district = int(communecode/100);
label var district "Used for merging with '92 & '98 district data and collapsing";
gen province = int(communecode/10000);
label var province "Used for merging with '92 & '98 province data and collapsing";
save hhvlss02.dta, replace;

keep if reltohead02==1;
duplicates drop;
drop if district==.;
destring, replace; /*some numeric variables are in string form*/
sort district;

collapse  female02 ageyrs02 edgrade02 dliterate_all02 diploma02 school02 workforother02 workonownfield02 selfemp02 havework02 
    lookedforwork02 mosworkedlastyr02 agr_activity02 agrland02 cropland02 
    longterm_crop02 irrinc02 irrexp02 ddwellingfullyowned02 ddwellingpartowned02 invalids02 elderly02 delectricity02 dflushtoilet02 
    food02 nonfood02 hhexp02 pcexp02 dkinh02 dhoa02  exp02r98 exppc02r98  
    (count) count_hh02 = househol02
    [w=hhsizewt02], by(district) fast; /*CHECK WEIGHTS - IS THIS HOW THEY ARE USED?*/

sort district;
save hhvlss02collapse.dta, replace;

/*NOTE: IN GENERAL, ALL VARIABLES ARE NOW AVERAGES OF HOUSEHOLD HEADS*/

use hhvlss02.dta, clear; sort district; keep if reltohead02==1; duplicates drop; drop if district==.;
    collapse (mean) hhsize02 [w=wt30], by(district); 
    label var hhsize02 "HH: Avg HH size in district";
    sort district; save temphh.dta, replace;
    use hhvlss02collapse.dta, clear; merge district using temphh.dta; drop _merge; sort district; save hhvlss02collapse.dta, replace;
use hhvlss02.dta, clear; keep if reltohead02==1; duplicates drop; drop if district ==.;
    collapse (sum) hhsizewt02, by(district); rename hhsizewt02 communeweight02;
    label var communeweight02 "VLSS02: # persons represented by surveyed district (sum across district of hhsizewt)";
    sort district; save temphh.dta, replace;
    use hhvlss02collapse.dta, clear; merge district using temphh.dta; drop _merge; sort district; save hhvlss02collapse.dta,replace;


/*COLLAPSE 02 FILE TO PROVINCE LEVEL*/
use hhvlss02.dta;

keep if reltohead02==1;
duplicates drop;
drop if province==.;
destring, replace; /*some numeric variables are in string form*/

sort province;

collapse  female02 ageyrs02 edgrade02 dliterate_all02 diploma02 school02 workforother02 workonownfield02 selfemp02 havework02 
    lookedforwork02 mosworkedlastyr02 agr_activity02 agrland02 cropland02 
    longterm_crop02 irrinc02 irrexp02 ddwellingfullyowned02 ddwellingpartowned02 invalids02 elderly02 delectricity02 dflushtoilet02 
    food02 nonfood02 hhexp02 pcexp02 dkinh02 dhoa02 exp02r98 exppc02r98  
    (count) count_hh02 = househol02
    [w=hhsizewt02], by(province) fast; /*CHECK WEIGHTS - IS THIS HOW THEY ARE USED?*/

sort province;
save hhvlss02collapse_province.dta, replace;

/*NOTE: IN GENERAL, ALL VARIABLES ARE NOW AVERAGES OF HOUSEHOLD HEADS*/

use hhvlss02.dta, clear; sort province; keep if reltohead02==1; duplicates drop; drop if district==.;
    collapse (mean) hhsize02 [w=wt30], by(province); 
    label var hhsize02 "HH: Avg HH size in province";
    sort province; save temphh.dta, replace;
    use hhvlss02collapse_province.dta, clear; merge province using temphh.dta; drop _merge; sort province; save hhvlss02collapse_province.dta, replace;
use hhvlss02.dta, clear; keep if reltohead02==1; duplicates drop; drop if province ==.;
    collapse (sum) hhsizewt02, by(province); rename hhsizewt02 communeweight02;
    label var communeweight02 "VLSS02: # persons represented by surveyed province (sum across province of hhsizewt)";
    sort province; save temphh.dta, replace;
    use hhvlss02collapse_province.dta, clear; merge province using temphh.dta; drop _merge; sort province; save hhvlss02collapse_province.dta,replace;


**//LABELS;
foreach filename in hhvlss02collapse.dta hhvlss02collapse_province.dta{;
use "`filename'",clear;


rename female02 sex_head_female02;
rename ageyrs02 age_head02;

label var sex_head_female02 "Percentage with female household heads in 02";
label var age_head02 "Average age of household head in 02";

label var dkinh02 "Proportion ethnic Vietnamese in 2002";
label var dhoa02 "Proportion ethnic Hoa (Chinese?) in 2002";
label var invalids02 "Proprtion w. invalids, sick vets, etc. in hh in 2002";
label var elderly02 "Proportion w. elderly disabled receiving regular subsidy in 2002";


**//label var school02 "Attend school in the past 12 months";
label var edgrade02 "Grade (0-12): similar to edgrade92/98";
label var diploma02 "Highest degree (similar to diploma93 & comped98_head, not identical)";

label var workforother02 "receive salary, wage";
label var workonownfield02 "do the agricultural, forestry & aquacultural work on their own";
label var selfemp02 "do non-farm production and services";
label var havework02 "Have work? (Currently employed?)";
label var lookedforwork02 "Looked for work ?";
**//label var whynolook02 "Reason for not having look for work";
**//label var mainjob02 "Most time consuming work (see svy for codes) ";
**//label var organiz02 "Name of organization of this work (see svy for codes)";
**//label var mosworkedlastyr02 "Months in last 12 months doing mainjob";
**//label var mosworkedlastyrall02 "Months in last 12 months doing all jobs";
**//label var workfor02 "For whom did you work?";
**//label var secjob02 "Two or more jobs at the same time? past 12 mos";

label var food02 "Expenditure on regular food";
label var nonfood02 "Expenditure on non-food and non-food stuff ";
label var hhexp02 " IV. Expenditure  [Code 16 + 17 + 25 + 26 + 27 + 28 + 32 + 35]";
label var pcexp02 " VII. Average Expenditure/person/month [Indicator IV/ (quan'ty of hhold members  x 12)]";
**//label var exp02r98_old "real cons exp 02, in 98 1000VND, NOT adj for reg/mo price diff";
**//label var exppc02r98_old "real yrly cons exp per cap 02, in 98 1000VND,NOT adj for reg/mo price diff";
label var exp02r98 "real cons exp 02, in 98 1000VND, adj for mnth but not reg. price diff";
label var exppc02r98 "real yrly cons exp per cap 02, in 98 1000VND,adj for mnth but not reg. price diff";


label var agr_activity02 "Manage and use agricultural, syvilcutural and aquacultural land?";
label var agrland02 "Total area of agricultural land (m2)";
label var cropland02 "Total area of land for annual crop (m2)";
label var longterm_crop02 "Area of land for annual crop used for long (m2)";
label var irrinc02 "Total income from irrigation";
label var irrexp02 "Total expense of irrigation";
label var dliterate_all02 "1 if edgrade02 >=5 or literate02 =1, (1 if can read & write)";
label var delectricity02 "1 if lightingsource02 is electricity";
label var dflushtoilet02 "1 if toilettype02 is flush w/septic sewage";

label var ddwellingfullyowned02 "1 if dwellingowned02 ==2 (fully owned)";
label var ddwellingpartowned02 "1 if dwellingowned02 ==1 (part owned)";

save "`filename'", replace;
};

/**************************************************************************************************************************************/
/*CALCULATE AND COLLAPSE ANTHROPOMETRIC MEASURES*/

foreach x in district province {;
/*For women*/
use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear <=1920 & female ==1 [w=hhsizewt], by(`x');
rename height height_fpre1920;
label var height_fpre1920 "avg. height all females born 1920 or earlier";
rename idcod hnum_fpre1920; label var hnum_fpre1920 "number of ppl represented by height_fpre1920 average";
sort `x';
save `x'_height_fpre1920, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1920 & birthyear <=1925 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1921;
label var height_f1921 "avg. height all females born 1921-1925";
rename idcod hnum_f1921; label var hnum_f1921 "number of ppl represented by height_f1921 average";
sort `x';
save `x'_height_f1921, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1925 & birthyear <=1930 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1926;
label var height_f1926 "avg. height all females born 1926-1930";
rename idcod hnum_f1926; label var hnum_f1926 "number of ppl represented by height_f1926 average";
sort `x';
save `x'_height_f1926, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1930 & birthyear <=1935 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1931;
label var height_f1931 "avg. height all females born 1931-1935";
rename idcod hnum_f1931; label var hnum_f1931 "number of ppl represented by height_f1931 average";
sort `x';
save `x'_height_f1931, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1935 & birthyear <=1940 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1936;
label var height_f1936 "avg. height all females born 1936-40";
rename idcod hnum_f1936; label var hnum_f1936 "number of ppl represented by height_f1936 average";
sort `x';
save `x'_height_f1936, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1940 & birthyear <=1945 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1941;
label var height_f1941 "avg. height all females born 1941-45";
rename idcod hnum_f1941; label var hnum_f1941 "number of ppl represented by height_f1941 average";
sort `x';
save `x'_height_f1941, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1945 & birthyear <=1950 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1946;
label var height_f1946 "avg. height all females born 1946-50";
rename idcod hnum_f1946; label var hnum_f1946 "number of ppl represented by height_f1946 average";
sort `x';
save `x'_height_f1946, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1950 & birthyear <=1955 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1951;
label var height_f1951 "avg. height all females born 1951-55";
rename idcod hnum_f1951; label var hnum_f1951 "number of ppl represented by height_f1951 average";
sort `x';
save `x'_height_f1951, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1955 & birthyear <=1960 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1956;
label var height_f1956 "avg. height all females born 1956-60";
rename idcod hnum_f1956; label var hnum_f1956 "number of ppl represented by height_f1956 average";
sort `x';
save `x'_height_f1956, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1960 & birthyear <=1965 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1961;
label var height_f1961 "avg. height all females born 1961-65";
rename idcod hnum_f1961; label var hnum_f1961 "number of ppl represented by height_f1961 average";
sort `x';
save `x'_height_f1961, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1965 & birthyear <=1970 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1966;
label var height_f1966 "avg. height all females born 1966-70";
rename idcod hnum_f1966; label var hnum_f1966 "number of ppl represented by height_f1966 average";
sort `x';
save `x'_height_f1966, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1970 & birthyear <=1975 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1971;
label var height_f1971 "avg. height all females born 1971-75";
rename idcod hnum_f1971; label var hnum_f1971 "number of ppl represented by height_f1971 average";
sort `x';
save `x'_height_f1971, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1975 & birthyear <=1980 & female ==1 [w=hhsizewt], by(`x');
rename height height_f1976;
label var height_f1976 "avg. height all females born 1976-80";
rename idcod hnum_f1976; label var hnum_f1976 "number of ppl represented by height_f1976 average";
sort `x';
save `x'_height_f1976, replace;


/*For men*/
use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear <=1920 & female ==0 [w=hhsizewt], by(`x');
rename height height_mpre1920;
label var height_mpre1920 "avg. height all males born 1920 or earlier";
rename idcod hnum_mpre1920; label var hnum_mpre1920 "number of ppl represented by height_mpre1920 average";
sort `x';
save `x'_height_mpre1920, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1920 & birthyear <=1925 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1921;

label var height_m1921 "avg. height all males born 1921-1925";
rename idcod hnum_m1921; label var hnum_m1921 "number of ppl represented by height_m1921 average";
sort `x';
save `x'_height_m1921, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1925 & birthyear <=1930 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1926;
label var height_m1926 "avg. height all males born 1926-30";
rename idcod hnum_m1926; label var hnum_m1926 "number of ppl represented by height_m1926 average";
sort `x';
save `x'_height_m1926, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1930 & birthyear <=1935 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1931;
label var height_m1931 "avg. height all males born 1931-35";
rename idcod hnum_m1931; label var hnum_m1931 "number of ppl represented by height_m1931 average";
sort `x';
save `x'_height_m1931, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1935 & birthyear <=1940 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1936;
label var height_m1936 "avg. height all males born 1936-40";
rename idcod hnum_m1936; label var hnum_m1936 "number of ppl represented by height_m1936 average";
sort `x';
save `x'_height_m1936, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1940 & birthyear <=1945 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1941;
label var height_m1941 "avg. height all males born 1941-45";
rename idcod hnum_m1941; label var hnum_m1941 "number of ppl represented by height_m1941 average";
sort `x';
save `x'_height_m1941, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1945 & birthyear <=1950 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1946;
label var height_m1946 "avg. height all males born 1946-50";
rename idcod hnum_m1946; label var hnum_m1946 "number of ppl represented by height_m1946 average";
sort `x';
save `x'_height_m1946, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1950 & birthyear <=1955 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1951;
label var height_m1951 "avg. height all males born 1951-55";
rename idcod hnum_m1951; label var hnum_m1951 "number of ppl represented by height_m1951 average";
sort `x';
save `x'_height_m1951, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1955 & birthyear <=1960 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1956;
label var height_m1956 "avg. height all males born 1956-60";
rename idcod hnum_m1956; label var hnum_m1956 "number of ppl represented by height_m1956 average";
sort `x';
save `x'_height_m1956, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1960 & birthyear <=1965 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1961;
label var height_m1961 "avg. height all males born 1961-65";
rename idcod hnum_m1961; label var hnum_m1961 "number of ppl represented by height_m1961 average";
sort `x';
save `x'_height_m1961, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1965 & birthyear <=1970 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1966;
label var height_m1966 "avg. height all males born 1966-70";
rename idcod hnum_m1966; label var hnum_m1966 "number of ppl represented by height_m1966 average";
sort `x';
save `x'_height_m1966, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1970 & birthyear <=1975 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1971;
label var height_m1971 "avg. height all males born 1971-75";
rename idcod hnum_m1971; label var hnum_m1971 "number of ppl represented by height_m1971 average";
sort `x';
save `x'_height_m1971, replace;

use hhvlss98.dta;
sort `x';
collapse height (count) idcod if birthyear >1975 & birthyear <=1980 & female ==0 [w=hhsizewt], by(`x');
rename height height_m1976;
label var height_m1976 "avg. height all males born 1976-80";
rename idcod hnum_m1976; label var hnum_m1976 "number of ppl represented by height_m1976 average";
sort `x';
save `x'_height_m1976, replace;

};

/****************************************************************************************************************************************/
**// MERGING OF ALL DATA TO CREATE HHVLSSALLCOLLAPSE_PROVINCE_PANEL (PROVPAN);

/*MERGE ALL DISTRICT DATA - keep all districts & provinces*/
use hhvlss9893collapse.dta;
sort district;
merge district using hhvlss02collapse.dta;
drop _merge;
save hhvlssALLcollapse.dta, replace;

use hhvlss9893collapse_province.dta;
sort province;
merge province using hhvlss02collapse_province.dta;
drop _merge;
save hhvlssALLcollapse_province.dta, replace;

/*MERGE ALL DISTRICT DATA - keep only districts in 98 and 93 and 02*/
use hhvlss9893collapse.dta;
sort district;
merge district using hhvlss02collapse.dta, nokeep;
drop _merge;
save hhvlssALLcollapse_panel.dta, replace;

use hhvlss9893collapse_province.dta;
sort province;
merge province using hhvlss02collapse_province.dta, nokeep;
drop _merge;
save hhvlssALLcollapse_province_panel.dta, replace;

erase temphh.dta;

/*MERGE HEIGHT DATA*/
use hhvlssALLcollapse_panel.dta;
sort district;

foreach x in fpre1920 f1921 f1926 f1931 f1936 f1941 f1946 f1951 f1956 f1961 f1966 f1971 f1976 mpre1920 m1921 m1926 m1931 m1936 m1941 m1946 m1951 m1956 m1961 m1966 m1971 m1976{;
merge district using district_height_`x'.dta;
drop _merge;
drop if district ==.;
sort district;
save hhvlssALLcollapse_panel.dta, replace;
erase district_height_`x'.dta;
};

use hhvlssALLcollapse_province_panel.dta;
sort province;

foreach x in fpre1920 f1921 f1926 f1931 f1936 f1941 f1946 f1951 f1956 f1961 f1966 f1971 f1976 mpre1920 m1921 m1926 m1931 m1936 m1941 m1946 m1951 m1956 m1961 m1966 m1971 m1976{;
merge province using province_height_`x'.dta;
drop _merge;
drop if province ==.;
sort province;
save hhvlssALLcollapse_province_panel.dta, replace;
erase province_height_`x'.dta;
};

/* DATA CONSTRUCTION - BEGIN COMBINING INDIVIDUAL DATA FILES TO CREATE DISTRICT AND PROVINCE LEVEL DATA FOR USE IN ANALYSIS (DATCON) */;
cd ..;
cd DSCA;
use DSCAdata;
sort district;
save DSCAdata, replace;
clear;


cd ..;
cd IFPRI;
use GIS_var1;
save temp1, replace;
/* USE THESE VARIABLES BOTH AS DISTRICT CONTROLS AND OUTCOMES */;

/* DISTRICT GEOGRAPHIC CONTROLS */;
rename district_code district;

rename _ha__arable_land ha_arable;
/* ANOTHER GOOD CONTROL: navigable river length, NAV_RIV_LENGTH */;

rename percentage_of_total_area_by_elev area_0_250m;
gen area_over_1000m = area_1001 + area_over_1500m;
/* ELEV_STD HAS LITTLE PREDICTIVE POWER */;

foreach var in
    area_0_250m area_251 area_501 area_over_1000m
{;
replace `var' = `var'/100;
};

/* OMITTED CATEGORY = LOW ELEVATION */;
global x_elev = "area_251 area_501 area_over_1000m";

rename percentage_of_total_area_by_slop slp_c1;
gen slp_c45 = slp_c4 + slp_c5;
/* OMITTED CATEGORY = 1 */;
global x_slope = "slp_c2 slp_c3 slp_c45";

rename percentage_of_total_area_by_soil soil_1;
/* ONLY CONSIDER THOSE SOIL TYPES ACCOUNTING FOR AT LEAST
ONE PERCENT OF VIETNAMESE LAND AREAS, THE MINOR SOIL TYPES
ARE THE OMITTED CATEGORY. 18 DISTINCT SOIL TYPES */;
global x_soil1 = "soil_1 soil_3 soil_6 soil_7 soil_8 soil_9 soil_10 soil_11 soil_12";
global x_soil2 = "soil_14 soil_24 soil_26 soil_33 soil_34 soil_35 soil_39 soil_40 soil_41";

/* GEOGRAPHIC ISOLATION */;
rename mean dist_p_town_mean;
rename mean_1 dist_d_town_mean;


/* DISTRICT OUTCOMES */;
rename percentage_of_total_area_under_  percent_cultivated;
rename market_variables_no_markets num_markets;
rename length_of_roads_by_type_length_t length_tot;
/* OTHER ROAD VARIABLES LENGTH_MAIN, LENGTH_MINOR */;


/* DISTRICT LATITUDE */;
rename y_coord north_lat;
replace north_lat = north_lat/100000;
gen diff_17 = abs(north_lat-17);
gen diff_17_2 = diff_17^2;

/* DISTRICT LONGITUDE */;
rename utm48_coordinates_district_centr east_long;
replace east_long = east_long/100000 + 100;

/* COMPUTE THE DISTANCE TO 17 DEGREES ? */;

global x_gis = "north_lat";
/* ADD east_long IN THE FUTURE? */;

sort district;
save temp1, replace;
clear;


use GIS_var2a;
save temp2, replace;
/* DISTRICT GEOGRAPHIC CONTROLS */;

/* PRECIPITATION */;
foreach var in
    pre tmp hum sun
{;
gen `var'_avg = (`var'_avg_jan + `var'_avg_feb + `var'_avg_mar + `var'_avg_apr
    + `var'_avg_may + `var'_avg_jun + `var'_avg_jul + `var'_avg_aug
    + `var'_avg_sep + `var'_avg_oct + `var'_avg_nov + `var'_avg_dec)/12;
/* STANDARD DEVIATION ACROSS MONTHS */;
egen `var'_sd = rsd(`var'_avg_jan `var'_avg_feb `var'_avg_mar `var'_avg_apr
    `var'_avg_may `var'_avg_jun `var'_avg_jul `var'_avg_aug
    `var'_avg_sep `var'_avg_oct `var'_avg_nov `var'_avg_dec);
drop `var'_avg_*;
};

/* TEMPERATURE AND SUN ARE HIGHLY CORRELATED, ONLY INCLUDE TEMPERATURE */;
global x_weather = "pre_avg tmp_avg";

sort district;
save temp2, replace;
clear;

insheet using SES-data.csv, clear; sort district;
merge district using temp1;
tab _merge; drop _merge;

sort district;
merge district using temp2;
tab _merge; drop _merge;


cd ..;
cd DSCA;
sort district;
merge district using DSCAdata;

drop _merge*;
save temp1, replace;

cd ..;

label var poverty_p0 "District poverty rate, 1999";
rename pcexp pcexp_99;
label var pcexp_99 "District per capita consumption expenditures, 1999";
label var gini "District GINI coefficient, 1999";

/* GENERATE PROPORTIONS FROM POVERTY MAPPING */
gen lit_rate = literate_15plus/pop_15plus;
gen illit_rate = 1 - lit_rate;

gen elec_rate = hh_elec/no_hh;
gen tv_rate = hh_tv/no_hh;
gen radio_rate = hh_radio/no_hh;

gen urban_pct = pcturban/100;

/* GENERATE POPULATION DENSITY 1999 */;
gen popdensity1999 = pop_tot/area_tot_km2;
label var popdensity1999 "Population Density 1999";

gen log_popdensity1999 = log(popdensity1999);
label var log_popdensity1999 "Log(Population Density 1999)";


/* GENERATE PROVINCE FE */;
/* # DISTRICTS / PROVINCE */;
tab province, gen(Iprovince);
drop Iprovince1;

egen pop_prov = sum(pop_tot), by(province);

/* ORDNANCE */;
/* Chemical, Grenade, Fuel_Air_Explosive, Submunition - almost no variation, drop */;
/* A, AC, ACC, HCC, HCP, HCPD, HCVT, HP, HVTF - almost no variation, drop */;
/* MK, MK07, MK70, MK8 - almost no variation, drop */;
/* RAGON, SHRKE, VC, VTN, VTNSD, VTSD, W - almost no variation, drop */;

/* IS AMMUNITION A MEASURE OF OVERALL COMBAT ACTIVITY? */;

gen mine_per = Mine/area_tot_km2;

global ord0 = "Ammunition";
global ord1 = "General_Purpose Cluster_Bomb Missile Rocket Cannon_Artillery";
global ord2 = "Incendiary WP";
global ord3 = "Mine";

global ord3_per = "mine_per";

/* THESE BELOW TEND TO HAVE LITTLE PREDICTIVE POWER / LITTLE VARIATION */;
global ord4 = "AAC";
global ord5 = "HE HECVT HEPD";
global ord6 = "ILL ILLUM ILUM";
global ord7 = "MK10 MK12 MK7";
global ord8 = "RAP VT";


/* TWO METHODS -
    1) SUM UP TOTAL BOMBS, MISSILES, ETC
    2) CREATE AN INDEX BASED ON PRINCIPAL COMPONENTS (COMMAND: PCA)
*/;

/* METHOD 1 */;
gen tot_bmr  = General_Purpose + Cluster_Bomb + Missile + Rocket + Cannon_Artillery;
label var tot_bmr "Total # of U.S. bombs, missiles, rockets";

gen tot_bmr_2 = (tot_bmr)^2;
label var tot_bmr_2 "Total # of U.S. bombs, missiles, rockets - squared";

gen log_tot_bmr = log(tot_bmr);
label var log_tot_bmr "Log(Total # of U.S. bombs, missiles, rockets)";


gen tot_bmr_per  = tot_bmr/area_tot_km2;
label var tot_bmr_per "Total U.S. bombs, missiles, rockets per km2";

gen tot_bmr_per_2 = (tot_bmr_per)^2;
label var tot_bmr_per_2 "Total U.S. bombs, missiles, rockets per km2 - squared";

gen log_tot_bmr_per = log(tot_bmr_per);
label var log_tot_bmr_per "Log(Total U.S. bombs, missiles, rockets per km2)";


/* IT WOULD BE NICE TO HAVE BOMBS PER POPULATION, BUT WE ONLY HAVE DETAILED
DISTRICT POPULATIONS FOR 1999. WE HAVE IT FOR THE PROVINCE IN 1960-61 */;


gen tot_bomb = General_Purpose + Cluster_Bomb;
label var tot_bomb "Total # of U.S. bombs";

gen tot_bomb_per = tot_bomb/area_tot_km2;
label var tot_bomb_per "Total U.S. bombs per km2";
/* THERE IS ONE OBVIOUS OUTLIER */;
replace tot_bomb_per=. if tot_bomb_per>1000;

label var General_Purpose "Total # of U.S. general purpose bombs";


gen tot_bmr_hi = (tot_bmr>35500 & tot_bmr~=.);
label var tot_bmr_hi "Total U.S. bombs, missiles, rockets > 355000";

gen tot_bmr_per_hi = (tot_bmr_per>78 & tot_bmr~=.);
label var tot_bmr_per_hi "Total U.S. bombs, missiles, rockets per km2 > 78";


/* METHOD 2 - ONLY RETAIN STATISTICALLY SIGNIFICANT EIGENVECTORS */;
pca $ord0 $ord1 $ord2 $ord3 [aw=pop_tot], mineigen(1) comp(2);
predict war_f1 war_f2;
label var war_f1 "U.S. war intensity index (eigenvector 1)";
label var war_f2 "U.S. war intensity index (eigenvector 2)";


/* HOW TO PROXY FOR OVERALL MILITARY ACTIVITY? */;

sort district;
save temp1, replace;


/* PRE-WAR DATA, VLSS DATA */;
**//PRE-WAR DATA;  
**//NOTE: PER UNIT AREA VARS MORE INTUITIVELY ACCURATE, SINCE THERE WAS NO NEED TO NORMALIZE OVER AREA 
    TO DEAL WITH SHIFTING BOUNDARIES.
I.E., PER-UNIT-AREA, PRE-WAR DISTRICT FIGURES ARE JUST WEIGHTED AVGS OF THE VALUES OF THE PRE-WAR PROVINCES 
    THAT CONTAINED THEM.
NON-PER-UNIT-AREA FIGURES ARE CALCULATED, E.G., AS WEIGHTED-AVG[PROVINCEENTRY1960/PROVINCEAREA1960]*DISTRICTAREA1999;
clear;

cd "Pre-War Data"; use prewardt.dta; save temp1.dta, replace;
**//LABELS;
label var cerealprod_padval1960_n "Output of Cereals, in tons of paddy value, 1960";
label var cerealprod_padval1965_n "Output of Cereals, in tons of paddy value, 1965";
label var cerealprodpercap_pv_kgper1960_n "Output of Cerals per cap, kg of paddy vaule per person, 1960";
label var cerealprodpercap_pv_kgper1965_n "Output of Cerals per cap, kg of paddy vaule per person, 1965";
label var plantedarea_crop1960_n "Planted Crop Area, Hectares, 1960";
label var plantedarea_crop1965_n "Planted Crop Area, Hectares, 1965";
label var plantedarea_nonpadc1960_n "Planted Non-Paddy Crop Area, Hectares, 1960";
label var plantedarea_nonpadc1965_n "Planted Non-Paddy Crop Area, Hectares, 1965";
label var plantedarea_total1960_n "Planted Total Area, Hectares, 1960";
label var plantedarea_total1965_n "Planted Total Area, Hectares, 1965";
label var popdens_pctdis1960_n "Avg % Disagreemnt b/t Underlying Backed-Out Pop Figures, 1960";
label var popdens_pctdis1965_n "Avg % Disagreemnt b/t Underlying Backed-Out Pop Figures, 1965";
label var popdensity1960_n "PopDensity, per km2, backed-out from cereal/paddy percap (avg), 1960";
label var popdensity1960_n "PopDensity, per km2, backed-out from cereal/paddy percap (avg), 1960";
foreach year in 1961 1962 1963{; label var rubberplanted`year' "Rubber Planted Area, Hectares, `year'";}; 
foreach year in 1958 1959 1961 1962 1963{; 
    label var rubberworkable`year' "Rubber Workable Area, Hectares, `year'";
    label var rubberworked`year' "Rubber Worked Area, Hectares, `year'";
    label var rubberworkedtoworkable`year' "Rubber Ratio Worked/Workable, `year'";};
sort district; save temp1.dta, replace;
cd ..;
merge district using temp1.dta; tab _merge; drop _merge; sort district; 
save temp1.dta, replace;

**//VLSS DATA;
cd "VLSS"; use hhvlss98collapse.dta; save temp1.dta, replace;
label var sex_head_female "HHEXP: Avg Gender of HH.head (0:M;1:F)";
label var age_head "HHEXP: Avg Age of HH.head";
label var agegroup_head "HHEXP: Avg AgeGroup of HH.head"; 
*    label define agegroup 1 "under 20" 2 "from 20" 3 "from 30" 4 "from 40" 5 "from 50" 6 "from 60" 7 "70 or ab";
*    label val agegroup_head agegroup;
label var comped98_head "HHEXP: Avg completed diploma HH.head";
    /*DIPLOMA LABELS TRANSLATED BY KHUYEN*/ label define diploma 0 Never 1 "Nhatre = Kindergarten" 
    2 "<cap I = <primary" 3 "Cap I = Primary" 4 "Cap II = Lower Sec" 5 "Cap III = Higher Sec" 6 "Nghe SC = Voc Training" 
    7 "THCN = Secondary Voc Training" 8 DHDC 9 "DHCD = Bachelors" 10 "Thac sy = Masters" 11 "PTS = PhD Candidate" 
    12 "TS = PhD", modify;
    label val comped98_head diploma;
label var educyr98_head "HHEXP: Avg schooling years of HH.head";
label var farm "Type of HH (1:farm; 0:nonfarm)";
label var urban98 "1:urban 98, 0:rural 98";
label var urban92 "1:urban 92, 0:rural 92";
label var avg_ill4wks "HH: Avg of Avg days ill in past 4wks (all HH members)";
label var avg_hospital12mths "HH: Avg of Avg days spent in hospital past 12mths (all HH members)";
label var literate "HH: ED: Can you read this sentence?";
    *label define literate 3 "yes w/o difficulty" 2 "yes w/ difficulty" 1 "only in other lang" 0 no;
    *label val literate literate;
label var numerate "HH: ED: Can you do these calculations?";
    *label define numerate 2 "yes w/o difficulty" 1 "yes w/ difficulty" 0 no;
    *label val numerate numerate;
label var ricexpd "HHEXP: Avg Value rice expenditures, current 1000VND";
label var nonrice "HHEXP: Avg Value food expenditures no rice, current 1000VND";
label var totnfdx1 "HHEXP: Avg Value Nonfood exp.purchase/barter, current 1000VND (comp 93)";
label var totnfdhp "HHEXP: Avg Value Nonfood home production, current 1000VND";
label var totnfdh1 "HHEXP: totnfdhp, excl. coal,wood,sawdust,chaff consumed, current 1000VND (comp 93)";
label var food "HHEXP: Avg Exp on food/foodstuff, current 1000VND (comp 93)";
label var nonfood1 "HHEXP: Avg Exp on non-food(stuffs), current 1000VND (comp 93)";
label var hhexp1 "HHEXP: Avg total exp = food + nonfood1, current 1000VND (comp 93)";
label var pcexp1 "HHEXP: Avg Exp per Cap = hhexp1/hhsize, current 1000VND (comp 93)";
label var pcfdex1 "HHEXP: Avg exp per cap food/foodstuff = food/hhsize, current 1000VND (comp 93)";
label var rlfood "HHEXP: Avg Exp on food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)";
label var rlnfd1 "HHEXP: Avg Exp on non-food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)";
label var rlhhex1 "HHEXP: Avg total exp, adj for reg/mo prices, 1998 1000VND (comp 93)";
label var rlpcex1 "HHEXP: Avg Exp per cap, adj for reg/mo prices, 1998 1000VND (comp 93)";
label var rlpcfdex "HHEXP: Avg exp per cap on food(stuff,) adj for reg/mo prices, 1998 1000VND (comp 93)";
label var nonfood2 "HHEXP: Avg Exp on non-food(stuffs), current 1000VND (not comp 93)";
label var hhexp2 "HHEXP: Avg total exp = food + nonfood2, current 1000VND (not comp 93)";
label var pcexp2 "HHEXP: Avg Exp per Cap = hhexp2/hhsize, current 1000VND (not comp 93)";
label var hhexp2 "HHEXP: Avg total exp = food + nonfood2, current 1000VND (not comp 93)";
label var pcexp2 "HHEXP: Avg exp per cap = hhexp2/hhsize, current 1000VND (not comp 93)";
label var rlhhex2 "HHEXP: Avg total exp, adj for reg/mo prices, 1998 1000VND (not comp 93)";
label var rlpcex2 "HHEXP: Avg Exp per cap, adj for reg/mo prices, 1998 1000VND (not comp 93)";

**//label var factorydistance_min "COM: EXP: min(factorydistance*) across district";
**//label var factorylabor_sum "COM: EXP: sum(factorylabor*) across district";
label var comped98father "HH: EDPAR: Avg of HH.head's Father's highest diploma"; 
    *label define diploma0 0 none 1 prim 2 lowsec 3 hisec 4 certif 5 training 6 "tech/prof.sec" 7 jc 8 assoc 9 bach 10 mast 11 "sub-doc" 12 phd 13 "don't know"; 
    *label val comped98father diploma0; 
label var comped98mother "HH: EDPAR: Avg of HH.head's Mother's highest diploma"; 
    *label val comped98mother diploma0; 
label var educyr98father "HH: EDPAR: Avg of HH.head's Father's yrs formal sch (grade+postsec)";
label var educyr98mother "HH: EDPAR: Avg of HH.head's Mother's yrs formal sch (grade+postsec)";
label var workedpast12mo "HH: EMP: Avg Have you worked (for pay, at your farm, self-employed) in past 12 mo?";
label var yearsinwork "HH: EMP: Avg How many years have you been doing mainjob?";
label var salary "HH: EMP: Avg Have you ever or will you receive salary or wage for mainjob, inc. pay-in-kind?";
label var bornhere "HH: IMM: Avg Born in current district?";
label var yrshere "HH: IMM: Avg How many years have you lived in current residence?";
label var dwellingshared "HH: HOUSE: Avg Does your hh share dwelling with another?";
label var dwellingowned "HH: HOUSE: Avg Does a member of your hh own all or part of dwelling? 0=none,1=part,2=all";

gen notbornhere = 1-bornhere;
label var notbornhere "HH: IMM: Avg NOT Born in current district?";

drop urb93;
label var calpc93 "MINOT: kcal per cap per day, 1993";
label var calok93 "MINOT: 1 if 3500>=calpc_93>=1000";
label var expb93 "MINOT: Exp Bought/Bartered, Past12mo 1000VND";
label var exph93 "MINOT: Exp Home-Produced, Past12mo 1000VND";
label var exp93  "MINOT: Exp, Past12mo 1000VND";
label var exppc93 "MINOT: Exp per cap, Past12mo 1000VND";
label var fexp93 "MINOT: Exp on Consumption, Past12mo 1000VND";
label var fpct93 "MINOT: Fraction Consumption Exp = fexp_93/exp_93";
label var hfpct93 "MINOT: Fraction of Cons Exp that is Home Produced";
**//label var adults93 
label var children93;
label var infants93;
label var hhsize93;
replace sex_head_female_93=0 if sex_head_female_93==1; label var sex_head_female_93 "HHEXP: Avg Gender of HH.head (0:M;1:F)";
label var ricevb93 "MINOT: Value of bought rice 1000VND";
label var ricevh93 "MINOT: Value of home produced rice 1000VND";
label var riceqb93 "MINOT: Quantity of bought rice kg?";
label var riceqh93 "MINOT: Quantity of home produced rice kg?";
label var maizev93 "MINOT: Value of maize 1000VND";
label var maizeq93 "MINOT: Quantity of maize kg?";
label var maniocv93 "MINOT: Value of manioc 1000VND";
label var maniocq93 "MINOT: Quantity of manioc kg?";
label var swpotv93 "MINOT: Value of sweet potatoes 1000VND";
label var swpotq93 "MINOT: Quantity of sweet potatoes kg?";
foreach varpart in calpc calok expb exph exp exppc fexp fpct hfpct adults children infants hhsize ricevb ricevh riceqb 
    ricexpd nonrice totnfdx1 totnfdh1 nonfood1 pcfdex1
    riceqh maizev maizeq maniocv maniocq swpotv swpotq 
    rcpi mcpi {;
        rename `varpart'93 `varpart'_93;};
/*NOTE: VARS WITH LABELS BEGINNING '93:' ARE CONSTRUCTED TO AGREE WITH VLSS98 HHEXPENDITURE FILE.*/
label var ricexpd_93 "93: Expenditure on rice 1000VND";
label var nonrice_93 "93: Expenditure on food, no rice 1000VND";
label var totnfdx1_93 "93: Expenditure on non-food purchased/bartered 1000VND";
label var totnfdh1_93 "93: Value of home production of non-food";
rename fexp_93 food_93;
label var nonfood1_93 "93: Avg non-food expenditure, current 1000VND";
rename exp_93 hhexp1_93;
rename exppc_93 pcexp1_93;
label var pcfdex1_93 "93: Exp per cap on food(stuffs), current price 1000VND";
rename exp93r98 rlhhex1_93; label var rlhhex1_93 "93: Cons exp 93, in 98 1000VND, adj for reg/mo price diff";
rename exppc93r98 rlpcex1_93; label var rlpcex1_93 "93: Cons exp per cap 93, in 98 1000VND, adj for reg/mo price diff";
label var rcpi_93 "93: Avg regional price deflator for district";
label var mcpi_93 "93: Avg monthly price deflator for district";
label var CONSCHANGEHH "VLSS: Avg HH Cons Change 93-98, in 98 1000VND adj reg/mo price diffs";
label var CONSCHANGEPC "VLSS: Avg HH Percap Cons Change 93-98, in 98 1000VND adj reg/mo price diffs";
label var CONSGROWTHHH "VLSS: Avg HH Cons %Change 93-98, adj reg/mo price diffs";
label var CONSGROWTHPC "VLSS: Avg HH Percap Cons %Change 93-98, adj reg/mo price diffs";
label var count_hh "COUNT: #HH Sampled in district";
label var count_avgill4wks "COUNT: #HH within district with non-missing 'avgill4wks'";
label var count_avghospital12mths "COUNT: #HH with in district with non-missing 'avghospital12mths'";
label var count_ed98father "COUNT: #HH with in district with non-missing 'ed98father'";
label var count_ed98mother "COUNT: #HH with in district with non-missing 'ed98mother'";
label var count_workedpast12mo "COUNT: #HH with in district with non-missing 'workedpast12mo'";
label var count_yearsinwork "COUNT: #HH with in district with non-missing 'yearsinwork'";
label var count_salary "COUNT: #HH with in district with non-missing 'salary'";
label var count_bornhere "COUNT: #HH with in district with non-missing 'bornhere'";
label var count_yrshere "COUNT: #HH with in district with non-missing 'yrshere'";

gen rlpcex1_9398 = (pcexp1 + pcexp1_93)/2;
label var rlpcex1_9398 "Avg Cons exp per cap 93 and 98, in 98 1000VND, adj for reg/mo price diff";

/*REDEFINE COM LABELS*/
**//label define cropcodes 1 "Winter Rice" 2 "Autumn Rice" 3 "Winter Rice" 4 "Swidden Rice" 5 "Annual Rice" 6 "Glutinous Rice" 
    7 "Specialty Rice" 8 "Corn/Maize" 9 "Sweet Potatoes" 10 "Cassava/Manioc" 11 "Other Staple Crops" 12 Potatoes 
    13 "Kohlrabi, Cabbage, Cauliflower" 14 "Other Leafy Greens" 15 "Tomatoes" 16 "Water Morning Glory" 17 "Fresh Legumes (Beans)" 
    18 "Dried Legumes (Beans)" 19 "Herbs and Spices" 20 "Other Vegetables, Tubers, and Fruits" 21 "Soy Beans" 22 Peanuts 
    23 "Sesame Seeds" 24 "Sugar Cane" 25 Tobacco 26 Cotton 27 "Jute, Ramie" 28 "Rush (For Making Mats" 29 "Other Annual Industrial Crops" 
    30 "Other Annual Crops" 31 Tea 32 Coffee 33 Rubber 34 "Black Pepper" 35 "Coconut (For Oil, Copra)" 36 Mulberry 37 Cashew 
    38 "Other Perennial Industrial Crops" 39 "Oranges, Limes and Mandarins" 40 Pineapple 41 Bananas 42 Mango 43 Apple 44 Grapes 
    45 Plum 46 Papaya 47 "Litchi, Longan, Rambutan" 48 Sapodilla 49 "Custard Apple" 50 "Jackfruit, Durian" 51 Mangosteen 
    52 "Other Fruit Trees" 53 "Mu Oil Tree" 54 "Cinnamon Tree" 55 "Anise Tree" 56 "Pine Tree" 57 "Varnish Tree" 58 "tree for Wood" 
    59 Bamboo 60 "Fan Palm Tree" 61 "Water Coconut Palm" 62 "Other Silviculture Tree";
**//label define noschool_reason 1 distance 2 "economic difficulties" 3 "illness/handicap" 4 "don't want to" 5 crowding 6 "parents don't care" 7 "must work" 8 other;
**//label define geogtype 1 coast 2 "inland delta" 3 "hills/midlands" 4 "low mts" 5 "hi mts";
**//label define maininc 1 agriculture 2 forestry 3 "aquatic products" 4 industry 5 handicrrafts 6 construction 7 trade 8 transport 9 services 10 other; 
**//label define changelivstdreason 1 "changes in agro policy" 2 "expansion in non-agro production" 3 weather 4 disaster 5 inflation 6 "changes in ability to obtain educ" 7 "changes in ability to use health svc" 8 "changes in ability to use social svc" 9 other;
**//label define immigration 1 "more move in than out" 2 "more move out than in" 3 equal 4 "nobody moved in or out"; 
**//label define infra_imps_type 1 road 2 "drinking water supply" 3 irrigation 4 "land reclamation" 5 "dryland converted to paddy" 6 school 7 "health ctr" 8 electricity 9 "other public inf" 10 other; 
**//label define illness 1 malaria 2 leprosy 3 goiter 4 tuberculosis 5 "other respiratory" 6 "dengue fever" 7 "childhood illness (diph,measles,polio,tetanus)" 8 "diarrhea/dysentery" 9 "child malnutrition" 10 rabies 11 "accident/injury" 12 "complicated birth" 13 other;

sort district; save temp1.dta, replace;
cd ..;
merge district using temp1.dta; tab _merge; drop _merge; sort district; 

gen area_tot_km2_2 = area_tot_km2^2;
global x_oth = "area_tot_km2 area_tot_km2_2";


/* SOUTH, NORTH HAVE PREWAR MEASURES FOR SLIGHTLY DIFFERENT YEARS */;
gen popdensity6061 = popdensity1961;
replace popdensity6061 = popdensity1960_n if popdensity6061==.;
label var popdensity6061 "Population Density 1960-1";

gen log_popdensity6061 = log(popdensity6061);
label var log_popdensity6061 "Log(Population Density 1960-1)";

gen paddyyield6061 = paddyyieldperhectare1961;
replace paddyyield6061 = paddyyieldperhectare1960_n if paddyyield6061==.;

gen log_paddyyield6061 = log(paddyyieldperhectare1961);
replace log_paddyyield6061 = log(paddyyieldperhectare1960_n) if log_paddyyield6061==.;

label var paddyyield6061 "Paddy yield, 1960-61";
label var log_paddyyield6061 "Log(Paddy yield, 1960-61)";

gen south = (popdensity1960_n==.);
gen south_popdensity6061 = south*popdensity6061;
gen south_paddyyield6061 = south*paddyyield6061;
gen south_tot_bmr = south*tot_bmr;
gen south_tot_bmr_per = south*tot_bmr_per;
gen south_log_tot_bmr_per = south*log_tot_bmr_per;
gen south_tot_bmr_hi = south*tot_bmr_hi;
gen south_General_Purpose = south*General_Purpose;
gen south_war_f1 = south*war_f1;

gen south_north_lat = south*north_lat;
gen south_diff_17 = south*diff_17;

pwcorr $ord0 $ord1 $ord2 $ord3 [aw=pop_tot], obs sig star(0.05);
bys south: pwcorr $ord0 $ord1 $ord2 $ord3 [aw=pop_tot], star(0.05);


/* CREATE PROVINCE BOMBING MEASURES */;
foreach vio in
    tot_bmr /* tot_bmr_per */ tot_bmr_hi tot_bomb war_f1 war_f2
{;
egen `vio'_prov = mean(`vio'), by(province);
};
gen log_tot_bmr_prov = log(tot_bmr_prov);

tab region;


/* MORE LABELS */;
label var elec_rate "District electricity, 1999";
label var lit_rate "District literacy rate, 1999";
label var rlpcex1_93 "Per capita expenditures, 1993";
label var rlpcex1 "Per capita expenditures, 1998";
label var CONSGROWTHPC "Per capita expenditures growth, 1993-98";
label var notbornhere "Proportion not born in district, 1998";

label var north_lat "Degrees North Latitude";
label var diff_17 "Abs value of (Latitude - 17 degrees)";
label var east_long "Degrees East Longitude";

/* DEFINE SAMPLES */;
gen sample_all = 1;
replace sample_all = 0 if 
    (poverty_p0==. | tot_bmr==. | tot_bmr_per==. | tot_bmr_per>1000
    | popdensity6061==. | south==. | pre_avg==. | soil_1==.);

gen rural = 1;
replace rural = 0 if ((paddyyield6061==.) | (provincename=="Ho Chi Minh (City)")
    | (provincename=="Ha Noi (City)") | (provincename=="Da Nang (City)")
    | (provincename=="Hai Phong (City)"));
replace paddyyield6061=. if rural==0;

gen central = 0;
replace central = 1 if (sample_all==1
    & (region==4 | region==5 | region==6 | region==7)
    & (provincename~="Ho Chi Minh (City)")
    & (provincename~="Da Nang (City)"));

keep if sample_all==1;

quietly compress;
save temp1.dta, replace;


/* IT TURNS OUT THAT THESE MEASURES ARE VERY HIGHLY CORRELATED */;
pwcorr $ord0 $ord1 $ord2 $ord3 tot_bmr tot_bmr_per 
    if sample_all==1 [aw=pop_tot], star(0.05);


/* MULTIPLE COLLAPSES TO GET CORRECT PROVINCE LEVEL DATA (PROVCREATE) */;
collapse                                                                    ///
    $ord0
    $ord1
    $ord2
    $ord3
    $ord3_per
    $ord4
    $ord5
    $ord6
    $ord7
    $ord8
    log_tot_bmr*
    tot_bmr* tot_bomb* war_f1 war_f2
    log_popdensity* popdensity* log*paddy* paddyyield* births* south* region
    pop_prov  sample* central rural
    diff_17*
    (sum) area_sum=area_tot_km2
    (sum) tot_bmr_sum=tot_bmr
    (sum) tot_bomb_sum=tot_bomb
    (sum) General_Purpose_sum=General_Purpose
    (sum) Mine_sum = Mine
    (sum) pop_tot_sum=pop_tot
    if sample_all==1, by(province);

replace popdensity1999 = pop_tot_sum/area_sum;
replace log_popdensity1999 = log(popdensity1999);
label var popdensity1999 "Population Density 1999";
label var log_popdensity1999 "Log(Population Density 1999)";

replace tot_bmr = tot_bmr_sum;
label var tot_bmr "Total # of U.S. bombs, missiles, rockets";

replace tot_bmr_2 = (tot_bmr)^2;

replace log_tot_bmr = log(tot_bmr);
label var log_tot_bmr "Log(Total # of U.S. bombs, missiles, rockets)";

replace tot_bmr_per = tot_bmr/area_sum;
label var tot_bmr_per "Total U.S. bombs, missiles, rockets per km2";

replace tot_bmr_per_2 = (tot_bmr_2)^2;

replace log_tot_bmr_per = log(tot_bmr_per);
label var log_tot_bmr_per "Log(Total U.S. bombs, missiles, rockets per km2)";

/* EVENTUALLY REPLACE ALL MUNITIONS WITH PROPER AVERAGES */;
replace tot_bomb = tot_bomb_sum;
label var tot_bomb "Total # of U.S. bombs";

replace tot_bomb_per = tot_bomb/area_sum;
label var tot_bomb_per "Total U.S. bombs per km2";

replace General_Purpose=General_Purpose_sum;
label var General_Purpose "Total # of U.S. general purpose bombs";

label var tot_bmr_hi "Prop. districts where Total U.S. bombs, missiles, rockets > 355000";

replace Mine = Mine_sum;
label var tot_bmr "Total # of U.S. mines";

replace mine_per = Mine/area_sum;
label var mine_per "Total U.S. mines per km2";

label var popdensity6061 "Population Density 1960-61";
replace log_popdensity6061 = log(popdensity6061);
label var log_popdensity6061 "Log(Population Density 1960-61)";

label var paddyyield6061 "Paddy yield, 1960-61";
replace log_paddyyield6061 = log(paddyyield6061);
label var log_paddyyield6061 "Log(Paddy yield, 1960-61)";

save temp2, replace;
clear;


cd IFPRI;
insheet using SES-data-prov.csv;
/* SHOULD THERE BE A SEPARATE COLLAPSE DIRECTLY TO THE PROVINCE LEVEL 
    FOR THE VLSS DATA?
    YES, WE DO THIS BELOW. */;

rename p0 poverty_p0;
rename exppc pcexp_99;

keep province poverty_p0 pcexp_99 gini;

label var poverty_p0 "District poverty rate, 1999";
label var pcexp_99 "District per capita consumption expenditures, 1999";
label var gini "District GINI coefficient, 1999";

/* destring province, replace; */;
sort province;
cd ..;
save temp3A, replace;
clear;


use temp1;
collapse lit_rate elec_rate radio_rate urban_pct percent_cultivated
    [aw=pop_tot]
    if sample_all==1, by(province);

label var elec_rate "District electricity, 1999";
label var lit_rate "District literacy rate, 1999";

sort province;
save temp3B, replace;
clear;


use temp1;
collapse
    $x_weather /* $x_oth */ $x_elev $x_gis $x_soil1 $x_soil2 $x_slope
    east_long
    [aw=area_tot_km2]
    if sample_all==1, by(province);
sort province;
save temp4, replace;
clear;


use temp2;

sort province;
merge province using temp3A;
tab _merge; drop _merge;

sort province;
merge province using temp3B;
tab _merge; drop _merge;

sort province;
merge province using temp4;
tab _merge; drop _merge;

drop if sample_all~=1;
sort province;
compress;
save temp2, replace;
clear;


use temp1;
keep province provincename;
sort province;
drop if province[_n-1]==province[_n];
save temp_prov, replace;
clear;

use temp2;
merge province using temp_prov;
tab _merge; 
drop if _merge==2; drop _merge;
save temp2, replace;
clear;

/* MERGE IN 1990S POPULATION DATA BY PROVINCE */;
insheet using pop_trends_jan05.csv;
keep province pop*;
sort province;
save temp3, replace; clear;

use temp2;
sort province;
merge province using temp3;
tab _merge; drop _merge;

foreach num in
    1990 1992 1994 1996 1998 2000
{;
gen popdensity`num' = pop_`num'/area_sum;
label var popdensity`num' "Population Density `num'";
};

/* THE 1999 POP CENSUS FIGURES DO NOT MATCH UP WITH THE YEARBOOK POP NUMBERS
    --> USE CHANGES FROM 1990 TO 1999? WHY IS THIS? */;

save temp2, replace;
clear;


/* MERGE IN 1990S OTHER DATA BY PROVINCE */;
insheet using vietnam_data_31jan05.csv;
keep province industry_00 classrooms_99 phones_00;
sort province;
save temp3, replace; clear;

use temp2;
sort province;
merge province using temp3;
tab _merge; drop _merge;

replace industry_00 = industry_00/pop_prov;
replace classrooms_99 = classrooms_99/pop_prov;
replace phones_00 = phones_00/pop_prov;
save temp2, replace;
clear;


/* MERGE IN EARLIER OTHER DATA BY PROVINCE */;
cd "Quoc-Data";
use vn_oldyearbooks_20may05;
cd ..;

foreach num in
    76 77 78 79 80 81 82 83 84 85
{;
gen pupils_`num' = pupils1_`num' + pupils2_`num' + pupils3_`num';
};

keep province
    pupils_* food2_* pop_76-pop_85
    invest_76-invest_85 output_81-output_85;

gen invest_85_per = invest_85/pop_85;
gen output_85_per = output_85/pop_85;
gen food2_85_per = food2_85/pop_85;
gen pupils_85_per = pupils_85/pop_85;

sort province;
save temp3, replace; clear;

use temp2;
sort province;
merge province using temp3;
tab _merge; drop _merge;

foreach num in 
    76 77 78 79 80 81 82 83 84 85
{;
gen popdensity19`num' = pop_`num'*1000/area_sum;
replace popdensity19`num' = . if popdensity19`num'==0;
};

gen ch_popdensity_20001990 = popdensity2000-popdensity1990;
gen ch_popdensity_20001985 = popdensity2000-popdensity1985;
gen ch_popdensity_20001976 = popdensity2000-popdensity1976;

save temp2, replace;
clear;


/* USE LATEST VLSS DATA: 93, 98, 02 */
/* REPRESENTATIVE AT THE PROVINCE LEVEL */;
/* ASK RACHEL - WHERE IS UPDATED 1993 REAL CONSUMPTION PC? */;
cd "VLSS";

/* THERE ARE ONLY 56 OBSERVATIONS FOR 2002 VLSS - 
CHECK WITH RACHEL ABOUT WHY NOT 59 */;
use hhvlssALLcollapse_province_panel;
sort province;
save temp3, replace;
cd ..;

use temp2;
sort province;
merge province using "VLSS\temp3", update replace;
tab _merge; drop _merge;

/* CREATE CONSUMPTION GROWTH FIGURES 1993-98, 1993-2002 */;
/* WHY ARE DECIMAL PLACES SCREWED UP IN 2002? */;
replace exppc02r98 = exppc02r98*100;
gen consgrowth_9398 = (rlpcex1 - exppc93r98)/exppc93r98;
gen consgrowth_9302 = (exppc02r98 - exppc93r98)/exppc93r98;

/* CREATE AVERAGE HEIGHTS FOR BOTH GENDERS */;
foreach yr in
    1931 1936 1941 1946
    1951 1956 1961 1966 1971 1976
{;
gen temp_f = height_f`yr';
replace temp_f = 0 if height_f`yr'==.;
gen weight_f = hnum_f`yr';
replace weight_f = 0 if hnum_f`yr'==.;

gen temp_m = height_m`yr';
replace temp_m = 0 if height_m`yr'==.;
gen weight_m = hnum_m`yr';
replace weight_m = 0 if hnum_m`yr'==.;

gen height_`yr' = (weight_f*temp_f + weight_m*temp_m)/(weight_f+weight_m);
gen hnum_`yr' = (weight_f+weight_m);
gen prop_`yr' = (weight_f)/(hnum_`yr');

drop temp_f temp_m weight_f weight_m;
};


foreach num in
    3 4 5 6 7
{;
gen height_`num'1`num'6 = (hnum_19`num'1*height_19`num'1 + hnum_19`num'6*height_19`num'6)/(hnum_19`num'1 + hnum_19`num'6);
gen hnum_`num'1`num'6 = (hnum_19`num'1 + hnum_19`num'6);
gen prop_`num'1`num'6 = (hnum_19`num'1*prop_19`num'1 + hnum_19`num'6*prop_19`num'6)/(hnum_19`num'1 + hnum_19`num'6);
};


foreach num in
    3 4 5 6 7
{;
gen height_`num'1`num'6_3136 = height_`num'1`num'6 - height_3136;
gen prop_`num'1`num'6_3136 = prop_`num'1`num'6 - prop_3136;

gen height_`num'1`num'6_4146 = height_`num'1`num'6 - height_4146;
gen prop_`num'1`num'6_4146 = prop_`num'1`num'6 - prop_4146;

gen height_`num'1`num'6_5156 = height_`num'1`num'6 - height_5156;
gen prop_`num'1`num'6_5156 = prop_`num'1`num'6 - prop_5156;


gen temp_f1 = height_f19`num'1;
replace temp_f1 = 0 if height_f19`num'1==.;
gen weight_f1 = hnum_f19`num'1;
replace weight_f1 = 0 if hnum_f19`num'1==.;

gen temp_f6 = height_f19`num'6;
replace temp_f6 = 0 if height_f19`num'6==.;
gen weight_f6 = hnum_f19`num'6;
replace weight_f6 = 0 if hnum_f19`num'6==.;

gen temp_m1 = height_m19`num'1;
replace temp_m1 = 0 if height_m19`num'1==.;
gen weight_m1 = hnum_m19`num'1;
replace weight_m1 = 0 if hnum_m19`num'1==.;

gen temp_m6 = height_m19`num'6;
replace temp_m6 = 0 if height_m19`num'6==.;
gen weight_m6 = hnum_m19`num'6;
replace weight_m6 = 0 if hnum_m19`num'6==.;

gen height_f`num'1`num'6 = (weight_f1*temp_f1 + weight_f6*temp_f6)/(weight_f1+weight_f6);
gen height_m`num'1`num'6 = (weight_m1*temp_m1 + weight_m6*temp_m6)/(weight_m1+weight_m6);

drop temp_f* temp_m* weight_f* weight_m*;
};

save temp2, replace; 
clear;

/* INCORPORATE THE 1967 SES MEASURE */;
use "HAMLA\hamla_1may05";
drop province;
rename province_code province;
rename dev_score hamla_dev_score;
label var hamla_dev_score "1967 Avg SES, Province";    
sort province;
save temp3, replace;
clear;

use temp2;
sort province;
merge province using temp3;
tab _merge; drop _merge;

drop sample_all;
gen sample_all = 1;
replace sample_all = 0 if 
    (poverty_p0==. | tot_bmr==. | tot_bmr_per==.
    | popdensity6061==. | south==. | pre_avg==. | soil_1==.
    | age_head02==. | age_head==. | age_head93==.);

compress;

save war_data_province_sep09, replace; /*Formerly temp2*/


/* BRING HEIGHT, HAMLA DATA INTO DISTRICT LEVEL DATASET */;
keep province height* hamla_dev_score;
sort province;
save temp3, replace;
clear;

use temp1;
sort province;
merge province using temp3;
tab _merge; drop _merge;
save war_data_district_sep09, replace; /*Formerly temp1*/
clear;
