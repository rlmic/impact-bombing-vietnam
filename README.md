# The long-run impact of bombing Vietnam

## Project structure

```
├── LICENSE
├── README.md          <- The top-level README for users.
├── data
│   ├── external       <- Data from third party sources.
│   ├── interim        <- Intermediate data that has been transformed.
│   ├── processed      <- The final, canonical data sets for modeling.
│   └── raw            <- The original, immutable data dump.
│
├── docs               <- A default Sphinx project; see sphinx-doc.org for details
│
│
├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
│                         the creator's initials, and a short `-` delimited description, e.g.
│                         `1.0-jqp-initial-data-exploration`.
│
│
├── outputs            <- Generated analysis as HTML, PDF, LaTeX, etc.
│   └── figures        <- Generated graphics and figures to be used in reporting
│   └── tables         <- Generated tables to be used in reporting
│
├── src/               <- Source code for use in this project, see below for script details.
│   ├── general        <- Scripts to download or generate data
│   │
│   ├── pipelines

```
# Datasets

+ Defense Security Cooperation Agency (DSCA): Archives housed at the United States National Archives in Record Group 218, called “Records of the U.S. Joint Chiefs of Staff”. The database contains information on all ordnance dropped from U.S. and allied airplanes and helicopters in Vietnam between 1965 and 1975, as well as artillery fired from naval ships.

+ Vietnam Poverty, Geographic, and Climatic Data
District-level estimates of poverty were provided by Nicholas Minot of the International Food Policy Research Institute (IFPRI). The estimates were generated through poverty mapping, an application of the small-area estimation method developed in Elbers et al (2003). This method matches detailed, small- sample survey data to less-detailed, large-sample census data across geographic units, to generate area- level estimates of an individual- or household-level phenomenon—in our case, district-level poverty incidence in Vietnam. For more detailed information, see Minot et al. (2003).
The two datasets used by Minot et al. (2003) are the 1997/8 Vietnam Living Standards Survey (VLSS) and a 33% subsample (5,553,811 households) of the 1999 Population and Housing Census. The VLSS, undertaken by the Vietnam General Statistical Office (GSO) in Hanoi with technical assistance from the World Bank, is a detailed household-level survey of 4270 rural and 1730 urban Vietnamese households. The 1999 Population and Housing Census was conducted by the GSO with technical support from the United Nations Family Planning Agency and United Nations Development Program (UNDP). We also use data from the 1992/3 and 2002 VLSS survey rounds in this paper.
 49
Minot et al. use the VLSS data to estimate a household-level, log-linear regression of real cost-of- living-adjusted per capita consumption expenditure on 17 household characteristics common to both the VLSS and the Population and Housing Census. These characteristics include: household size, proportion over 60 years old, proportion under 15 years old, proportion female, highest level of education completed by head of household, whether or not head has a spouse, highest level of education completed by spouse, whether or not head is an ethnic minority, occupation of head over last 12 months, type of house (permanent; semi-permanent or wooden frame; “simple”), house type interacted with living area, whether or not household has electricity, main source of drinking water, type of toilet, whether or not household owns a television, whether or not household owns a radio, and region. Minot et al. (2003) partition the sample to undertake separate parameter estimates for the correlates of rural and urban poverty.
Predicted consumption expenditures per capita for each of the district-coded households in the 1999 Population and Housing Census sample are then generated using the parameter estimates from these regressions. Properly weighting by the size of each household, this enables Minot et al (2003) to generate an estimate of district-level poverty incidence, the percentage of the population in each district that lives below the official national poverty line of 1,789,871 Dong (VND) per person per year (GSO 2000).
All district-level topographic, geographic, and climatic data used in this paper were provided by Nicholas Minot and are identical to those used in Minot et al. (2003). The topographical data used in Minot et al. (2003) are taken from the United States Geological Survey.
Province population figures in the 1980s and 1990s are from the Vietnam Statistical Yearbooks (Vietnam General Statistical Office). Unfortunately, we have been unable to locate complete and consistently defined province level demographic data from the mid-1970s through the mid-1980s. These Yearbooks also contain information on total state investment flows by province from 1976-1985, data that is also used in the statistical analysis.

