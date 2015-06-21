##Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
##Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
##Support Vector Machine. International Workshop of Ambient Assisted Living 
##(IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

##This loads the files from the UCI HAR dataset and then reshapes, renames 
##and concatenates the data and loads it into a tidy dataset

library(dplyr)
library(reshape2)
##loads the training data files.  The directory from the UCI HAR dataset should 
##be in the same directory where run_analysis.R is located

## Loads the X_train.txt into traindata
traindata <- read.table("train/X_train.txt")
##loads the features.txt file and uses it to name the columns of traindata
featurelist <- read.table("features.txt")
colnames(traindata) <- featurelist[,2]

##removes all columns that do not have mean average or standard deviation data
traindata <- traindata[, grep("mean|std", colnames(traindata))]

##Loads two new columns which are added to traindata. Action_ID identifies the 
##action and Person_ID identifies the person performing the test
Action_ID <- read.table("train/y_train.txt")
Person_ID <- read.table("train/subject_train.txt")
traindata <- cbind(Action_ID, Person_ID, traindata)

## Names the two new columns
colnames(traindata)[1] <- "Action_ID"
colnames(traindata)[2] <- "Person_ID"

## Loads the X_train.txt into testdata
testdata <- read.table("test/X_test.txt")
##loads the features.txt file and uses it to name the columns of testdata

featurelist <- read.table("features.txt")
colnames(testdata) <- featurelist[,2]

##removes all columns that do not have mean average or standard deviation data
testdata <- testdata[, grep("mean|std", colnames(testdata))]

##Loads two new columns which are added to testdata. Action_ID identifies the 
##action and Person_ID identifies the person performing the test
Action_ID <- read.table("test/y_test.txt")
Person_ID <- read.table("test/subject_test.txt")
testdata <- cbind(Action_ID, Person_ID, testdata)
## Names the two new columns
colnames(testdata)[1] <- "Action_ID"
colnames(testdata)[2] <- "Person_ID"
## Adds the training and test data sets together into bigdata
bigdata <- rbind(traindata, testdata)

##These rename the Action ID from a number to its corresponding text term
bigdata$Action_ID[bigdata$Action_ID ==1] = "WALKING"
bigdata$Action_ID[bigdata$Action_ID ==2] = "WALKING UPSTAIRS"
bigdata$Action_ID[bigdata$Action_ID ==3] = "WALKING DOWNSTAIRS"
bigdata$Action_ID[bigdata$Action_ID ==4] = "SITTING"
bigdata$Action_ID[bigdata$Action_ID ==5] = "STANDING"
bigdata$Action_ID[bigdata$Action_ID ==6] = "LAYING"

##These change the column names to make them more descriptive and easier to read
colnames(bigdata) <- gsub("-std", "Std", colnames(bigdata))
colnames(bigdata) <- gsub("-mean", "Mean", colnames(bigdata))
colnames(bigdata) <- gsub("[()]", "", colnames(bigdata))
colnames(bigdata) <- gsub("[-]", "", colnames(bigdata))
colnames(bigdata) <- gsub("^f", "Freq", colnames(bigdata))
colnames(bigdata) <- gsub("^t", "Time", colnames(bigdata))

## These commands identify Action ID and Person ID as identifiers and then average the 
##data for each of the readings for both activity and the person being tested
DataShow <- melt(bigdata, id=c("Action_ID","Person_ID"))
DataView <- dcast(DataShow, Action_ID + Person_ID ~ variable,mean)  

##Loads the dataframe into a text file and uses 5 significant digits 
## for each value and then aligns the columns with tab key and removes quotes
DataView <- format(DataView, digits =5)
write.table(DataView, file="DataView.txt",row.names=FALSE,sep="\t\t",quote=FALSE)



