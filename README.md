Getting and Cleaning Data Project
============

__*Peer assessment assignment for Coursera specialization course - Getting and cleaning data*__


Files in Repo: 
----------------------

#### run_analysis.R
Running this script will do the following: 
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names. 
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

#### CodeBook.md
This file describes the variables, the data, and any transformations or work that you performed to clean up the data. More information also available from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


Tidy dataset
-------------------------
To produce a tidy dataset please follow these steps: 
 1. Download the data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into your working directory 
 2. Unzip the data folder
 3. Run the run_analysis.R script from your working directory

## My notes: 
* For this assignment I chose to use only the 3 combined text files in each of the folders ie y, x and subject. 
* When the run_analysis.R script runs it starts of reading the features file to create a list of column names. It then incorporates the column names while reading in the data. 
* The script starts of reading in the training data and tidying the data up including extracting only the mean and std columns. I used grep to extract only the columns with mean 
