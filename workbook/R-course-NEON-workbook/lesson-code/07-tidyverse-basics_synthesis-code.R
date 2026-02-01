## Code from the Data manipulation in the tidyverse Synthesis Chapter
## Author: YOUR NAME HERE
## Date: TODAYS DATE
## Description: This code calculates diversity and abundance of 
##              macroinvertebrates at three NEON sites in summer 2021.


# If data have not been previously downloaded, uncomment and run:
# source("lesson-code/07-tidyverse-basics_download-data.R")

## Load packages for the analysis
library(neonUtilities)
library(dplyr)
library(tidyr)
library(ggplot2)

## Read in previously stacked data tables
# Define location of data
savepath <- "data"

# Read in macroinvertebrate abundance data from data product 20120
inv_fieldData <- readTableNEON(
  dataFile = file.path(savepath, "filesToStack20120", "stackedFiles", "inv_fieldData.csv"),
  varFile = file.path(savepath, "filesToStack20120", "stackedFiles", "variables_20120.csv")
)

# Read in macroinvertebrate taxonomy data from data product 20120
inv_taxa <- readTableNEON(
  dataFile = file.path(savepath, "filesToStack20120", "stackedFiles", "inv_taxonomyProcessed.csv"),
  varFile = file.path(savepath, "filesToStack20120", "stackedFiles", "variables_20120.csv")
)


## Analysis: Calculate macroinvertebrate diversity and abundance

# Count the number of unique taxa found at each site and sampling date, combining across all of the samples collected on the same date)
site_summary <- inv_taxa |>
  group_by(siteID, collectDate) |>
  summarize(num_taxa = length(unique(scientificName)))

# Calculate total macroinvertebrate abundance in each sample
inv_bysample <- inv_taxa |>
  group_by(siteID, collectDate, sampleID) |>
  summarize(tot_abun = sum(estimatedTotalCount))


# Join the inv_taxa table with the collection date column in inv_fieldData. 
inv_bysample <- inv_fieldData |>
  
  # Select sample info columns from inv_fieldData
  select(sampleID, benthicArea) |>
  
  # Join with counts of taxa in inv_taxa
  right_join(inv_bysample, by = "sampleID")

# Calculate abundance in each sample standardized by sampling area
inv_bysample <- inv_bysample |>
  mutate(abun_per_m2 = tot_abun / benthicArea)

# Calculate average abundance for each collection date and site.
site_summary <- inv_bysample |>
  group_by(siteID, collectDate) |>
  summarize(abun_per_m2 = mean(abun_per_m2)) |>
  
  # Join with site summary 
  right_join(site_summary)

# Save the summary data to a file.
write.csv(site_summary,
          file = "results/lesson-07-synthesis.csv")

# Plot diversity versus abundance with points colored by site
ggplot(site_summary, aes(x = abun_per_m2, y = num_taxa)) +
  geom_point(aes(color = siteID)) +
  labs(x = expression("Num. individuals per"~m^2),
       y = "Num. taxa",
       color = "Site")