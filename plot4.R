#This is the second of 4 scripts for Coursera's Exploratory Data Analysis course Project 1.

#The object of this and the other three scripts is to reproduce plots using a dataset from the UC Irvine Machine Learning Repository about Electric Power Consumption.  The data is downloaded directly from the Coursera exdata-010 project 1 site.


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

#data frame is cleaned when datetime vector is added; original Date and Time character vectors are left for comparison

#CREATING PLOT 4
#Plot 4 is a combination of multiple plots; the two in the first column are two which have been created already (plot2 and plot3, respectively).  The two in the other column are time-series data plots of Voltage and Global Reactive Power.

#opening graphics device
#setting width and length to 480 as indicated in project instruction
png(file="plot4-504.png", width=504, height=504)

#setting global parameters
#Downloading and viewing plot4 with an alternate image viewer shows the plot with a transparent background.
par(bg="transparent", mfcol=c(2,2))

#creating first plot
with(hpc.data, plot(y=Global_active_power, x=datetime, type="l", xlab="", ylab="Global Active Power"))

#The color of the graph was determined by parsing out the rgb values using the tool found at http://www.ginifab.com/feeds/pms/pms_color_in_image.php
#creating second plot
with(hpc.data, plot(y=Sub_metering_1, x=datetime, type="l", col="black", xlab="", ylab="Energy sub metering"))
with(hpc.data, lines(y=Sub_metering_2, x=datetime, col="#ff2500"))
with(hpc.data, lines(y=Sub_metering_3, x=datetime, col="#0230ff"))
legend("topright", legend=grep("Sub_*", names(hpc.data), value=TRUE), col=c("black", "#ff2500", "blue"), lty=1, bty="n")

#creating third plot
with(hpc.data, plot(y=Voltage, x=datetime, type="l"))

#creating fourth plot
with(hpc.data, plot(y=Global_reactive_power, x=datetime, type="l"))

#closing graphics device
dev.off()