if(!require('sqldf')){
    install.packages('sqldf')
}

library(sqldf)

colclasses = c("character", "character", rep("numeric",7))
sql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
data <- read.csv.sql("household_power_consumption.txt", sql, sep=';',
                        colClasses=colclasses, header = T)


hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power(kilowatt)")
