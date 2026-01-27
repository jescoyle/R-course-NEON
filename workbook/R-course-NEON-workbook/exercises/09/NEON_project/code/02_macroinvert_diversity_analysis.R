## Macroinvertebrate diversity analysis
## Author: Jes Coyle
## Date: 2023-11-29
## Description: This script analyzes how macroinvertebrate diversity 
## is related to water temperature at three NEON aquatic sites during the summer of 2021: 
## Caribou Creek, Alaska (CARI), Martha Creek, Washington (MART), and Teakettle Creek, California (TECR).
## Resulting figures are saved in the output folder of this project.


# Load packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)

# Load data tables:

# Info about invertebrate samples
inv_fieldData <- read.csv("data/inv_fieldData.csv")

# Info about the species found in each sample
inv_taxa <- read.csv("data/inv_taxa.csv")

# Sensor data for temperature- 30min averages
TSW_30min <- read.csv("data/TSW_30min.csv")


## GOAL: Plot total macroinvertebrate abundance vs. avg temperature for each sample.


# Use the inv_taxa table to count the number of unique
# taxa and their total abundance in each sample

inverts_bysample<- inv_taxa %>% 
  group_by(siteID, sampleID) %>%
  summarize(num_taxa = length(unique(scientificName)),
            num_ind = sum(estimatedTotalCount))

# Select the columns needed with info about the samples collected:
# elevation, collectDate, habitatType, benthicArea
sample_info <- inv_fieldData %>%
  select(sampleID, elevation, collectDate, habitatType, benthicArea)


# Join the the inverts summary table with
# info on the sampling effort and locations
inverts_bysample <- left_join(inverts_bysample, sample_info, by = "sampleID")

# Calculate invertebrate density as: tot. individuals / area sampled (m^2)
inverts_bysample <- inverts_bysample %>%
  mutate(invert_density_m2 = num_ind / benthicArea)

# Convert collectDate to a date-time class and extract the date
# as a separate column
inverts_bysample <- inverts_bysample %>%
  mutate(collectDate = ymd_hms(collectDate),
         day = date(collectDate))


# Calculate average daily surface water temperature:

# Remove bad measurements, then convert startDateTime to a date-time class
# and extract the date to a new column
TSW_30min_good <- TSW_30min %>%
  filter(finalQF == 0) %>%
  mutate(startDateTime = ymd_hms(startDateTime),
         day = date(startDateTime)) 


# Summarize daily temperature measurements from both sensors together
daily_temp <- TSW_30min_good %>%
  group_by(siteID, day) %>%
  summarize(temp_daily_avg = mean(surfWaterTempMean),
           temp_daily_min = min(surfWaterTempMinimum),
           temp_daily_max = max(surfWaterTempMaximum))


# Join inverts_bysample with daily_temp so that
# Each sample is matched with the daily temperature
# measurements on the day the sample was collected
inverts_bysample <- left_join(inverts_bysample, daily_temp,
                              by = c("siteID", "day"))




# Calculate average temperature for 30 day time interval 
# before each invertebrate sampling event

# Define a vector of time intervals- one for each sample
inverts_bysample$interval_30day <- interval(end = inverts_bysample$day,
                                            start = inverts_bysample$day - ddays(30))


## Calculate average temperature from 30 days prior 
## to each sampling event:

# Define a vector to hold the average temperatures
# There will be one for each row in inverts_bysample
N <- nrow(inverts_bysample)
avg_temp <- rep(NA, N) 

# Loop through each row in inverts_bysite
for(i in 1:N){
  
  # Define the time interval and site for this row
  this_interval <- inverts_bysample$interval_30day[i]
  this_site <- inverts_bysample$siteID[i]
  
  # Get all rows from TWS_avg within the time interval for this row
  use_temps <- filter(TSW_30min_good, 
                      startDateTime %within% this_interval,
                      siteID == this_site)
  
  # Calculate the average temperature and save it in avg_temp
  # remove any missing values
  avg_temp[i] <- mean(use_temps$surfWaterTempMean, na.rm = TRUE)
}

