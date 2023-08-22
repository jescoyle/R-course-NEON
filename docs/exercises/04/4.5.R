
A <- c(1, 2, 3, "4")

B <- c(TRUE, FALSE, FALSE, NA)

C <- factor(A)

dat1 <- list(A = A, B = B, C = C)

dat2 <- data.frame(A, B, C)


# Using object dat1 in the code above, 
# demonstrate two different ways to select the 3rd item in 1st element.