+ Data from the pre-*American War* period

Pre-war, province-level demographic data on South Vietnam were taken from the 1959-1965 editions of the Statistical Yearbook of Vietnam, published by the National Institute of Statistics in Saigon, and for North Vietnam from the Vietnam Agricultural Statistics over 35 Years (1956-1990), published by the GSO Statistical Publishing House in Hanoi (1991). Province level agricultural statistics are also available (e.g., rice paddy yields), but it is widely thought that such prewar data are unreliable as a result of the prewar ideological conflict between North and South Vietnam (Banens 1999), and thus we do not use those data in the analysis.
A final data source we considered is the HAMLA/HES database collected by the U.S. government starting in South Vietnam in 1967-68 (described in Kalyvas and Kocher 2003), which collected rough proxies for village socioeconomic conditions. The two main drawbacks of this data is that first, the exact procedure for assigning the local SES measures is not transparent or well-described in existing sources, and second the data was collected several years into the war, and thus may be endogenous to earlier U.S. bombing patterns. For these reasons we do not utilize this data in the analysis.


# Reproducing the results

## Running the main analysis
## Constructing the datasets




\Pre-war Data\prewardt.do

Constructs "\Pre-war Data\prewardt.dta" from the Data*.txt files.  Calls 
on prewardtNViet.do to integrate the North Vietnamese data (because the 
file was at maximum length, and this was a natural break point, as the 
merge methods differ.)  Logs using "\Pre-war Data\prewardt.log."

Matches districts to their pre-war provinces using "\Pre-war 
Data\districtcodesprewarmatchedw.txt" and "\Pre-war 
Data\districtcodesprewarmatchedN.txt" for South and North Vietnam 
respectively.  

There are notes on this data in "\Pre-war Data\Pre-War Data Report 
8-13-04.doc."



To construct full datasets \temp1.dta and \temp2.dta from the original 
tab-delimited/csv tables, the correct order in which to run the files is 
as follows: "\Pre-war Data\prewardt.do," \VLSS\hhconst.do, 
\VLSS\comconst.do, \war_082504.do.

NOTE: All do-files must be run from the directories that contain them.  

-----

LIST OF KEY FILES, INCLUDING DO-FILE OUTPUT

*****

"\Bombing Decisions - Reduced Form.doc" is the 13-page list of categorized 
quotations regarding relevant points of Vietnamese bombing strategy.  My 
own personal summaries and observations are in small caps.  

"\DATA WRITE-UPS2.doc" is a 7-page collection of preliminary data 
write-ups for all our datasets.  

"\DATA WRITE-UPS2SUPP.doc" is an 8-page table, with introduction, 
providing best available details on the categories used in the bombing 
data (specifically, those derived from AIR_SUM.txt, as the Naval Gunfire 
Data are less interesting a priori and proved too cryptic to decipher.)  

*****

\war_082504.do

**THIS IS THE FILE THAT SHOULD BE MODIFIED TO OUTPUT DESIRED STATISTICAL 
TABLES.  THE OTHER FILES MERELY CONSTRUCT ITS INPUTS AND NEED BE REFERRED 
TO ONLY FOR CLARIFICATION.**

Constructs complete dataset from bombing data, VLSS commune-level 
collapsed data, pre-war data from statistical yearbooks yearbooks, and 
social, topographical, and climatological variables provided by Nicholas 
Minot at IFPRI.  

Assembles \temp1.dta and \temp2.dta (temp1.dta collapsed to province 
level) from \DSCA\DSCAdata.dta, \VLSS\VLSScommune.dta, "\Pre-war 
Data\prewardt.dta," \IFPRI\SES-data.csv, \IFPRI\GIS_var1.dta, 
\IFPRI\GIS_var2a.dta.  

