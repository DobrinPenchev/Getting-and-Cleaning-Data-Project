# make sure to execute the R script from your working directory or 
# set your working directory to the one which the script is placed in

require(dplyr)
require(tidyr)

# creates ProjectData folder in the working directory, downloads the zip file there and unzips it
# records the date/time of the download

if(!file.exists("./ProjectData")) {dir.create("./ProjectData")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,"./ProjectData/projectdata.zip")
download.date <- date()
unzip("./ProjectData/projectdata.zip",exdir = "./ProjectData")

# reads all the relevant files and creates a full data set (project requirement 1)

trainSet <- read.table("./ProjectData/UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("./ProjectData/UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./ProjectData/UCI HAR Dataset/train/subject_train.txt")

testSet <- read.table("./ProjectData/UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("./ProjectData/UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./ProjectData/UCI HAR Dataset/test/subject_test.txt")

activityLabels <- read.table("./ProjectData/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("./ProjectData/UCI HAR Dataset/features.txt", sep = " ", stringsAsFactors = FALSE)

train.full.set <- cbind(trainSubject,trainLabels,trainSet)
test.full.set <- cbind(testSubject,testLabels,testSet)
full.set <- rbind(train.full.set,test.full.set)

# assigns names to the columns in the data set; 
# replaces activity ids with their names (project requirement 3)

names(full.set) <- c("StudyParticipant","ActivityType",features$V2)
for (i in 1:6)
{full.set[full.set$ActivityType == i,"ActivityType"] <- activityLabels[activityLabels == i,"V2"]}

# removes non-relevant duplicate columns from the data set
# creates a sub-set with the means and standard deviation columns (project requirement 2)

full.set.no.dupes <- full.set[,!duplicated(colnames(full.set))]
mean.stdev.subset <- select(full.set.no.dupes, StudyParticipant, ActivityType, contains("mean()"), contains("std()"))

# features are used as variable names for the columns in the data set
# the lines below replace the special symbols with a dot symbol so that column names 
# can be readable and in the same time R functions can still manipulate those

names(mean.stdev.subset) <- gsub("\\(\\)","",names(mean.stdev.subset))
names(mean.stdev.subset) <- gsub("\\),",".",names(mean.stdev.subset))
names(mean.stdev.subset) <- gsub("\\,",".",names(mean.stdev.subset))
names(mean.stdev.subset) <- gsub("\\)","",names(mean.stdev.subset))
names(mean.stdev.subset) <- gsub("\\(",".",names(mean.stdev.subset))
names(mean.stdev.subset) <- gsub("\\-",".",names(mean.stdev.subset))
names(mean.stdev.subset) <- sub("\\-",".",names(mean.stdev.subset))

# makes the variable names (columns) readable for non-domain experts (project requirement 4)

names(mean.stdev.subset) <- sub("^t", "Time",names(mean.stdev.subset))
names(mean.stdev.subset) <- sub("^f", "Frequency",names(mean.stdev.subset))
names(mean.stdev.subset) <- sub("mean","Average",names(mean.stdev.subset))
names(mean.stdev.subset) <- sub("std","Deviation",names(mean.stdev.subset))
names(mean.stdev.subset) <- sub("Gyro","Gyroscope",names(mean.stdev.subset))
names(mean.stdev.subset) <- sub("Acc","Acceleration",names(mean.stdev.subset))
names(mean.stdev.subset) <- sub("Mag","Magnitude",names(mean.stdev.subset))
names(mean.stdev.subset) <- gsub("\\.","",names(mean.stdev.subset))

# creates a tidy data set with averages for each variable by activity & subject
# creates a text file with the data set (project requirement 5)

averages <- mean.stdev.subset %>% 
            group_by_("StudyParticipant","ActivityType") %>%
            summarise_each_(funs(mean),names(mean.stdev.subset[3:68]))

averages.tidy <- gather(averages,Variable,Average,-c(StudyParticipant,ActivityType))

write.table(averages.tidy,"./ProjectData/Tidy Set with Averages.txt", row.names = FALSE)
