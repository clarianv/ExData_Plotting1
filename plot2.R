####################################################
# Line graph
####################################################

# 1. get data
elecdata <- read.table(file = "household_power_consumption.txt",skip=66637,nrows= 2880, sep = ";" )
names(elecdata) <- c("Date" ,"Time",
                     "Global_active_power" ,"Global_reactive_power" ,"Voltage","Global_intensity",
                     "Sub_metering_1","Sub_metering_2","Sub_metering_3")
# create new column that has the date/time format
elecdata$datetime <- as.POSIXct(paste(elecdata$Date, elecdata$Time), format="%d/%m/%Y %H:%M:%S") 


# 2. create CONNECTED scatterplot
par(mfcol= c(1,1)) #make sure it uses the default layout
with(elecdata, 
     plot(Global_active_power ~ datetime,  
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))


# 3. copy to PNG file
dev.copy(png, file="plot2.png") #copy to png file
dev.off() #close png device


