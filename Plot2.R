## set the working directory
setwd("/Users/Haijie/data_sciences/Chapitre_3")

## Check if the data folder exists and create a new directory
if (!exists("./data")){
        dir.create("data")
}

## download the zip file and rename it
downFile<-"./data/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(downFile)){
        downURL<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(downURL,downFile)
}

## zipped the data file
if(!file.exists("./data/household_power_consumption.txt")){ 
        unzip(downFile,exdir="./data")
}

## read Data 
colClasses<-c(rep.int("character",2),rep.int("numeric",7))
ElecCon<-read.table("./data/household_power_consumption.txt",
                    header = TRUE,
                    sep=";",
                    na.strings = "?",
                    colClasses=colClasses)

## subset the two days : 2007-02-01 and 2007-02-02
library(dplyr)
Elec<-filter(ElecCon,Date=="1/2/2007"|Date=="2/2/2007")

## convert the "Date" column to the right class
Elec$Date<-as.Date(Elec$Date,"%d/%m/%Y")

## Convert the "Time" colum to the right class
Elec$Time<-strptime(paste(Elec$Date,Elec$Time),"%Y-%m-%d %H:%M:%S")

## draw the canvas
library(datasets)
with(Elec,plot(Time,Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)"))

## copy my plot to a PNG file
dev.copy(png,file="plot2.png")

## Close the PNG device
dev.off()

