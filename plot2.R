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

png(file = "plot2.png", width = 480, height = 480)

plot(df$Time, df$Global_active_power,type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
