## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("C:/FUN Stuff/@ In Progress/Data Science Specialization/03. Getting and Cleaning Data/Week 4/Course Project")

training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training[,562] <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,563] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test[,562] <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test[,563] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Reading features and making the feature names better suited for R with some substitutions
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] <- gsub('-mean', 'Mean', features[,2])
features[,2] <- gsub('-std', 'Std', features[,2])
features[,2] <- gsub('[-()]', '', features[,2])

# Merging the training and the test sets to creat one data set
mergedData <- rbind(training, test)

# Getting the data on mean and std. dev. ONLY
colsM_SD <- grep(".*Mean.*|.*Std.*", features[,2])

# First reduce the features table as per our need
features <- features[colsM_SD,]

# Adding the last two columns of subject and activity 
colsM_SD <- c(colsM_SD, 562, 563)

# Removing the rest of columns from mergedData
mergedData <- mergedData[,colsM_SD]

# Adding the column names (features) to mergedData
colnames(mergedData) <- c(features$V2, "Activity", "Subject")
colnames(mergedData) <- tolower(colnames(mergedData))

currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
    mergedData$activity <- gsub(currentActivity, currentActivityLabel, mergedData$activity)
    currentActivity <- currentActivity + 1
}

mergedData$activity <- as.factor(mergedData$activity)
mergedData$subject <- as.factor(mergedData$subject)

tidy = aggregate(mergedData, by=list(activity = mergedData$activity, subject=mergedData$subject), mean)

# Removing the subject and activity column, since a mean of those is no longer in use
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t", row.names=FALSE)
