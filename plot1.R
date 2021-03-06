# Loading "Eletric Power Consumption - EPC" dataset
EPCdata <- read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings = "?")

#Loading Packages
library(dplyr)
library(lubridate)

#Formatting date to Type Date
EPCdata$Date <- dmy(EPCdata$Date) 

#Filtering observations between 2007-02-01 and 2007-02-02 
EPCdata <- filter(EPCdata, Date >= "2007-02-01" & Date<= "2007-02-02") 

#Removing incomplete observations
EPCdata <- EPCdata[complete.cases(EPCdata),]

#Combining Date and Time columns
DateTime <- paste(EPCdata$Date, EPCdata$Time)
EPCdata$DateTime <- as.POSIXct(DateTime)

## PLOT 1
png("plot1.png", width = 480, height = 480)

hist(EPCdata$Global_active_power, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     xlim = c(0,8),
     ylim = c(0,1200),
     col = "red")

dev.off()
