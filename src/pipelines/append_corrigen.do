/*
VALIDATING THE CORRELATION BETWEEN OLD AND
PREVIOUS COORDINATES

CONTROLLED BY ORIGINAL SOUTH INDICATOR
------------------------------------------

*/


use "$district_data", clear
eststo clear

eststo tab: regress                                                         ///
    diff_17_corrected                                                       ///
    diff_17                                                                 ///
    south
    
// Produce regression table

esttab `tab' using "$tables/tab_valid_dist.tex", replace                    ///
    nomtitle label star(* 0.10 ** 0.05 *** 0.01)                            ///
    booktabs nonotes                                                        ///                                                 
    sfmt(%14.5fc) r2 b(%12.7f) se(%12.7f)                                  