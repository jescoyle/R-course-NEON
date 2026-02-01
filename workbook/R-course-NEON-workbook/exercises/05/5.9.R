## Exercise 5.9

# Load the lubridate package
library(lubridate)

# Load the NEON surface water data from TEAK site
surfwater <- read.csv("data/NEON_water/surfwater_30min_avg_TECR_2021-04_2021-10.csv")

# Load the microbial cell count data from Teakettle Creek in 2021
microbes <- read.csv("data/NEON_Water/microbe_abun_TECR_2021-04_2021-10.csv")


# View the time points when data were collected
microbes$collectDate

# Convert collectDate to a date-time
microbes$collectDate <- ymd_hms(microbes$collectDate)

# Convert startDateTime and endDateTime to a date-time class
surfwater$startDateTime <- ymd_hms(surfwater$startDateTime)
surfwater$endDateTime <- ymd_hms(surfwater$endDateTime)

# Define a new column in surfwater that records the time interval 
# for each measurement
surfwater$timeInterval <- interval(start = surfwater$startDateTime,
                                   end = surfwater$endDateTime)


# A function that determines which of the time intervals in
# vector ints contain the time point x.
# Arguments:
#   x = a point in time of class POSIXct
#   ints  = a vector of time intervals of class Interval (lubridate package)
match_timeInterval <- function(x, ints){

  # Return the indices of intervals in ints that contain x
  which(_______ %within% ________)
  
}

# Find the row of surfwater that matches the first row of microbes
match_timeInterval(microbes$collectDate[1], surfwater$timeInterval)

# If you completed the function correctly you should get row 1666.

# Vectorize match_timeInterval over x
Vmatch_timeInterval <- ______________________________

# Use the vectorized function to find the rows of surfwater that match each row of microbes
use_rows <- Vmatch_timeInterval(microbes$____________, surfwater$____________)

# Use use_rows to select the correct rows of surfwater
# and bind the columns of surfwater to matching rows of microbes
microbe_wq_data <- cbind(microbes, surfwater[________________])


# If the code above was completed correctly, then the code below
# will generate a plot showing microbe cell count versus surface water temperature.
# It will have five data points- one for each row of microbe_wq_data
plot(cells_ml ~ surfWaterTemp.mean, 
     data = microbe_wq_data)



