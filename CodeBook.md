# CodeBook for Week 4 Assignment of "Getting and Cleaning Data" course

## Data set `tidy-summary.txt`

### Format

This data set is provided as a space-separated-value file format. Factors are represented by strings, which are quoted with the double quote character ("). All other varibles are numeric.

### Transformations from original data set

Unziping the [file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) obtained from [Human Activity Recognition Using Smartphones Data Set 
 (UCI Machine Learning Repository)](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#), one finds the files 
 
```
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/y_train.txt
```

which were all combined into this data set. The main transformations performed were 

   + the translation of the data of `UCI HAR Dataset/train/subject_train.txt` and `UCI HAR Dataset/test/subject_test.txt` into factors (to emphasize that ordering of the integers appears to be meaningless)
   
   + the translation of the data of `UCI HAR Dataset/train/y_train.txt` and `UCI HAR Dataset/test/y_test.txt` into factors, but following the correspondence document in `UCI HAR Dataset/activity_labels.txt`, and this `y` variable was renamed `activity`

   + for each `subject` and `activity` pairing, and for each observation of this pairing, only mean and standard deviation of the variables recorded in the observation were kept. In turns, only the averages of these are kept for each given `subject` and `activity`.

### Variables

Variable names follow the variable names in the UCI data set, except dashes, parentheses, and commas have been removed (by using R's `make.names` function). Moreover, only mean and standard deviation of each of the recorded observations are kept in the tidy data sets.  Details about each of the variables can be found in the file `UCI HAR Dataset/features_info.txt` included in the UCI zip file.

From the 563 different variables in the `UCI HAR Dataset/*/X_*.txt` data sets, we end up with 81 variables. By combining the information about activity and subject (i.e., all three files within the `test` and `train` data sets), we end 83 different variables. 

The first two are `activity` and `subject`, both of which are factors. All remaining variables are numeric. 

   + `activity` may be any of `WALKING`, `WALKING_UPSTAIRS`,  `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`.

   + `subject` may be any label from 1 through 30, but since the ordering is meaningless, these values are stored as quoted strings.


