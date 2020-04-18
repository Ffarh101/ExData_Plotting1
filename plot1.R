
library("data.table")

# Read file and specify '?' as NA
consumption <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Convert Date variable to Date format
consumption[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Fetch data only for 2007-02-01 to 2007-02-02 in Date variable
consumption <- consumption[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Open a png device
png("plot1.png", width = 480, height = 480)

# Draw plot
hist(consumption[, Global_active_power], xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main = "Global Active Power", col = "Red")

dev.off()
