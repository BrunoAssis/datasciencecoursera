rankall <- function(outcome, num = "best") {
  outcome.data <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  valid.outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if (!outcome %in% valid.outcomes) {
    stop("invalid outcome")
  }
  
  valid.nums <- c("best", "worst")
  
  if (!is.numeric(num) && !num %in% valid.nums) {
    stop("invalid num")
  }

  outcome.data$State <- as.factor(outcome.data$State)
  
  target.column <- paste("Hospital.30.Day.Death..Mortality..Rates.from.", normalize.outcome(outcome), sep = "")

  do.call("rbind", lapply(levels(outcome.data$State), function(state) {
    state.data <- outcome.data[outcome.data$State == state, ]
    state.data[, target.column] <- as.numeric(state.data[, target.column])
    state.data <- state.data[!is.na(state.data[, target.column]), ]
    
    if (num == "best") {
      position <- 1
    } else if (num == "worst") {
      position <- nrow(state.data)
    } else {
      position <- num
    }

    chosen_hospital <- state.data[order(state.data[, target.column], state.data$Hospital.Name),][position,]
    data.frame(hospital = chosen_hospital$Hospital.Name, state = state)
  }))
}

normalize.outcome <- function(outcome) {
  library(stringi)
  gsub(" ", ".", stri_trans_totitle(outcome))
}
