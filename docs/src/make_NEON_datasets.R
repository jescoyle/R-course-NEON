# This script downloads data sets from NEON and saves them in the format used by this text.

# Check if NEONUtilities are installed and load
neonUtilities_isavailable <- require("neonUtilities")
if(!neonUtilities_isavailable){
  install.packages("neonUtilities")
  library("neonUtilities")
}

## NOT USING THE FOLLOWING YET ###
## Surface water and community data from Teakettle Creek, NEON

# Define dates for download: Defined based on when data are collected for the organismal samples
startdate <- "2021-04"
enddate <- "2021-10" # 
aquasite <- "TECR" # Teakettle Creek, Sierra Nevada, CA 


# Access files from NEON API, merge data and read into R
# Must answer "y" to proceed for each download 


# Microbial cell counts in surface water
microbe_abun <- loadByProduct(dpID = "DP1.20138.001",
                              site = aquasite,
                              startdate = startdate,
                              enddate = enddate)

# Periphyton, seston and phytoplankton collection # provisional as of 7/2023, May, Aug, Sept 2021
plankton <- loadByProduct(dpID = "DP1.20166.001",
                          site = aquasite,
                          startdate = startdate,
                          enddate = enddate)

# Macroinvertebrate collection: May, July, Sept 2021
inverts <- loadByProduct(dpID = "DP1.20120.001",
                         site = aquasite,
                         startdate = startdate,
                         enddate = enddate)



# Nitrate in surface water
nitrate <- loadByProduct(dpID = "DP1.20033.001",
              site = aquasite,
              startdate = startdate,
              enddate = enddate)

# Photosynthetically active radiation
# PAR <- loadByProduct(dpID = "DP1.20042.001",
#                          site = aquasite,
#                          startdate = startdate,
#                          enddate = enddate)

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

# Water sensor locations
sensor_locs <- waterqual$sensor_positions_20288

## Surface water temperature
watertemp_30min <- watertemp$TSW_30min

View(watertemp$variables_20053)

# Define variables to keep in the final data table
keep_vars <- c("siteID", "horizontalPosition", "verticalPosition", 
               "startDateTime", "endDateTime", "surfWaterTempMean", 
               "surfWaterTempExpUncert", "finalQF")
watertemp_30min <- watertemp_30min[, keep_vars]

# Set measurements to NA if quality flag is 1
watertemp_30min[watertemp_30min$finalQF == 1, c("surfWaterTempMean", "surfWaterTempExpUncert")] <- NA

# Identify sensor location
watertemp_30min$HOR.VER <- with(watertemp_30min, paste(horizontalPosition, verticalPosition, sep = "."))


## Water quality
waterqual_inst <- waterqual$waq_instantaneous

View(watertemp$variables_20053)

# Define variables to keep in the final data table
waterqual_vars <- c("specificConductance", "dissolvedOxygen", "pH", "chlorophyll", "turbidity", "fDOM")
keep_vars <- c("siteID", "horizontalPosition", "verticalPosition", 
               "startDateTime", "endDateTime", 
               "specificConductance", "specificConductanceExpUncert", "specificCondFinalQF",
               "dissolvedOxygen", "dissolvedOxygenExpUncert", "dissolvedOxygenFinalQF",
               "pH", "pHExpUncert", "pHFinalQF",
               "chlorophyll", "chlorophyllExpUncert", "chlorophyllFinalQF",
               "turbidity", "turbidityExpUncert", "turbidityFinalQF",
               "fDOM", "fDOMExpUncert", "fDOMFinalQF")


waterqual_inst <- waterqual_inst[, keep_vars]

# Identify sensor location
waterqual_inst$HOR.VER <- with(waterqual_inst, paste(horizontalPosition, verticalPosition, sep = "."))


## Nitrate
nitrate_15min <- nitrate$NSW_15_minute

View(nitrate$variables_20033)

# Define variables to keep in the final data table
keep_vars <- c("siteID", "horizontalPosition", "verticalPosition", 
               "startDateTime", "endDateTime", "surfWaterNitrateMean", 
               "surfWaterNitrateExpUncert", "finalQF")
nitrate_15min <- nitrate_15min[, keep_vars]

# Set measurements to NA if quality flag is 1
nitrate_15min[nitrate_15min$finalQF == 1, c("surfWaterNitrateMean", "surfWaterNitrateExpUncert")] <- NA

# Identify sensor location
nitrate_15min$HOR.VER <- with(nitrate_15min, paste(horizontalPosition, verticalPosition, sep = "."))


## Save data tables
write.csv(watertemp_30min, 
          file.path("data/NEON_water", paste0(paste("watertemp_30min", aquasite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)
write.csv(waterqual_inst, 
          file.path("data/NEON_water", paste0(paste("waterqual_inst", aquasite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)
write.csv(nitrate_15min, 
          file.path("data/NEON_water", paste0(paste("nitrate_15min", aquasite, startdate, enddate, sep = "_"), ".csv")), 
          row.names = FALSE)





####### Soil temp and CO2 data #########
## NOT USING RIGHT NOW

# Define dates for download
startdate <- "2022-01"
enddate <- "2022-06" 
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
# write.csv(intro_to_R.dat, "data/intro-to-R_dat.csv", 
#           row.names = FALSE) # decided to use the stream data instead
