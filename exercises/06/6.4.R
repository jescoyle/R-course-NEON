# Exercise 6.4

# Fill in the blanks to produce the graph shown in the exercise.
# This graph compares the number of good versus erroneous 
# dissolved oxygen measurements between the two sensor locations. 
# No data were omitted from wq prior to making this graph.

# Load Teakettle Creek water quality data
wq <- read.csv("data/NEON_water/waterqual_inst_TECR_2021-04_2021-10.csv")

# Redefine factor levels for finalQF
wq$dissolvedOxygenFinalQF <- factor(wq$dissolvedOxygenFinalQF)
levels(wq$dissolvedOxygenFinalQF) <- list(________ = 0,
                                          ________ = 1)

# Compare data quality of DO between two sensors
ggplot(data = wq,
       mapping = aes(x = _________________)) +
  ________(aes(fill = ___________________)) +
  labs(x = _____________,
       y = _____________,
       _____ = "Data quality")







# Exercise 6.7
# Export the graph as a pdf with dimensions 6 x 5 inches.