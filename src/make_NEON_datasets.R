# This script downloads data sets from NEON and saves them in the format used by this text.

# Check if NEONUtilities are installed and load
neonUtilities_isavailable <- require("neonUtilities")
if(!neonUtilities_isavailable){
  install.packages("neonUtilities")
  library("neonUtilities")
}

# Define dates for download
startdate <- "2022-01"
enddate <- "2022-06"
aquasite <- "TECR" # Teakettle Creek, Sierra Nevada, CA 
terrsite <- "TEAK"

## Soil CO2 exchange and temperature: unccoment to redownload
#soilCO2 <- loadByProduct(dpID = "DP1.00095.001",
#                         site = terrsite,
#                         startdate = startdate,
#                         enddate = enddate)

soilCO2_30min <- soilCO2$SCO2C_30_minute

View(soilCO2$variables_00095)
View(soilCO2$sensor_positions_00095)

# Define variables to keep in the final data table
keep_vars <- c("siteID", "horizontalPosition", "verticalPosition", 
                "startDateTime", "endDateTime", "soilCO2concentrationMean", 
               "soilCO2concentrationExpUncert", "finalQF")
soilCO2_30min <- soilCO2_30min[, keep_vars]

# Set measurements to NA if quality flag is 1
soilCO2_30min[soilCO2_30min$finalQF == 1, c("soilCO2concentrationMean", "soilCO2concentrationExpUncert")] <- NA

# Merge with sensor location
soilCO2_30min$HOR.VER <- with(soilCO2_30min, paste(horizontalPosition, verticalPosition, sep = "."))
soilCO2_30min <- merge(soilCO2_30min, soilCO2$sensor_positions_00095[, c("HOR.VER", "xOffset", "yOffset", "zOffset")])

# Download soil temperature: uncomment to redownload
#soiltemp <- loadByProduct(dpID = "DP1.00041.001",
#                          site = terrsite,
#                          startdate = startdate,
#                          enddate = enddate)
#
soiltemp_30min <- soiltemp$ST_30_minute
View(soiltemp$variables_00041)

# Define variables to keep in the final data table
keep_vars <- c("siteID", "horizontalPosition", "verticalPosition", 
               "startDateTime", "endDateTime", "soilTempMean", 
               "soilTempExpUncert", "finalQF")
soiltemp_30min <- soiltemp_30min[, keep_vars]

# Set measurements to NA if quality flag is 1
soiltemp_30min[soiltemp_30min$finalQF == 1, c("soilTempMean", "soilTempExpUncert")] <- NA

# Merge with sensor location
soiltemp_30min$HOR.VER <- with(soiltemp_30min, paste(horizontalPosition, verticalPosition, sep = "."))
soiltemp_30min <- merge(soiltemp_30min, soiltemp$sensor_positions_00041[, c("HOR.VER", "xOffset", "yOffset", "zOffset")])


# Make data set for Intro to R lesson
soilCO2_30min$finalQF.CO2 <- soilCO2_30min$finalQF
soiltemp_30min$finalQF.temp <- soiltemp_30min$finalQF
drop_vars <- c("xOffset", "yOffset", "zOffset", "finalQF") # position variables and quality flag differ by sensor type so remove before merge
intro_to_R.dat <- merge(soilCO2_30min[, !(colnames(soilCO2_30min) %in% drop_vars)],
                        soiltemp_30min[, !(colnames(soilCO2_30min) %in% drop_vars)])

# Quick plot to decide which plot to focus on
library(ggplot2)
library(dplyr)

intro_to_R.dat %>%
  ggplot(aes(y = soilTempMean, x = startDateTime, color = verticalPosition)) +
  geom_line() +
  facet_wrap(~ horizontalPosition)

intro_to_R.dat %>%
  ggplot(aes(y = soilCO2concentrationMean, x = startDateTime, color = verticalPosition)) +
  geom_line() +
  facet_wrap(~ horizontalPosition)

intro_to_R.dat %>%
  ggplot(aes(y = soilCO2concentrationMean, x = soilTempMean, color = verticalPosition)) +
  geom_point() +
  facet_wrap(~ horizontalPosition)

# Decided to focus on plot 003
intro_to_R.dat <- intro_to_R.dat[intro_to_R.dat$horizontalPosition == "003", ]

View(intro_to_R.dat)

# Save data sets
write.csv(soilCO2_30min, 
          file.path("data/NEON_soils", paste0(paste("soilCO2_30min", terrsite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)
write.csv(soiltemp_30min, 
          file.path("data/NEON_soils", paste0(paste("soiltemp_30min", terrsite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)
write.csv(intro_to_R.dat, "data/intro-to-R_dat.csv", 
          row.names = FALSE)

### NOT USING THE FOLLOWING YET ###
## Surface water variables from Teakettle Creek, NEON





# Access files from NEON API, merge data and read into R
# Must answer "y" to proceed for each download 

# Nitrate
nitrate <- loadByProduct(dpID = "DP1.20033.001",
              site = aquasite,
              startdate = startdate,
              enddate = enddate)

# Photosynthetically active radiation
PAR <- loadByProduct(dpID = "DP1.20042.001",
                         site = aquasite,
                         startdate = startdate,
                         enddate = enddate)

# Temperature in surface water
watertemp <- loadByProduct(dpID = "DP1.20053.001",
                           site = aquasite,
                           startdate = startdate,
                           enddate = enddate)

# Water quality, including conductivity, chl a, oxygen, dom, pH, turbidity
waterqual <- loadByProduct(dpID = "DP1.20288.001",
                           site = aquasite,
                           startdate = startdate,
                           enddate = enddate)


# 
