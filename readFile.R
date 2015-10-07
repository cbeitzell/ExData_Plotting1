dtfile<- fread("household_power_consumption.txt",colClasses = c(Date="character",Time="character",Global_active_power="numeric",Global_reactive_power="numeric",Voltage="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric"))
dtsub <- subset(dtfile, Date == '1/2/2007' | Date == '2/2/2007')
rm(dtfile)

hist(as.numeric(dtsub$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)")

with(dtsub,plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Global_active_power, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))

with(dtsub,plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(dtsub,points(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_2,col = "red", type = "l"))
with(dtsub,points(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_3,col = "blue",type = "l"))
legend("topright",lwd = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2,","Sub_metering_3"))

par(mfrow = c(2,2))
with(dtsub,{
        plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Global_active_power, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")
        plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Voltage, type = "l",xlab = "datetime",ylab = "Voltage")
        plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        points(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_2,col = "red", type = "l")
        points(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_3,col = "blue",type = "l")
        legend("topright",lwd = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2,","Sub_metering_3"))
        plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Global_reactive_power, type = "l",xlab = "datetime")
})
