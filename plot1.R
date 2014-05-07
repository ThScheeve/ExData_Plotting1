temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";")
unlink(temp)

data <- subset(data, data$Date %in% c("1/2/2007", "2/2/2007"))
data$DateTime <- apply(data[, c("Date", "Time")], 1, paste, collapse = " ")
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data$Date <- NULL
data$Time <- NULL
for (col in 1:7) {
  data[, col] <- as.numeric(as.character(data[, col]))
}

png("plot1.png", width = 480, height = 480)
hist(x = data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()