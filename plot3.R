# Reading the text file into a dataframe
library(dplyr)


pData <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep=";", na.strings = "?")
pData$Date <- as.Date(pData$Date, "%d/%m/%Y")

# Select only the two dates in February
pDataSub <- filter(pData, Date == "2007-02-01" | Date == "2007-02-02")

# Convert to weekdays
pDataSub$Date <- weekdays(pDataSub$Date)


# There are 2880 values, 1-1440 are for Thursday and 1441-2880 are for Friday
nTh <- length(pDataSub$Date[pDataSub$Date == "Thursday"])  # Number of Days that are Thursday
nFr <- length(pDataSub$Date[pDataSub$Date == "Friday"])    # Number of Days that are Friday
nTot <- nTh + nFr +1                                       # Add 1 past the total number (for plotting)

# Plot the third plot
png("plot3.png", height = 480, width = 480)
with(pDataSub, plot(Sub_metering_1, xaxt="n", type="l", ylab = "Energy sub metering", xlab = ""))
with(pDataSub, lines(Sub_metering_2, xaxt= "n", type = "l", col = "red", xlab = "", ylab=""))
with(pDataSub, lines(Sub_metering_3, xaxt= "n", type = "l", col = "blue", xlab = "", ylab=""))
axis(1, at = c(1, nTh+1, nTot), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col = c("black", "red", "blue"), lty = c(1,1,1))

dev.off()