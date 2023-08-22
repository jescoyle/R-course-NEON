#  1. Read in the data in the file data/NEON_water/waterqual_inst_TECR_2021-04_2021-10.csv
#  to a data frame.


# 2. The QF columns are quality flags that indicate issues with the data. 
#    QF = 0 indicates that the data are good. 
#    Extract all pH values where the pHFinalQF column is not equal to 0.
#    Save these values to a vector named `bad_pH`.




# 3. What fraction of the data contain bad pH values?
#    HINT: divide the number of values in `bad_pH` by 
#          the total number of observations in the data.