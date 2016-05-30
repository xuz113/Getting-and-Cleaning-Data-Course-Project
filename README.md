## Getting and Cleaning Data Course Project
The purpose of this project is to collect, work with, and clean a data set. A R code has been generated to accomplish the following:

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names.
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

below is detailed instruction

### Download file and put it into working directory, unzip the file
```
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./C3Wk4pdata")){dir.create("./C3Wk4pdata")}
download.file(fileUrl, destfile = "./C3Wk4pdata/Wk4qDataset.zip", method = "curl")
unzip(zipfile="./C3Wk4pdata/Wk4qDataset.zip",exdir="./C3Wk4pdata")
```
