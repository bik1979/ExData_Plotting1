## assume that the data file is already downloaded and in the same folder
# data file could also be downloaded and unzipped in R using download.file() and unzip() commands
# selective loading rows using a pipe with grep
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';', stringsAsFactors = F, na.strings = "?")
# load column names in first row
colnames(data) <- names(read.table('household_power_consumption.txt', header = TRUE, sep = ";", nrows=1))
#open png device
png("plot1.png", width=480, height=480)
# generate histogram plot
hist(data$Global_active_power, breaks = 12, col = "red", xlab = "Global Active Power (kilowatts)", main= "Global Active Power")
# close device
dev.off()
