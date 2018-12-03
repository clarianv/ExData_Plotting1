####################################################
# Historgram
####################################################

# 1. get data
elecdata <- read.table(file = "household_power_consumption.txt",skip=66637,nrows= 2880, sep = ";" )
names(elecdata) <- c("Date" ,"Time" ,
             "Global_active_power" ,"Global_reactive_power" ,"Voltage","Global_intensity",
             "Sub_metering_1","Sub_metering_2","Sub_metering_3")

# 2. create histogram
par(mfcol= c(1,1)) #make sure it uses the default layout
hist(x = elecdata$Global_active_power, 
     col="red", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     main = "Global Active Power")


# 3. copy to PNG file
dev.copy(png, file="plot1.png") #copy to png file
dev.off() #close png device
