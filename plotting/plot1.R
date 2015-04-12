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

##
##  For each plot you should
##  •Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
##  •Name each of the plot files as plot1.png, plot2.png, etc.
##  •Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file.
##  •Add the PNG file and R code file to the top-level folder of your git repository (no need for separate sub-folders)
##
makeplot1 <- function(gooddata)
{
  png("plot1.png", height=480, width=480)
  hist(gooddata$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
  dev.off()
}

gooddata = loaddata()
makeplot1(gooddata)