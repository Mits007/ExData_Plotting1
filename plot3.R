plot3<-function(){
    
    # code to calculate the # of rows to be skipped
    start_date = as.Date("17/12/2006", "%d/%m/%Y")
    end_date = as.Date("01/02/2007", "%d/%m/%Y")
    num_days = as.numeric(end_date - start_date)
    start_time = strptime("17:24:00", "%H:%M:%S")
    end_time = strptime("23:59:00", "%H:%M:%S")
    num_rows = as.numeric(difftime(end_time, start_time, units = "min")) + 1
    skip_rows = num_days * 24* 60 + num_rows
    # end of code to claculate # of rows to be skipped
    
    # read the headers
    headers = read.table("./household_power_consumption.txt", sep = ";", 
                         header = TRUE, nrows = 1)
    
    # read the required data ( 2007-02-01 to 2007-02-02)
    data_file = read.table("./household_power_consumption.txt", 
                           header = FALSE, sep = ";", skip = skip_rows+1, 
                           nrows = 2880, na.strings = "?", 
                           stringsAsFactors = FALSE)
    
    names(data_file) = names(headers)
    # create a new column with given date and time, convert the time in 
    # POSIXt format
    data_file$Time2 = paste(data_file$Date, data_file$Time)
    data_file$Time2 = strptime(data_file$Time2, "%d/%m/%Y %H:%M:%S")
    # plot the graph
    png("./plot3.png")
    x<-data_file$Time2
    y<-data_file$Sub_metering_1
    plot(x, y, type = "n", xlab = "", ylab = "Energy Sub Metering")
    points(x, data_file$Sub_metering_1, type = "l", col = "black")
    points(x, data_file$Sub_metering_2, type = "l", col = "red")
    points(x, data_file$Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2",
                                  "Sub_metering_3"), )
    dev.off()
}