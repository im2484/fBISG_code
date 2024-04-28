
options(scipen=999)# setting to avoid exponent form in our data 

#download libraries 

library(wru)
library(eiCompare)
library(tidycensus)
library(stringr)
library(tidygeocoder)
library(tidyverse)

#signed up for US census API key to access wru library 

census_api_key("a76f383b6970e77c44252d493390ad49f21ce247", install = TRUE)
readRenviron("~/.Renviron")

Sys.setenv("a76f383b6970e77c44252d493390ad49f21ce247" = "Your Key")

#Test run wru package using just Atlantic County, New Jersey

atlantic_county_voters <- read.csv("vlist_Atlantic.csv")

atlantic_county_voters <- atlantic_county_voters %>%
  mutate(surname = last,
         state = 'nj',
         county = '001',
         partyReg = ifelse(party == "Democratic",1,ifelse(party == "Republican",2,0)),
         age = 2023 -(as.integer(substr(atlantic_county_voters$dob, start = 1, stop = 4))))


atlantic_bisg <- predict_race(voter.file = atlantic_county_voters, surname.only = F,names.to.use = 'surname, first',surname.year = 2010,party = "partyReg", year = 2020, census.geo = "county", census.key = "a76f383b6970e77c44252d493390ad49f21ce247")# use predict_race function in wru package to execute analysis

# test run was successful and predicted race for registered voters in Atlantic County, New Jersey (NJ)

# Next: load csv datasets for all 21 NJ counties 

nj_voter_list <-  list.files(path = "C://Users//im2484//OneDrive - Princeton University//Desktop//High_WaterMark//Documentary//Warehouse_Section//Warehouse_proximityMapping_Sample//BISG_Method//Statewide Voter List 09.29.2023//light_house", 
                  pattern = "*.csv",) %>% 
  map_df(~read_csv(.) %>%
           mutate(ward = as.numeric(ward),
                  district = as.numeric(district)))

nj_county_fips <- data.frame(county = c("Atlantic","Bergen","Burlington","Camden","CapeMay","Cumberland","Essex","Gloucester","Hudson","Hunterdon","Mercer","Middlesex","Monmouth","Morris","Ocean","Passaic","Salem","Somerset","Sussex","Union","Warren")) %>%
  mutate(fips_code = seq(1, 41, by = 2))

nj_county_fips$fips_code <- sprintf("%003d", nj_county_fips$fips_code) 
nj_voter_list <- left_join(nj_voter_list, nj_county_fips, by='county',all.x = TRUE) # create chr FIPS code column


nj_voter_list <- nj_voter_list %>%
  mutate(surname = last,
         state = 'nj',
         partyReg = ifelse(party == "Democratic",1,ifelse(party == "Republican",2,0)),
         age = 2023 -(as.integer(substr(nj_voter_list$dob, start = 1, stop = 4))),
         address = str_c(nj_voter_list$street_num, nj_voter_list$street_name,sep = " ")) %>%
  rename(county_name = 'county',
         county = 'fips_code') #mutate necessary column names and conditions to execute model

nj_voter_list <- nj_voter_list[!is.na(nj_voter_list$surname), ] # drop NA values


nj_voter_fbisg <- predict_race(voter.file = nj_voter_list, surname.only = F, names.to.use = 'surname, first', surname.year = 2020, party = "partyReg", year = 2020, census.geo = "county", model = "fBISG", census.key = "a76f383b6970e77c44252d493390ad49f21ce247") # apply conditions to run our fBISG model

#6,446,623 registered voters in our dataset
#921,996 (14.3%) individuals' last names were not matched.
#257,881 (4%) individuals' first names were not matched.

# Sum the mean of each race category 
# NJ_fbisg total voter list [scaled from 0 to 1 on a probability scale] 

mean(NJ_fbisg$pred.whi) #0.6058878  ~ 61%
mean(NJ_fbisg$pred.bla) #0.1040542  ~ 10%
mean(NJ_fbisg$pred.his) #0.1682297  ~ 17%
mean(NJ_fbisg$pred.asi) #0.08734088 ~ 09%
mean(NJ_fbisg$pred.oth) #0.03448744 ~ 03%

write.csv(NJ_vList_fbisg,"C://Users//im2484//OneDrive - Princeton University//Desktop//High_WaterMark//Documentary//Warehouse_Section//Warehouse_proximityMapping_Sample//BISG_Method//NJ_fbisg_zip.csv")

# NJ_fbisg registered voters within 0.5 mile of a warehouse (517,480) [scaled from 0 to 1 on a probability scale] 

# pred.white            = 0.379362  ~ 38%   
# pred.black            = 0.153323  ~ 15%   
# pred.hispanic         = 0.327291  ~ 33%   
# pred.asian            = 0.10185   ~ 10%   
# pred.other            = 0.038175  ~ 04%   
