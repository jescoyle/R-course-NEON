## Code from the Intro to R Synthesis Chapter
## Author: YOUR NAME HERE
## Date: TODAYS DATE
## Description: This code loads and explores water temperature data from the Teakettle Lake 
##              NEON site in April 2021


## The comments in this code match the Synthesis lesson
## Your job is to fill in the blanks to complete the code.

# Load the lubridate package
# The package must be installed for this to work.
library(lubridate)

# Read in a data table with water temperature
watertemp <- read.csv("                  ")


# Display the first 10 elements in the startDateTime column
watertemp$startDateTime[              ]


# Convert the text to a date and time
# This replaces the existing startDateTime column
# ymd_hms() comes from the lubridate package
watertemp$startDateTime <- ymd_hms(watertemp$          )


# View the date component of each value (but only from rows 1 - 10)
date(           )[1:10]

# What was the most recent (i.e. highest) date that data were recorded in this data set?
max(                  )


# What was the earliest (i.e. lowest) date that data were recorded in this data set?
min(                  )

# Plot the mean temperature over time
plot(x = watertemp$           , y = watertemp$               )

# Plot the mean temperature over time (a different syntax)
plot(             ~              , data = watertemp)


# Calculate the upper and lower bounds on temperature using the
# mean and expected uncertainty columns in the watertemp data frame
temp_upperbound <- with(           , surfWaterTempMean + surfWaterTempExpUncert)
temp_lowerbound <- with(           , surfWaterTempMean - surfWaterTempExpUncert)

# Print the first 10 values of each of these vectors
temp_upperbound[      ]
temp_lowerbound[      ]

