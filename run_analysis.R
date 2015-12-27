library(dplyr)
library(utils)
library(stringi)

# prepare_analysis function is used to read the Data from the specified dataDirectory
# to put together (cbind) the 3 Data files and merging the results
# returns the preparedDataSet as a table
prepare_analysis <- function (dataDirectory = "UCI HAR Dataset"){
	msg <- paste(" not found in directory ", dataDirectory, "! Check this parameter!\n")
	measureNames <- paste(dataDirectory, "features.txt", sep="/")
	activityNames <- paste(dataDirectory, "activity_labels.txt", sep="/")
	if( !file.exists(measureNames) ) stop(paste("features.txt", msg));
	if( !file.exists(activityNames) ) stop(paste("activity_labels.txt", msg));
	
	measureNames <- read.table(measureNames) #naming
	columnsMeanStd <- stringi::stri_detect_regex(measureNames$V2, "-mean|-std") # removing columns not containing mean ot std
	columnsSelected <- measureNames$V1[columnsMeanStd]
	measureNames[,2]<-stri_replace_all_fixed(measureNames[,2], c("(", ")", "-"), c("","", "_"), vectorize_all=FALSE)
	activityNames <- read.table(activityNames) #activityNames naming

	dataFile 		<- c("test/X_test.txt", "train/X_train.txt")
	activityFile 	<- c("test/Y_test.txt", "train/Y_train.txt")
	subjectFile 	<- c("test/subject_test.txt", "train/subject_train.txt")
	
	dataFile 	 <- paste(dataDirectory,dataFile, sep="/" )
	activityFile <- paste(dataDirectory,activityFile, sep="/" )
	subjectFile  <-  paste(dataDirectory,subjectFile, sep="/" )

	if(sum(file.exists(dataFile)) != length(dataFile)) stop(paste(dataFile , msg));
	if(sum(file.exists(activityFile)) != length(activityFile)) stop(paste(activityFile, msg));
	if(sum(file.exists(subjectFile)) != length(subjectFile)) stop(paste(subjectFile, msg));
	
	destData <- NULL
	for( i in 1:length(dataFile)) { #reading Data from 3 files
		# message("Step ", i,  dataFile[i]); 
		dx <- read.table( dataFile[i] ) %>% as.tbl %>% select(columnsSelected)
		dy <- read.table( activityFile[i] );
		ds <- read.table( subjectFile[i] );
		dataSet <- cbind(dy, ds, dx) #column binding the Data: activityFile, subjectFile, dataFile
		if(is.null(destData)) { 
			destData <- dataSet
		} else { 
			destData <- rbind(destData, dataSet) #merging
		}
	}
	names(destData) <- c("ActivityID", "SubjectID", as.vector(measureNames$V2[columnsMeanStd]))
	names(activityNames) <- c("ActivityID", "ActivityName")
	destData <- inner_join(activityNames,destData) %>% select(- ActivityID)
	destData %>% as.tbl
}

# run_analysis function takes as first argument a preparedDataSet by the previous function
# and a second optional argument which is a file name to write to
run_analysis <- function (preparedDataSet, destFile = NULL){
	gb <- preparedDataSet %>% group_by(ActivityName,SubjectID) %>% summarise_each(funs(mean)) %>% ungroup
	if(!is.null(destFile)) gb %>% write.table(destFile, row.name=FALSE);
	gb
}

#uncomment this lines to execute the default
# test <- prepare_analysis()
# test %>% run_analysis
