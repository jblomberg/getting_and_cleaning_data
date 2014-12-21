# Feature Selection

Columns were included that contained in "mean" or "std".This does not include columns such as `fBodyAcc-meanFreq()-X` or `angle(X,gravityMean)`, which were stripped.

# Raw Data

The raw data provided in the UCI HAR Dataset is split among a 'test' and 'train' dataset. These both share the same features & activities, which are derived from the files `activity_labels.txt` and `features.txt`. Each set contains 3 files of interest: observations, subjects, and activities. These possess the same row dimensions, and can be merged directly together.

# Data Processing

## Factor creation
* Activities: Created using the `activity_labels.txt` file
* Features: Created using the `features.txt` file
	
	Feature names were cleaned of the characters '-','(', and ')'

## Data loading

* Observational data was loaded using the feature factor for column names
* Corresponding activity data was loaded and associated with the activity factor
* Subject data was loaded as a factor

## Combining individual data frames

The observational data was combined with the activity data and subjects to form a complete dataframe. This was done for both the training and test data.

## Merging test and training data

The test and training data were merged via a single rbind, since previous work had been done to ensure they were of similar dimensions.

## Extracting mean & std variables

The `dplyr` library was used to extract the desired variables. The `select` function, combined with its associated `contains` function was used to select the features as described in the above section, [Feature Selection].

## Tidying the dataset

The aggregate function was used to group by unique (subject, activity) pairs and calculate the mean for all features.

# Data Shape

Each row is an observation of a unique (subject,activity) tuple. All observation data are the `mean` of the source observations for the tuple.

## Columns

* Subject
	
	- factor: The id of the subject. Range: 1-30

* Activity
	- factor: The activity being performed in the observations. One of:
		- WALKING
		- WALKING_UPSTAIRS
		- WALKING_DOWNSTAIRS
		- SITTING
		- STANDING
		- LAYING
* Observation Data:
	* tBodyAcc.mean.X
	* tBodyAcc.mean.Y
	* tBodyAcc.mean.Z
	* tGravityAcc.mean.X
	* tGravityAcc.mean.Y
	* tGravityAcc.mean.Z
	* tBodyAccJerk.mean.X
	* tBodyAccJerk.mean.Y
	* tBodyAccJerk.mean.Z
	* tBodyGyro.mean.X
	* tBodyGyro.mean.Y
	* tBodyGyro.mean.Z
	* tBodyGyroJerk.mean.X
	* tBodyGyroJerk.mean.Y
	* tBodyGyroJerk.mean.Z
	* tBodyAccMag.mean
	* tGravityAccMag.mean
	* tBodyAccJerkMag.mean
	* tBodyGyroMag.mean
	* tBodyGyroJerkMag.mean
	* fBodyAcc.mean.X
	* fBodyAcc.mean.Y
	* fBodyAcc.mean.Z
	* fBodyAccJerk.mean.X
	* fBodyAccJerk.mean.Y
	* fBodyAccJerk.mean.Z
	* fBodyGyro.mean.X
	* fBodyGyro.mean.Y
	* fBodyGyro.mean.Z
	* fBodyAccMag.mean
	* fBodyBodyAccJerkMag.mean
	* fBodyBodyGyroMag.mean
	* fBodyBodyGyroJerkMag.mean
	* tBodyAcc.std.X
	* tBodyAcc.std.Y
	* tBodyAcc.std.Z
	* tGravityAcc.std.X
	* tGravityAcc.std.Y
	* tGravityAcc.std.Z
	* tBodyAccJerk.std.X
	* tBodyAccJerk.std.Y
	* tBodyAccJerk.std.Z
	* tBodyGyro.std.X
	* tBodyGyro.std.Y
	* tBodyGyro.std.Z
	* tBodyGyroJerk.std.X
	* tBodyGyroJerk.std.Y
	* tBodyGyroJerk.std.Z
	* tBodyAccMag.std
	* tGravityAccMag.std
	* tBodyAccJerkMag.std
	* tBodyGyroMag.std
	* tBodyGyroJerkMag.std
	* fBodyAcc.std.X
	* fBodyAcc.std.Y
	* fBodyAcc.std.Z
	* fBodyAccJerk.std.X
	* fBodyAccJerk.std.Y
	* fBodyAccJerk.std.Z
	* fBodyGyro.std.X
	* fBodyGyro.std.Y
	* fBodyGyro.std.Z
	* fBodyAccMag.std
	* fBodyBodyAccJerkMag.std
	* fBodyBodyGyroMag.std
	* fBodyBodyGyroJerkMag.std 