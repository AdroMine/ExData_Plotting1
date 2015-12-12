#Creating Plot 2

library(data.table) # Using dataTable package for reading the data.

#Creating classes for the data to be read to speed up process.
classes <- c(rep("char",2),rep("numeric",7))

#Read data
df <- fread(input = "household_power_consumption.txt",sep = ";",header = TRUE,na.strings = "?",colClasses = classes) #na.strings works in latest version 1.9.6, did not work properly in older versions, where the numeric would get coerced into character classes because of ?

#Define date margins
t1 <- as.Date("2007-02-01")
t2 <- as.Date("2007-02-02")

#Convert Date to date format
df[,Date:=as.Date(Date,"%d/%m/%Y")]

#Extract subset
dt <- df[Date %in% t1:t2]

#Create new column for the combined date and time as a single object.
dt[,datetime:=as.POSIXct(paste(Date,Time))]

#Drawing the plot
png(filename = "plot2.png",width = 480,height = 480,units = "px")
plot(dt$datetime,dt$Global_active_power,ylab="Global Active Power(kilowatts)",xlab="",type="l")
dev.off()