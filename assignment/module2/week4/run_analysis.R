run_analysis <- function(){

  #read the data first and provide descriptive column names
  
  features <- read.table("features.txt")
  activityLabels <- read.table("activity_labels.txt", col.names = c("activityId", "activityType"), check.names = FALSE)

  xtest <- read.table("X_test.txt", col.names = features[,2], check.names = FALSE)
  ytest <- read.table("y_test.txt", col.names = c("activityId"), check.names = FALSE)
  subjectTest <- read.table("subject_test.txt", col.names = c("subjectId"), check.names = FALSE)
  
  
  xtrain <- read.table("X_train.txt", col.names = features[,2], check.names = FALSE)
  ytrain <- read.table("y_train.txt", col.names = c("activityId"), check.names = FALSE)
  subjectTrain <- read.table("subject_train.txt", col.names = c("subjectId"), check.names = FALSE)
  

  #merge Train and Test data to generate 1 big data
  mergedTrain <- cbind(ytrain, subjectTrain, xtrain)
  mergedTest <- cbind(ytest, subjectTest, xtest)
  mergedData <- rbind(mergedTrain, mergedTest)
  
  #get only mean and std variables then merge it with the Activity Labels
  mergedMeanStd <- subset(mergedData, select = grep("mean|std|activityId|subjectId", names(mergedData)))
  mergedDescriptive <- merge(activityLabels, mergedMeanStd, by="activityId", all.y=TRUE)
 

  #now get the mean of all the mean and std variables, 
  #without changing the values of the subjectId, activityId and activity Type
  #arrange bu subjectId and activityId then write to txt file
  finalTidyData <- 
    aggregate(. ~subjectId + activityId - activityType, mergedDescriptive, mean) %>%
    arrange(subjectId, activityId) %>%
    write.table("finalTidyData.txt", row.name=FALSE)
  
}