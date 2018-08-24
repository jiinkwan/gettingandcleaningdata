## Author: Jinkwan Hong
## Date: 2018/08/24
## Purpose: Return a tidy data out of UCI HAR data

library(data.table)
## Loading data sets
run_analysis <- function() {
  
  ## Reading necessary files
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  feature <- read.table("./UCI HAR Dataset/features.txt", colClasses = "character")
  act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = "character")
  
  ## Turning data frames to data tables for performance
  x_testDT <- data.table(x_test)
  y_testDT <- data.table(y_test)
  x_trainDT <- data.table(x_train)
  y_trainDT <- data.table(y_train)
  
  ## Dropping data frames after data table creation
  
  rm(x_test)
  rm(y_test)
  rm(x_train)
  rm(y_train)
  
  ##  Merge test x,u and train x,y
  mergedTest <- cbind(x_testDT, y_testDT)
  mergedTrain <- cbind(x_trainDT, y_trainDT)
  ##  Introducing subject numbers
  mergedSubject <- rbind(subject_test,subject_train)
  ##  Merging all data all together
  merged <- rbind(mergedTest,mergedTrain)
  merged <- cbind(merged, mergedSubject)
  
  ## Adding missing column names in feature.txt
  feature[nrow(feature) + 1,] <- cbind(V1="562",V2="Activity")
  feature[nrow(feature) + 1,] <- cbind(V1="563",V2="Subject")
  names(merged) <- paste0(feature$V2,feature$V1)
  ## selecting only mean and std variables
  merged <- merged %>% select(grep('mean|std',names(merged)),`Subject563`,`Activity562`)
  ## replacing activity number with activity description
  merged$Activity562 <- act_labels$V2[match(merged$Activity562,act_labels$V1)]
  ## creating the data set for Step 5. Average of each variable for each activity and each subject.
  group <- merged %>% group_by(`Subject563`,`Activity562`) %>% summarise_all(mean)
  
  ## Check if average file exists. If it does, delete it.
  if (file.exists("subject_activity_means.txt")) {file.remove("subject_activity_means.txt")}
  
  ## Write the average data set to a file
  write.table(group, file = "subject_activity_means.txt",row.names = FALSE)
  
  ## returning tidy data set.
  merged
}