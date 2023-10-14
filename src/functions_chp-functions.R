# A function that converts a vector of temperatures from
# fahrenheit to kelvin
fahr_to_kelvin <- function(temp) {
  # Calculate temp in kelvin
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  
  # Return the value of kelvin
  return(kelvin)
}

# A function that converts a vector of temperatures from
# kelvin to celsius
kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}

# A function that converts a vector of temperatures from
# fahrenheit to celsius
fahr_to_celsius <- function(temp) {
  
  temp_k <- fahr_to_kelvin(temp)
  temp_c <- kelvin_to_celsius(temp_k)
  
  return(temp_c)
}

# A function that returns the lower and upper uncertainty bounds
# around a given values as a 2-column matrix
# Arguments:
#   mu = a vector of values around which bounds should be calculated
#   sigma = a vector containing the amount of uncertainty (in the same units as mu)
calc_uncertainty <- function(mu, sigma = 0) {
  
  # Calculate the upper bound
  upper <- mu + sigma
  
  # Calculate the lower bound
  lower <- mu - sigma
  
  # Combine the bounds into a matrix
  bounds <- cbind(lower, upper)
  
  # Return the matrix
  return(bounds)
}


# A function that calculates average monthly surface water temperature
# across both sensors at a NEON site from a dataframe of temperature
# measurements.
# Arguments:
#   dat = a dataframe containing the columns: 
#         surfWaterTempMean, startDateTime, siteID, finalQF
#   site = the NEON site code for the site of interest
#   month = the month to calculate average temperature over
#   na.rm = indicates whether NA values should be removed prior to calculation
calc_monthly_avg <- function(dat, site, month, na.rm = TRUE) {
  
  # Remove data that did not pass quality control
  # keep finalQF == 0
  keep_dat <- subset(dat, finalQF == 0)
  
  # Subset the data frame to only contain observations from site
  keep_dat <- subset(keep_dat, siteID == site)
  
  # Subset the data frame to only contain observations from month
  # convert character to date
  keep_dat$startDateTime <- lubridate::ymd_hms(keep_dat$startDateTime) 
  
  # extract month as a numeric value
  keep_dat$startMonth <- lubridate::month(keep_dat$startDateTime)
  
  # subset based on month
  keep_dat <- subset(keep_dat, startMonth == month)
  
  # Calculate the average of the surfWaterTempMean column
  # use the na.rm value provided by the user of the function
  vals <- mean(keep_dat$surfWaterTempMean, na.rm = na.rm)
  
  # Return the calculated value
  return(vals)
}