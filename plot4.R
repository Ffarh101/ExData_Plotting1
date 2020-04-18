
library("data.table")

# Read file and specify '?' as NA
consumption <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Create a new variable merging the data from Date and Time variables
consumption[, date_time := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Fetch data only for 2007-02-01 to 2007-02-02 in date_time variable
consumption <- consumption[(date_time >= "2007-02-01") & (date_time < "2007-02-03")]

# Open a png device
png("plot4.png", width = 480, height = 480)

# Draw plots
par(mfrow=c(2,2))

# Plot 1
plot(x = consumption[, date_time], y = consumption[, Global_active_power], xlab = "", ylab = "Global Active Power", type = "l")

# Plot 2
plot(x = consumption[, date_time], y = consumption[, Voltage], xlab = "datetime", ylab = "Voltage", type = "l")

# Plot 3
plot(x = consumption[, date_time], y = consumption[, Sub_metering_1], xlab = "", ylab = "Energy sub metering", type = "l")
lines(x = consumption[, date_time], y = consumption[, Sub_metering_2], col = "red")
lines(x = consumption[, date_time], y = consumption[, Sub_metering_3], col = "blue")
legend("topright", lty = c(1,1), bty = "n", cex = 0.9, col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")) 

# Plot 4
plot(x = consumption[, date_time], y = consumption[, Global_reactive_power], xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()
