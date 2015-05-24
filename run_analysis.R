# 1. Merges the training and the test sets to create one data set

# Tabulating data
features <- read.table("./features.txt",header=FALSE)
activityType <- read.table("./activity_labels.txt",header=FALSE)
subjectTrain <- read.table("./train/subject_train.txt",header=FALSE)
xTrain <- read.table("./train/x_train.txt",header=FALSE)
yTrain <- read.table("./train/y_train.txt",header=FALSE)

# Assigning column names
colnames(activityType)  <- c("activityId","activityType")
colnames(subjectTrain)  <- "subjectId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"

# Concantenate to create the merged set of (yTrain, subjectTrain, and xTrain)
trainingData <- cbind(subjectTrain,xTrain,yTrain)

# Tabulating test data
subjectTest <- read.table("./test/subject_test.txt",header=FALSE)
xTest       <- read.table("./test/x_test.txt",header=FALSE)
yTest       <- read.table("./test/y_test.txt",header=FALSE)

# Assigning column names to the test data
colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

# Concantenate to create merged final test the (xTest, yTest and subjectTest)
testData <- cbind(subjectTest,xTest,yTest)

# Combine training and test data for final data set
finalData <- rbind(trainingData,testData)

# Vector creation for column names from the finalData selecting mean() & stddev() columns
colNames  <- colnames(finalData)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Vector containing parameters of "ID, mean() & stddev() columns" and others=False
logicalVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Subset finalData table based on the logicalVector to keep only desired columns
finalData <- finalData[logicalVector==TRUE]

# 3. Uses descriptive activity names to name the activities in the data set

# Merge finalData set with acitivityType table with descriptive activity names.
finalData <- merge(finalData,activityType,by="activityId",all.x=TRUE)

# Merged colNames vector with new column names
colNames  <- colnames(finalData)

# 4. Appropriately labels the data set with descriptive variable names.

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{colNames[i] <- gsub("\\()","",colNames[i])
 colNames[i] <- gsub("-std$","StdDev",colNames[i])
 colNames[i] <- gsub("-mean","Mean",colNames[i])
 colNames[i] <- gsub("^(t)","time",colNames[i])
 colNames[i] <- gsub("^(f)","freq",colNames[i])
 colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
 colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
 colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
 colNames[i] <- gsub("AccMag","AccMagnitude",colNames[i])
 colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
 colNames[i] <- gsub("JerkMag","JerkMagnitude",colNames[i])
 colNames[i] <- gsub("GyroMag","GyroMagnitude",colNames[i])
}

# Reassigning new descriptive column names to finalData set
colnames(finalData) <- colNames

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Tabulating finalDataNoActivityType without activityType column
finalDataNoActType  <- finalData[,names(finalData) != "activityType"]

# Summarizing finalDataNoActivityType table include mean of each variable for each activity and each subject
tidyData    <- aggregate(finalDataNoActType[,names(finalDataNoActType) != c("activityId","subjectId")],by=list(activityId=finalDataNoActType$activityId,subjectId = finalDataNoActType$subjectId),mean)

# Consolidating tidyData with activityType including descriptive acitvity names
tidyData    <- merge(tidyData,activityType,by='activityId',all.x=TRUE)

# Export Text Output
write.table(tidyData, "./Scrubbed.txt",row.names=TRUE,sep="\t")

