# the plot2 script will take a set of energy data residing in the energyDT
# and convert the Global_active_power into a plot by the date and time.

require(data.table)

plot2 <- function() {

	# check to see if the energyDT data.table exists. If
	# it doesn't, then call the read_power_data function
	# to create it.  
	if(!(exists("energyDT"))) read_power_data()

	# set the plotting device to be a png.  It is height and 
	# width of 480.
	png(filename = "plot2.png",width=480,height=480,type = "cairo")

	# In case the rows for plotting have changed, set it
	# so one graph will be drawn.
	par(mfrow = c(1,1))

	# using the energyDT data, create a line plot.
	with(energyDT,plot(datetime,Global_active_power, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))

	# Close out the plotting device.
	dev.off()     
}


# This would make more sense to have this code in a 
# seperate file to source.  However after reading some concerns
# of other students, it has been added to each script.
# The read_power_data function is responsible for
# getting the raw data from the household_power_consumption.txt
# file, and manipulating it to be used with the plotting.

read_power_data <- function(){
	
	# If the file doesn't exist in the local working
	# directory, get the zip file and unpack it. If
	# there is an error unzipping the file then stop.

	if (!(length(list.files(".",pattern = "^household_power_consumption.txt$")) > 0)) {
		if (!(get_zip_data())) {
			stop("Can't get zip data")
		}
	}
	
	# first read in the file, and subset the data by Feburary 1st and 2nd 2007.

	dtfile<- fread("household_power_consumption.txt", na.strings = "?")
	dtsub <- subset(dtfile, Date == '1/2/2007' | Date == '2/2/2007')
	rm(dtfile)

	# convert the columns to numeric.  The fread function has
	# some problems doing this automatically.

	dtsub <- dtsub[,Global_active_power:=as.numeric(Global_active_power)]
	dtsub <- dtsub[,Global_reactive_power:=as.numeric(Global_reactive_power)]
	dtsub <- dtsub[,Voltage:=as.numeric(Voltage)]
	dtsub <- dtsub[,Global_intensity:=as.numeric(Global_intensity)]
	dtsub <- dtsub[,Sub_metering_1:=as.numeric(Sub_metering_1)]
	dtsub <- dtsub[,Sub_metering_2:=as.numeric(Sub_metering_2)]
	dtsub <- dtsub[,Sub_metering_3:=as.numeric(Sub_metering_3)]
	dtsub <- cbind(dtsub, datetime = as.POSIXct(strptime(paste(dtsub$Date,dtsub$Time), format = '%d/%m/%Y %H:%M:%S')))

	# set data into the enerygDT variable, so all of the plot
	# functions can use it.
	energyDT <<- dtsub
	rm(dtsub)
}


# The get_zip_data function simple downloads and unzips the file 
# needed for this assignment.
get_zip_data <- function() {

	# set down load file
	destURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(destURL,"./powerconsump.zip")
       
	# unzip the file
	unzip("./powerconsump.zip")
	file.remove("./powerconsump.zip")

	# if the file doesn't exist after download ans unzip return FALSE.
	if (!(length(list.files(".",pattern = "^household_power_consumption.txt$")) > 0)) {
		return(FALSE)
	} else {
		return(TRUE)
	}
}

