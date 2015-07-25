# Getting and Cleaning Data Course Project

Introduction
------------
This repository contains the course project for the Coursera course "Getting and Cleaning data."

About the raw data
------------------

The features (561 of them) are unlabeled and can be found in the x_test.txt. 
The activity labels are in the y_test.txt file.
The test subjects are in the subject_test.txt file.

The features (561 of them) are unlabeled and can be found in the x_train.txt. 
The activity labels are in the y_train.txt file.
The test subjects are in the subject_train.txt file.

About the script and the tidy dataset
-------------------------------------
The script called run_analysis.R which will merge the test and training sets together.
Prerequisites for this script:

1. the UCI HAR Dataset must be extracted;
2. the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"

After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

The script will create a tidy data set containing the means of all the columns per test subject and per activity.
This tidy dataset will be written to a tab-delimited file called new_tidy_dataset.txt.

About the Code Book
-------------------
The CodeBook.md file explains the data manipulations and the resulting new data and variables.
