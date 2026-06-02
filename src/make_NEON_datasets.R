# This script downloads data sets from NEON and saves them in the format used by this text.

# Check if NEONUtilities are installed and load
neonUtilities_isavailable <- require("neonUtilities")
if(!neonUtilities_isavailable){
  install.packages("neonUtilities")
  library("neonUtilities")
}

# Load other packages
library(dplyr)
library(tidyr)
library(lubridate)

## Define personal NEON API token
NEON_token <- ""

# If not using a token, leave this as 
# NEON_token <- ""

## Surface water and community data from Teakettle Creek, NEON

# Define dates for download: Defined based on when data are collected for the organismal samples
startdate <- "2021-04"
enddate <- "2021-10" # 
aquasite <- "TECR" # Teakettle Creek, Sierra Nevada, CA 


# Access files from NEON API, merge data and read into R
# Must answer "y" to proceed for each download 


# Microbial cell counts in surface water
microbes <- loadByProduct(dpID = "DP1.20138.001",
                              site = aquasite,
                              startdate = startdate,
                              enddate = enddate,
                              token = NEON_token)

# Periphyton, seston and phytoplankton collection # provisional as of 7/2023, May, Aug, Sept 2021
# plankton <- loadByProduct(dpID = "DP1.20166.001",
#                           site = aquasite,
#                           startdate = startdate,
#                           enddate = enddate,
#                           token = NEON_token))

# Macroinvertebrate collection: May, July, Sept 2021
# inverts <- loadByProduct(dpID = "DP1.20120.001",
#                          site = aquasite,
#                          startdate = startdate,
#                          enddate = enddate,
#                          token = NEON_token))



# Nitrate in surface water
nitrate <- loadByProduct(dpID = "DP1.20033.001",
              site = aquasite,
              startdate = startdate,
              enddate = enddate,
              token = NEON_token)

# Photosynthetically active radiation
# PAR <- loadByProduct(dpID = "DP1.20042.001",
#                          site = aquasite,
#                          startdate = startdate,
#                          enddate = enddate,
#                          token = NEON_token))

# Temperature in surface water
watertemp <- loadByProduct(dpID = "DP1.20053.001",
                           site = aquasite,
                           startdate = startdate,
                           enddate = enddate,
                           token = NEON_token)

# Water quality, including conductivity, chl a, oxygen, dom, pH, turbidity
waterqual <- loadByProduct(dpID = "DP1.20288.001",
                           site = aquasite,
                           startdate = startdate,
                           enddate = enddate,
                           token = NEON_token)

# Water sensor locations
sensor_locs <- waterqual$sensor_positions_20288

## Surface water temperature
watertemp_30min <- watertemp$TSW_30min

View(watertemp$variables_20053)

# Define variables to keep in the final data table
keep_vars <- c("siteID", "horizontalPosition", "verticalPosition", 
               "startDateTime", "endDateTime", "surfWaterTempMean", 
               "surfWaterTempExpUncert", "finalQF")
watertemp_30min <- watertemp_30min[, keep_vars]

# Set measurements to NA if quality flag is 1
watertemp_30min[watertemp_30min$finalQF == 1, c("surfWaterTempMean", "surfWaterTempExpUncert")] <- NA

# Identify sensor location
watertemp_30min$HOR.VER <- with(watertemp_30min, paste(horizontalPosition, verticalPosition, sep = "."))


## Water quality
waterqual_inst <- waterqual$waq_instantaneous


# Define variables to keep in the final data table
waterqual_vars <- c("specificConductance", "dissolvedOxygen", "pH", "chlorophyll", "turbidity", "fDOM")
keep_vars <- c("siteID", "horizontalPosition", "verticalPosition", 
               "startDateTime", "endDateTime", 
               "specificConductance", "specificConductanceExpUncert", "specificCondFinalQF",
               "dissolvedOxygen", "dissolvedOxygenExpUncert", "dissolvedOxygenFinalQF",
               "pH", "pHExpUncert", "pHFinalQF",
               "chlorophyll", "chlorophyllExpUncert", "chlorophyllFinalQF",
               "turbidity", "turbidityExpUncert", "turbidityFinalQF",
               "fDOM", "fDOMExpUncert", "fDOMFinalQF")


waterqual_inst <- waterqual_inst[, keep_vars]

# Identify sensor location
waterqual_inst$HOR.VER <- with(waterqual_inst, paste(horizontalPosition, verticalPosition, sep = "."))


## Nitrate
nitrate_15min <- nitrate$NSW_15_minute

View(nitrate$variables_20033)

# Define variables to keep in the final data table
keep_vars <- c("siteID", "horizontalPosition", "verticalPosition", 
               "startDateTime", "endDateTime", "surfWaterNitrateMean", 
               "surfWaterNitrateExpUncert", "finalQF")
