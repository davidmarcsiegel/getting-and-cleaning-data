# Source of data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 1. Merge the training and the test sets to create one data set.
setwd("~/R/CleaningData")
training = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

testing = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

allData = rbind(training, testing)

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

colsWeWant <- grep(".*Mean.*|.*Std.*", features[,2])
# First reduce the features table to what we want
features <- features[colsWeWant,]
# Now add the last two columns (subject and activity)
colsWeWant <- c(colsWeWant, 562, 563)
# And remove the unwanted columns from allData
allData <- allData[,colsWeWant]
# Add the column names (features) to allData
colnames(allData) <- c(features$V2, "Activity", "Subject")
colnames(allData) <- tolower(colnames(allData))


# 3. Use descriptive activity names to name the activities in the data set, and
# 4. Appropriately label the data set with descriptive variable names. 
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
    allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity)
    currentActivity <- currentActivity + 1
}

allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)


# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyset = aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean)
# Remove the subject and activity column, since a mean of those has no use
tidyset[,90] = NULL
tidyset[,89] = NULL
write.table(tidyset, "new_tidy_dataset.txt", sep="\t", row.name=FALSE)
