#####################################################################################
## Exploratory Data Analysis, Course Project 1
## Martín Dâvila
## 20150912
#####################################################################################
## Description of the following script
## plot4.r
#####################################################################################
## This script will perform the following project steps, taken from the web page: 
## Our overall goal here is simply to examine how household energy usage varies
## over a 2-day period in February, 2007.
## Your task is to reconstruct the following plots below,
## all of which were constructed using the base plotting system.
#####################################################################################


# First of all we need to set the work directory, in which we find all the data sets
# for me is the following
setwd("C:/Coursera/Course Project 1 EDA")
getwd()


# Clean up the workspace
rm(list=ls())



## Obtaining the dataset in full
data_full <- read.csv("C:/Coursera/Course Project 1 EDA/household_power_consumption.txt",
                      header=T, sep=';', na.strings="?", nrows=2075259,
                      check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Convert the dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Making the Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})




## Save it to a png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
