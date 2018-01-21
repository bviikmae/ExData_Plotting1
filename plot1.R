# read data to a table
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric',
                                  'numeric','numeric','numeric','numeric','numeric'))
# format date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# select a subset of complete cases from data between 2007-2-1 and 2007-2-2
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]

# concatenate date and time together, format correctly and add to the table
date_time <- paste(data$Date, data$Time)
date_time <- setNames(date_time, "Date and time")
data <- data[ ,!(names(data) %in% c("Date","Time"))]
data <- cbind(date_time, data)
data$date_time <- as.POSIXct(date_time)

# plot global active power as histogram
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

# save the historgram to a PNG file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
