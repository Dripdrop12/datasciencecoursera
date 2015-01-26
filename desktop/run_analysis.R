# Packages to Install #
install.packages(c("downloader","plyr","dplyr","tidyr"))
library(plyr)
library(downloader)
library(dplyr)
library(tidyr)

# Set the working directory to the location of the unzipped files #
setwd("C:/Users/Jon/Desktop/JHU Data Specialization/UCI HAR Dataset")

## Merge the training and the test sets to create one data set.

# Load in the Test and Train files #
testset <- read.table("test/X_test.txt",header=FALSE)
trainset <- read.table("train/X_train.txt",header=FALSE)

# Load in variable labels and add them to as colnames #
features <- read.table("features.txt",header=FALSE)
names(testset) <- as.vector(features$V2)
names(trainset) <- as.vector(features$V2)

# load and cbind the activity labels to the two data frames #
y_train <- read.table("train/Y_train.txt", header=FALSE)
y_test <- read.table("test/Y_test.txt",header=FALSE)

testset <- cbind(y_test,testset)
names(testset)[1]<-"Activity_Label"

trainset <- cbind(y_train,trainset)
names(trainset)[1]<-"Activity_Label"

# rbind the two properly labeled datasets #

ttset <- rbind(trainset,testset)

write.table(ttset,file="Merged.txt",row.name=FALSE)




## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## 1) Each variable forms a column 2) Each observation forms a row 3) Each type of observational unit forms a table



test_files <- list.files("test/Inertial Signals",full.names=TRUE)
test_tables <- lapply(test_files, read.table, header = FALSE)

train_files <- list.files("train/Inertial Signals",full.names=TRUE)
train_tables <- lapply(train_files, read.table, header = FALSE)

dat <- data.frame()
for(i in 9) {
        dat <- rbind(dat, as.data.frame(test_tables[i]))         
}