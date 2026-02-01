## Code from the Vectorization and Functions Synthesis Chapter
## Author: YOUR NAME HERE
## Date: TODAYS DATE
## Description: This code downloads and explores water temperature 
##              and data from the Teakettle Creek and Sycamore Creek 
##              NEON site from Sept 2022 through Aug 2023.


# Install the neonUtilities package that contains
# functions for working with NEON data.
# (Only do this once)
install.packages("neonUtilities")

# Load the neonUtilities package
library(neonUtilities)

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
# HINT: Comment this out once you have run it once
#       so that you don't download data multiple times
zipsByProduct(dpID = dpID,
              site = sites,
              startdate = startdate,
              enddate = enddate,
              savepath = savepath,
              include.provisional = TRUE)

# Unzips data and stacks data tables by site
# Saves resulting tables into the savepath directory
# HINT: Comment this out once you have run it once
#       so that you don't stack the data tables multiple times
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

# Show the first few rows
head(TSW_30min)

# How many unique values of horizontal and vertical position are there?
table(TSW_30min$horizontalPosition)
table(TSW_30min$verticalPosition)

# Challenge: How many measurements were made at each site?



# YOUR JOB: Fill in the code below each function as you
#           follow along in the lesson.
# A function that calculates average monthly surface water temperature
# across both sensors at a NEON site from a dataframe of temperature
# measurements.
# Arguments:
#   dat = a dataframe containing the columns we need (TBD)
#   site = the NEON site code for the site of interest
#   month = the month to calculate average temperature over
#   na.rm = indicates whether NA values should be removed prior to calculation
calc_monthly_avg <- function(dat, site, month, na.rm) {
  
  # Remove data that did not pass quality control
  # keep finalQF == 0
  
  
  # Subset the data frame to only contain observations from site
  
  
  
  # Subset the data frame to only contain observations from month
  
  
  # Calculate the average of the surfWaterTempMean column
  
  
  
  # Return the calculated value
  
}


# Code for debugging the calc_monthly_avg function
test <- calc_monthly_avg(dat = TSW_30min, 
                         site = "TECR", 
                         month = 8, 
                         na.rm = TRUE
)

View(test)

# Count how many observations in the resulting test data
# come from each site
table(test$siteID)

# Count how many observations in the resulting test data
# have each quality flag value
table(test$finalQF)

# Challenge: Count how many observations in the resulting 
# test data come from each month
table(           ) 


# Define a new version of the function vectorized along month
calc_monthly_avg_byMonth <- Vectorize(calc_monthly_avg, "month")

# Calculate the mean monthly temperature for the TECR site
calc_monthly_avg_byMonth(dat = TSW_30min, 
                         site = "TECR", 
                         month = 1:12, 
                         na.rm = TRUE)

# Define a new data frame with just the data from TECR
dat_TECR <- subset(TSW_30min, siteID == "TECR")

# Add a column that identifies the month
dat_TECR$month <- lubridate::month(dat_TECR$startDateTime)

# For each month, count the number of values of surfWaterTempMean
# that were missing or not (is.na == TRUE means missing)
table(dat_TECR$month, is.na(dat_TECR$surfWaterTempMean))
