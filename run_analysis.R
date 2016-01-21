library(plyr)
library(reshape2)
library(data.table)

# Dowload and unzip UCI HAR dataset, unless the unzipped directory already exists
if (!file.exists("UCI HAR Dataset")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, "UCI-HAR-dataset.zip")
    unzip("UCI-HAR-dataset.zip")
}

# read in datasets
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# set column names on observations (from features), activities and subjects
colnames(features) = c('feature_id', 'feature_name')
colnames(x_test) <- colnames(x_train) <- features$feature_name
colnames(activity_labels) <- c('activity_id', 'activity_name')
colnames(y_test) <- colnames(y_train) <- c('activity_id')
colnames(subject_test) <- colnames(subject_train) <- c('subject_id')

# merge activity and subject ids into test and train data sets
x_test <- cbind(x_test, activity_id = y_test$activity_id)
x_train <- cbind(x_train, activity_id = y_train$activity_id)
x_test <- cbind(x_test, subject_id = subject_test$subject_id)
x_train <- cbind(x_train, subject_id = subject_train$subject_id)

# merge test and train, adding a new variable on subject for sample type (test vs. train)
subject_test$sample_type <- "test"
subject_train$sample_type <- "train"
x_merged <- rbind(x_test, x_train)
subjects_merged <- unique(rbind(subject_test, subject_train)[c("subject_id", "sample_type")])

# extract mean and std columns
selected_columns <- names(x_merged)[grep('-mean()|-std()|^activity|^subject',names(x_merged))]
x_select <- subset(x_merged, select=(selected_columns))

# change measurement columns to more descriptive labels
descriptive_measurement_columns <- measurement_columns <- selected_columns[grep('^activity|^subject',selected_columns, invert=TRUE)]
pattern_replacements <- list(c("t","time_"), c("Body", "body_"), c("Acc", "acceleration_"))
for (row in pattern_replacements) {
    descriptive_measurement_columns <- gsub(row[1], row[2], descriptive_measurement_columns)
}
#apply(pattern_replacements, 1, function(row) gsub(row[1], row[2], measurement_columns))
setnames(x_select, old=measurement_columns, new=descriptive_measurement_columns)

# average each variable for each activity and each subject
average_melt <- melt(x_select, id.vars=c('activity_id', 'subject_id'))
averages <- dcast(average_melt, activity_id + subject_id ~ variable, mean, margins = c('activity_id', 'subject_id'))

# export tidy datasets to 'tidy' directory
if (!file.exists("tidy"))  dir.create("tidy")

write.csv(x_select, "tidy/HAR_sensor_measurements.csv", row.names = FALSE)
write.csv(activity_labels, "tidy/activities.csv", row.names = FALSE)
write.csv(subjects_merged, "tidy/subjects.csv", row.names = FALSE)
write.csv(averages, "tidy/averages_by_activity_and_subject.csv", row.names = FALSE)
