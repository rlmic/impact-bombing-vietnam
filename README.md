# The long-run impact of bombing Vietnam
===

## Overview
<p align="justify">

This repository aims to facilitate the reproducibility of the paper "The Long-run Impact of Bombing Vietnam." by E. Miguel and G. Roland, in the Journal of Development Economics, alongside posterior corrections to the original paper --Supplement of "The Long-run Impact of Bombing Vietnam" and the *Corrigendum* to "The Long-run Impact of Bombing Vietnam". 

Continuing, we present a "map"*" to help the user navigate through this project, a detailed description on how to run the analysis, a brief description of the data sources and documentation, finalizing with relevant contact information.

## Project structure

The folder is structured to facilitate the reproduction and transparency in the generation of the econometric analysis. To navigate efficiently through the project, please refer to the following detailed "map" of the project:

```
├── README.md          <- The top-level README for users.
├── data
│   ├── clean          <- Data used as input for the analysis.
│     ├── district_bombing_corrected_data.dta
│     └── province_bombing_corrected_data.dta
│
├── docs               <- Documentation associated with the paper. See below for documentation details.
│   └── impact-bombing-vietnam-suplement.pdf   
│   └── impact-bombing-vietnam-corrigendum.pdf   
│   └── impact-bombing-vietnam-paper.pdf    
│
├── outputs            <- Outputs produced by the source code
│   └── figures        <- Generated graphics and figures to be used in reporting
│   └── tables         <- Generated tables to be used in reporting
│
└── src                <- Source code for to reproduce analysis
    ├── general        <- Scripts contaning the constants used in the project. See below for script details.
    │   ├──  constants.do
    │   ├──  lab_dis.do
    │   └──  lab_pro.do
    │
    └── pipelines      <- Scripts contaning the main code to reproduce the analysis project. 
        ├──  main.do
        ├──  analysis_alterna.do
        ├──  analysis_corrected.do
        └──  append_corrigen.do 

```

## How to replicate the analysis?[^1]  

Open the `main.do` file, located under `src/pipelines/` and execute. The `main.do` file calls on the other do files to reproduce each part of the analysis. In the beginning portion of the `main.do` file, you will see the following lines of code:

```{do}
// Change this path
global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"
```

This global variable defines where the directory sits on your computer. **To run the replication file, you'll need to change this to reflect where you're storing the directory on your hard drive (the filepath)**. 

Note that several STATA routines may need to be installed for the programs to run properly. 

The `main.do` file will 1) load the constants and labels used for our analysis, 2) load the corresponding data sources, 3) run the analysis, splitted in three other do files:

      + `analysis_corrected.do`: reproduces the main analysis presented in the original paper, considering as input the corrected locations of the provinces and districts in Vietnam, 

      + `analysis_alterna.do`: generates the alternative econometric analysis mentioned in the original paper, but not shown in the tables included as part of the published paper,

      + `append_corrigen.do`: produces the additional analysis included as part of the Appendix of the *Corregidum*.

The expected outputs will be produced within the directory `outputs/`, either under `outputs/figures/` or `outputs/tables/`. Finally, to facilitate tracking the execution of the do file, a logs file will be saved under `logs/`, which you can use to check the tables and figure. 

## Data Sources

The two main data sources are used are located under `data/` and include:

+ district_bombing_corrected_data.dta: relevant variables at district-level.
+ province_bombing_corrected_data.dta: relevant variables at province-level.

## Documentation

We include the following documents to serve as reference as one is reproducing the paper:

+ `impact-bombing-vietnam-paper.pdf`: Original paper published in the Journal of Development Economics.
+ `impact-bombing-vietnam-supplement.pdf`: The supplement material that outlines minor discrepancies found in data replication which do not, as a whole, affect the reported data analysis published in the paper.
+ `impact-bombing-vietnam-corrigendum.pdf`: The *Corrigendum* to corrects Miguel and Roland (2011) for errors in re-projecting district and
province locations from one geographic coordinate system to another. 

## References

[1] Edward Miguel and G ́erard Roland. “The long-run impact of bombing Vietnam”. In: Journal of Development Economics 96.1 (2011), pp. 1–15. url:  https://doi.org/10.1016/j.jdeveco.2010.07.004


## Contact information

+ Edward Miguel emiguel@berkeley.edu

[^1]: Several STATA routines may need to be installed for the programs to run properly. 

</p>