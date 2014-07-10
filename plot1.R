colclasses = c("character", "character", rep("numeric",7))
data <- read.csv("household_power_consumption.txt", colClasses = colclasses, 
                 na.strings= "?", sep = ";")

hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power(kilowatt)")
