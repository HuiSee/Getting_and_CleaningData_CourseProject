
## Step0: Read all files ##
filepath <- "F:\\Coursea\\03. Cleansing Data\\Course Project\\UCI HAR Dataset"

## read features files ##
datax_train <- read.table(file.path(filepath, "train", "X_train.txt"), head=FALSE)
datax_test <- read.table(file.path(filepath, "test", "X_test.txt"), head=FALSE)

## read activity files ##
datay_train <- read.table(file.path(filepath, "train", "y_train.txt"), head=FALSE)
datay_test <- read.table(file.path(filepath, "test", "y_test.txt"), head=FALSE)

## read subject files ##
datasubject_train <- read.table(file.path(filepath, "train", "subject_train.txt"), head=FALSE)
datasubject_test <- read.table(file.path(filepath, "test", "subject_test.txt"), head=FALSE)

## read features file ##
features <- read.table(file.path(filepath, "features.txt"), head=FALSE)

## read activity file ##
activity <- read.table(file.path(filepath, "activity_labels.txt"), head=FALSE)


## Step1:  Merges the training and the test sets to create one data set ##

## combined respective data by rows ##
datafeatures <- rbind(datax_train, datax_test)
dataactivity <- rbind(datay_train, datay_test)
datasubject <- rbind(datasubject_train, datasubject_test)

## names variables ##
names(datafeatures) <- features$V2
names(dataactivity) <- c("activity")
names(datasubject) <- c("subject")

## combined all data ##
allData <- cbind(datafeatures, datasubject, dataactivity)


## Step2: Extracts only the measurements on the mean and standard deviation for each measurement ##
## get columns name with either mean or std ##
featuresnames <- features$V2[grep("(mean|std)\\(\\)", features$V2)]

##subset selected names rows ##
selectednames <- c(as.character(featuresnames), "subject", "activity")

## get subset data that contains above ##
selectedData <- allData[,selectednames]


## Step3:  Uses descriptive activity names to name the activities in the data set ##
selectedData$activity <- activity[selectedData$activity,2]


## Step4: Appropriately labels the data set with descriptive variable names ##
names(selectedData) <- gsub("^t","time",names(selectedData))
names(selectedData) <- gsub("^f", "frequency",names(selectedData))
names(selectedData) <- gsub("BodyBody","Body",names(selectedData))

## get mean and write table to tidydata ##
library(plyr);
Data<-aggregate(. ~subject + activity, selectedData, mean)
Data<-Data[order(Data$subject,Data$activity),]
write.table(Data, file.path(filepath, file = "tidydata.txt"), row.name=FALSE)
