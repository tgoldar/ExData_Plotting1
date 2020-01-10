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

############ plot 1
hist(info$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

# generate the file and close de device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()