library(data.table)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "data.zip")
unzip("data.zip")

df <- fread(file = "household_power_consumption.txt", na.strings = "?", 
            colClasses = c("character", "character", rep("numeric", 7)),
            stringsAsFactors = FALSE)
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

df <- df[df$Date >= "2007-02-01" & df$Date <= "2007-02-02", ]
df$Time <- as.POSIXct(paste(as.character(df$Date), df$Time))

png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

plot(df$Time, df$Global_active_power,type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

plot(df$Time, df$Voltage,type="l", 
     xlab="datetime", ylab="Voltage")

plot(df$Time, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", col= c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), lwd = c(1,1))

plot(df$Time, df$Global_reactive_power,type="l", 
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
