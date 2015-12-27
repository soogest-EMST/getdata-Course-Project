Code book 
===========
this file describes 
* the variables & the data, 
* work performed to clean up the data

1. Variables & the data
There are lots of files to take in the raw data, I'd put them in 2 categories:
- measure data : such as X_train.txt, y_train.txt and subject_train.txt 
- label data: features.txt - for the column name, and activity_labels.txt for the activities

Further more, there are 2 sets of measured data, train and test.


2. Work performed
 For each set of measured data
- removing columns not containing "mean" or "std" data
- column binding the Data: activityFile, subjectFile, dataFile
- merging into one set of data

Then :
- naming the data columns
- joining with the activity labels, in order to have a more "talkative" data.
 
Finally:
- grouping, calculating average
- and writting a new data set file.
