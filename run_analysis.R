# The script performs clean up and tidying of the UCI HAR datasets to meet the
# requirements of project submission.
#
# PRE-REQUISITES: 
#   (1) This script expects the required UCI HAR Dataset to be unzipped and 
#       available in the working directory.
#   (2) 'dplyr' package installed.
#                                   
# Load required Libraries
require(dplyr)
#
# The 'features' holds the Variable Names in the Test and Train data sets
features <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)
# Need to extract only the mean and standard deviations for each measurement hence 
# retaining 'features' list to only contain variables names containing "mean" or "std"
features <- features[grep("mean|std", features$V2), ]
# Add variable names to 'features' list
names(features) <- c("featureID", "featureName")
features$featureName <- sub("\\(\\)", "", features$featureName)
#
# The 'activityLabels' holds the activity label names and their corresponding IDs.
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", as.is = TRUE)

### Begin loading Test data
# Load Test subjects
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Load Test activities
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
# Load Test results
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
# Retain only measurements holding "mean" or "std"
testData <- select(testData, features$featureID)
# Rename variables to appropriate feature names
names(testData) <- features$featureName
# Add Subjects and Activities data columns
testData <- mutate(testData, subjectID = testSubjects$V1, activityName = testActivities$V1)
    
### Begin loading Training data
# Load Test subjects
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
# Load Test activities
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
# Load Test results
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
# Retain only measurements holding "mean" or "std"
trainData <- select(trainData, features$featureID)
# Rename variables to appropriate feature names 
names(trainData) <- features$featureName
# Add Subjects and Activities data columns
trainData <- mutate(trainData, subjectID = trainSubjects$V1, activityName = trainActivities$V1)

### Merge both Test and Train data sets
mergedData <- rbind(testData, trainData)

# Add factor to activity in order to label the activities by name 
# [$V1 is the activity code and $V2 is the label of the activity from activityLabel table]
mergedData$activityName <- factor(mergedData$activityName, activityLabels$V1, activityLabels$V2)
# Sort the merged data by Subject and Activity
mergedData <- arrange(mergedData, subjectID, activityName)
### Summarize data to average each measurement by Subject and Activity
summarizedData <- mergedData %>% group_by(subjectID, activityName) %>% summarise_each(funs(mean))
### Write the data to a text file to be read by a simple 'read.table("final-tidy-data.txt", header = TRUE)' statement
write.table(summarizedData, file = "final-tidy-data.txt", row.name = FALSE)
