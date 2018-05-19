# Clear current workspace
rm(list = ls())

# Clear Console 
cat("\014")

source('get_package.R')

# Install and/or load packages
get.package('tidyverse')
get.package('rpart')
get.package('randomForest')
get.package('modelr')
get.package('glue')

# Read data into workspace
melb.data <- read.csv('data/melb_data.csv')

# Neglect na records
melb.data <- na.omit(melb.data)

# Summarize the data
summary(melb.data)

# Partition data into train and test set
partition.data <- resample_partition(melb.data, c(test = 0.3, train = 0.7))

print(lapply(partition.data, dim))

get.mae <- function(max.depth, target, features, train.data, test.data) {
  features <- paste(features, collapse = "+")
  formula <- as.formula(paste(target, "~", features, sep = ""))
  
  model <- rpart(formula, data = train.data, control = rpart.control(maxdepth = max.depth))
  mean.average.error <- mae(model = model, test.data)
  
  return(mean.average.error)
}

target <- "Price"
features <- c("Rooms", "Bathroom", "Landsize", "BuildingArea", "YearBuilt", "Lattitude",
              "Longtitude")

for (max.depth in 1:10) {
  mean.average.error <- get.mae(max.depth, target, features, partition.data$train, partition.data$test)
  print(glue("Max Depth: ", max.depth, "\t MAE: ", mean.average.error))
}