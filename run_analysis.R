# Dowload and unzip UCI HAR dataset, unless the unzipped directory already exists
if (!file.exists("UCI HAR Dataset")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, "UCI-HAR-dataset.zip")
    unzip("UCI-HAR-dataset.zip")
}


