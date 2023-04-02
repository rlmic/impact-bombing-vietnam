# [The long-term effects of war exposure on civic engagement](https://www.pnas.org/doi/abs/10.1073/pnas.2015539118)

## Description

Datasets shared by Joan Barceló with corrected latitude measurements. 

## Content

| Dataset | Source| Description|
| ------------- | ------------- |------------ |
|corrected_distance_SHARED.dta | Malesky | The first two measurements are in degrees, and the last two are in kilometers. These measurements use the provincial capital as the reference point.|
|pnas_provincecentroid_corrected_shared.dta | Joan Barceló | Uses the province centroid as the reference point. Given that Vietnam was predominantly a rural country, the centroid might better represent a central location minimizing the distance to where people lived. However, this dataset includes only 49 provinces, as these are the provinces with at least one respondent.|

## Problem

Concerns on the:
+ Accuracy of the model. One of the variables might be flawed and the main model might be misspecified.

About the model specification, they argue: "In your model, you follow Miguel and Roland in controlling for south_wartime and latitude_wartime in the first stage.  These covariates are very strongly mechanically correlated to your measure of distance from the 17th, which is the absolute value of distance.  As a result, latitude is already captured in the distance measure and south is captured by the absolute value, as distances below the 17th are turned from negative to positive.  Did you calculate the variance inflation factor (VIF) of these covariates to make sure that the VIF was below 10 for them and that this was not introducing severe multicollinearity?  Are your results in Tables 1-3 robust to dropping latitude and south." In a follow-up email, they continue by saying that: "Again, the issue here is the first-stage regression of the IV-2SLS regression, not the second.  The concern is whether distance from the 17th is actually statistically distinguishable from the combination of Latitude and South.  Together, they appear to be measuring the exact same thing as distance.  We agree that dropping them makes statistical sense, makes it easier to interpret the coefficient on distance, and still provides a reasonably strong first stage.  Have you tried it in your analysis?"

In my opinion, south and latitude are indeed strongly correlated, which explains why their VIF is high. However, as these variables are being used as controls, even if they are estimated inefficiently, they should not impact the main predictor in the model. The bombing variables in my model do not have high VIFs, which reassures me that their coefficients are not being estimated inefficiently. Therefore, I would not recommend removing these two variables. If necessary, I would consider removing one of them to eliminate any redundancy in the controls, which would bring all the VIFs in the models below 10.

In general, I believe that a high VIF in control variables should not be a cause for concern. If two controls are highly correlated with each other, it is common practice to consider removing one of them, but never both. Removing both could create an omitted variable bias in the model. Additionally, it is possible that there are more provinces, districts, or people farther away from the 17th parallel in the north than in the south. Removing the south dummy would affect the variable "distance to the parallel" due to the imbalance in the north-south distance to the parallel.


I have confirmed that the variable "north_latitude" is off by about 1 or 2 degrees to the north of its actual location. I have not yet checked the impact of this on my results, but it appears to be a measurement error rather than a systematic issue. The deviation is only in the provincial data, so I suspect it could have been a problem with aggregating the latitude values from the districts to the province. I was wondering if you have any old code that could confirm this as the explanation for the deviation. Do you have any thoughts on this?
