# Step 0 - Download and extract data

library(dplyr)

## Define variables

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filePath <- "UCI HAR Dataset"
fileName <- paste(filePath, ".zip")
resultFile <- "tidy_data.txt"

## Check archive and download if not exists

if (!file.exists(fileName)) {
  download.file(fileUrl, fileName, mode = "wb")
}

## Extract dataset if file path is not exits

if (!file.exists(filePath)) {
  unzip(fileName)
}

## Read training data into 3 variables

trainingSubjects <- read.table(file.path(filePath, "train", "subject_train.txt"))
trainingXValues <- read.table(file.path(filePath, "train", "X_train.txt"))
trainingYValues <- read.table(file.path(filePath, "train", "y_train.txt"))

## Read test data into 3 variables

testSubjects <- read.table(file.path(filePath, "test", "subject_test.txt"))
testXValues <- read.table(file.path(filePath, "test", "X_test.txt"))
testYValues <- read.table(file.path(filePath, "test", "y_test.txt"))

## Read features (as is)

features <- read.table(file.path(filePath, "features.txt"), as.is = TRUE)

##  Read activity labels and define column names

activities <- read.table(file.path(filePath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

# Step 1 - Merges the training and the test sets to create one data set.

## Merge training and test data into activity

activity <- rbind(
  cbind(trainingSubjects, trainingXValues, trainingYValues),
  cbind(testSubjects, testXValues, testYValues)
)

## Clean up memory for next steps

rm(trainingSubjects, trainingXValues, trainingYValues, testSubjects, testXValues, testYValues)

## Assign column names

colnames(activity) <- c("subject", features[, 2], "activity")

# Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

## Grep nessessery columns with regular expression

definedColumns <- grepl("activity|subject|mean|std", colnames(activity))

## Reassing activity with defined columns only

activity <- activity[, definedColumns]

# Step 3 - Uses descriptive activity names to name the activities in the data set

## Replace activity current values with factor levels

activity$activity <- factor(activity$activity, levels = activities[, 1], labels = activities[, 2])

# Step 4 - Appropriately labels the data set with descriptive variable names.

## Get current column names

activityColumns <- colnames(activity)

## Clean special chars with gsub before names converting

activityColumns <- gsub("[\\(\\)-]", "", activityColumns)

## Expand abbrs and synonimous

activityColumns <- gsub("Acc", "Accelerometer", activityColumns)
activityColumns <- gsub("BodyBody", "Body", activityColumns)
activityColumns <- gsub("Freq", "Frequency", activityColumns)
activityColumns <- gsub("Gyro", "Gyroscope", activityColumns)
activityColumns <- gsub("Mag", "Magnitude", activityColumns)
activityColumns <- gsub("mean", "Mean", activityColumns)
activityColumns <- gsub("std", "StandardDeviation", activityColumns)
activityColumns <- gsub("^f", "frequencyDomain", activityColumns)
activityColumns <- gsub("^t", "timeDomain", activityColumns)

## Reassign new clean column names

colnames(activity) <- activityColumns

# Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Group data by subject and activity

groupedData <- group_by(activity, subject, activity)

## Apply mean to summarize results

resultData <- summarise_each(groupedData, funs(mean))

## Save result data to result file

write.table(resultData, resultFile, row.names = FALSE, quote = FALSE)