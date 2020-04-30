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

## PLOT 4
png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(EPCdata, {
        plot(Global_active_power~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~DateTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DateTime,col="red")
        lines(Sub_metering_3~DateTime,col="blue")
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~DateTime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.off()
