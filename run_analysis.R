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

# set column names from features
colnames(x_test) <- features$V2
colnames(x_train) <- features$V2

# todo: set column names on activity_labels to id and name, merge in id but not name
y_test_labeled <- merge(y_test, activity_labels, by.x = "V1", by.y = "V1")
y_train_labeled <- merge(y_train, activity_labels, by.x = "V1", by.y = "V1")
x_test <- cbind(x_test, activity = y_test_labeled$V2)
x_train <- cbind(x_train, activity = y_train_labeled$V2)

# todo: set column name on subjects, merge in id
x_test <- cbind(x_test, subject = subject_test$V1)
x_train <- cbind(x_train, subject = subject_train$V1)

# merge test and train, adding a new variable for sampleType
x_test$sampleType <- "test"
x_train$sampleType <- "train"
x_merged <- rbind(x_test, x_train)

# extract mean and std columns
x_select <- subset(x_merged, select=(names(x_merged)[grep('-mean()|-std()|^activity|^sampleType|^subject',names(x_merged))]))

# todo: average each variable for each activity and each subject

# todo: export tidy datasets
if (!file.exists("tidy"))  dir.create("tidy")

write.csv(x_select, "tidy/HAR_sensor_measurements.csv")
write.csv(activity_labels, "tidy/activities.csv")
#write.csv(subject_lookup, "tidy/subjects.csv")
#write.csv(averages, "tidy/averages_by_subject_and_activity.csv")