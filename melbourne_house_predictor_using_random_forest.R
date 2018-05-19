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
train.data <- read.csv('data/melbourne-house-prices-train-data.csv')
test.data <- read.csv('data/melbourne-house-prices-test-data.csv')

# Neglect na records
na.omit(train.data)

# Summarize the data
summary(train.data)

target <- "SalePrice"
features <- c("LotArea", "OverallQual", "TotRmsAbvGrd", "YearBuilt")

features <- paste(features, collapse = "+")
formula <- as.formula(paste(target, "~", features, sep = ""))

max.depth = 2

model <- randomForest(formula, data = train.data, control = randomForest.control(maxdepth = max.depth))
predictions <- predict(model, newdata = test.data)

submission.file <- data_frame('Id' = test.data$Id, 'SalePrice' = predictions)
write_csv(submission.file, 'data/melbourne-house-prices-predictions.csv')