pollutantmean <- function(directory, pollutant, id = 1:332) {
  dataset <- data.frame()
  for (file.id in id) {
    file <- file.path(directory, paste(sprintf("%03d", file.id), ".csv", sep = ""))
    file.data <- read.csv(file)
    dataset <- rbind(dataset, file.data)
  }
  mean(dataset[[pollutant]], na.rm = TRUE)
}