nitrate_15min <- nitrate_15min[, keep_vars]

# Set measurements to NA if quality flag is 1
nitrate_15min[nitrate_15min$finalQF == 1, c("surfWaterNitrateMean", "surfWaterNitrateExpUncert")] <- NA

# Identify sensor location
nitrate_15min$HOR.VER <- with(nitrate_15min, paste(horizontalPosition, verticalPosition, sep = "."))


# Microbial cell counts
View(microbes$variables_20138)

microbe_abun <- microbes$amc_cellCounts

# Check whether rawAbundance accounts for sample dilution prior to analysis
with(microbe_abun, totalCellCount/numberOfFieldsAnalyzed*43209.88/analysisVolume) # Formula from BATELLE_epifluorProtocol_V6
microbe_abun$rawMicrobialAbundance
# It does not because these numbers match
# This means the rawMicrobialAbundance values are in cells/ml of the sample that was analyzed after dilution
# Need to multiply the abundance values by the dilution factor, then correct for preservant volume
# as described in NEON User Guide for Surface Water Microbial Cell Count (NEON.DPI.20138)

# Replace missing dilution factor values with 1
microbe_abun$dilutionFactor[is.na(microbe_abun$dilutionFactor)] <- 1

microbe_fieldsamples <- microbes$amc_fieldCellCounts[, c("cellCountSampleID", "cellCountSampleVolume", 
                                                         "cellCountPreservantVolume")]

# Merge data
microbe_abun <- left_join(microbe_abun, microbe_fieldsamples)

# Calculate microbial abundances by correcting for dilution and preservant volume
microbe_abun$cells_ml <- with(microbe_abun, (rawMicrobialAbundance*dilutionFactor)*((cellCountSampleVolume + cellCountPreservantVolume)/cellCountSampleVolume))

# Define variables to keep in the final data table
keep_vars <- c("cellCountSampleID", "siteID", "namedLocation", "collectDate", "cells_ml", "qaqcStatus", "sampleCondition", "remarks")
microbe_abun <- microbe_abun[, keep_vars]


