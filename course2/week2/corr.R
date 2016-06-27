corr <- function(directory, threshold = 0) {
  id <- 1:332
  results <- numeric()
  for (file.id in id) {
    file <- file.path(directory, paste(sprintf("%03d", file.id), ".csv", sep = ""))
    file.data <- read.csv(file)
    complete.obs <- complete(directory, file.id)$nobs
    if (complete.obs > threshold) {
      condition <- !is.na(file.data$sulfate) & !is.na(file.data$nitrate)
      results <- c(results, cor(file.data$sulfate[condition], file.data$nitrate[condition]))
    }
  }
  results
}