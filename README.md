# The long-run impact of bombing Vietnam

## Project structure

This folder contains the necesarry files to reproduce the analysis.

```
├── LICENSE
├── README.md          <- The top-level README for users.
├── data
│   ├── clean          <- Data from third party sources.

│
├── docs               <- A default Sphinx project; see sphinx-doc.org for details
│   └── codebook       <- 
│   └── tables    
│
├── outputs            <- Generated analysis as HTML, PDF, LaTeX, etc.
│   └── figures        <- Generated graphics and figures to be used in reporting
│   └── tables         <- Generated tables to be used in reporting
│
├── src/               <- Source code for use in this project, see below for script details.
│   ├── general        <- Scripts to download or generate data
│   │
│   ├── pipelines
        ├──  main.do
        └──  produce_analysis_corrected.do

```

## How to replicate the analysis  

Open the main.do file, and execute. A log file is produced, which you can use to check the tables and figure. 

In the beginning portion of the .do file, you will see the following lines of code:

```{do}
// Change this path
global dir = "/Users/cegaadmin/Dropbox (CEGA)/github/impact-bombing-vietnam"
```

This global variable defines where the directory sits on your computer. To run the replication file, you'll need to change this to reflect where you're storing the directory on your hard drive (the filepath). Note that several STATA routines may need to be installed for the programs to run properly.

	