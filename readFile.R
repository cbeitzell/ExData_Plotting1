library(data.table)
#dtfile<- fread("household_power_consumption.txt",colClasses = c(Date="character",Time="character",Global_active_power="numeric",Global_reactive_power="numeric",Voltage="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric"))

read_power_data <- function(){

        if (!(identical(basename(getwd()),"exdata-data-household_power_consumption"))) {
                if (length(list.files(".",pattern = "^exdata-data-household_power_consumption$")) > 0) {
                        setwd("exdata-data-household_power_consumption")
                        if (!(length(list.files(".",pattern = "^household_power_consumption.txt$")) > 0)) {
                                if (!(get_zip_data())) {
                                        stop("Can't get zip data")
                                }
                        }
                } else if (!(length(list.files(".",pattern = "^household_power_consumption.txt$")) > 0)) {
        
                        if (!(get_zip_data())) {
                                stop("Can't get zip data")
                        }
                }
                   
        } else {
                if (!(length(list.files(".",pattern = "^household_power_consumption.txt$")) > 0)) {
                        if (!(get_zip_data())) {
                                stop("Can't get zip data")
                        }
                }
        }
        
        dtfile<- fread("household_power_consumption.txt")
        dtsub <- subset(dtfile, Date == '1/2/2007' | Date == '2/2/2007')
        rm(dtfile)
        dtsub <- dtsub[,Global_active_power:=as.numeric(Global_active_power)]
        dtsub <- dtsub[,Global_reactive_power:=as.numeric(Global_reactive_power)]
        dtsub <- dtsub[,Voltage:=as.numeric(Voltage)]
        dtsub <- dtsub[,Global_intensity:=as.numeric(Global_intensity)]
        dtsub <- dtsub[,Sub_metering_1:=as.numeric(Sub_metering_1)]
        dtsub <- dtsub[,Sub_metering_2:=as.numeric(Sub_metering_2)]
        dtsub <- dtsub[,Sub_metering_3:=as.numeric(Sub_metering_3)]
        dtsub <- cbind(dtsub, datetime = as.POSIXct(strptime(paste(dtsub$Date,dtsub$Time), format = '%d/%m/%Y %H:%M:%S')))
        energyDT <<- dtsub
        rm(dtsub)
}
        
get_zip_data() <- function() {
        destURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(destURL,"./powerconsump.zip")
        unzip("./powerconsump.zip")
        file.remove("./powerconsump.zip")
        if (!(length(list.files(".",pattern = "^household_power_consumption.txt$")) > 0)) {
                return(FALSE)
        } else {
                return(TRUE)
        }
}




par(mfrow = c(1,1))
with(dtsub,hist(Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot1.png",width=480,height=480)
dev.off()


#with(dtsub,plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Global_active_power, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
par(mfrow = c(1,1))
with(dtsub,plot(datetime,Global_active_power, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png",width=480,height=480)
dev.off()

par(mfrow = c(1,1))
with(dtsub,plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(dtsub,points(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_2,col = "red", type = "l"))
with(dtsub,points(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_3,col = "blue",type = "l"))
legend("topright",lwd = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), text.font = 1)
dev.copy(png, file = "plot3.png",width=480,height=480)
dev.off()


par(mfrow = c(2,2))
with(dtsub,{
        plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Global_active_power, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")
        plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Voltage, type = "l",xlab = "datetime",ylab = "Voltage")
        plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        points(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_2,col = "red", type = "l")
        points(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Sub_metering_3,col = "blue",type = "l")
        legend("topright",lwd = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        plot(strptime(paste(Date,Time), format = '%d/%m/%Y %H:%M:%S'),Global_reactive_power, type = "l",xlab = "datetime")
})
dev.copy(png, file = "plot4.png",width=480,height=480)
dev.off()
