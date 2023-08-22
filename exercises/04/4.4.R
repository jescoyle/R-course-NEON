
A <- c(1, 2, 3, "4")

B <- c(TRUE, FALSE, FALSE, NA)

C <- factor(A)

dat1 <- list(A = A, B = B, C = C)

dat2 <- data.frame(A, B, C)


# Using object dat2 in the code above, 
# append a new column named X that is the numeric equivalent of column A.