# The long-run impact of bombing Vietnam

## Overview

This repository aims to facilitate the reproducibility of the paper "The Long-run Impact of Bombing Vietnam." Thus, we provide the replication materials to reproduce the econometric analysis and the expected output.

## Project structure

The folder is structured to facilitate the reproduction of the principal analysis and the alternative research mentioned in the original paper "The long-run impact of Bombing Vietnam" and its corresponding Supplement. Likewise, we have included the code to reproduce the figures and additional outputs as part of the *Corrigendum* to "The Long-run Impact of Bombing Vietnam."

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

## How to replicate the analysis  

Open the `main.do` file, located in the following directory `src/pipelines/` and execute. The `main.do` file calls on the other do files to reproduce each part of the analysis. In particular:

+ `analysis_corrected.do`: reproduces the main analysis within the paper, with the correction for the errors in re-projecting district and province locations from one geographic coordinate systems to another. 
+ `analysis_alterna.do`: reproduces the alternative econometric analysis mentioned withint the original paper, but not shown withing the tables included as part of the published paper.
+ `append_corrigen.do`: reproduces the additional analysis produced as part of the appendix in the *Corregidum*.

In the beginning portion of the `main.do` file, you will see the following lines of code:

```{do}
// Change this path
global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"
```

This global variable defines where the directory sits on your computer. To run the replication file, you'll need to change this to reflect where you're storing the directory on your hard drive (the filepath). Note that several STATA routines may need to be installed for the programs to run properly. 

The expected outputs will be produced within the directory `outputs/`, either under `outputs/figures/` or `outputs/tables/`. To facilitate tracking the execution of the do file, a logs file will be saved under `logs/`, which you can use to check the tables and figure. 

## Data Sources

To reproduce this analysis, two main data sources are used:
+ district_bombing_corrected_data.dta: relevant variables a district-level.
+ province_bombing_corrected_data.dta: relevant variables a province-level.

## Documentation

As part of the documentation of this project, we include the following documents:
+ `impact-bombing-vietnam-paper.pdf`: Original paper published in the Journal of Development Economics.
+ `impact-bombing-vietnam-suplement.pdf`: The supplement material that outlines minor discrepancies found in data replication which do not, as a whole, affect the reported data analysis published in the paper.
+ `impact-bombing-vietnam-corrigendum.pdf`: The *corrigendum* that corrects Miguel and Roland (2010) for errors in re-projecting district and
province locations from one geographic coordinate system to another. 

## Contact information

	