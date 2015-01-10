#This is the first of 4 scripts for Coursera's Exploratory Data Analysis course Project 1

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

#CREATING PLOT 1
#Plot 1 is a histogram of the Global Active Power data

#Dimensions are 480x480 as indicated in the project instructions
png(file="plot1.png", width=480, height=480)

#The background is set to be transparent as the reference image's background is transparent when viewed outside of the browser e.g saved to my computer and viewed with an image viewer.
#If it were required to produce a white background instead of a transparent one, one would simply delete this call to par() and specify no background color such that the default value of white is selected.
par(bg="transparent")

#The color of the graph was determined by parsing out the rgb values of one of the columns in the histogram using the tool found at http://www.ginifab.com/feeds/pms/pms_color_in_image.php
hist(x=hpc.data$Global_active_power, col="#ff2500", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#closing graphics device
dev.off()

