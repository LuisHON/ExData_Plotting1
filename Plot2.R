############# downloading de file dataset

# setting the working directory
setwd("C:/Users/LHON/Desktop/Coursera/Data Science/4_Exploratiry Analisys/1ª Semana/Quiz 1/")

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

# Global Active Power (kilowatts) per DateTime 

# reading the dataset
# na.strings = "?" to remove de na values.
dataset = read.csv(file = DataEnd, header = TRUE, sep = ";", na.strings = "?")

# To convert the Dates chr to Date objects
# X = strptime(x = "Dataset", format = "%d/%m/%Y", )

dataset$Date = as.Date(dataset$Date, format = "%d/%m/%Y")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# The dates in dataset are in 1/2/2007 and 2/2/2007 format.

# Subset the values with select function from Dplyr
Quiz_1B = select(filter(dataset, Date == "2007-2-1" | Date == "2007-2-2"), Date:Sub_metering_3)

# Quiz_1B = mutate(Quiz_1B, DateTime = paste(Date, Time, sep = " "))
# Quiz_1B receive a new column named DateTime, with a Date-Time POSIXlt format
# with "Year-month-day Hour-Minute-Second"
Quiz_1B = mutate(Quiz_1B, DateTime = strptime(paste(Date, Time, sep = " "), format = "%Y-%m-%d %H:%M:%S"))

# open the graphic device
png("plot2.png", width=480, height=480)

plot(Quiz_1B$DateTime, Quiz_1B$Global_active_power, type = "l",
     ylab = "Global Active Power (Killowatts)",
     xlab = " ")

# close the graphic device and turn the RStudioGD (2) (default) - 
# the main device
dev.off()
