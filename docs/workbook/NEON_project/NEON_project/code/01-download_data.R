## Example analysis of NEON Data
## Step 1: download data
## Author: Jes Coyle, jrc16@stmarys-ca.edu
## Date: 2026-04-30
## Description: This code downloads and stacks NEON data used 
##              this analysis. It should only be run once.

# Load required packages
library(neonUtilities)

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
              token = "")

# select y after verifying the data is not too large

# Download surface water temperature data
zipsByProduct(dpID = "DP1.20053.001",
              site = sites,
              startdate = startdate,
              enddate = enddate,
              savepath = savepath,
              include.provisional = TRUE, 
              token = "")

# select y after verifying the data is not too large

# Unzips data and stacks data tables by site
# This will stack all data within each data product folder.
stackByTable(filepath = file.path(savepath, "filesToStack20120"))
stackByTable(filepath = file.path(savepath, "filesToStack20053"))




