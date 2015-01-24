
analyzeHAR = function(){
  library(dplyr)
  library(reshape2)
  
  # Load raw data
  y_test = read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
  subject_test = read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
  x_test = read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
  
  y_train = read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
  subject_train = read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
  x_train = read.table(".\\UCI HAR Dataset\\train\\X_train.txt")

  features = read.table(".\\UCI HAR Dataset\\features.txt")
  activityLabels = read.table(".\\UCI HAR Dataset\\activity_labels.txt")
  
  # 1.Merges the training and the test sets to create one data set.
  x_all = rbind(x_test, x_train)
  y_all = rbind(y_test, y_train)
  subject_all = rbind(subject_test, subject_train)
  
  # 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  meanIndexes = grep("mean()", features$V2)
  stdIndexes = grep("std()", features$V2)
  filteredIndexes = c(meanIndexes, stdIndexes)
  x_filtered = x_all[,filteredIndexes]
  
  # 4.Appropriately labels the data set with descriptive variable names. 
  # Get rid of () and two - in the column names
  descColName = features[filteredIndexes,2]
  descColName = sub("()", "", descColName, fixed=TRUE)
  descColName = sub("-", "", descColName, fixed=TRUE)
  descColName = sub("-", "", descColName, fixed=TRUE)
  
  colnames(x_filtered)=descColName
  
  # 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  colnames(y_all)="ActivityId"
  x_filtered=cbind(x_filtered,y_all)
  colnames(subject_all)="SubjectId"
  x_filtered=cbind(x_filtered,subject_all)
  
  x_filtered$line=rownames(x_filtered)
  xmelt=melt(x_filtered, id.vars=c("line", "ActivityId", "SubjectId"), measure.vars = descColName)
  groupdata = dcast(xmelt, ActivityId + SubjectId ~ variable, mean)
  
  # 3.Uses descriptive activity names to name the activities in the data set
  # Do this step last so to save some storage space for temp variables
  colnames(activityLabels)=c("id","Activity")
  cleanData = merge(activityLabels, groupdata, by.x="id", by.y="ActivityId", all=TRUE)
  
  cleanData = select(cleanData,-id)
  
  write.table(cleanData, ".\\UCIHARCleanData.txt", row.names=FALSE)
  
  return(cleanData)
}