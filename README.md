Getting and Cleaning Data - Course Project
This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1.Download the dataset if it does not already exist in the working directory

2.Load all the files including the activity, feature info, training, test and subject file

3.Merges the training and test dataset, keep only those columns which reflect a mean or standard deviation

4.Loads the activity and subject data for each dataset, and merges those columns with the dataset

5.creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair

6.The end result is shown in the file tidy.txt
