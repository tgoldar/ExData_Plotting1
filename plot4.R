#install.packages("sqldf")
library(sqldf)

# Read the file filtering the specified rows
info <- read.csv.sql("household_power_consumption.txt", "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";", header=TRUE, colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# format the Date column
info$Date <- as.Date(info$Date, "%d/%m/%Y")

# paste te date and time together and give it format
dateTime <- paste(info$Date, info$Time)
dateTime <- as.POSIXct(dateTime)

# add dateTime to the dataframe
info <- cbind(dateTime, info)

# to show the days names in english
Sys.setlocale("LC_TIME", "C")

############ plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(info,plot(dateTime, Global_active_power, type="l", ylab="Global Active Power", xlab=""))
with(info,plot(dateTime, Voltage, type="l", ylab="Voltage", xlab="datetime"))
with(info, {
  plot(Sub_metering_1~dateTime, type="l", ylab="Energy sub metering", xlab="", col = 'black')
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, cex=0.7, bty="n",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(info,plot(dateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))

# generate the file and close de device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()