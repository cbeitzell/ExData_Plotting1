# The read_power_data script contains the code to get, read int, and
# manipulate data found in the household_power_consumption.txt
# file.  The resulting data will be a data.table called energyDT.
source("read_power_data.R")

library(data.table)

plot1 <- function() {

        # check to see if the energyDT data.table exists. If
        # it doesn't, then call the read_power_data function
        # to create it.  The read_power_data function resides
        # in the read_power_data.R script.
        if(!(exists("energyDT"))) read_power_data()
        
        # set the plotting device to be a png.  It is height and 
        # width of 480.
        png(filename = "plot1.png",width=480,height=480,type = "windows")
        
        # In case the rows for plotting have changed, set it
        # so one graph will be drawn.
        par(mfrow = c(1,1))
        
        # Using the energyDT data, create a histogram for the Global 
        # Active Power variable.
        with(energyDT,hist(Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)"))
        
        # Close out the plotting device.
        dev.off()        
}


