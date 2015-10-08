source("read_power_data.R")

library(data.table)

plot1 <- function() {

        if(!(exists("energyDT"))) read_power_data()
        par(mfrow = c(1,1))
        with(energyDT,hist(Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)"))
        dev.copy(png, file = "plot1.png",width=480,height=480)
        dev.off()        
}


