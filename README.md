gettingAndCleaningData
======================

# Script for the course project of 'Getting and Cleaning Data', a course on coursera.

## Working of the script:
1. Importing the data files:
- X_test.txt and X_train.txt are read in with read.table, and combined with rbind into the data.frame data.
- features.txt is read in with read.table, the names of data are updated with the data from features.
- The activity files y_test.txt and y-train.txt are read in and combined with rbind.
- The activity text labels are added by merging the contents of activity_labels.txt.
- The subject text files are read in and combined with rbind.
2. Select the columns with means and standard deviations:
- A match vector on the column names of data is constructed with the help of the regexpr functions.
- The vector is used to subset the data
3. The subsetted data is combined with the activity and subject data frames with rbind.
4. Getting the averages by Subject x Activity:
- The Activity and Subject columns are combined to get all unique combinations.
- The dataframe is melted.
- The mean is computed for all levels in the constructed column.
- The contructed column is split to its original components.
5. The data is written to file.


