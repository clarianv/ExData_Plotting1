####################################################
# Three Line graphs in one chart
####################################################

# 1. get data
elecdata <- read.table(file = "household_power_consumption.txt",skip=66637,nrows= 2880, sep = ";" )
names(elecdata) <- c("Date" ,"Time",
                     "Global_active_power" ,"Global_reactive_power" ,"Voltage","Global_intensity",
                     "Sub_metering_1","Sub_metering_2","Sub_metering_3")
# create new column that has the date/time format
elecdata$datetime <- as.POSIXct(paste(elecdata$Date, elecdata$Time), format="%d/%m/%Y %H:%M:%S") 


# 2. create three CONNECTED scatterplots in one graph
# 2.a. submetering 1 - line ; black (default)
# 2.b. submetering 2 - line ; red
# 2.c. submetering 3 - line ; black
par(mfcol= c(1,1)) #make sure it uses the default layout
with(elecdata, 
     plot(Sub_metering_1 ~ datetime,  
          type = "l",
          ylab = "Energy sub metering"))
with(elecdata,
     lines(Sub_metering_2 ~ datetime,col="red"))
with(elecdata,
     lines(Sub_metering_3 ~ datetime,col="blue"))


legend("topright",
       col=c("black","blue","red"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, 
       cex=0.8) 

#lty as in line type can be:
#0=blank, 1=solid (default), 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash


# 3. copy to PNG file
dev.copy(png, file="plot3.png") #copy to png file
dev.off() #close png device


