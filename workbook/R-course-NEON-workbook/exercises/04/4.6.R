
A <- c(1, 2, 3, "4")

B <- c(TRUE, FALSE, FALSE, NA)

C <- factor(A)

dat1 <- list(A = A, B = B, C = C)

dat2 <- data.frame(A, B, C)


# Using object dat1 in code above, 
# append a third item named Zeros that contains a vector with four 0 s.