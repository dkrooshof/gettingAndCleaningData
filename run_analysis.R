## Script to produce a tidy dataset for 'Human Activity Recognition Using Smartphones Dataset'
## Attention: script assumes the data folder to be present in your working directory!
## Douwe Krooshof

library(reshape)

## Import main test and train data, then row bind into one dataframe:
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
data <- rbind(testData,trainData)

## Import features file that holds the column names, attach column names to data:
features <- read.table("UCI HAR Dataset/features.txt")
names(data) <- features[,2]

## Import activity numbers for test and train data, then row bind into one vector:
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
activities <- rbind(testActivities,trainActivities)

## Import activity labels, merge (merge does NOT retain row order!):
activities$id  <- 1:nrow(activities) #id column added
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activities <- merge(activities, activityLabels,by.x="V1",by.y="V1")
activities <- activities[order(activities$id),] #resort by id to regain original order
names(activities) <- c("ActivityNr","id", "Activity")

## Import Subject numbers, row bind, rename vector:
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjects <- rbind(testSubjects,trainSubjects)
names(subjects) <- "Subject"

## Construct logical vector and subset data to retain mean() and std() columns:
match <- regexpr("mean\\(\\)|std\\(\\)",names(data),perl=TRUE)
data <- data[,match > 0]

## Column bind activities and subjects:
data <- cbind(subjects,activities,data)

## Reshape the data:
molten_data <- melt(data, id=c("Subject","ActivityNr","id","Activity"))
output_data <- cast(molten_data, Subject + Activity ~ variable, mean)

## Write file to working directory:
write.table(output_data,"output_data.txt",sep=",")






