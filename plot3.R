source("read_power_data.R")

library(data.table)

plot3 <- function() {
        
        if(!(exists("energyDT"))) read_power_data()
        par(mfrow = c(1,1))
        with(dtsub,plot(datetime,Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
        with(dtsub,points(datetime,Sub_metering_2,col = "red", type = "l"))
        with(dtsub,points(datetime,Sub_metering_3,col = "blue",type = "l"))
        legend("topright",lwd = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), text.font = 1)
        dev.copy(png, file = "plot3.png",width=480,height=480)
        dev.off() 
}
