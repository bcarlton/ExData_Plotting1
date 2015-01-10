#This is the second of 4 scripts for Coursera's Exploratory Data Analysis course Project 1

#The object of this and the other three scripts is to reproduce plots using a dataset from
#UC Irvine Machine Learning Repository about Electric Power Consumption.  The data is downloaded
#directly from the Coursera exdata-010 project 1 site.


##READING IN AND CLEANING DATA SET
#Only data from the dates(Y-m-d) 2007-02-01 and 2007-02-02 will be used
setwd("~/R/EDA")

#read in only necessary data
#nrows and skip parameters are hard coded in after being determined from the following code, which I am not executing for the purposes of efficiency
# setwd("~/R/EDA/")
# datelist <- system("cut -f1 -d ';' household_power_consumption.txt", intern=TRUE)
# mydates <- grep("^[12]/2/2007", datelist)
# skipnum <- mydates[1] - 1
# endnum <- mydates[length(mydates)]+1
hpc.data <- read.table(file="household_power_consumption.txt", sep=";", header=FALSE, stringsAsFactors=FALSE, na.strings="?", skip=66637, nrows=69518-66638)

#reading file again to produce names for data
names(hpc.data) <- read.table(file="household_power_consumption.txt", sep=";", stringsAsFactors=FALSE, nrows=1)

#combining Date and Time fields to produce a single datetime variable
#Note that original source dates are in %d/%m/%Y format
hpc.data$datetime <- strptime(paste(hpc.data$Date, hpc.data$Time), format="%d/%m/%Y %H:%M:%S")

#data frame is cleaned when datetime vector is added

#CREATING PLOT 2
#Plot 2 is a line-connected time-series plot of the Global Active Power.  The x-axis only shows the day of the week.

#Dimensions are 480x480 as indicated in the project instructions
png(file="plot2.png", width=480, height=480)

#The background is set to be transparent as the reference image's background is transparent when viewed outside of the browser e.g saved to my computer and viewed with an image viewer.
#If it were required to produce a white background instead of a transparent one, one would simply delete this call to par() and specify no background color such that the default value of white is selected.it
par(bg="transparent")

with(hpc.data, plot(y=Global_active_power, x=datetime, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

#closing graphics device
dev.off()