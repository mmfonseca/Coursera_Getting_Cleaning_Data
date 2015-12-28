## Getting and Cleaning Data Course Project
##
## The purpose of this project is to demonstrate your ability to collect, work 
## with, and clean a data set. The goal is to prepare tidy data that can be 
## used for later analysis. You will be graded by your peers on a series of 
## yes/no questions related to the project. 
## You will be required to submit: 
## 1) a tidy data set as described below, 
## 2) a link to a Github repository with your script for performing the 
## analysis, and 
## 3) a code book that describes the variables, the data, and any 
## transformations or work that you performed to clean up the data called 
## CodeBook.md. 
## You should also include a README.md in the repo with your scripts. This 
## repo explains how all of the scripts work and how they are connected.
##
## One of the most exciting areas in all of data science right now is wearable
## computing - see for example this article . Companies like Fitbit, Nike, and
## Jawbone Up are racing to develop the most advanced algorithms to attract new
## users. The data linked to from the course website represent data collected 
## from the accelerometers from the Samsung Galaxy S smartphone. 
## A full description is available at the site where the data was obtained: 
##
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## Here are the data for the project: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
##
## You should create one R script called run_analysis.R that does the following. 
## 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
## each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

setwd("/Users/mmfonseca/git/Coursera_Getting_Cleaning_Data")

## destination path for zip file (raw data)
filePathZip <- "./Dataset_Samsung.zip"
## url of file to be downloaded
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## download file only if file does not exits
if (!file.exists(filePathZip)) {        
        download.file(fileUrl, destfile = filePathZip, method = "curl")
        dateDownload <- date()
        show(dateDownload)
        ## [1] "Sun Dec 27 19:01:30 2015"
}

## unzip file
unzip(filePathZip)

## a directory was created named "UCI HAR Dataset". However, I would prefer to
## name the directory as "UCI_HAR_Dataset". So, the first thing I will do is to
## change the directory name:
file.rename("UCI HAR Dataset", "UCI_HAR_Dataset")


## Now, let's start with the 5 steps of the course project:
##
## Dataset
## Source:
## Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca 
## Oneto(1) and Xavier Parra(2)
## 1 - Smartlab - Non-Linear Complex Systems Laboratory
## DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
## 2 - CETpD - Technical Research Centre for Dependency Care and Autonomous 
## Living
## Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú
## (08800), Spain
## activityrecognition '@' smartlab.ws
##
##
## Data Set Information:
##
## The experiments have been carried out with a group of 30 volunteers within 
## an age bracket of 19-48 years. Each person performed six activities 
## (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
## wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded
## accelerometer and gyroscope, we captured 3-axial linear acceleration and 
## 3-axial angular velocity at a constant rate of 50Hz. The experiments have 
## been video-recorded to label the data manually. The obtained dataset has
## been randomly partitioned into two sets, where 70% of the volunteers was 
## selected for generating the training data and 30% the test data. 
##
## The sensor signals (accelerometer and gyroscope) were pre-processed by 
## applying noise filters and then sampled in fixed-width sliding windows of 
## 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration 
## signal, which has gravitational and body motion components, was separated
## using a Butterworth low-pass filter into body acceleration and gravity. 
## The gravitational force is assumed to have only low frequency components, 
## therefore a filter with 0.3 Hz cutoff frequency was used. From each window,
## a vector of features was obtained by calculating variables from the time 
## and frequency domain.




## Step 1. Merges the training and the test sets to create one data set.
##
## both the training and the test sets are organized as follow:
## in each directory there are three txt files:
## subject_test.txt, X_test.txt and y_test.txt
## and one subdirectory named "Inertial Signals"
##
## To execute this step I will use R commands. First, I will upload the files
## of each set, create a directory named "merged" and then I will use the 
## command "write.table" (without and then with the append option) and create 
## the corresponding merged files into it
## 
## Getting training files
## because we do not wnat to keep all table in memory, we will go by each table
## time and then remove them from memory (when the corresponding merged is
## created)
##
## create "merged" directory (that will contain the merged files)
## NOTE: some of the original files start with two character " " and the 
## columns may be separated by one or two " ". However, in the merged files
## the columns will be separated only with one " ".

