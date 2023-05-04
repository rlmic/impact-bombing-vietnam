# The long-run impact of bombing Vietnam

## Project structure

This folder contains the necesarry files to reproduce the analysis, as well as the expected output from the running the source code provided.

```
├── README.md          <- The top-level README for users.
├── data
│   ├── clean          <- Data used as input for the analysis.
      ├── district_bombing_corrected_data.dta
      └── province_bombing_corrected_data.dta
│
├── docs               <- Documentation associated with the paper. See below for documentation details.
│   └── The long-run impact of Bombing Vietnam_Supplement.pdf   
│   └── [Paper] The Long-Run Impact of Bombing Vietnam.pdf    
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
        ├──  produce_analysis_corrected.do
        └──  data_valid.do 

```

## How to replicate the analysis  

Open the `main.do` file, located in the following directory `src/pipelines/` and execute. A log file is produced, which you can use to check the tables and figure. 

In the beginning portion of the .do file, you will see the following lines of code:

```{do}
// Change this path
global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"
```

This global variable defines where the directory sits on your computer. To run the replication file, you'll need to change this to reflect where you're storing the directory on your hard drive (the filepath). Note that several STATA routines may need to be installed for the programs to run properly.

## Github repository asociated

	