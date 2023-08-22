
# Determine the class and structure of each of the following objects

A <- c(1, 2, 3, "4")

B <- c(TRUE, FALSE, FALSE, NA)

C <- factor(A)

dat1 <- list(A = A, B = B, C = C)

dat2 <- data.frame(A, B, C)