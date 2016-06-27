add2 <- function(x, y) {
  x + y
}

above10 <- function(v) {
  use <- v > 10
  v[use]
}

above <- function(v, n = 10) {
  use <- v > n
  v[use]
}

columnMean <- function(m, removeNA = TRUE) {
  nc <- ncol(m)
  means <- numeric(nc)
  for (i in 1:nc) {
    means[i] <- mean(m[, i], na.rm = removeNA)
  }
  means
}