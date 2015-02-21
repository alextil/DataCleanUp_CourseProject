---
title: "Readme"
output: html_document
---

This file provides an overview of the data files ans script supporting this submission. More details about the data, variables and transformations performed can be found in the codebook.md file.

##Files in this submission include 

- 'Readme.md' (this file)
- 'codebook.md' - a file that describes the data and variables in the submission
- 'run_analysis.r' - the code file that produces the output data set
- 'output_tidy_dataset.txt' - the file created by the code in run_analysis.r 

##Source data 

The source data for this assignment is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) 

The script for the assignment assumes that the source data is unzipped and stored in the working directory in the "UCI HAR Dataset" folder.  The unzipped files requied by this script are;

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Script overview 

The code that produces the output is stored in the run_analysis.R file located in the same location as this file. 

The script performs the following steps 

Step 1 : Merge the individual files into a single data set

- 1a. Load the training X, Y and Subject files 
- 1b. Load the test X, Y and Subject files
- 1c. Load the features descriptions
- 1d. Set the column names of the X sets to use the friendly feature descriptions
- 1e. Use cbind to join the  data in the X sets with the training activity id's in Y sets
- 1f. Rename the first column of the bound data sets to a friendly name "ActivityID"
- 1g. Use rbind to join the subject data sets for the training and test data 
- 1h. Rename the sinlge column of the merged data set in 1g to "SubjectID"
- 1i  Use rbind & cbind to merge the training and test datasets together then add the subjects

At this stage we have a merged data set (stored as 'finalData').  The assigment does not ask
for this dataset to be exported.  It will be used as the base set for step2. 

Step 2 : Create a dataset that contains only the mean and standard deviation values

Step 3 : Uses descriptive activity names to name the activities in the data set

- 3a : load the activity data using friendly column names 
- 3b : Use merge to join the dataset from Step 2 with the activity data from 3a
- 3c : Remove the activityID from the dataset as it is no longer needed

Step 4 : Create an tidy data set with the average of each variable for each activity and each subject

- 4a : install the plyr package if required then load it.
- 4b : Use ddply to calculate the mean for each group of subject/activity pairs  
- 4c : Write the final dataset to a file in the working directory
