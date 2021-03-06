############# downloading de file dataset

# setting the working directory
setwd("C:/Users/LHON/Desktop/Coursera/Data Science/4_Exploratiry Analisys/1� Semana/Quiz 1/")

# end_file = file internet address
end_file = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# using method = "curl" because https gets error whithout.
download.file(url = end_file, destfile = "Quiz1DataSet", method = "curl", )

# unzip files
unzip("Quiz1DataSet.zip", exdir = "Quiz1_Plot")

# getting the working directory
FileDir = getwd()

# the name of the dataset txt file 
# &
# the path of the dataset txt file
DataEnd = paste(FileDir, list.files(path = paste(FileDir, "/Quiz1_Plot", sep = ""), pattern = ".txt"), sep = "/")
#################################################################################################

# to load more than one package at time
library(easypackages)

# libraries()
libraries("tidyr", "dplyr", "lattice", "ggplot2")

#################################################################################################

# reading the dataset
# na.strings = "?" to remove de na values.
dataset = read.csv(file = DataEnd, header = TRUE, sep = ";", na.strings = "?")

# To convert the Dates chr to Date objects
# X = strptime(x = "Dataset", format = "%d/%m/%Y", )

dataset$Date = as.Date(dataset$Date, format = "%d/%m/%Y")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# The dates in dataset are in 1/2/2007 and 2/2/2007 format.

# Subset the values with select function from Dplyr
Quiz_1C = select(filter(dataset, Date == "2007-2-1" | Date == "2007-2-2"), Date:Sub_metering_3)

# Quiz_1C = mutate(Quiz_1C, DateTime = paste(Date, Time, sep = " "))
# Quiz_1C receive a new column named DateTime, with a Date-Time POSIXlt format
# with "Year-month-day Hour-Minute-Second"
Quiz_1C = mutate(Quiz_1C, DateTime = strptime(paste(Date, Time, sep = " "), format = "%Y-%m-%d %H:%M:%S"))


# open the graphic device
png("plot3.png", width=480, height=480)


with(Quiz_1C, {
     plot(x = DateTime, y = Sub_metering_1, type = "l", 
          xlab = " ", ylab = " Energy sub metering")
     
     lines(DateTime, Sub_metering_2, col ="red")
     
     lines(DateTime, Sub_metering_3, col="blue")
     
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     
})

# close the graphic device and turn the RStudioGD (2) (default) - 
# the main device
dev.off()
