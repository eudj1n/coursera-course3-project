# Getting and Cleaning Data Course Project Code Book

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Download and extract data and load dplyr library for processing
    - Dataset downloaded and extracted under the folder called UCI HAR Dataset (not included in this repository)
    - I used this variables to simplify its further usage:
        - *fileUrl* - archive link, provided in [README.md](README.md);
        - *filePath* - folder to data extraction;
        - *fileName* - zip-archive name to save downloaded file;
        - *resultFile* - result data file [tidy_data.txt](tidy_data.txt).

1. Read and assign each data to variables
    - trainingSubjects <- test/subject_train.txt
    contains train data of 21/30 volunteer subjects being observed
     - trainingXValues <- test/X_train.txt
    contains recorded features train data
    - trainingYValues <- test/y_train.txt
    contains train data of activitiy code labels
    - testSubjects <- test/subject_test.txt
    contains test data of 9/30 volunteer test subjects being observed
    - testXValues <- test/X_test.txt
    contains recorded features test data
    - testYValues <- test/y_test.txt
    contains test data of activitity code labels
    - features <- features.txt
    The features selected for this database come from the accelerometer and gyroscope.
    - activities <- activity_labels.txt
    List of activities performed when the corresponding measurements with labels (codes).

1. Merges the training and the test sets to create one data set
    - Merge training data using cbind - cbind(trainingSubjects, trainingXValues, trainingYValues);
    - Merge test data using cbind - cbind(testSubjects, testXValues, testYValues);
    - activity - merge prepared data with rbind to create one data set;
    - After this, I cleaned up memory to unset unused in next steps variables via rm function.

1. Extracts only the measurements on the mean and standard deviation for each measurement
    - Use grepl function to extract required column names - activity, subject, mean and std;
    - This column names was assigned to *definedColumns* variable.

1. Uses descriptive activity names to name the activities in the data set
    - Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

1. Appropriately labels the data set with descriptive variable names
    - Removed special characters;
    - All Acc in column’s name replaced by Accelerometer;
    - All typo BodyBody in column’s name replaced by Body;
    - All Freq in column’s name replaced by Frequency;
    - All Gyro in column’s name replaced by Gyroscope;
    - All Mag in column’s name replaced by Magnitude;
    - All mean in column’s name replaced by Mean;
    - All std in column’s name replaced by StandardDeviation;
    - All start with character f in column’s name replaced by Frequency;
    - All start with character t in column’s name replaced by Time;
    - Reassing column names with replaced ones.

1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
    - Group data with group_by function into *groupedData* variable;
    - Summarize each variable with summarize_each function into *resultData* varibable using list mean param to avoid deprecation warning;
    - Store *resultData* (180 rows) into result file [tidy_data.txt](tidy_data.txt)
