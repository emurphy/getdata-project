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
features <- fread("UCI HAR Dataset/features.txt")
x_test <- fread("UCI HAR Dataset/test/X_test.txt")
x_train <- fread("UCI HAR Dataset/train/X_train.txt")
y_test <- fread("UCI HAR Dataset/test/y_test.txt")
y_train <- fread("UCI HAR Dataset/train/y_train.txt")
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# set column names on activities, subjects and observations
colnames(features) = c('feature_id', 'feature_name')
colnames(x_test) <- colnames(x_train) <- features$feature_name
colnames(activity_labels) <- c('activity_id', 'activity_name')
colnames(y_test) <- colnames(y_train) <- c('activity_id')
colnames(subject_test) <- colnames(subject_train) <- c('subject_id')

# convert activity names to lowercase and merge activity names into test and train
activity_labels$activity_name <- tolower(activity_labels$activity_name)
setkey(y_test, activity_id)
setkey(y_train, activity_id)
setkey(activity_labels, activity_id)
y_test <- y_test[activity_labels]
y_train <- y_train[activity_labels]

# merge activity name and subject ids into test and train data sets
x_test <- cbind(x_test, activity_name = y_test$activity_name)
x_train <- cbind(x_train, activity_name = y_train$activity_name)
x_test <- cbind(x_test, subject_id = subject_test$subject_id)
x_train <- cbind(x_train, subject_id = subject_train$subject_id)

# merge test and train, adding a new variable on subject for sample type (test vs. train)
subject_test$sample_type <- "test"
subject_train$sample_type <- "train"
x_merged <- rbind(x_test, x_train)
subjects_merged <- unique(rbind(subject_test, subject_train)[c("subject_id", "sample_type")])

# extract mean and std columns
selected_columns <- names(x_merged)[grep('^activity|^subject|-mean()|-std()|Mean',names(x_merged))]
x_select <- subset(x_merged, select=(selected_columns))

# change measurement columns to more descriptive labels
descriptive_columns <- measurement_columns <- selected_columns[grep('^activity|^subject',selected_columns, 
                                                                    invert=TRUE)]
pattern_replacements <- list(c("^t","time_"), c("^f", "frequency_"), 
                             c("Body", "body_"), c("Gravity", "gravity_"), 
                             c("Acc", "acceleration_"), c("Gyro", "angular_velocity_"),
                             c("-meanFreq()", "mean_frequency"), c("-mean\\(\\)", "mean"), 
                             c("-([X-Z])", "_\\1_axial"), c("-std\\(\\)", "standard_deviation"),
                             c("frequency\\(\\)", "frequency"), c("Mag", "magnitude_"), c("Jerk", "jerk_"), 
                             c("gravityMean", "gravity_mean"), c("Mean", "mean"), 
                             c("angle\\(([X-Z])", "angle\\(\\1_axial"),
                             c("angle\\(", "sample_average_angle_"), 
                             c(",", "_by_"), c("tbody", "time_body"), c("\\)", ""))
for (row in pattern_replacements) {
    descriptive_columns <- gsub(row[1], row[2], descriptive_columns)
}
setnames(x_select, old=measurement_columns, new=descriptive_columns)

# average each variable for each activity and each subject
fixed_variable_columns <- c('activity_name', 'subject_id')
average_melt <- melt(x_select, id.vars=fixed_variable_columns)
averages <- dcast(average_melt, activity_name + subject_id ~ variable, mean, margins = c('activity_name', 'subject_id'))

# move fixed variable (subject id and activity name) columns to the beginning
setcolorder(x_select, c(fixed_variable_columns, descriptive_columns))

# export tidy datasets, creating tidy directory if it does not yet exist
write.table(averages, "averages_by_activity_and_subject.txt", row.names = FALSE)

if (!file.exists("tidy"))  dir.create("tidy")

write.table(x_select, "tidy/HAR_sensor_measurements.txt", row.names = FALSE)
write.table(activity_labels, "tidy/activities.txt", row.names = FALSE)
write.table(subjects_merged, "tidy/subjects.txt", row.names = FALSE)
