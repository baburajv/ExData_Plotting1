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

#use png to crete png image, set borders
png(".\\plot1.png",width = 480, height = 480, units = "px")

#draw histogram
hist(as.numeric(powerconsumption_to_plot$global_active_power), col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

#cleanup
dev.off()
rm(powerconsumption_to_plot)
