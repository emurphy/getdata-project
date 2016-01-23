# tidy and average UCI Human Activity Recognition (HAR) Using Smartphones Data Set

## Installation

The following R package dependencies need to be installed:

- plyr
- reshape2
- data.table

The script has been tested using R version 3.2.2 on Mac OS X Yosemite 10.5.5. 

## Invocation, Input and Output

The script must be run from the project root directory. For example with:
```
cd /work/getdata-project
Rscript run_analysis.R
```
The script will download and unzip the original UCI HAR data to the `UCI HAR Dataset` directory, unless that directory already exists (to save time and bandwidth on subsequent runs).

It writes four new dataset text files to disk using `write.table`. The primary output file is saved in the working directory:

- `averages_by_activity_and_subject.txt` 

The remaining three are saved for reference under a `tidy` directory:

- `subjects.csv`
- `activities.csv`
- `HAR_sensor_measurements.csv`

The above are all described in more detail in the [Code Book](CodeBook.md)

## run_analysis.R steps

The script performs the following steps. 

- Download and unzip the UCI HAR dataset unless the directory already exists
- Read in the dataset using read.table
- Set column names on activities, subjects and observations using `colnames`. Observation columns are for the time being named from the original `features.txt`.
- Merge activity and subject ids into the test and train data sets using `cbind`
- Merge the test and train datasets using `rbind`, also adding a new variable on subject for sample type (`test` vs. `train`).
- Select the mean and standard deviation columns, with a combination of `grep` and `subset`.
- Change the measurement columns to more descriptive labels, as described in the Code Book. This is done by iterating over a list of pattern <=> replacement pairs and using `gsub`. Then `data.table` package's `setcolnames` function is used (for speed and readability).
- Average each variable for each activity and each subject. `reshape2` package's `melt` and `dcast` functions perform the mean calculations and reshape the data frame into 88 variables with 187 records.
- In the tidied HAR sensor measurement data, move fixed variable (subject and activity id) columns to the beginning (columns 1 and 2).
- Write the datasets using `write.table` with `row.names = FALSE`

## References

```
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
```

