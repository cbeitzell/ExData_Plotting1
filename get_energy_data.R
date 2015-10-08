library(data.table)

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