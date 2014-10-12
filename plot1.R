## plot1.R
##   This R function creates a PNG file of Global Active Power from the Electric
## power consumption dataset from the UCI Machine Learning website.

plot1 <- function() {
    ## Read database, which is assumed to have been unzipped in the working dir.
    householdPowerConsumption <- read.table("household_power_consumption.txt",
                                            header = TRUE,
                                            sep = ";",
                                            na.strings = "?")
    
    ## Convert date strings to R Date objects to make them easier to work with.
    householdPowerConsumption$Date <- as.Date(householdPowerConsumption$Date,
                                              format = "%d/%m/%Y")
    
    ## Create a data frame containing just the Global Active Power for 1 and 2
    ## February 2007.
    globalActivePower <- subset(householdPowerConsumption, 
                                Date == "2007-02-01" | Date == "2007-02-02",
                                select = Global_active_power)
    
    ## Plot the histogram using the PNG device at default 480 x 480 resolution.
    png("plot1.png")
    hist(globalActivePower$Global_active_power,
         main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)",
         col = "red")
    dev.off()
    
}