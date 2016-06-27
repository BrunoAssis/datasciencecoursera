complete <- function(directory, id = 1:332) {
  dataset <- data.frame(id = numeric(), nobs = numeric())
  for (file.id in id) {
    file <- file.path(directory, paste(sprintf("%03d", file.id), ".csv", sep = ""))
    file.data <- read.csv(file)
    dataset <- rbind(dataset, data.frame(id = file.id, nobs = sum(complete.cases(file.data))))
  }
  dataset
}