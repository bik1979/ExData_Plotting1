## assume that the data file is already downloaded and in current folder
# selective loading rows using a pipe with grep
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';', stringsAsFactors = F, na.strings = "?")
# load column names in first row
colnames(data) <- names(read.table('household_power_consumption.txt', header = TRUE, sep = ";", nrows=1))
#add DateTime column, parse date and time to POSIX format with strptime 
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
#open png device
png("plot3.png", width=480, height=480)
# plot lines 
x = data$DateTime 
with(data, plot(x, data$Sub_metering_1,  xlab = "", ylab = "Energy sub mettering", main= "", type = "l")) 
lines(x, data$Sub_metering_2, col = "red")
lines(x, data$Sub_metering_3, col = "blue")
# plot legend
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_mettering_1", "Sub_mettering_2", "Sub_mettering_3"))
# close device
dev.off()
