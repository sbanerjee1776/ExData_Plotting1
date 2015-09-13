# Reading the text file into a dataframe
library(dplyr)


pData <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep=";", na.strings = "?")
pData$Date <- as.Date(pData$Date, "%d/%m/%Y")

# Select only the two dates in February
pDataSub <- filter(pData, Date == "2007-02-01" | Date == "2007-02-02")

# Convert to weekdays
pDataSub$Date <- weekdays(pDataSub$Date)


# There are 2880 values, 1-1440 are for Thursday and 1441-2880 are for Friday
# There are 2880 values, 1-1440 are for Thursday and 1441-2880 are for Friday
nTh <- length(pDataSub$Date[pDataSub$Date == "Thursday"])  # Number of Days that are Thursday
nFr <- length(pDataSub$Date[pDataSub$Date == "Friday"])    # Number of Days that are Friday
nTot <- nTh + nFr +1                                       # Add 1 past the total number (for plotting)

# Open the device
png("plot4.png", height = 480, width = 480)
par(mfrow = c(2,2))  # Set up two rows and two columns for plotting




# Plot the first subplot
with(pDataSub, {
  
  # First Plot (Top Left)
  plot(Global_active_power, xaxt="n", type="l", ylab = "Global Active Power", xlab = "")
  axis(1, at = c(1, nTh+1, nTot), labels = c("Thu", "Fri", "Sat"))
    
  # Second Plot (Top Right)
  plot(Voltage, xaxt="n", type="l", ylab = "Voltage", xlab = "datetime")
  axis(1, at = c(1, nTh+1, nTot), labels = c("Thu", "Fri", "Sat"))
  
  # Third Plot (Bottom Left)
  plot(Sub_metering_1, xaxt="n", type="l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2, xaxt= "n", type = "l", col = "red", xlab = "", ylab="")
  lines(Sub_metering_3, xaxt= "n", type = "l", col = "blue", xlab = "", ylab="")
  axis(1, at = c(1, nTh+1, nTot), labels = c("Thu", "Fri", "Sat"))
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col = c("black", "red", "blue"), lty = c(1,1,1))
   
  # Fourth Plot (Bottom Right)
  plot(Global_reactive_power, xaxt="n", type="l", ylab = "Global_reactive_power", xlab = "datetime")
  axis(1, at = c(1, nTh+1, nTot), labels = c("Thu", "Fri", "Sat"))
})
     
dev.off()