library(data.table)

if (!file.exists("UCI_HAR_Dataset/merged")) {
        dir.create("UCI_HAR_Dataset/merged")
        dir.create("UCI_HAR_Dataset/merged/Inertial\ Signals")
}

## subject
subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")

write.table(subject_test, file = "UCI_HAR_Dataset/merged/subject_merged.txt",
            append = FALSE, 
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(subject_train, file = "UCI_HAR_Dataset/merged/subject_merged.txt",
            append = TRUE, 
            quote = FALSE, row.names = FALSE, col.names = FALSE)

rm(subject_test,subject_train)

## X
X_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
X_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")

write.table(X_test, file = "UCI_HAR_Dataset/merged/X_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(X_train, file = "UCI_HAR_Dataset/merged/X_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)

rm(X_test,X_train)

## y
y_test <- read.table("UCI_HAR_Dataset/test/y_test.txt")
y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt")

write.table(y_test, file = "UCI_HAR_Dataset/merged/y_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(y_train, file = "UCI_HAR_Dataset/merged/y_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(y_test,y_train)

## Inertial Signals/body_acc_x
body_acc_x_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_x_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/body_acc_x_train.txt")
write.table(body_acc_x_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_x_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(body_acc_x_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_x_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(body_acc_x_test,body_acc_x_train)

## Inertial Signals/body_acc_y
body_acc_y_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_y_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/body_acc_y_train.txt")
write.table(body_acc_y_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_y_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(body_acc_y_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_y_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(body_acc_y_test,body_acc_y_train)

## Inertial Signals/body_acc_z
body_acc_z_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/body_acc_z_test.txt")
body_acc_z_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/body_acc_z_train.txt")
write.table(body_acc_z_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_z_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(body_acc_z_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_z_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(body_acc_z_test,body_acc_z_train)

## Inertial Signals/body_gyro_x
body_gyro_x_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_x_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/body_gyro_x_train.txt")
write.table(body_gyro_x_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_x_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(body_gyro_x_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_x_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(body_gyro_x_test,body_gyro_x_train)

## Inertial Signals/body_gyro_y
body_gyro_y_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_y_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/body_gyro_y_train.txt")
write.table(body_gyro_y_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_y_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(body_gyro_y_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_y_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(body_gyro_y_test,body_gyro_y_train)

## Inertial Signals/body_gyro_z
body_gyro_z_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/body_gyro_z_test.txt")
body_gyro_z_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/body_gyro_z_train.txt")
write.table(body_gyro_z_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_z_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(body_gyro_z_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_z_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(body_gyro_z_test,body_gyro_z_train)

## Inertial Signals/total_acc_x
total_acc_x_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_x_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/total_acc_x_train.txt")
write.table(total_acc_x_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_x_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(total_acc_x_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_x_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(total_acc_x_test,total_acc_x_train)

## Inertial Signals/total_acc_y
total_acc_y_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_y_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/total_acc_y_train.txt")
write.table(total_acc_y_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_y_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(total_acc_y_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_y_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(total_acc_y_test,total_acc_y_train)

## Inertial Signals/total_acc_z
total_acc_z_test <- read.table(
        "UCI_HAR_Dataset/test/Inertial Signals/total_acc_z_test.txt")
total_acc_z_train <- read.table(
        "UCI_HAR_Dataset/train/Inertial Signals/total_acc_z_train.txt")
write.table(total_acc_z_test, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_z_merged.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(total_acc_z_train, 
            file = "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_z_merged.txt",
            append = TRUE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(total_acc_z_test,total_acc_z_train)


## Step 2. Extracts only the measurements on the mean and standard deviation
## for each measurement. 
##
## As one can read from the original "features.txt" file the measurements on
## the mean and standard deviation for each measurement are found in the 
## following columns
## 1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,
## 161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,
## 268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,
## 516,517,529,530,542,543
## which is the result of the following unix command
## grep 'mean()\|std()' features.txt | awk '{print $1}' | perl -pe 's/\n/,/g'
##
## NOTE: the measurements in question are found in the file 
##       "UCI_HAR_Dataset/merged/X_merged.txt"
## I will create a new table named "X_merged_means_std.txt" with only mean() and std()
##
## load original merged table
merged_table <- read.table("UCI_HAR_Dataset/merged/X_merged.txt")

## vector with column numbers to keep
mycolumns <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,
               124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,
               240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,
               350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)

## create subtable with selected columns
subtable_merged <- merged_table[,mycolumns]

## write table to file
write.table(subtable_merged, 
            file = "UCI_HAR_Dataset/merged/X_merged_means_std.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(merged_table,mycolumns,subtable_merged)


## Step 3. Uses descriptive activity names to name the activities in the
## data set
## 
## the codes for the descriptive activities for each record are found in the 
## file "UCI_HAR_Dataset/merged/y_merged.txt"
## and the activities are coded as follows (see also file 
## UCI_HAR_Dataset/activity_labels.txt):
## 1 WALKING
## 2 WALKING_UPSTAIRS
## 3 WALKING_DOWNSTAIRS
## 4 SITTING
## 5 STANDING
## 6 LAYING
##
## So, what we need to do is to create a new y_merged.txt file without
## using the codes, but using descriptive activity names instead
## the new table will be named y_merged_with_names.txt

## loading records for activities
activities <- read.table("UCI_HAR_Dataset/merged/y_merged.txt")

## go through each record and substitute the code by the respective activity
## name

activities2 <- activities
for (i in 1:nrow(activities)) {
        mycode <- activities[i,1]
        
        if (mycode == 1) {
                activities2[i,1] <- "WALKING"
                next
        }
        if (mycode == 2) {
                activities2[i,1] <- "WALKING_UPSTAIRS"
                next
        }
        if (mycode == 3) {
                activities2[i,1] <- "WALKING_DOWNSTAIRS"
                next
        }
        if (mycode == 4) {
                activities2[i,1] <- "SITTING"
                next
        }
        if (mycode == 5) {
                activities2[i,1] <- "STANDING"
                next
        }
        if (mycode == 6) {
                activities2[i,1] <- "LAYING"
                next
        }
}

## write new table to file
## write table to file
write.table(activities2, 
            file = "UCI_HAR_Dataset/merged/y_merged_with_names.txt",
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = FALSE)
rm(activities,activities2)


## Step 4.Appropriately labels the data set with descriptive variable names.
## 
## We need to attribute collumn names to every table

## Table: subject_merged.txt
tableName <- "UCI_HAR_Dataset/merged/subject_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- "Subject"
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: X_merged_means_std.txt
tableName <- "UCI_HAR_Dataset/merged/X_merged_means_std.txt"
mytable <- read.table(tableName)
colnamesVector <- c("tBodyAcc-mean-X","tBodyAcc-mean-Y","tBodyAcc-mean-Z","tBodyAcc-std-X","tBodyAcc-std-Y",
                    "tBodyAcc-std-Z","tGravityAcc-mean-X","tGravityAcc-mean-Y","tGravityAcc-mean-Z",
                    "tGravityAcc-std-X","tGravityAcc-std-Y","tGravityAcc-std-Z","tBodyAccJerk-mean-X",
                    "tBodyAccJerk-mean-Y","tBodyAccJerk-mean-Z","tBodyAccJerk-std-X","tBodyAccJerk-std-Y",
                    "tBodyAccJerk-std-Z","tBodyGyro-mean-X","tBodyGyro-mean-Y","tBodyGyro-mean-Z",
                    "tBodyGyro-std-X","tBodyGyro-std-Y","tBodyGyro-std-Z","tBodyGyroJerk-mean-X",
                    "tBodyGyroJerk-mean-Y","tBodyGyroJerk-mean-Z","tBodyGyroJerk-std-X","tBodyGyroJerk-std-Y",
                    "tBodyGyroJerk-std-Z","tBodyAccMag-mean","tBodyAccMag-std","tGravityAccMag-mean",
                    "tGravityAccMag-std","tBodyAccJerkMag-mean","tBodyAccJerkMag-std","tBodyGyroMag-mean",
                    "tBodyGyroMag-std","tBodyGyroJerkMag-mean","tBodyGyroJerkMag-std","fBodyAcc-mean-X",
                    "fBodyAcc-mean-Y","fBodyAcc-mean-Z","fBodyAcc-std-X","fBodyAcc-std-Y","fBodyAcc-std-Z",
                    "fBodyAccJerk-mean-X","fBodyAccJerk-mean-Y","fBodyAccJerk-mean-Z","fBodyAccJerk-std-X",
                    "fBodyAccJerk-std-Y","fBodyAccJerk-std-Z","fBodyGyro-mean-X","fBodyGyro-mean-Y",
                    "fBodyGyro-mean-Z","fBodyGyro-std-X","fBodyGyro-std-Y","fBodyGyro-std-Z",
                    "fBodyAccMag-mean","fBodyAccMag-std","fBodyBodyAccJerkMag-mean","fBodyBodyAccJerkMag-std",
                    "fBodyBodyGyroMag-mean","fBodyBodyGyroMag-std","fBodyBodyGyroJerkMag-mean",
                    "fBodyBodyGyroJerkMag-std")
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: X_merged_means_std.txt
tableName <- "UCI_HAR_Dataset/merged/y_merged_with_names.txt"
mytable <- read.table(tableName)
colnamesVector <- "Activity"
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: body_acc_x_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_x_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("body_acc_x_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: body_acc_y_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_y_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("body_acc_y_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: body_acc_z_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/body_acc_z_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("body_acc_z_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: body_gyro_x_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_x_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("body_gyro_x_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: body_gyro_y_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_y_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("body_gyro_y_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: body_gyro_z_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_z_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("body_gyro_z_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: total_acc_x_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_x_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("total_acc_x_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: total_acc_y_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_y_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("total_acc_y_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

## Table: total_acc_z_merged.txt
tableName <- "UCI_HAR_Dataset/merged/Inertial Signals/total_acc_z_merged.txt"
mytable <- read.table(tableName)
colnamesVector <- vector()
for (i in 1:128) {
        myColName <- paste("total_acc_z_",i,sep="")
        colnamesVector[i] <- myColName
}
colnames(mytable) <- colnamesVector
write.table(mytable, 
            file = tableName,
            append = FALSE,
            quote = FALSE, row.names = FALSE, col.names = TRUE)

######################
## Now, let's finally merge all tables in one table that will be named "TidyTable"
## First, we will upload all tables and then write to file the merged table

## Upload tables
Subject_table  <- read.table("UCI_HAR_Dataset/merged/subject_merged.txt", header = TRUE)
X_means_std    <- read.table("UCI_HAR_Dataset/merged/X_merged_means_std.txt", header = TRUE)
Activity_table <- read.table("UCI_HAR_Dataset/merged/y_merged_with_names.txt", header = TRUE)
body_acc_x     <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/body_acc_x_merged.txt", header = TRUE)
body_acc_y     <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/body_acc_y_merged.txt", header = TRUE)
body_acc_z     <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/body_acc_z_merged.txt", header = TRUE)
body_gyro_x    <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_x_merged.txt", header = TRUE)
body_gyro_y    <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_y_merged.txt", header = TRUE)
body_gyro_z    <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/body_gyro_z_merged.txt", header = TRUE)
total_acc_x    <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/total_acc_x_merged.txt", header = TRUE)
total_acc_y    <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/total_acc_y_merged.txt", header = TRUE)
total_acc_z    <- read.table("UCI_HAR_Dataset/merged/Inertial Signals/total_acc_z_merged.txt", header = TRUE)

myTidyTable <- cbind(Subject_table,X_means_std,Activity_table,body_acc_x,body_acc_y,body_acc_z,body_gyro_x,
                     body_gyro_y,body_gyro_z,total_acc_x,total_acc_y,total_acc_z)

rm(Subject_table,X_means_std,Activity_table,body_acc_x,body_acc_y,body_acc_z,body_gyro_x,
                     body_gyro_y,body_gyro_z,total_acc_x,total_acc_y,total_acc_z)

## write TidyTable to file
write.table(myTidyTable, 
            file = "Dataset_Samsung_Tidy.txt",
            quote = FALSE, row.names = FALSE, col.names = TRUE)


## removing all temporary files and directories
unlink("UCI_HAR_Dataset", recursive=TRUE)

