# This is the CodeBook describing data in "week4.txt" and how it was generated.

# "wee4.txt" contains average aggregated sensor measures of an experiment carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The measures are a subset of original measures as required by the assignment at https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project
----------------------------------------------------------------------------------------------------------------------------

# "week4.txt" data was generated with the script "run_analysis.R".
# The script assumes, that exercise source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip has been downloaded and unzipped into R working directory and use relative path from there on.
# The script: 
# 1. loads source data measurements for training and test data sets and merges them into a single data set called "measurements". Dplyr package is used for better performance.
# 2. loads descriptive names for measurements (in source data called features), leaves only measures that contain "mean" or "std" in their names and adds these descriptive measure names into the "measurements" data set
# 3. loads activity codes for each measure and corresponding activity labels and merges them into "measurements" data set as two additional columns
# 4. loads test subject code into "measurements" data set as an additional column
# 5. finds the mean value for each measure in "measurements" by subject and activity and exracts this data into a data table called "aggregated"
------------------------------------------------------------------------------------------------------------

# Data Dictionary
"week4.txt" has the following columns:
 - Subject: Integer, a code of the test subject with values from 1 to 30.
 - ActivityCode: Integer, a code with six different values for the the type of activity performed when a measurement was taken
 - ActivityLabel: factor, the name of the activity performed while doing the measurement
            1 LAYING
            2 SITTING
            3 STANDING
            4 WALKING
            5 WALKING_DOWNSTAIRS
            6 WALKING_UPSTAIRS
- 86 different measure columns of movement direction and force. All measures are averages for a given subject during given activity. Each measure of acceleration (containing "acc"" in column name) are in standard gravity units 'g'. Each measure of angular velocity (containing "gyro" in its column name) is in radians/second. More detailed description of measures is at "UCI HAR Dataset\features_info.txt". Example measure names:
        tBodyAcc-mean()-X
        tBodyAcc-mean()-Y 
        tBodyAcc-mean()-Z
        tBodyAcc-std()-X 
        ...
-------------------
# use the following code to load the data into T
week4<-read.table("week4.txt",header=TRUE)
