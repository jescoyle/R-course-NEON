Title: Relationship between surface water temperature and macroinvertebrate diversity and abundance at three NEON sites.
Author: Jes Coyle
Institution: Saint Mary's College of California
Contact: jrc16@stmarys-ca.edu
Date: April 30, 2026

This folder contains and example of an analysis of National Ecological Observatory Network data created for BIOL 353L: Macrosystems Biology Lab. Two data products from three aquatic stream sites (Martha Creek, WA, Caribou Creek, AK, and Teakettle Creek, CA) were downloaded for all of 2024. The data products are:

“Macroinvertebrate Collection (DP1.20120.001).” National Ecological Observatory Network (NEON). https://doi.org/10.48443/ZJ4Y-4073.

“Temperature (PRT) in Surface Water (DP1.20053.001).” National Ecological Observatory Network (NEON). https://doi.org/10.48443/33ZJ-CQ24.

Scripts used to download and analyze data are in the code folder. The contents are numbered in the order in which scripts were run to complete the analysis.

	01-download_data.R
		Uses functions from the neonUtilities package to download and stack data from multiple months.
	
	02-move_data.sh
		Uses terminal commands to move stacked data tables and delete large data downloads.
	
	03-invert_temperature_analysis.R
		Conducts analysis of macroinvertebrate abundance and diversity and water temperature.
	

The data folder contains two folders of stacked NEON data tables (which are named by the data product, date and sites) and two derived data tables from the analysis.

	macroinvertebrates_site_summary.csv
		Contains macroinvertebrate abundance and diversity measurements at each site and collection date.
	
	temperature_summary_14days.csv
		Contains temperature summaries for the 14 days prior to each macroinvertebrate collection date at each site.
		
The output folder contains two figures generates during the analysis.

	abun_vs_Tmean.png
		Shows relationship between total adult macroinvertebrate abundance on each collection date and the mean temperature over the time period 14 days prior to collection.
	macroinvert_vs_temperature.svg
		Shows the relationship between total adult macroinvertebrate abundance, family richness and genera richness and mean, minimum and maximum temperature over the time period 14 days prior to collection.
 
 
