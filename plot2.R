## assume that the data file is already downloaded and in current folder
# selective loading rows using a pipe with grep
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';', stringsAsFactors = F, na.strings = "?")
# load column names in first row
colnames(data) <- names(read.table('household_power_consumption.txt', header = TRUE, sep = ";", nrows=1))
#add DateTime column, parse date and time to POSIX format with strptime 
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
#open png device
png("plot2.png", width=480, height=480)
#create plot, type "l" for line
x = data$DateTime 
y = data$Global_active_power
with(data, plot(x, y,  xlab = "", ylab = "Global Active Power (kilowatts)", main= "", type = "l")) 
# close device
dev.off()
