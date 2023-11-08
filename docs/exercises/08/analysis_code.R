### This script conducts an analysis described in Chp. 8. Data manipulation in the tidyverse.


### Goal 1: Compare the total number of macroinvertebrate taxa at found at each site.

## Start with the macroinvertebrates data downloaded from NEON.
 startdate <- "2021-05-31"
 enddate <- "2021-10-31"

 # Define the sites to download 
 # TECR = Teakettle Creek,  MART = Martha Creek, CARI = Caribou Creek
 sites <- c("TECR", "MART", "CARI") 

 # Macroinvertebrate observations
 inverts_list <- loadByProduct(dpID = "DP1.20120.001",
                               site = sites,
                               startdate = startdate,
                               enddate = enddate)

 # Temperature in surface water
 watertemp_list <- loadByProduct(dpID = "DP1.20053.001",
                                 site = sites,
                                 startdate = startdate,
                                 enddate = enddate)

## Extract two tables from this download:

 # Extract invertebrate collections
 # inv_fieldData = when and where the invertebrate samples were collected
 inv_fieldData <- inverts_list$inv_fieldData

 # Extract taxonomic information
 # inv_taxonomyProcessed = which taxa were collected in each sample
 inv_taxa <- inverts_list$inv_taxonomyProcessed


## Use the `inv_taxonomyProcessed` table to count the number of unique
## taxa found at each site, combining across all of the samples from 
## each site (which were collected at different locations and on two 
## separate sampling dates).

 inverts_bysite <- inv_taxa %>% 
   group_by(siteID) %>%
   summarize(num_taxa = length(unique(scientificName)))

 # Output a table comparing these values.
 inverts_bysite




### Goal 2: Plot macroinvertebrate abundance and temperature over time

## Start with macroinvertebrate data tables
## inv_fieldData and inv_taxonomyProcessed (saved as inv_taxa)
## Use surface water temperature data from TSW_30min

## Use inverts_taxa to calculate the total abundance of
## macroinvertebrates in each sample from each site 
 inverts_bysample <- inv_taxa %>%
   group_by(siteID, sampleID) %>%
   summarize(total = sum(estimatedTotalCount))

## Join inverts_bysample with inv_fieldData to determine the 
## dates which each sample was collected and the amount of area sampled.

 # Since we don't need all the columns, we can just select the columns
 # of interest before joining.
 field_cols <- inv_fieldData %>% 
   select(sampleID, collectDate, benthicArea)

 # Join the invertebrate abundance with field data columns
 # left_join keeps all rows in inverts_bysample
 inverts_bysample <- left_join(inverts_bysample, field_cols, by = "sampleID")


## Control for variability in abundance based on the amount 
## of area sampled by calculating density = abundance / area`

 inverts_bysample <- inverts_bysample %>%
   mutate(density_per_m2 = total / benthicArea)


## Calculate average macroinvertebrate density across all samples 
## collected on the same date at the same site. 

 # Make a column that extracts the date from collectDate
 # First need to convert collectDate to a date-time class
 # Then extract just the date portion
 inverts_bysample <- inverts_bysample %>%
   mutate(collectDate = ymd_hms(collectDate),
          collect_day = date(collectDate))
 # Note: we could have combined this step with the last
 # step and created  two columns with one `mutate()`.

 # Summarize the samples by date and site
 # calculate average macroinvertebrate density
 # calculate number of samples averaged 
 inverts_bysite <- inverts_bysample %>%
   group_by(siteID, collect_day) %>%
   summarize(density_per_m2 = mean(density_per_m2),
             n_samples = n()) 


## Calculate average temperature across both sensors for 
## each time point at each site and save this in a new table

 TSW_avg <- TSW_30min %>%
   group_by(siteID, startDateTime) %>%
   summarize(temp_avg_C = mean(surfWaterTempMean),
             n_obs = n()) # keep track of the number of measurements averaged


## Graph macroinvertebrate density and temperature over time 
## for the four sites.

 # Convert startDateTime to a date-time class
 TSW_avg$startDateTime <- ymd_hms(TSW_avg$startDateTime)

 # Temperature vs. time colored by site
 TSW_avg %>% 
   ggplot(aes(x = startDateTime, y = temp_avg_C, color = siteID)) +
   geom_line() +
   labs(x = "Date",
        y = expression("Surface water temperature"~(degree*C)),
        color = "NEON Site")

 # Macroinvertebrate density vs. time
 inverts_bysite %>% 
   ggplot(aes(x = collect_day, y = density_per_m2, color = siteID)) +
   geom_point() +
   geom_line() +
   labs(x = "Date",
        y = expression("Macroinvertebrate density (num. per"~m^2),
        color = "NEON Site")


 # Define 3 day time intervals before each collection date
 inverts_bysite$temp_interval <- interval(end = inverts_bysite$collect_day,
                                          start = inverts_bysite$collect_day - ddays(3))

## Join inverts_bysite with temperature data that corresponds to the
## date when samples were collected.

 # Define a vector to hold the average temperatures
 # There will be one for each row in inverts_bysite
 N <- nrow(inverts_bysite)
 avg_temp <- rep(NA, N) 

 # Loop through each row in inverts_bysite
 for(i in 1:N){
  
   # Define the time interval and site for this row
   this_interval <- inverts_bysite$temp_interval[i]
   this_site <- inverts_bysite$siteID[i]
  
   # Get all rows from TWS_avg within the time interval for this row
   use_temps <- filter(TSW_avg, 
                       startDateTime %within% this_interval,
                       siteID == this_site)
  
   # Calculate the average temperature and save it in avg_temp
   # remove any missing values
   avg_temp[i] <- mean(use_temps$temp_avg_C, na.rm = TRUE)
 }

 # Add avg_temp as a new column in inverts_bysite
 inverts_bysite$temp_avg_3day <- avg_temp

## Graph macroinvertebrate density versus water temperature as a scatterplot.
## Connect points from the same site with arrows pointing from the 
## first to the second sample.

 inverts_bysite %>%
   ggplot(aes(x = temp_avg_3day, y = density_per_m2)) + 
   geom_point(aes(color = siteID)) + 
   labs(x = expression("Surface water temperature"~(degree*C)),
        y = expression("Macroinvertebrate density (num. per"~m^2),
        color = "NEON Site")
 
 
 