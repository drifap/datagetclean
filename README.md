Getting and Cleaning Data Project
============

__*Peer assessment assignment for Coursera specialization course - Getting and cleaning data*__

### Instructions:
You should create one R script called run_analysis.R that does the following:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names. 
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject


### Data available from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### More information on dataset available from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


## My notes: 
* For this assignment I chose to use only the 3 combined text files in each of the folders ie y, x and subject. 
* To make my codes shorter I moved the six text files + features file into a folder named data. 
* When the run_analysis.R script runs it starts of reading the features file to create a list of column names. It then incorporates the column names while reading in the data. 
* The script starts of reading in the training data and tidying the data up including extracting only the mean and std columns. I used grep to extract only the columns with mean 