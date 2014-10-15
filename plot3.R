## plot3.R
##   This R function creates a PNG file of Submetering 1-3 in the Electric
## power consumption dataset from the UCI Machine Learning website.

plot3 <- function() {
    ## Read database, which is assumed to have been unzipped in the working dir.
    householdPowerConsumption <- read.table("household_power_consumption.txt",
                                            header = TRUE,
                                            sep = ";",
                                            na.strings = "?")
    
    ## Convert date strings to R Date objects to make them easier to work with.
    householdPowerConsumption$Date <- as.Date(householdPowerConsumption$Date,
                                              format = "%d/%m/%Y")
    
    ## Create a data frame containing just the three submetering datasets for 1
    ## and 2 February 2007.
    globalActivePower <- subset(householdPowerConsumption, 
                                Date == "2007-02-01" | Date == "2007-02-02",
                                select = c(Date, Time, Sub_metering_1,
                                           Sub_metering_2, Sub_metering_3))
    
    ## Convert the Date and Time columns to a single DateTime column.
    globalActivePower$DateTime <- strptime(paste(globalActivePower$Date, 
                                                 globalActivePower$Time),
                                           format = "%Y-%m-%d %H:%M:%S")
    
    ## Plot the line plot using the PNG device at default 480 x 480 resolution.
    png("plot3.png")
    plot(globalActivePower$DateTime, globalActivePower$Sub_metering_1,
         main = "",
         xlab = "",
         ylab = "Global Active Power (kilowatts)",
         type = "l")
    lines(globalActivePower$DateTime, globalActivePower$Sub_metering_2,
          col = "red")
    lines(globalActivePower$DateTime, globalActivePower$Sub_metering_3,
          col = "blue")
    dev.off()
    
}