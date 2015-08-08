library(dplyr)

filename <- "course3_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Step 1: Merges the training and the test sets to create one data set
#=====================================================================
## Load the datasets

train_set <- read.table("UCI HAR Dataset/train/X_train.txt")
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

test_set <- read.table("UCI HAR Dataset/test/X_test.txt")
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

## Create 'X' data set
set_data <- rbind(train_set,test_set)

## Create Activities data set
activities_data <- rbind(train_activities, test_activities)

## Create Subjects data
subjects_data <- rbind(train_subjects, test_subjects)


# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
#===============================================================================================

features <- read.table("UCI HAR Dataset/features.txt")

## Extract only the data on mean and standard deviation
features_mean_std <- grep(".*mean.*|.*std.*", features[,2])

## Take only the desired columns
set_data <- set_data[,features_mean_std]

## Rename the columns to be descriptive
colnames(set_data) <- features[features_mean_std, 2]

# Step 3: Uses descriptive activity names to name the activities in the data set
#===============================================================================

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

## Update values with descriptive activity names
activities_data[, 1] <- activities[activities_data[, 1], 2]

## Rename the activities data column
colnames(activities_data) <- "activity"

# Step 4: Appropriately labels the data set with descriptive variable names
#==========================================================================

## Rename the subject column
colnames(subjects_data) <- "subject"

## Merge all the data
all_data <- cbind(set_data, activities_data, subjects_data)

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject
#==========================================================================================================

avg_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:79]))

write.table(avg_data, "tidy_data.txt", row.name=FALSE)
