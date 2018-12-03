####################################################
# Four Charts in one page
####################################################


#------------------------------------
# functions
#------------------------------------

getElecData <- function()
{
  elecdata <- read.table(file = "household_power_consumption.txt",skip=66637,nrows= 2880, sep = ";" )
  names(elecdata) <- c("Date" ,"Time",
                       "Global_active_power" ,"Global_reactive_power" ,"Voltage","Global_intensity",
                       "Sub_metering_1","Sub_metering_2","Sub_metering_3")
  # create new column that has the date/time format
  elecdata$datetime <- as.POSIXct(paste(elecdata$Date, elecdata$Time), format="%d/%m/%Y %H:%M:%S") 
  
  elecdata
}


plot_active_power <- function()
{
  with(elecdata, 
       plot(Global_active_power ~ datetime,  
            type = "l",
            xlab = "",
            ylab = "Global Active Power"))
}

plot_voltage <- function()
{
  with(elecdata, 
       plot(Voltage ~ datetime,  
            type = "l",
            xlab = "",
            ylab = "Voltage"))
}

plot_submetering <- function()
{
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
         bty = "n",
         cex=0.8) 
  
  #lty as in line type can be:
  #0=blank, 1=solid (default), 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash
}

plot_reactive_power <- function()
{
  with(elecdata, 
       plot(Global_reactive_power ~ datetime,  
            type = "l",
            xlab = ""))
}


copyToPng <- function(filename)
{
  dev.copy(png, file=filename) #copy to png file
  dev.off() #close png device
}





#------------------------------------
# main
#------------------------------------

# 1. get data
elecdata <- getElecData()

# 2. setup up page that would contain 4 charts:
par(mfcol= c(2,2)) #plot starting from top to bottom, then left to right

# 3. plot the 4 graphs:
plot_active_power()
plot_submetering()
plot_voltage()
plot_reactive_power()

# 4. Copy to png
copyToPng("plot4.png")