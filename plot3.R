###Code for creating Plot 3
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
png("plot3.png", width=480, height=480)
with(power, plot(date_time, Sub_metering_1, ylab='Energy sub metering', type ='l', xlab="", col = 'black'))
with(power, lines(date_time, Sub_metering_2, col = 'red'))
with(power, lines(date_time, Sub_metering_3, col = 'blue'))
legend('topright', c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'), lty= 1, col=c('black','red','blue'))
dev.off()
