Title: Effects of water temperature on macroinvertebrate abundance and diversity along a latitudinal gradient
Author: Jes Coyle
Date: 2023-11-29

Description:
This project analyzes macroinvertebrate diversity and abundance at three NEON aquatic sites from June - October 2021: 
Caribou Creek, Alaska (CARI), Martha Creek, Washington (MART), and Teakettle Creek, California (TECR).

There are three folders in this package:

data/	contains data files
	TSW_30min.csv			each row is a 30-min average from a water temperature sensor at a site
	inv_fieldData.csv 		each row contains information about macroinvertebrate samples collected at the NEON sites
	inv_taxa.csv			each row contains information about a particular macroinvertebrate taxon collected in a specific samples
	inverts_bysample.csv	each row summarizes macroinvertebrate abundance, richness and surface water temperature for a sample
							this was the derived data table used to make the graphs
							
output/ contains the figures generate by the analysis and used in the paper

code/ 	contains the R code scripts. They should be run in this order:
	01_download_NEON_data.R					this script downloads the NEON data sets and creates TSW_30min.csv, inv_fielddata.csv, and inv_taxa.csv
	02_macroinvert_diversity_analysis.R		this script summarizes the invertebrate data and generates inverts_bysample.csv along with all the figures


To rund the analysis, begin by opening the NEON_project.Rproj file. 
	