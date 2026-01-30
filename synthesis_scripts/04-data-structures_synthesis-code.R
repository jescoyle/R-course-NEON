## Code from the Data Structures Synthesis Chapter
## Author: YOUR NAME HERE
## Date: TODAYS DATE
## Description: This code loads and explores water temperature 
##              and microbial abundance data from the Teakettle Lake 
##              NEON site in April 2021

# Load the NEON surface water data from TEAK site
surfwater <- read.csv("data/NEON_water/surfwater_30min_avg_TECR_2021-04_2021-10.csv")

# Load the microbial cell count data from Teakettle Creek in 2021
microbes <- read.csv("data/NEON_Water/microbe_abun_TECR_2021-04_2021-10.csv")

# View the structure of these data
str(microbes)

# View the time points when data were collected
microbes$collectDate

# Count the number of rows that begin on a certain hour
table(hour(surfwater$startDateTime))

# Count the number of rows that begin on a certain minute of the hour
table(minute(surfwater$startDateTime))

# Count the number of rows that begin on a certain second of the hour
table(second(surfwater$startDateTime))

# Define a set of startDateTimes that match the five collection
# dates in microbes
these_dates <- c("2021-05-05 16:30:00",
                 "2021-06-01 18:30:00",
                 "2021-07-14 16:00:00",
                 "2021-08-03 17:00:00",
                 "2021-09-01 17:00:00")

# Convert to a date-time class
these_dates <- ymd_hms(these_dates)

# Find the measurements in surf water that correspond 
# to these five time points:
# Subset surfwater to only rows whose startDateTime column
# matches one of the dates in these_dates
microbe_wq_data <- subset(surfwater, startDateTime %in% these_dates)

# View the start and end time points of each row in the 
# water quality data set
microbe_wq_data[, c("startDateTime", "endDateTime")]

# View the collection time and cell density of the microbial data
microbes[, c("collectDate", "cells_ml")]


# Combine microbes with water quality data from the
# same time points
microbes_wq <- cbind(microbes, microbe_wq_data)


# Graph microbial cell counts (y axis) vs. nitrate concentration (x axis)
# Specify axis labels with xlab and ylab arguments
with(microbes_wq,
     plot(x = surfWaterNitrate.mean,
          y = cells_ml,
          xlab = "Nitrate (umol per L)",
          ylab = "Microbial cell density (num. per ml)")
)


# Convert collectDate to a date-time
microbes$collectDate <- ymd_hms(microbes$collectDate)

# Convert endDateTime to a date-time class
surfwater$endDateTime <- ymd_hms(surfwater$endDateTime)

# Define a new column in surfwater that records the time interval 
# for each measurement
surfwater$timeInterval <- interval(start = surfwater$startDateTime,
                                   end = surfwater$endDateTime)


# Define the time point that we are interested in
# and print the value of this_time
this_time <- microbes[1, "collectDate"]
this_time

# Subset to rows whose time interval contains this_time
subset(surfwater, this_time %within% timeInterval)



