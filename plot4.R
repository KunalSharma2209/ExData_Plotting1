### Writing code and setting your working directory

getwd()

dir()

setwd("~/R/ExploratoryWeek1Assignment")

library(lubridate)


### Read in the data

power_data <- read.delim("household_power_consumption.txt", header=TRUE, sep=";")
head(power_data)
power_data[1,]

### Add a variable to the data table, combining the date and time into one

power_data[,10] <- dmy_hms(paste(power_data$Date, power_data$Time))
names(power_data) <- c(names(power_data)[1:9],"Date_time")
head(power_data)

power_data$Date <- dmy(power_data$Date)
power_data$Time <- hms(power_data$Time)

### Use this newly created variable to form a condensed data table showing only data for the two days of interest

power_data_subset1 <- power_data[date(power_data[,10])==dmy("1/2/2007"),]
head(power_data_subset1)
nrow(power_data_subset1)
power_data_subset2 <- power_data[date(power_data[,10])==dmy("2/2/2007"),]
head(power_data_subset2)
nrow(power_data_subset2)

power_data_condensed <- rbind(power_data_subset1, power_data_subset2)
head(power_data_condensed)
nrow(power_data_condensed)


### Plot 4

power_data_condensed$Global_active_power <- as.numeric(as.character(power_data_condensed$Global_active_power))

power_data_condensed$Sub_metering_1 <- as.numeric(as.character(power_data_condensed$Sub_metering_1))
power_data_condensed$Sub_metering_2 <- as.numeric(as.character(power_data_condensed$Sub_metering_2))
power_data_condensed$Sub_metering_3 <- as.numeric(as.character(power_data_condensed$Sub_metering_3))

power_data_condensed$Voltage <- as.numeric(as.character(power_data_condensed$Voltage))
power_data_condensed$Global_reactive_power <- as.numeric(as.character((power_data_condensed$Global_reactive_power)))


png(filename = "plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(power_data_condensed$Date_time, power_data_condensed$Global_active_power, type="l",
     ylab = "Global Active Power", xlab="") 

plot(power_data_condensed$Date_time, power_data_condensed$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(power_data_condensed$Date_time, power_data_condensed$Sub_metering_1,
     type="l", ylab="Energy sub metering", xlab="")
lines(power_data_condensed$Date_time, power_data_condensed$Sub_metering_2,col="red")
lines(power_data_condensed$Date_time, power_data_condensed$Sub_metering_3,col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1, bty="n")

plot(power_data_condensed$Date_time, power_data_condensed$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

dev.off()