Constructs intermediate files \DSCA\temp1.dta, \VLSS\temp1.dta, 
\IFPRI\temp1.dta, and \IFPRI\temp2.dta.  Logs using \war_082504.log.

*****

\DSCA\dscadatawork.do

Constructs \DSCA\DSCAdata.dta from \DSCA\AIR_SUM.txt, \DSCA\NAVY_SUM2.txt, 
and "\DSCA\Geo codes for Vietnam.txt."  Logs using \DSCA\dscadatawork.log.

*****

\VLSS\Hhconst.do

Constructs \VLSS\hhvlss98.dta and \VLSS\hhvlss98collapse.dta (hhvlss98.dta 
collapsed to commune level, using only household heads, weighted by 
provided weights multiplied by household size) from \VLSS\93EXP.dta (Nick 
Minot's constructed 93 expenditure file) and VLSS files in 
\VLSS\VLSS98\DATA\HOUSEHOLD.  Logs using \VLSS\Hhconst.log.

*****

\VLSS\Comconst.do

Constructs \VLSS\comvlss98.dta, \VLSS\comvlss98collapse.dta 
(comvlss98.dta, collapsing all responses from various respondents into a 
single observation for each commune, simply averaging responses when there 
are more than two for a single variable,) and ultimately 
\VLSS\VLSScommune.dta, the merging ov \VLSS\hhvlss98collapse.dta, 
\VLSS\comvlss98collapse.dta, and comVLSSmatch.dta, which matches VLSS 
commune codes to GSO codes of communes and districts (omitting a handful 
of ambiguous cases.)  

Logs using \VLSS\Comconst.log.

*****

\Pre-war Data\prewardt.do

Constructs "\Pre-war Data\prewardt.dta" from the Data*.txt files.  Calls 
on prewardtNViet.do to integrate the North Vietnamese data (because the 
file was at maximum length, and this was a natural break point, as the 
merge methods differ.)  Logs using "\Pre-war Data\prewardt.log."

Matches districts to their pre-war provinces using "\Pre-war 
Data\districtcodesprewarmatchedw.txt" and "\Pre-war 
Data\districtcodesprewarmatchedN.txt" for South and North Vietnam 
respectively.  

There are notes on this data in "\Pre-war Data\Pre-War Data Report 
8-13-04.doc."


Pre-War Data
prewardt.dta (sorted by district, should merge easily)
all-inclusive (as requested)

All yields are in tons per hectare.  
All productions are in tons.  
All planted areas are in hectares.  
All population densities are per km2.

All variables ending with YEAR_n are derived from the recent North 
Vietnamese yearbook.  There are 17 districts with pre-war figures from 
both the recent North Vietnamese yearbook and old South Vietnamese 
yearbooks.  Error could have been introduced at many points throughout the 
process, and their “percent disagreement” (difference/average) exceeds 
100% in some cases.  This could result from disagreements in the original 
reporting or from errors introduced by the interpolation method; there is 
now way of knowing, as the original data cover different areas.  

There’s no theoretical reason we cannot merge the “paddy yield” and 
“population density” variables (or any other agreements that exist) across 
the North and South Vietnamese Data :
	
egen paddyyield1960=rmean(paddyyield1960n paddyyieldperhectare1959 
paddyyieldperhectare1961);
egen paddyyield1965=rmean(paddyyield1965n paddyyieldperhectare1965);
egen popdensity_1960=rmean(popdensity1960n popdensity1959 popdensity1961);

There’s a good case to be made for the pre-war figures being approximately 
province-level for the north, and approximately district-level for the 
south.  
Districts:	Total	Split	Split>.05	PctSplit	
PctSplit>.05
North(1965)	328	78	16	0.237805	0.04878
1965	302	138	92	0.456954	0.304636
1963	302	141	100	0.466887	0.331126
1962	301	124	107	0.41196	0.355482
1961	302	121	97	0.400662	0.321192
1959	303	75	64	0.247525	0.211221


