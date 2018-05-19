# Clear current workspace
rm(list = ls())

# Clear Console 
cat("\014")

source('get_package.R')

get_package('tidyverse')
get_package('rpart')
get_package('randomForest')

melb_data <- read.csv('data/melb_data.csv')
summary(melb_data)