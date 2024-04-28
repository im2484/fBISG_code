# Modeling racial disparities in exposure to Warehouse Pollution in New Jersey

## Motivation

New Jersey has seen an unprecedented expansion of warehouse distribution centers since 2020, with corporations such as Amazon and Wayfair pouring thousands of trucks into local communities. This has strained local infrastructure and created a threat to public health. Air and noise pollution produced by heavy-truck traffic increases the risk of preterm births and respiratory disease.  

It is anecdotally understood that distribution centers are typically developed in areas with high Black and Hispanic populations. Yet, the scale of this disparity is not documented since the state does not track warehouse development.   

In order to quantify the scale of this problem, we used warehouse data obtained from a financial database and a dataset of 6 million registered voters obtained through an OPRA request. We applied a race prediction algorithm (fBISG) that imputes racial probability using party affiliation, first and last name, and county of residence. We then geocoded all registered addresses and conducted a spatial analysis at different distance intervals. 



## About fBISG
Social scientists and public health researchers often must predict individual race and ethnicity when assessing disparities in policy and health outcomes. Bayesian Improved Surname Geocoding (BISG), which uses Bayes’ rule to combine information from the census surname list with the geocoding of individual residence, has emerged as a leading methodology for this prediction task 

In 2022 a fully Bayesian Improved Surname Geocoding (fBISG) methodology was introduced that accounts for potential measurement error in U.S. Census counts by extending the naïve Bayesian inference of the BISG methodology to full posterior inference. To address the missing surname problem, It supplements the U.S. Census surname data with additional data on last, first, and middle names taken from the voter files of six Southern states where self-reported race is available.

Note: fBISG is only as accurate as the data available to it and is an estimate not a certainty. It should be treated as such.

More information on [fBISG is available here](https://www.science.org/doi/10.1126/sciadv.adc9824). 

## Data Source

The data used in our model was obtained via an Open Public Records Act request with the New Jersey Department of Elections. The data was shared in individual CSV files for all 21 counties in New Jersey and contains the registered voter's first and last name, party affiliation, date of birth, and voter address. 

## Methodology

After applying the fBISG algorithm to our registered voter database using the wru package in R, we exported our fBISG CSV file to ArcGIS and geocoded the address column for all 6 million+ voters. 

We ran a tree ring analysis to estimate the demographic makeup of our population at 1 mile, 0.5 miles, and 0.25 miles from a warehouse. 

We choose to sum the mean race probability of each distance interval rather than assign a race to an individual voter and do a total sum

 [due to ethical concerns regarding assigning race based on a threshold cutoff.]

## Findings

 NJ_fbisg registered voters **state total** (6,446,623) [scaled from 0 to 1 on a probability scale] 

 pred.white            = 0.6058878  ~ **61%**   
 pred.black            = 0.1040542  ~ **10%**   
 pred.hispanic         = 0.1682297  ~ **17%**   
 pred.asian            = 0.0873408  ~ **9%**  
 pred.other            = 0.0344874  ~ **3%**  

 NJ_fbisg registered voters within **0.5 miles** of a warehouse (517,480) [scaled from 0 to 1 on a probability scale] 

 pred.white            = 0.379362  ~ **38%**   
 pred.black            = 0.153323  ~ **15%**   
 pred.hispanic         = 0.327291  ~ **33%**   
 pred.asian            = 0.10185  ~ **10%**  
 pred.other            = 0.038175  ~ **4%**   

  NJ_fbisg registered voters within **0.25 miles** of a warehouse (164,177) [scaled from 0 to 1 on a probability scale] 

 pred.white            = 0.36  ~ **36%**   
 pred.black            = 0.16  ~ **16%**   
 pred.hispanic         = 0.35  ~ **35%**   
 pred.asian            = 0.10  ~ **10%**  
 pred.other            = 0.04  ~ **4%**  


- ### Follow up
  - per Migration Policy Institute (MPI) there are an estimated 440,000 unauthorized immigrants in NJ, 314,000 of which would be classified as Hispanic/Latino, 97,000 of which would be classified as Asian.

  -  we suspect that the populations missing from our data [due to ineligibility to register to vote] would  exacerbate our fbisg disparity findings. 
