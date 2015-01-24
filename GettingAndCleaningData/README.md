==================================================================
run_analysis.R
Version 1.0
==================================================================
Author: Bingfeng Li.
Jan 23, 2015
Course Project of Getting and Cleaning Data
https://www.coursera.org/specialization/jhudatascience/1
==================================================================

The goal of this script is to process raw data from the accelerometers from the Samsung Galaxy S smartphone, prepare tidy data that can be used for later analysis.

Input raw data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

More info about the raw data can be obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

There are total 5 steps of data processing:
	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	3. Appropriately labels the data set with descriptive variable names. 
	4. From the data set in step 3, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	5. Uses descriptive activity names to name the activities in the data set.

In the end, the script saves the tidy data set to a local file and return the result.

For more information about the output data, please refer to COOKBOOK.md.