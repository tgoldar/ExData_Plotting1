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

############ plot 3
with(info, {
  plot(Sub_metering_1~dateTime, type="l", ylab="Energy sub metering", xlab="", col = 'black')
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# generate the file and close de device
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()