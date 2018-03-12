###Code for creating Plot 2
library(lubridate)
library(dplyr)
#download the data
URL<- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('household_power_consumption.txt')) {
        download.file(URL,destfile = 'power_consumption.zip')
        unzip('power_consumption.zip')
        power<-read.csv("household_power_consumption.txt", header=FALSE, sep=";" stringsAsFactors = FALSE)
        print('File is ready to use')
} else {
        power<-read.csv("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE)
        print('File is ready to use')
}

power <- power[power$Date %in% c("1/2/2007","2/2/2007") ,]
power$date_time <- with(power, strptime(paste(Date,Time, sep = ' '),'%d/%m/%Y %H:%M:%S'))
power$Date<- dmy(power$Date)
power$Time <- hms((power$Time))
power[3:8]<- sapply(power[3:8],as.numeric)


png("plot2.png", width=480, height=480)
with(power, plot(date_time, Global_active_power, ylab='Global Active Power (kilowatts)', type ='l', xlab=""))
dev.off()
