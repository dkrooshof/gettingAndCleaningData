gettingAndCleaningData
======================

# Script for the course project of 'Getting and Cleaning Data', a course on coursera.

## Working of the script:

### Importing the data files:

- X_test.txt and X_train.txt are read in with read.table, and combined with rbind into the data.frame data.
- features.txt is read in with read.table, the names of data are updated with the data from features.
- The activity files y_test.txt and y-train.txt are read in and combined with rbind.
- The activity text labels are added by merging the contents of activity_labels.txt. Special attention is needed to retain the row order since we use cbind later on.
- The subject text files are read in and combined with rbind.

### Select the columns with means and standard deviations:

- A match vector on the column names of data is constructed with the help of the regexpr functions.
- The vector is used to subset the data

### The subsetted data is combined with the activity and subject data frames with cbind.

### Getting the averages by Subject x Activity:

- The dataframe is melted, with the melt function from the reshape package.
- The mean is computed for all levels of Subject and Activity with the cast function.

### The data is written to file.


