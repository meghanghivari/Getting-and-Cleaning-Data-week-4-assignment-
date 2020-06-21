# Week 4 assignment

library(dplyr)

# Get raw data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "getdata-projectfiles-UCI-HAR-Dataset.zip")
unzip("getdata-projectfiles-UCI-HAR-Dataset.zip")

# Utility function to read all files in a directory into
# a data frame

load_data <- function(path, pattern='\\.txt', sep="") { 
  files <- dir(path, pattern = pattern, full.names = TRUE)
  tables <- lapply(files, function(f) { read.csv(f, sep=sep, header=FALSE) })
  bind_cols(tables)
}

get_data <- function(path, pattern) {
  filenames <- dir(path)[2:4]
  data <- load_data(path)
  data
}

# Get list of features in X matrix, and combine with subject & activity
raw.features <- read.csv("UCI HAR Dataset/features.txt", sep="", header = FALSE)[,2]
features <- make.names(raw.features, unique = TRUE) # Task #4
mean.std <- c(c(TRUE), grepl(x = features, pattern="mean|std"), c(TRUE)) # Task #2
all.names <- c(c("subject"), features, c("activity"))[mean.std]
all.names <- gsub(pattern = "\\.", replacement = "", all.names)

# Get all test data
test <- get_data("UCI HAR Dataset/test/", "_test.txt")[,mean.std]
names(test) <- all.names

# Get all training data
train <- get_data("UCI HAR Dataset/train/", "_train.txt")[,mean.std]
names(train) <- all.names

# Combine (Test #1)
dt <- bind_rows(list(train, test))

# Relabel factors for clarity (Task #3)
dt$subject <- as.factor(dt$subject)
dt$activity <- as.factor(dt$activity)
activity.labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header = FALSE, stringsAsFactors = FALSE)[,2]
levels(dt$activity) <- activity.labels

# Summarize according to activity and subject(Task #5)
dt.summ <- aggregate(. ~ activity + subject, data = dt, mean)

# Save the data for submission
write.table(dt.summ, file = "tidy-summary.txt", row.names = FALSE)