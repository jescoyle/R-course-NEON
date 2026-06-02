## Example analysis of NEON Data
## Step 2: clean up data download
## Author: Jes Coyle, jrc16@stmarys-ca.edu
## Date: 2026-04-30
## Description: This code renames stacked data tables
##              and removes unnecessary files.

# Paths are relative to the NEON_project home directory
# Move stacked macroinvertebrates data
# into new directory with informative name
mkdir data/stacked20120_2024_TECR-CARI-MART

mv data/filesToStack20120/stackedFiles/* data/stacked20120_2024_TECR-CARI-MART

# Move stacked temperature data
# into new directory with informative name
mkdir data/stacked20053_2024_TECR-CARI-MART

mv data/filesToStack20053/stackedFiles/* data/stacked20053_2024_TECR-CARI-MART

# Remove original downloaded data
rm -r data/filesToStack*
