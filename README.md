# Getting and Cleaning Data Course Project

This repository is a Eugene Kozlov (@eudj1n) submission for Getting and Cleaning Data course project. It has the instructions on how to run analysis on Human Activity dataset.

## Dataset
I used [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (and this [archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) for this course project.

## Files
1. [CodeBook.md](CodeBook.md) a code book that describes the variables, the data, and all transformations or work that I performed to clean up the data and get final tidy data result;
1. [run_analysis.R](run_analysis.R) performs the data preparation and then followed by the preparaton and next 5 steps required as described in the course project’s definition:
	- Merges the training and the test sets to create one data set;
	- Extracts only the measurements on the mean and standard deviation for each measurement;
	- Uses descriptive activity names to name the activities in the data set;
	- Appropriately labels the data set with descriptive variable names;
	- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
1. [tidy_data.txt](tidy_data.txt) is the saved final data after going through all the steps described above.