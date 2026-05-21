## ============================================================
## run_analysis.R
## Getting and Cleaning Data – Course Project
## Johns Hopkins / Coursera
##
## Assumes the Samsung data folder "UCI HAR Dataset" is in
## the current working directory.  If not, the script downloads
## and unzips it automatically.
## ============================================================

library(dplyr)

## ----------------------------------------------------------
## 0.  Download / unzip data if needed
## ----------------------------------------------------------
dataDir <- "UCI HAR Dataset"

if (!file.exists(dataDir)) {
  message("Downloading dataset …")
  url <- paste0("https://d396qusza40orc.cloudfront.net/",
                "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  download.file(url, destfile = "dataset.zip", method = "curl")
  unzip("dataset.zip")
}

## ----------------------------------------------------------
## 1.  Merge the training and test sets into one data set
## ----------------------------------------------------------

# --- feature (column) names ---
features <- read.table(file.path(dataDir, "features.txt"),
                       col.names = c("id", "name"),
                       stringsAsFactors = FALSE)

# --- activity labels ---
activityLabels <- read.table(file.path(dataDir, "activity_labels.txt"),
                             col.names = c("id", "activity"),
                             stringsAsFactors = FALSE)

# Helper: read one partition (train or test)
readPartition <- function(partition) {
  path <- file.path(dataDir, partition)
  
  X       <- read.table(file.path(path, paste0("X_",       partition, ".txt")),
                        col.names = features$name)
  y       <- read.table(file.path(path, paste0("y_",       partition, ".txt")),
                        col.names = "activityId")
  subject <- read.table(file.path(path, paste0("subject_", partition, ".txt")),
                        col.names = "subject")
  
  cbind(subject, y, X)
}

train <- readPartition("train")
test  <- readPartition("test")

combined <- rbind(train, test)

## ----------------------------------------------------------
## 2.  Extract only mean and standard deviation measurements
## ----------------------------------------------------------
# Keep subject, activityId, and any column whose name contains
# "mean()" or "std()" (exact feature names use dots after
# read.table substitutes parentheses).
keepCols <- grepl("subject|activityId|mean\\.\\.|std\\.\\.", names(combined))
combined  <- combined[, keepCols]

## ----------------------------------------------------------
## 3.  Use descriptive activity names
## ----------------------------------------------------------
combined$activityId <- activityLabels$activity[combined$activityId]
names(combined)[names(combined) == "activityId"] <- "activity"

## ----------------------------------------------------------
## 4.  Label with descriptive variable names
## ----------------------------------------------------------
names(combined) <- names(combined) |>
  gsub(pattern = "^t",          replacement = "time")           |>
  gsub(pattern = "^f",          replacement = "frequency")      |>
  gsub(pattern = "Acc",         replacement = "Accelerometer")  |>
  gsub(pattern = "Gyro",        replacement = "Gyroscope")      |>
  gsub(pattern = "Mag",         replacement = "Magnitude")      |>
  gsub(pattern = "BodyBody",    replacement = "Body")           |>
  gsub(pattern = "\\.mean\\.\\.", replacement = "Mean")         |>
  gsub(pattern = "\\.std\\.\\.",  replacement = "Std")          |>
  gsub(pattern = "\\.$",         replacement = "")              |>
  gsub(pattern = "\\.",          replacement = "")

## ----------------------------------------------------------
## 5.  Create a second, independent tidy data set with the
##     average of each variable for each activity and subject
## ----------------------------------------------------------
tidyData <- combined |>
  group_by(subject, activity) |>
  summarise(across(everything(), mean), .groups = "drop")

write.table(tidyData, "tidy_data.txt", row.names = FALSE)

message("Done!  Tidy data written to tidy_data.txt  (",
        nrow(tidyData), " rows × ", ncol(tidyData), " columns)")
