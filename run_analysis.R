#library(dplyr)

#read and merge testresults and activity label data into data tables
test_subject<-tbl_dt(read.table("UCI HAR Dataset/test/subject_test.txt"))
train_subject<-tbl_dt(read.table("UCI HAR Dataset/train/subject_train.txt"))
subject<-bind_rows(test_subject,train_subject)
rm(test_subject)
rm(train_subject)

x_test<-tbl_dt(read.table("UCI HAR Dataset/test/X_test.txt"))
x_train<-tbl_dt(read.table("UCI HAR Dataset/train/X_train.txt"))
measurements<-bind_rows(x_test,x_train)
rm(x_test)
rm(x_train)

y_test<-tbl_dt(read.table("UCI HAR Dataset/test/y_test.txt"))
y_train<-tbl_dt(read.table("UCI HAR Dataset/train/y_train.txt"))
activities<-bind_rows(y_test,y_train)
rm(y_test)
rm(y_train)

# read names for measurements
features<-read.table("UCI HAR Dataset/features.txt")

# Exctracting all the mean and standard deviation measures into a separate data table. Only the ones where mean is at the end of the measurement name
measurements<-select(measurements,c(grep("mean|std",features$V2,ignore.case=TRUE)))

# assign descriptive names to measurements
names(measurements)<-c(grep("mean|std",features$V2,ignore.case=TRUE,value=TRUE))

# merge activity labels with measurements and give a descriptive name to the new column
measurements<-bind_cols(measurements,activities)
names(measurements)[length(measurements)]<-"ActivityCode"

# read names for activities into a data table
activity_labels<-tbl_dt(read.table("UCI HAR Dataset/activity_labels.txt"))

# join measurements with activity labels and assign a descriptive name for the column
measurements<-inner_join(measurements,activity_labels,by=c("ActivityCode"="V1"))
names(measurements)[length(measurements)]<-"ActivityLabel"

# join measurements with subjects
measurements<-bind_cols(measurements,subject)
names(measurements)[length(measurements)]<-"Subject"

# calculate average of each variable for each activity and each subject and export it into an R data table called "aggregated"
measurements<-group_by(measurements,Subject,ActivityLabel)
aggregated<-summarise_each(measurements,funs(mean))
write.table(aggregated,file="week4.txt",row.names = FALSE)
#print("Data Export Ready")

