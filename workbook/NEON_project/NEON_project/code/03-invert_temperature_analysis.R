## Example analysis of NEON Data
## Step 3: analyze relationship between macroinvertebrates and temperature
## Author: Jes Coyle, jrc16@stmarys-ca.edu
## Date: 2026-04-30
## Description: This code calculates diversity and abundance of 
##              macroinvertebrates at three NEON sites in 2024. It
##              related diversity and abundance to several water 
##              temperature variables.


## Load packages for the analysis
library(neonUtilities)
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)


# Read in macroinvertebrate abundance data from data product 20120
inv_fieldData <- readTableNEON(
  dataFile = "data/stacked20120_2024_TECR-CARI-MART/inv_fieldData.csv",
  varFile = "data/stacked20120_2024_TECR-CARI-MART/variables_20120.csv"
)

# Read in macroinvertebrate taxonomy data from data product 20120
inv_taxa <- readTableNEON(
  dataFile = "data/stacked20120_2024_TECR-CARI-MART/inv_taxonomyProcessed.csv",
  varFile = "data/stacked20120_2024_TECR-CARI-MART/variables_20120.csv"
)

# Read in 30-min avg surface water temperature data from data product 20053
TSW_30min <- readTableNEON(
  dataFile = "data/stacked20053_2024_TECR-CARI-MART/TSW_30min.csv",
  varFile = "data/stacked20053_2024_TECR-CARI-MART/variables_20053.csv"
)

## GOAL 1: Create macroinvertebrate community summary table

# Filter data to only adults 
inv_taxa_adult <- filter(inv_taxa, invertebrateLifeStage == "adult")

# Calculate total num. individuals in each sample
abundance <- inv_taxa_adult |>
  group_by(sampleID, siteID, collectDate) |>
  summarize(tot_abun = sum(estimatedTotalCount))


# Join abundance in each sample with 
# benthicArea column from inv_fieldData
# Then calculate density as total abundance / area
abundance <- inv_fieldData |>
  select(sampleID, benthicArea) |>
  right_join(abundance) |>
  mutate(abun_per_m2 = tot_abun / benthicArea)

# Then summarize abundance at each site and sampling date:
# n_samples = number of samples
# abun_per_m2 = average density across all samples 
site_summary <- abundance |>
  group_by(siteID, collectDate) |>
  summarize(n_samples = n(),
            abun_per_m2 = mean(abun_per_m2))

# Remove uncertain taxonomic IDs and non-distinct taxa
# then calculate number of unique genera and families 
# for each collection date at each site
diversity <- inv_taxa_adult |>
  filter(immatureSpecimen == "N",
         distinctTaxon == "Y") |>
  group_by(siteID, collectDate) |>
  summarize(n_genus = length(unique(genus)),
            n_family = length(unique(family)))

# Join diversity and abundance tables, keeping all rows
# in each table
site_summary <- full_join(site_summary, diversity)


# Write table as csv to output folder
write.csv(site_summary, file = "data/macroinvertebrates_site_summary.csv", row.names = FALSE)
         


## GOAL 2: Generate environmental data summary


# Remove erroneous temperature data flagged by FinalQF
temp_dat <- TSW_30min |>
  filter(finalQF == 0)

# Calculate average tempearture measurements between
# upstream and downstream sensors
temp_avg <- temp_dat |>
  group_by(siteID, startDateTime) |>
  summarize(Tmean = mean(surfWaterTempMean, na.rm = TRUE),
            Tmax = max(surfWaterTempMaximum, na.rm = TRUE),
            Tmin = min(surfWaterTempMinimum, na.rm = TRUE)) |>
  ungroup() # Removes grouping variables to avoid problems when using this data later
            


# Make a quick line graph to visualize the time series of
# temperature data availability at each site (line color)
temp_avg |>
  ggplot(aes(x = startDateTime, y = Tmean)) +
    geom_line(aes(color = siteID)) +

    # Add vertical line for each collection date
    geom_vline(data = site_summary, 
               mapping = aes(xintercept = collectDate,
                             color = siteID))

# Extract dates when macroinvertebrates were sampled
# and define dates two weeks prior
sample_dates <- site_summary |>
  select(siteID, collectDate) |>
  mutate(past_date = collectDate - ddays(14)) 


# Calculate water temperature statistics from mean temperature
# measurements collected between past_date and collectDate
env_14days <- sample_dates |>
  rowwise() |> # applies the functions in mutate() one row at at time
  mutate(Tmean = mean(subset(temp_avg, siteID == siteID &
                             startDateTime >= past_date & 
                             startDateTime < collectDate)$Tmean, na.rm = TRUE),
         Tmin = min(subset(temp_avg,siteID == siteID & 
                            startDateTime >= past_date & 
                            startDateTime < collectDate)$Tmean, na.rm = TRUE),
         Tmax = max(subset(temp_avg, siteID == siteID & 
                     startDateTime >= past_date & 
                     startDateTime < collectDate)$Tmean, na.rm = TRUE)
  )

# Save data

write.csv(env_14days, file = "data/temperature_summary_14days.csv", row.names = FALSE)



## GOAL 3: Join and graph community and environmental data

# Join temperature and macroinvertebrate data
# keeping all rows in site_summary
df <- left_join(site_summary, env_14days)

# Make a scatter plot showing relationship between temperature
# and total abundance

df |>
  ggplot(aes(x = Tmean, y = abun_per_m2, color = siteID)) +
    geom_point() +
    labs(x = expression("Mean 14-day surface water temperature"~(degree*C)),
         y = expression("Macroinvertebrate density (num. per"~m^2),
         color = "NEON Site") +
    theme_bw() # makes black and white color scheme

# Save as png
ggsave("output/abun_vs_Tmean.png", height = 4, width = 5)



# Pivot to long format to make multipanel graphs
# Each row is a combination of a temperature an macroinvertebrate variable
df_long <- df |>
  pivot_longer(starts_with("T"), names_to = "T_var", values_to = "Temperature") |>
  pivot_longer(c("abun_per_m2", "n_genus","n_family"), names_to = "M_var", values_to = "value")


df_long |>
  
  # use informative names for variables
  mutate(M_var = factor(M_var, 
                        labels = c("Density (num. per m2)", "Num. families", "Num genera")),
         T_var = factor(T_var, 
                        labels = c("Maximum", "Mean", "Minimum"))
  ) |> 
           
  # set up graph axes
  ggplot(aes(x = Temperature, y = value, color = siteID)) +
    
  # make separate plots for each macroinvertebrate variable and temp variable
  facet_grid(M_var ~ T_var, scales = "free") +
    
  # add points
  geom_point() +
  
  # add axis labels
  labs(x = expression("14-day surface water temperature"~(degree*C)),
       y = "",
       color = "NEON Site") +
  theme_bw() # makes black and white color scheme

# Save as svg - editable in Inkscape
ggsave("output/macroinvert_vs_temperature.svg", height = 7, width = 8)

