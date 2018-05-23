# read the csv file.
# pre-requisite: download the file from the given URL, unzip it and make it available in the working folder
powerconsumption<- read.csv(".\\household_power_consumption.txt", 
                            sep=";",
                            header=T,
                            na.strings="?")

# set the column names in all lower letters.
colnames(powerconsumption)<-c("date", "time", "global_active_power", "global_reactive_power", "voltage","global_intensity","sub_metering_1", "sub_metering_2", "sub_metering_3")

# set yyyy-mm-dd date format
powerconsumption$date <- as.Date(powerconsumption$date, format="%d/%m/%Y")

#filter the data that is required for this assignment.
powerconsumption_to_plot <- subset(powerconsumption, 
                                   subset =(date >= "2007-02-01" & date <="2007-02-02"))
#remove the unwanted object
rm(powerconsumption)

#combine date and time
powerconsumption_to_plot$datetime <- strptime(
    paste(powerconsumption_to_plot$date, powerconsumption_to_plot$time), "%Y-%m-%d %H:%M:%S")

datetime                <- powerconsumption_to_plot$datetime
energy_sub_metering_1   <- powerconsumption_to_plot$sub_metering_1
energy_sub_metering_2   <- powerconsumption_to_plot$sub_metering_2
energy_sub_metering_3   <- powerconsumption_to_plot$sub_metering_3

#use png to crete png image, set borders
png(".\\plot3.png",width = 480, height = 480, units = "px")

#plot
plot(
    datetime,
    energy_sub_metering_1,
    type="l",
    ylab="Energy sub metering", 
    xlab=""
)

lines( 
    datetime,
    energy_sub_metering_2,
    type="l",
    col = "red"
    )


lines( 
    datetime,
    energy_sub_metering_3,
    type="l",
    col = "blue"
)

legend("topright", 
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        col= c("black","red","blue"),
        lty=1, 
        lwd=2
      )


#cleanup
dev.off()
rm(powerconsumption_to_plot)



