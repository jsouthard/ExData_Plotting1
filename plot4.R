## Obtain data file if not present
dataFile <- "household_power_consumption.txt"
dataZip <- "household_power_consumption.zip"
if (!file.exists(dataFile)) {
	if (!file.exists(dataZip)){
		message("Data file", dataZip, " not found, downloading...")
		fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
		download.file(fileUrl, destfile=dataZip, method="curl")
		message("Done downloading")
		rm(fileUrl)
	}
	unzip(dataZip)
}
rm(dataZip)

## Read in data
tab5rows <- read.table(dataFile, header = TRUE, sep=";", nrows = 5)
classes <- sapply(tab5rows, class)
rm(tab5rows)
tmpTable <- read.table(dataFile,
					   header=T,
					   sep=";", 
					   na.strings = "?",
					   colClasses=classes,
					   nrows=2075270)
data <- tmpTable[(tmpTable$Date=="1/2/2007")|
				 (tmpTable$Date=="2/2/2007"),]
rm(classes, dataFile, tmpTable)
data$DateTime <- strptime(
					paste(as.character(data$Date), 
						  as.character(data$Time)),
					"%d/%m/%Y %H:%M:%S")

## Perform plotting
png(file="plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
# Plot 1 - Upper Left
plot(data$DateTime, 
	 data$Global_active_power,
	 pch=NA,
	 xlab="",
	 ylab="Global Active Power",
	 type="n")
lines(data$DateTime, data$Global_active_power)

# Plot 2 - Upper Right (because mfrow)
plot(data$DateTime, 
	 data$Voltage,
	 pch=NA,
	 xlab="datetime",
	 ylab="Voltage",
	 type="n")
lines(data$DateTime, data$Voltage)

# Plot 3 - Lower Left
plot(data$DateTime, 
	 data$Sub_metering_1,
	 pch=NA,
	 xlab="",
	 ylab="Energy sub metering",
	 type="n")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col="#FF0000")
lines(data$DateTime, data$Sub_metering_3, col="#0000FF")
legend("topright",
	   legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
	   lwd = 1,
	   bty = "n",
	   col = c("#000000", "#FF0000", "#0000FF"))

# Plot 4 - Lower Right
plot(data$DateTime, 
	 data$Global_reactive_power,
	 pch=NA,
	 xlab="datetime",
	 ylab="Global_reactive_power",
	 type="n")
lines(data$DateTime, data$Global_reactive_power)
dev.off()
