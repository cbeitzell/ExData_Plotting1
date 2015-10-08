source("read_power_data.R")

library(data.table)

plot3 <- function() {
        
        if(!(exists("energyDT"))) read_power_data()
        png(filename = "plot3.png",width=480,height=480,type = "windows")
        par(mfrow = c(1,1))
        with(energyDT,plot(datetime,Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
        with(energyDT,points(datetime,Sub_metering_2,col = "red", type = "l"))
        with(energyDT,points(datetime,Sub_metering_3,col = "blue",type = "l"))
        legend("topright", lwd = 1,col = c("black","red","blue"), legend = c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "))
        dev.off() 
}
