
## Data Source

Data was obtained via an Open Public Records Act request with the New Jersey Department of Elections. The data was provided in individual csv files for all 21 counties in New Jersey and contains registered voter's first and last name, party affiliation, date of birth, and voter address. 

## About fBISG
Social scientists and public health researchers often must predict individual race and ethnicity when assessing disparities in policy and health outcomes. Bayesian Improved Surname Geocoding (BISG), which uses Bayes’ rule to combine information from the census surname list with the geocoding of individual residence, has emerged as a leading methodology for this prediction task 

We introduce a fully Bayesian Improved Surname Geocoding (fBISG) methodology that accounts for potential measurement error in U.S. Census counts by extending the naïve Bayesian inference of the BISG methodology to full posterior inference. To address the missing surname problem, we supplement the U.S. Census surname data with additional data on last, first, and middle names taken from the voter files of six Southern states where self-reported race is available.

Note: fBISG is only as accurate as the data available to it and is an estimate not a certainty. It should be treated as such.

More information on [fBISG available here](https://www.science.org/doi/10.1126/sciadv.adc9824). 

## Methodology

After applying the fBISG algorithm to our registered voter database using the wru package in R, we exported our fBISG CSV file to ArcGIS and geocoded the address column for all 6 million+ voters. 

We ran a tree ring analysis to estimate the demographic makeup of our population at 1 mile, 0.5 miles, and 0.25 miles from a warehouse. 

We choose to sum the mean race probability of each distance interval rather than assign a race to an individual voter and do a total sum due to ethical concerns regarding assigning race based on a threshold cutoff.

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
 
 pred.asian            = 0.10185   ~ **10%**   
 pred.other            = 0.038175  ~ **04%**   

Per our model the probability of identifying as Hispanic nearly doubles for communities within 0.5 miles of a warehouse relative to state totals

- ### Follow up
  - per Migration Policy Institute (MPI) there are an estimated 440,000 unauthorized immigrants in NJ, 314,000 of which would be classified as Hispanic/Latino, 97,000 of which would be classified as Asian.

  -  we suspect that the populations missing from our data [due to ineligibility to register to vote] would  exacerbate our fbisg disparity findings. 
