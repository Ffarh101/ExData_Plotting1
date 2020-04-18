
library("data.table")

# Read file and specify '?' as NA
consumption <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Create a new variable merging the data from Date and Time variables
consumption[, date_time := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Fetch data only for 2007-02-01 to 2007-02-02 in date_time variable
consumption <- consumption[(date_time >= "2007-02-01") & (date_time < "2007-02-03")]

# Open a png device
png("plot2.png", width = 480, height = 480)

# Draw plot
plot(x = consumption[, date_time], y = consumption[, Global_active_power],
     xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

dev.off()
