
A <- c(1, 2, 3, "4")

B <- c(TRUE, FALSE, FALSE, NA)

C <- factor(A)

dat1 <- list(A = A, B = B, C = C)

dat2 <- data.frame(A, B, C)


# Using the object C in the code above, 
# change the order of the levels so that the the levels 
# are in descending numeric order 
# (e.g. "4" is the first level and "1" is the last level).