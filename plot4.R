## Course 4, Class Project 1, plot4.R

filep="./data/exdata_data_household_power_consumption/household_power_consumption.txt"
cnames <- c("Date","Time","Global_active_power",
            "Global_reactive_power","Voltage",
            "Global_intensity","Sub_metering_1",
            "Sub_metering_2","Sub_metering_3")

poweruse <- read.table(filep,header=FALSE,
                       col.names=cnames,skip=66637,sep=";",
                       na.strings="?",dec=".", nrows=2880,
                       colClasses=c(rep("character",2),
                                    rep("numeric",7)))

datetime <- paste(poweruse$Date,poweruse$Time,sep=" ")
poweruse <- cbind(datetime,poweruse)
poweruse$dtimeL <- strptime(poweruse$datetime, "%d/%m/%Y %H:%M:%S")

png(file="plot4.png",width=480,height=480)

par(mfrow=c(2,2))
with(poweruse,
     plot(as.POSIXct(dtimeL),Global_active_power,xlab="",
          ylab="Global Active Power",type="l",col="black"))

with(poweruse,
     plot(as.POSIXct(dtimeL),Voltage,xlab="datetime",
          ylab="Voltage",type="l",col="black"))

with(poweruse,
    plot(as.POSIXct(dtimeL),Sub_metering_1,xlab="",
         ylab="Energy sub metering",type="n"))
with(subset(poweruse),
     points(as.POSIXct(dtimeL),
            Sub_metering_1,col="black",type="l"))
with(subset(poweruse),
     points(as.POSIXct(dtimeL),
            Sub_metering_2,col="red",type="l"))
with(subset(poweruse),
     points(as.POSIXct(dtimeL),
            Sub_metering_3,col="blue",type="l"))
legend("topright",col=c("black","red","blue"),lty=1,
       legend=c("Sub_metering_1","Sub_metering_2",
                "Sub_metering_3"))

with(poweruse,
     plot(as.POSIXct(dtimeL),Global_reactive_power,xlab="datetime",
          ylab="Global_reactive_power",type="l",col="black"))

dev.off()

