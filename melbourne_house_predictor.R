# Clear current workspace
rm(list = ls())

# Clear Console 
cat("\014")

source('get_package.R')

# Install and/or load packages
get_package('tidyverse')
get_package('rpart')
get_package('randomForest')

# Read data into workspace
melb_data <- read.csv('data/melb_data.csv')

# Summarize the data
summary(melb_data)

# Train the data with features and output
fit <- rpart(Price ~ Rooms + Bathroom + Landsize + BuildingArea + YearBuilt + Lattitude 
             + Longtitude, data = melb_data)

# Plot regression tree
plot(fit, uniform = TRUE)

# add text to regression tree
text(fit, cex=0.6)

print("Predicting Prices for following houses")
print(head(melb_data))

predictions <- predict(fit, head(melb_data))
print(predictions)

print("Actaul Price")
print(head(melb_data$Price))