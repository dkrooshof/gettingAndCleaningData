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

## Import activity labels, merge:
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activities <- merge(activities, activityLabels,by.x="V1",by.y="V1")
names(activities) <- c("ActivityNr", "Activity")

## Import Subject numbers, row bind, rename vector:
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjects <- rbind(testSubjects,trainSubjects)
names(subjects) <- "Subject"

## Construct logical vector and subset data to retain mean() and std() columns:
match <- regexpr("mean\\(\\)|std\\(\\)",names(data),perl=TRUE)
data <- data[,match > 0]

## Column bind activities and subjects:
data <- cbind(activities,subjects,data)

## Take average by Activity by Subject:
data$splitby <- factor(paste0(data$Activity,",",data$Subject))
melted_data <- melt(data, id=c("ActivityNr","Activity","Subject","splitby"))
output_data <- cast(melted_data, splitby ~ variable, mean)
output_data$Subject <- sapply(strsplit(as.character(output_data$splitby), ","), "[", 2)
output_data$Activity <- sapply(strsplit(as.character(output_data$splitby), ","), "[", 1)
output_data <- output_data[,c(68,69,2:67)]

## Write file to working directory:
write.csv(output_data,"output_data.csv")






