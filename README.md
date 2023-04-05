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


