best <- function(state, outcome) {
  outcome.data <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")

  if (!state %in% outcome.data$State) {
    stop("invalid state")
  }
  
  valid.outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if (!outcome %in% valid.outcomes) {
    stop("invalid outcome")
  }
  
  target.column <- paste("Hospital.30.Day.Death..Mortality..Rates.from.", normalize.outcome(outcome), sep = "")

  state.data <- outcome.data[outcome.data$State == state,]
  state.data[, target.column] <- as.numeric(state.data[, target.column])

  state.data[which.min(state.data[, target.column]), ]$Hospital.Name
}

normalize.outcome <- function(outcome) {
  library(stringi)
  gsub(" ", ".", stri_trans_totitle(outcome))
}