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

png(file = "plot4.png", width = 480, height = 480)

par(mfcol = c(2, 2), mar = c(5, 4, 4, 2))

with(data, plot(DateTime, Global_active_power, type="l", 
                ylab="Global Active Power", xlab=""))

with(data, plot(DateTime, Sub_metering_1, type="n", 
                ylab="Energy sub metering", xlab=""))

with(data, points(DateTime, Sub_metering_1, type = "l")) 
with(data, points(DateTime, Sub_metering_2, type = "l", col = "Red")) 
with(data, points(DateTime, Sub_metering_3, type = "l", col = "Blue")) 
legend("topright", bty = "n", lwd = 1, 
       col = c("Black", "Red", "Blue"), legend = names(data)[8:10]) 

with(data, plot(DateTime, Voltage, type="l", xlab="datetime"))

with(data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))

dev.off()
