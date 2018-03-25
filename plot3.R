#############################################################################


## Author: Ravi M.B.
## Project 1: Course project 
## Course: Exploratory Data Analysis -- CoursEra


## Data is downloaded from the suggested URL : 
## http://archive.ics.uci.edu/ml/index.php
## Dataset is extracted from the available link on coursera course page
## Dataset is unzipped form the archive and the working directory is set using 
## setwd() function from privacy reasons, it is not included here
## goal here is simply to examine how household energy usage varies over a 2-day 
## period in February, 2007


###############################################################################


## Dataset being read

power_consumption_data <- read.table("household_power_consumption.txt",skip=1,sep=";")
dim(power_consumption_data)
head(power_consumption_data)
tail(power_consumption_data)

##  variables in the dataset are taken from the UCI web site

names(power_consumption_data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

## subset( ) function is the easiest way to select variables and observations which is for two days in February 2007
## Converting the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
power_subset <- subset(power_consumption_data,power_consumption_data$Date=="1/2/2007" | power_consumption_data$Date =="2/2/2007")
power_subset$Date <- as.Date(power_subset$Date, format="%d/%m/%Y")
power_subset$Time <- strptime(power_subset$Time, format="%H:%M:%S")
power_subset[1:1440,"Time"] <- format(power_subset[1:1440,"Time"],"2007-02-01 %H:%M:%S")
power_subset[1441:2880,"Time"] <- format(power_subset[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# plotting the results 
plot(power_subset$Time,power_subset$Sub_metering_1,type="n",xlab="Days",ylab="Energy sub metering")
with(power_subset,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(power_subset,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(power_subset,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# annotating the plot
title(main="Energy sub-metering")