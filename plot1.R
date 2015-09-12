# Reading the text file into a dataframe
library(dplyr)


pData <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep=";", na.strings = "?")
pData$Date <- as.Date(pData$Date, "%d/%m/%Y")

# Select only the two dates in February
pDataSub <- filter(pData, Date == "2007-02-01" | Date == "2007-02-02")

# Plot the histogram
png("plot1.png", height = 480, width = 480)
with(pDataSub, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power"))
dev.off()