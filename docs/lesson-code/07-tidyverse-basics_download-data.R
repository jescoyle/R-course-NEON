## Code from the Data manipulation in the tidyverse chapter
## Author: YOUR NAME HERE
## Date: TODAYS DATE
## Description: This code downloads and stacks NEON data used in this lesson.
##              It should only be run once.


library(neonUtilities)

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
              include.provisional = TRUE)

# Download surface water temperature data
zipsByProduct(dpID = "DP1.20053.001",
              site = sites,
              startdate = startdate,
              enddate = enddate,
              savepath = savepath,
              include.provisional = TRUE)

# Unzips data and stacks data tables by site
# This will stack all data within each data product folder
# Saves resulting tables into the savepath directory
stackByTable(filepath = file.path(savepath, "filesToStack20053"))
stackByTable(filepath = file.path(savepath, "filesToStack20120"))
