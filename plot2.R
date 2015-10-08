source("read_power_data.R")

library(data.table)

plot2 <- function() {
        
        if(!(exists("energyDT"))) read_power_data()
        png(filename = "plot2.png",width=480,height=480,type = "windows")
        par(mfrow = c(1,1))
        with(energyDT,plot(datetime,Global_active_power, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
        dev.off()     
}
