


## Step 1 : Merge the training and the test sets to create one data set.

### 1a : Load the training datasets 

  trainX <- read.table("./UCI HAR Dataset/train/x_train.txt")
  trainY <- read.table("./UCI HAR Dataset/train/y_train.txt")
  trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

### 1b : Load the test datasets 
  
  testX <- read.table("./UCI HAR Dataset/test/x_test.txt")
  testY <- read.table("./UCI HAR Dataset/test/y_test.txt")
  testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  

### 1c : Load the features descriptions 

  features <- read.table("./UCI HAR Dataset/features.txt")


### 1d : Set the column names of the X sets to use the friendly feature descriptions

  colnames(trainX) <- features$V2
  colnames(testX) <- features$V2
  

### 1e : use cbind to join the  data in the X sets with the training activity id's in Y sets

train <-cbind(trainY,trainX)
test  <-cbind(testY,testX)

### 1f : Rename the first column to be ActivityID
  
colnames(train)[1] <- "ActivityID" 
colnames(test)[1] <- "ActivityID" 
  
### 1g : Use rbind to join the subject data sets for the training and test data a
subjects <- rbind(trainSubjects,testSubjects)

### 1h : change the first column to a friendly name - SubjectID
  
colnames(subjects)[1] <- "SubjectID"

  
### 1i : merge the training and test datasets together then add the subjects 
combinedData <- rbind(train,test)
combinedData <- cbind(subjects,combinedData)
  
## Step 2 : Extract only the measurements on the mean and standard deviation 
##         for each measurement (but include the subject and activity ID's)

collist<-grepl("mean",colnames(combinedData),ignore.case=T)|grepl("std",colnames(combinedData),ignore.case=T)|grepl("ID",colnames(combinedData),ignore.case=T)
finalData <- combinedData[,collist]  

# Step 3 : Uses descriptive activity names to name the activities in the data set
## load the activity dataset then merge it with the final dataset to integrate the activity names 
  
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("ActivityID","ActivityName"))
finalData <- merge(activities,finalData,by="ActivityID")  
  
# remove the activity ID as it's no longer required 
finalData$ActivityID <- NULL
  


## Step 4 : Create an tidy data set with the average of each variable for each activity and each subject

### 4a : We are going to use ddply methods from the plyr package so lets load it. 
if(!require(data.table))
    {
      install.packages("plyr")
    }

library(plyr)

## 4b : calculate the mean for each group of subject/activity pairs  
finalDataGrouped <- ddply(finalData, c("SubjectID","ActivityName"),numcolwise(mean))  

# write the final Data set to a file in the working directory
write.table(finalDataGrouped,"output_tidy_datset.txt",row.name=FALSE)

  