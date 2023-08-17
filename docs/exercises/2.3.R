# Adapt the code in exercise 2 so that you can determine whether 
# every observation in the `nitrate` data frame is based on a 
# 30-minute time period average.
# HINT: You will need to calculate the difference in time between 
#  the start and end dates.


library(lubridate)

nitrate <- read.csv("data/NEON_water/nitrate_15min_TECR_2021-04_2021-10.csv")

nitrate$startDateTime <- ymd_hms(nitrate$startDateTime)
nitrate$endDateTime <- ymd_hms(nitrate$endDateTime)

nitrate$day <- with(nitrate, date(startDateTime))

table(nitrate$day)
