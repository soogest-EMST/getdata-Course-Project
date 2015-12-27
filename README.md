# getdata Course Project

As requested, I created one R script called run_analysis.R 
This file contains 2 functions

### prepare_analysis
# prepare_analysis function is used to read the Data from the specified dataDirectory
# to put together (cbind) the 3 Data files and merging the results
# returns the preparedDataSet as a table
This corresponds to steps 1 to 4 from the assignment

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 

### run_analysis function 
#which takes as first argument a preparedDataSet by the previous function
# and a second optional argument which is a file name to write to
This corresponds to step 5
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