# Add avg_temp as a new column in inverts_bysite
inverts_bysample$temp_avg_30day <- avg_temp


# Save summary data table
write.csv(inverts_bysample, file = "data/inverts_bysample.csv", row.names = FALSE)

# Define theme for graphs so they look similar
# THIS WAS NOT COVERED IN THE LESSONS
# BUT YOU MAY WANT TO USE IT TO MODIFY YOUR FIGURES
my_theme <-   theme_bw(base_size = 18, base_line_size = 1.5) + 
  theme(text = element_text(color = "black"),
        title = element_text(color = "black"),
        plot.title = element_text(size = rel(1)),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        strip.background = element_rect(fill = NA, color = NA),
        strip.text = element_text(color = "black", size = rel(1)),
        panel.border = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(color = "black"),
        axis.text = element_text(color = "black", size = rel(1)))

# Figure 1. Invertebrate density in each sample vs. avg daily temperature

inverts_bysample %>%
  ggplot(aes(x = temp_daily_avg, y = invert_density_m2, color = siteID)) +
  geom_point(size = 3) + 
  labs(x = expression("Avg. daily temperature"~(degree*C)),
       y = expression("Macroinvertebrate density"~(per~m^2)),
       color = "Site") +
  my_theme

ggsave("output/Fig1_sample_density_vs_daily_temp.png", height = 6, width = 8, units = "in")

# Figure 2. Invertebrate diversity in each sample vs. 30-day average temperature

inverts_bysample %>%
  ggplot(aes(x = temp_avg_30day, y = num_taxa, color = siteID)) +
  geom_point(size = 3) + 
  labs(x = expression("Avg. 30-day temperature"~(degree*C)),
       y = "Macroinvertebrate species richness",
       color = "Site") +
  my_theme

ggsave("output/Fig2_sample_richness_vs_30day_temp.png", height = 6, width = 8, units = "in")

# Figure 3. Average macroinvertebrate density at each site and habitatType

inverts_bysample %>%
  ggplot(aes(x = siteID, y = invert_density_m2, fill = habitatType)) +
  geom_bar(stat = "summary", fun = mean, position = "dodge") + 
  labs(x = "",
       y = expression("Macroinvertebrate density"~(per~m^2)),
       fill = "Habitat type") +
  my_theme

ggsave("output/Fig3_avg_density_by_habitat_site.png", height = 6, width = 8, units = "in")




## GOAL: Plot average macroinvertebrate abundance vs. temperature for plot over different dates

# Summarize samples by day and siteID
# Calculate average invertbrate density across all samples,
# temperatures, number of samples and fraction of samples
# that came from riffles
inverts_bysite <- inverts_bysample %>%
  group_by(siteID, day) %>%
  summarize(invert_density_m2 = mean(invert_density_m2),
            temp_avg_30day = mean(temp_avg_30day),
            temp_daily_avg = mean(temp_daily_avg),
            temp_daily_min = mean(temp_daily_min),
            n_samples = n(),
            frac_riffle = sum(habitatType == "riffle") / n_samples)

# Figure 4. Average macroinvertebrate density vs. daily minimum temperature
inverts_bysite %>%
  ggplot(aes(x = temp_daily_min, y = invert_density_m2, color = siteID)) +
   geom_point(size = 3) + 
   labs(x = expression("Minimum daily temperature"~(degree*C)),
        y = expression("Macroinvertebrate density"~(per~m^2)),
        color = "Site") +
   my_theme

ggsave("output/Fig4_site_density_vs_daily_temp.png", height = 6, width = 8, units = "in")


# Figure 5. Average macroinvertebrate density vs. fraction of samples from riffles
inverts_bysite %>%
  ggplot(aes(x = frac_riffle, y = invert_density_m2, color = siteID)) +
  geom_point(size = 3) + 
  labs(x = "Fraction of samples from riffles",
       y = expression("Macroinvertebrate density"~(per~m^2)),
       color = "Site") +
  my_theme

ggsave("output/Fig5_site_density_vs_riffle_frac.png", height = 6, width = 8, units = "in")











