source("read_power_data.R")

library(data.table)

plot4 <- function() {
        
        if(!(exists("energyDT"))) read_power_data()
        par(mfrow = c(2,2))
        with(dtsub,{
                plot(datetime,Global_active_power, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")
                plot(datetime,Voltage, type = "l",xlab = "datetime",ylab = "Voltage")
                plot(datetime,Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
                points(datetime,Sub_metering_2,col = "red", type = "l")
                points(datetime,Sub_metering_3,col = "blue",type = "l")
                legend("topright",lwd = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
                plot(datetime,Global_reactive_power, type = "l",xlab = "datetime")
        })
        dev.copy(png, file = "plot4.png",width=480,height=480)
        dev.off()
}
