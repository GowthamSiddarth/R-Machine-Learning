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

# Read data into workspace
melb.data <- read.csv('data/melb_data.csv')

# Summarize the data
summary(melb.data)

# Partition data into train and test set
partition.data <- resample_partition(melb.data, c(test = 0.3, train = 0.7))

print(lapply(partition.data, dim))

# Train the data with features and output
fit <- rpart(Price ~ Rooms + Bathroom + Landsize + BuildingArea + YearBuilt + Lattitude 
             + Longtitude, data = partition.data$train)

# Plot regression tree
plot(fit, uniform = TRUE)

# add text to regression tree
text(fit, cex=0.6)

print("Predicting Prices for following houses")
print(head(melb.data))

predictions <- predict(fit, head(melb.data))
print(predictions)

print("Actaul Price")
print(head(melb.data$Price))

mean.average.error = mae(model = fit, data = partition.data$test)
print(paste("MEAN AVERAGE ERROR: ", mean.average.error))