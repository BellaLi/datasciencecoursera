##
##  When loading the dataset into R, please consider the following:
##  •The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
##  •We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
##  •You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
##  •Note that in this dataset missing values are coded as ?.
##
loaddata <- function()
{
  file.rename("household_power_consumption.txt", "household_power_consumption.csv")
  rawdata = read.csv("household_power_consumption.csv", sep = ";")
  
  rawdata$DateTime = paste(rawdata$Date, rawdata$Time, sep=' ')
  rawdata$DateTime = as.POSIXct(strptime(rawdata$DateTime, "%d/%m/%Y %H:%M:%S"))
  
  rawdata$Date = as.Date(rawdata$Date, "%d/%m/%Y")
  
  startdate = as.Date("1/2/2007", "%d/%m/%Y")
  enddate = as.Date("3/2/2007", "%d/%m/%Y")
  filtereddata = filter(rawdata, Date < enddate, Date >= startdate)
  
  return(filtereddata)
}

makeplot4 <- function(gooddata)
{
  png("plot4.png", height=480, width=480)
  
  ## set panel grids
  par(mfrow = c(2,2))
  
  ## plot 1
  with(gooddata, plot(DateTime, Global_active_power, xlab = "", type="l"))
  
  ## plot 2
  with(gooddata, plot(DateTime, Voltage, type="l"))
  
  ## plot 3
  with(gooddata, plot(DateTime, Sub_metering_1, col="black", type="l", xlab = "", ylab="Energy sub meeting"))
  with(gooddata, points(DateTime, Sub_metering_2, col="red", type="l"))
  with(gooddata, points(DateTime, Sub_metering_3, col="blue", type="l"))
  legend("topright", pch = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## plot 4
  with(gooddata, plot(DateTime, Global_reactive_power, type="l"))
  
  ## reset the panel
  par(mfrow = c(1,1))
  dev.off()
}

gooddata = loaddata()
makeplot4(gooddata)