## Save data tables
write.csv(watertemp_30min, 
          file.path("data/NEON_water", paste0(paste("watertemp_30min", aquasite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)
write.csv(waterqual_inst, 
          file.path("data/NEON_water", paste0(paste("waterqual_inst", aquasite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)
write.csv(nitrate_15min, 
          file.path("data/NEON_water", paste0(paste("nitrate_15min", aquasite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)
write.csv(microbe_abun, 
          file.path("data/NEON_water", paste0(paste("microbe_abun", aquasite, startdate, enddate, sep = "_"), ".csv")),
          row.names = FALSE)


## Read back in data tables
watertemp_30min <- read.csv( file.path("data/NEON_water", paste0(paste("watertemp_30min", aquasite, startdate, enddate, sep = "_"), ".csv")))
waterqual_inst <- read.csv(file.path("data/NEON_water", paste0(paste("waterqual_inst", aquasite, startdate, enddate, sep = "_"), ".csv")))
nitrate_15min <- read.csv(file.path("data/NEON_water", paste0(paste("nitrate_15min", aquasite, startdate, enddate, sep = "_"), ".csv")))


### Create an aggregated data frame from the downstream sensor HOR.VER = 102.1
### with water temperature, nitrate, water quality averaged every 30 mins

temp <- watertemp_30min |> 
  filter(horizontalPosition == 102, finalQF == 0) |>
  select(siteID, startDateTime, endDateTime, surfWaterTempMean) |>
  mutate(startDateTime = ymd_hms(startDateTime),
         endDateTime = ymd_hms(endDateTime),
         sampleInterval = interval(startDateTime, endDateTime))

# Define 30 min time intervals within the date range sampled
n_30minutes <- interval(temp$startDateTime[1], temp$endDateTime[nrow(temp)])/dminutes(30)

ints_30min <- interval(temp$startDateTime[1] + minutes(seq(0, (30*(n_30minutes-1)), 30)),
                       temp$startDateTime[1] + minutes(seq(30, (30*n_30minutes), 30)))

# Determine which 30 min time period corresponds to each temperature sample
temp$whichInt <- sapply(temp$sampleInterval, function(x){
  max(which(int_start(x) %within% ints_30min))
})

any(is.na(temp$whichInt))

# Subset the nitrate data to only the samples at the sensor 2
nitrate <- nitrate_15min |>
  filter(horizontalPosition == 102, finalQF == 0) |>
  mutate(startDateTime = ymd_hms(startDateTime),
         endDateTime = ymd_hms(endDateTime),
         sampleInterval = interval(startDateTime, endDateTime))


# Determine which of the 30 min time interval samples each nitrate sample occurs within
nitrate$whichInt <- sapply(nitrate$sampleInterval, function(x){
  max(which(int_start(x) %within% ints_30min))
})

any(is.na(nitrate$whichInt))

# Calculate average within each 30 time interval
nitrate_mean <- nitrate |>
  group_by(whichInt) |>
  summarize(surfWaterNitrate.mean = mean(surfWaterNitrateMean, na.rm = TRUE))

# Subset the water quality data to only samples at sensor 2
waterqual <- waterqual_inst |>
  filter(horizontalPosition == 102) |>
  mutate(startDateTime = ymd_hms(startDateTime),
         endDateTime = ymd_hms(endDateTime),
         sampleInterval = interval(startDateTime, endDateTime))

# Determine which of the 30 min time interval samples each water quality sample occurs within
waterqual$whichInt <- sapply(waterqual$sampleInterval, function(x){
  max(which(int_start(x) %within% ints_30min))
})

any(is.na(waterqual$whichInt))

# Calculate average within each 30 time interval
waterqual_mean <- waterqual |>
  group_by(whichInt) |>
  summarize(specificConductance.mean = mean(specificConductance, na.rm = TRUE),
            dissolvedOxygen.mean = mean(dissolvedOxygen, na.rm = TRUE),
            pH.mean = mean(pH, na.rm = TRUE),
            chlorophyll.mean = mean(chlorophyll, na.rm = TRUE),
            turbidity.mean = mean(turbidity, na.rm = TRUE),
            fDOM.mean = mean(fDOM, na.rm = TRUE))

## Combine all data together
# Create data frame with time intervals
surfwater_30min <- data.frame(whichInt = 1:length(ints_30min), sampleInterval = ints_30min, siteID = "TECR")

# Add on temperature data with only the necessary columns. Standardize variables names to match other data
surfwater_30min <- temp |>
  transmute(whichInt,
            surfWaterTemp.mean = surfWaterTempMean) |>
  right_join(surfwater_30min)

# Add on nitrate and water quality data
surfwater_30min <- surfwater_30min |>
  left_join(nitrate_mean) |>
  left_join(waterqual_mean)

# Order by date
surfwater_30min <- surfwater_30min |> arrange(whichInt)

# Reorder columns and convert time interval to start and end time points
surfwater_30min <- surfwater_30min |>
  mutate(startDateTime = as.character(int_start(sampleInterval)),
         endDateTime = as.character(int_end(sampleInterval))) |>
  select(siteID, startDateTime, endDateTime, contains(".mean"))




# Save
write.csv(surfwater_30min,
          file.path("data/NEON_water", paste0(paste("surfwater_30min_avg", aquasite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)

            



##############################################
### This section creates RData files that 
### are pre-loaded into chapters

library(neonUtilities)


## Vectorization and functions

# Define dates for download
startdate <- "2022-09-01"
enddate <- "2023-08-31"

# Define the sites to download 
sites <- c("TECR", "SYCA") # Teakettle Creek and Sycamore Creek

# Define the data product
dpID <- "DP1.20053.001"  # Surface water temperature

# Define dates for download
startdate <- "2022-09-01"
enddate <- "2023-08-31"

# Define the sites to download 
sites <- c("TECR", "SYCA") # Teakettle Creek and Sycamore Creek

# Define the data product
dpID <- "DP1.20053.001"  # Surface water temperature

# Define the directory in which to save the data
# the file path is relative to the working directory
savepath <- "data"

# Download data specified by the arguments above
zipsByProduct(dpID = dpID,
              site = sites,
              startdate = startdate,
              enddate = enddate,
              savepath = savepath,
              include.provisional = TRUE,
              token = NEON_token)

# Unzips data and stacks data tables by site
# Saves resulting tables into the savepath directory
stackByTable(filepath = file.path(savepath, "filesToStack20053"))

# Define the location of the data file
data_filename <- "TSW_30min.csv"
data_filepath <- file.path(savepath, "filesToStack20053", "stackedFiles", data_filename)

# Define the location of the metadata file that contains variable names
var_filename <- "variables_20053.csv"
var_filepath <- file.path(savepath, "filesToStack20053", "stackedFiles", var_filename)

# Read in surface water temperature averaged over 30 min periods
TSW_30min <- readTableNEON(dataFile = data_filepath,
                           varFile = var_filepath)
save(TSW_30min, file = "src/chp-functions_watertemp.RData")


## Tidyverse basics

# Define dates for download: June 1 - Oct 31, 2021
# but we need to start before June 1 to get the entire month of June
startdate <- "2021-05-31"
enddate <- "2021-10-31"

# Define the sites to download 
# TECR = Teakettle Creek,  MART = Martha Creek, CARI = Caribou Creek
sites <- c("TECR", "MART", "CARI") 


# Define the directory in which to save the data
# the file path is relative to the working directory
savepath <- "data"

# Download macroinvertebrate data
zipsByProduct(dpID = "DP1.20120.001",
              site = sites,
              startdate = startdate,
              enddate = enddate,
              savepath = savepath,
              include.provisional = TRUE,
              token = NEON_token)

# Download surface water temperature data
zipsByProduct(dpID = "DP1.20053.001",
              site = sites,
              startdate = startdate,
              enddate = enddate,
              savepath = savepath,
              include.provisional = TRUE,
              token = NEON_token)


# Unzips data and stacks data tables by site
# Saves resulting tables into the savepath directory
stackByTable(filepath = file.path(savepath, "filesToStack20053"))
stackByTable(filepath = file.path(savepath, "filesToStack20120"))


# 
# # Unzips surface water temperature data and stacks data tables
# # from a particular date range
# stackFromStore(filepaths = file.path(savepath, "filesToStack20053"),
#                dpID = "DP1.20053.001",
#                site = sites,
#                startdate = substr(startdate, 1, 7),
#                enddate = substr(enddate, 1, 7))
               


# Read in surface water temperature averaged over 30 min periods
TSW_30min <- readTableNEON(
  dataFile = file.path(savepath, "filesToStack20053", "stackedFiles", "TSW_30min.csv"),
  varFile = file.path(savepath, "filesToStack20053", "stackedFiles", "variables_20053.csv")
)

# Read in macroinvertebrate abundance data from data product 20120
inv_fieldData <- readTableNEON(
  dataFile = file.path(savepath, "filesToStack20120", "stackedFiles", "inv_fieldData.csv"),
  varFile = file.path(savepath, "filesToStack20120", "stackedFiles", "variables_20120.csv")
)

# Read in  macroinvertebrate taxonomy data from data product 20120
inv_fieldData <- readTableNEON(
  dataFile = file.path(savepath, "filesToStack20120", "stackedFiles", "inv_taxonomyProcessed.csv"),
  varFile = file.path(savepath, "filesToStack20120", "stackedFiles", "variables_20120.csv")
)


save(TSW_30min, inv_fieldData, inv_taxa, file = "src/chp-tidyverse_datasets.RData")

# Remove download
unlink(file.path(savepath, "filesToStack20053"), recursive = TRUE, force = TRUE)
unlink(file.path(savepath, "filesToStack20120"), recursive = TRUE, force = TRUE)



## Example analysis

# Define dates for download: Jan 1 - Dec 31, 2024
# but we need to start before Jan 1 to get the entire month of January
startdate <- "2023-12-31"
enddate <- "2024-12-31"

# Define the sites to download 
# TECR = Teakettle Creek,  MART = Martha Creek, CARI = Caribou Creek
sites <- c("TECR", "CARI", "MART") 


# Define the directory in which to save the data
# the file path is relative to the working directory
savepath <- "data"

# Download macroinvertebrate data
zipsByProduct(dpID = "DP1.20120.001",
              site = sites,
              startdate = startdate,
              enddate = enddate,
              savepath = savepath,
              include.provisional = TRUE,
              token = NEON_token)

# Download surface water temperature data
zipsByProduct(dpID = "DP1.20053.001",
              site = sites,
              startdate = startdate,
              enddate = enddate,
              savepath = savepath,
              include.provisional = TRUE,
              token = NEON_token)

# Unzips data and stacks data tables by site
# This will stack all data within each data product folder.
stackByTable(filepath = file.path(savepath, "filesToStack20120"))
stackByTable(filepath = file.path(savepath, "filesToStack20053"))

# Read in macroinvertebrate abundance data from data product 20120
inv_fieldData <- readTableNEON(
  dataFile = "data/filesToStack20120/stackedFiles/inv_fieldData.csv",
  varFile = "data/filesToStack20120/stackedFiles/variables_20120.csv"
)

# Read in macroinvertebrate taxonomy data from data product 20120
inv_taxa <- readTableNEON(
  dataFile = "data/filesToStack20120/stackedFiles/inv_taxonomyProcessed.csv",
  varFile = "data/filesToStack20120/stackedFiles/variables_20120.csv"
)

# Read in 30-min avg surface water temperature data from data product 20053
TSW_30min <- readTableNEON(
  dataFile = "data/filesToStack20053/stackedFiles/TSW_30min.csv",
  varFile = "data/filesToStack20053/stackedFiles/variables_20053.csv"
)

save(inv_fieldData, inv_taxa, TSW_30min, file = "src/chp-example_analysis.RData")

# Remove download
unlink(file.path(savepath, "filesToStack20053"), recursive = TRUE, force = TRUE)
unlink(file.path(savepath, "filesToStack20120"), recursive = TRUE, force = TRUE)


