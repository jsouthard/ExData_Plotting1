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

## Perform plotting
png(file="plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, 
	 col="#FF0000",
	 main="Global Active Power",
	 xlab="Global Active Power (kilowatts)") 
dev.off()
