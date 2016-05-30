## this code was run on Mac OS X V10.10.5
## 1. Download file and put it into ./C3Wk4pdata folder (working directory)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./C3Wk4pdata")){dir.create("./C3Wk4pdata")}
download.file(fileUrl, destfile = "./C3Wk4pdata/Wk4qDataset.zip", method = "curl")

## unzip file into "./C3Wk4pdata/UCI HAR Dataset" folder
unzip(zipfile="./C3Wk4pdata/Wk4qDataset.zip",exdir="./C3Wk4pdata")

## Read all files into R
## including the following:
## 1. activity data set, both training (y_train.txt) and testing (y_test.txt)
## 2. subject data set, both training (subject_train.txt) and testing (subject_test.txt) 
## 3. features data set, both training (x_train.txt) and testing (x_test.txt)
## 4. features name data set (features.txt)
## 5. activity labels data set (activity_labels.txt)
actitity_ytest <- read.table("./C3Wk4pdata/UCI HAR Dataset/test/y_test.txt")
activity_ytrain <- read.table("./C3Wk4pdata/UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./C3Wk4pdata/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./C3Wk4pdata/UCI HAR Dataset/train/subject_train.txt")
        
features_xtest <- read.table("./C3Wk4pdata/UCI HAR Dataset/test/x_test.txt")
features_xtrain <- read.table("./C3Wk4pdata/UCI HAR Dataset/train/x_train.txt")

## combine test and train dataset by row
activity_y <- rbind(actitity_ytest, activity_ytrain)
subject <- rbind(subject_test, subject_train)
features_x <- rbind(features_xtest, features_xtrain)

## set names to variable
features_name <- read.table("./C3Wk4pdata/UCI HAR Dataset/features.txt")
names(features_x) <- features_name$V2
names(activity_y) <- c("activity")
names(subject) <- c("subject")

## 1. Merges the training and the test sets to create one data set.
All_data <- cbind(subject, activity_y, features_x)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
index_mean_sd <- grep("mean\\(\\)|std()",features_name$V2)
columnToextract <- c("subject", "activity", as.character(features_name$V2[index_mean_sd]))
data_mean_sd <- subset(All_data, select = columnToextract)

## 3. Uses descriptive activity names to name the activities in the data set
activity_label <- read.table("./C3Wk4pdata/UCI HAR Dataset/activity_labels.txt")
activity_names <- factor(data_mean_sd$activity)
levels(activity_names) <- activity_label$V2
data_mean_sd$activity <- activity_names

## 4. Appropriately labels the data set with descriptive variable names.
names(data_mean_sd)<-gsub("^t", "time", names(data_mean_sd))
names(data_mean_sd)<-gsub("^f", "frequency", names(data_mean_sd))
names(data_mean_sd)<-gsub("Mag", "Magnitude", names(data_mean_sd))
names(data_mean_sd)<-gsub("BodyBody", "Body", names(data_mean_sd))
names(data_mean_sd)<-gsub("Acc", "Accelerometer", names(data_mean_sd))
names(data_mean_sd)<-gsub("Gyro", "Gyroscope", names(data_mean_sd))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydataset <- aggregate(data_mean_sd[, -c(1:2)], by =list(subject = data_mean_sd$subject, activity = data_mean_sd$activity),mean, na.rm =TRUE)
write.table(tidydataset, "./C3Wk4pdata/tidydataset.txt", row.name=FALSE)



