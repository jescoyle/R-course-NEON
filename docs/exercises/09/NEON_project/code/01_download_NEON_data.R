## Download NEON Data
## Author: Jes Coyle
## Date: 2023-11-29
## Description: This script downloads NEON data for an analysis of analysis 
## of macroinvertebrate diversity and water temperature at three NEON aquatic sites: 
## Caribou Creek, Alaska (CARI), Martha Creek, Washington (MART), and Teakettle Creek, California (TECR).
## It also downloads data products for macroinvertebrate samples (DP1.20120.001)
## and surface water temperature (DP1.20053.001) from June - October 2021.
## Resulting data tables are saved in the data folder of this project.

# Load packages
library(neonUtilities)

# Define dates for download: June 1 - Oct 31, 2021
# but we need to start before June 1 to get the entire month of June
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

# Extract invertebrate collections
# and save as a separate data frame
inv_fieldData <- inverts_list$inv_fieldData

# Extract taxonomic information
# and save as a separate data frame
inv_taxa <- inverts_list$inv_taxonomyProcessed


# Temperature in surface water
watertemp_list <- loadByProduct(dpID = "DP1.20053.001",
                                site = sites,
                                startdate = startdate,
                                enddate = enddate)

# Extract 30 min temperature averages 
# and save as a separate data frame
TSW_30min <- watertemp_list$TSW_30min


# Save data tables to csv files for use in analysis
write.csv(inv_fieldData, file = "data/inv_fieldData.csv", row.names = FALSE)
write.csv(inv_taxa, file = "data/inv_taxa.csv", row.names = FALSE)
write.csv(TSW_30min, file = "data/TSW_30min.csv", row.names = FALSE)

