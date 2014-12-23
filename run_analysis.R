# Functions for cleaning the "UCI HAR Dataset". The main function is 
# `runAnalysis`. Other functions are accessible externally for testing, but not
# intended to be called by users of this code.

library(dplyr)

makeActivityFactor <- function(activityFile)
{
	activities <- read.table(activityFile)
	activityFactors <- factor(activities$V1, labels=activities$V2)
	activityFactors
}

makeFeatureFactor <- function(featureFile)
{
	features <- read.table(featureFile)

	features$V2 <- gsub(")", "", features$V2, fixed=TRUE)
	features$V2 <- gsub("(", "", features$V2, fixed=TRUE)
	features$V2 <- gsub("-", ".", features$V2, fixed=TRUE)
	featureFactors <- factor(features$V1, labels=features$V2)
	featureFactors
}

loadActivities <- function(activityFile, activityFactor)
{
	activities <- read.table(activityFile, col.names = c("ActivityVal"), colClasses = c("factor"))
	activities$Activity <- activityFactor[activities$ActivityVal]
	activities
}

loadSubjects <- function(subjectFile)
{
	subjects <- read.table(subjectFile, col.names = c("Subject"), colClasses = c("factor"))
	subjects
}

# data -> a dataframe with all the observations
# subjects -> a vector or dataframe of subjects, with the same dim as data
# activity -> a vector or dataframe ofactivities, with the same dim as data
mergeDataWithSubjectAndActivity <- function(data, subjects, activity)
{
	data <- cbind(activity$Activity, data)
	colnames(data)[1] = "Activity"
	data <- cbind(subjects, data)
	data
}

mergeDataSets <- function(dataSetOne, dataSetTwo)
{
	rbind(dataSetOne, dataSetTwo)
}

extractMeasurements <- function(df)
{
	# keep mean
	# keep std
	# drop Freq
	# drop angle
	extracted <- select(df, Subject, Activity, contains("mean"), 
		contains("std"), -contains("Freq"), -contains("angle"))
	extracted
}

extractTidy <- function(df)
{
	tidy <- aggregate(df[,c(-1,-2)], by=list(Subject=df$Subject, Activity=df$Activity), mean)
	tidy
}

runAnalysis <- function()
{
	activityFactor <- makeActivityFactor("UCI HAR Dataset/activity_labels.txt")
	featureFactor <- makeFeatureFactor("UCI HAR Dataset/features.txt")

	# Load the individual parts of the test data
	xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = featureFactor)
	yTest <- loadActivities("UCI HAR Dataset/test/y_test.txt", activityFactor)
	subjectTest <- loadSubjects("UCI HAR Dataset/test/subject_test.txt");

	# Merge test data
	xTest <- mergeDataWithSubjectAndActivity(xTest, subjectTest, yTest)


	# Load the individual parts of the training data
	xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = featureFactor)
	yTrain <- loadActivities("UCI HAR Dataset/train/y_train.txt", activityFactor)
	subjectTrain <- loadSubjects("UCI HAR Dataset/train/subject_train.txt")

	# Merge the training data
	xTrain <- mergeDataWithSubjectAndActivity(xTrain, subjectTrain, yTrain)

	# Merge data
	mergedData <- mergeDataSets(xTest, xTrain)
	# Extract desired columns
	extractedData <- extractMeasurements(mergedData)

	# Boil down dataset to means of each unique observation of a (subject, activity) pair
	tidyData <- extractTidy(extractedData)
	tidyData
}





