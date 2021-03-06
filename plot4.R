## assume that the data file is already downloaded and in current folder
# selective loading rows using a pipe with grep
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';', stringsAsFactors = F, na.strings = "?")
# load column names in first row
colnames(data) <- names(read.table('household_power_consumption.txt', header = TRUE, sep = ";", nrows=1))
#add DateTime column, parse date and time to POSIX format with strptime 
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
#open png device
png("plot4.png", width=480, height=480)
#set multiple plots 2 x 2
par(mfrow = c(2, 2))
# 1.1 global active power
with(data, plot(x, data$Global_active_power,  xlab = "", ylab = "Global Active Power (kilowatts)", main= "", type = "l"))
# 1.2. Voltage
with(data, plot(x, data$Voltage,  xlab = "datetime", ylab = "Voltage", main= "", type = "l"))
# 2.1. Sub metterings
# plot lines 
with(data, plot(x, data$Sub_metering_1,  xlab = "", ylab = "Energy sub mettering", main= "", type = "l")) 
lines(x, data$Sub_metering_2, col = "red")
lines(x, data$Sub_metering_3, col = "blue")
# plot legend
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_mettering_1", "Sub_mettering_2", "Sub_mettering_3"), bty = "n", x.intersp = 1, y.intersp = 1,  xjust = 1, yjust = 0)

# 2.2. global reactive power
# I know the label doesn't match the plot exactly, but I find this label nicer than with the underscores
# If no ylab attribute specified, then ylab would be exactly like in reference plot
with(data, plot(x, data$Global_reactive_power,  xlab = "datetime", ylab = "Global Reactive Power", main= "", type = "l"))
# close device
dev.off()
