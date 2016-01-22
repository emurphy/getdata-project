# run_analysis.R script to tidy UCI Human Activity Recognition Using Smartphones Data Set

## Installation

The following package dependencies need to be installed:

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

It creates a new `tidy` directory with four new CSV dataset files, as described in the [CodeBook](CodeBook.md)

## References

```
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
```

