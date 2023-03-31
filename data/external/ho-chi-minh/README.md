# [The long-term effects of war exposure on civic engagement](https://www.pnas.org/doi/abs/10.1073/pnas.2015539118)

## Description

Datasets shared by Joan Barceló with corrected latitude measurements. 

## Content

| Dataset | Source| Description|
| ------------- | ------------- |------------ |
|corrected_distance_SHARED.dta | Malesky | The first two measurements are in degrees, and the last two are in kilometers. These measurements use the provincial capital as the reference point.|
|pnas_provincecentroid_corrected_shared.dta | Joan Barceló | Uses the province centroid as the reference point. Given that Vietnam was predominantly a rural country, the centroid might better represent a central location minimizing the distance to where people lived. However, this dataset includes only 49 provinces, as these are the provinces with at least one respondent.|

## Problem


I downloaded the data from your archived website (clear and well-organised one, personally I like it, here is http://emiguel.econ.berkeley.edu/research/the-long-run-impact-of-bombing-vietnam/).

Then, we have two .dta files (war_data_province.dta and war_data_district.dta) with the variables "north_lat" (North latitude). 

Just picked one province: Thuathien-Hue (currently, located at around 18 northern latitude in your data - above 17th parallel - belonging to the above-side). However, as far as I checked at NASA (Located at 16.5 degrees north latitude, Google GIS is around 16.4860° N). I expanded by collecting my own data collection and found some differences (attached file) for all provinces around 2 degree differences. How does it influence results? north_lat is used to calculate the "diff_17" (with abs) the differences from 17th parallel. The current version (probably) used the 15th parallel with no variation at another province but it is not the Vietnamese Demilitarized Zone, previously defined.
