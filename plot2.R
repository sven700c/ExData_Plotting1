if(!require('sqldf')){
    install.packages('sqldf')
}

library(sqldf)

colclasses = c("character", "character", rep("numeric",7))
sql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
data <- read.csv.sql("household_power_consumption.txt", sql, sep=';',
                        colClasses=colclasses, header = T)

# Convert ? to NA since read.csv.sql function doesn't have na.strings var
data[data == "?"] = NA

# Combine Date and Time column into new column, convert it POSIX time
DateTime <- paste(data$Date, data$Time)
DateTime <- strptime(DateTime,"%d/%m/%Y %H:%M:%S")
data <- cbind(DateTime, data)

png(file = "plot2.png", width = 480, height = 480)

with(data, plot(DateTime, Global_active_power, type="l", 
                ylab="Global Active Power (kilowatts)", xlab=""))

dev.off()