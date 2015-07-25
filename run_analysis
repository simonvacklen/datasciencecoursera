
##Installing and loading necessary packages
install.packages("plyr")
install.packages("reshape2")
library("reshape2")
library ("plyr")



## importing all the separate files
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
actlab <- read.table("UCI HAR Dataset/activity_labels.txt")

##Adding variable names to activities
colnames(actlab) <- c("Act_CD", "Activity")

## merging tables in different stages
df <- rbind(train_x, test_x)
colnames(df) <- features$V2 

##selecting only the variables with mean and standard deviation for the accelerometer and gyroscope, the instructions are
##unclear as to excactly which variables to keep and this is my interpretation, as its the raw data that further
##data, such as jerk is derived from
df_acc <- df[ ,1:6]
df_gyro <- df[ ,121:126]
df <- cbind (df_acc, df_gyro)
##As per instructions, giving the selected variables clear names
colnames(df) <- c("Accelerometer_Mean_X", "Accelerometer_Mean_Y", "Accelerometer_Mean_Z", "Accelerometer_Std_X", "Accelerometer_Std_Y",
"Accelerometer_Std_Z", "Gyroscope_Mean_X",  "Gyroscope_Mean_Y",  "Gyroscope_Mean_Z",  "Gyroscope_Std_X",  "Gyroscope_Std_Y",  "Gyroscope_Std_Z")

##Adding the subjects variable
subj <- rbind(subj_train, subj_test)
colnames(subj) <- c("Subject_ID")
df <- cbind(df, subj)

##Adding the Y-data, calling the variable "Act_CD" so it connects to the x-data with the same variable in the merge
y <- rbind(train_y, test_y)
colnames(y) <- c("Act_CD")
df <- cbind(df, y)

##Adding activity labels to main dataset
df <- merge(df, actlab)
##Removing Act_CD, since we have added "Activity", which is the sam info in more clear name
df <- df[ ,2:15]

## creating second datasets according to instructions, with means for every subject, measure and activity	
df_melt <- melt(df, id=c("Subject_ID", "Activity"))
colnames(df_melt) <- c("Subject_ID", "Activity", "Variable", "Value")
df2 <- ddply(df_melt, .(Subject_ID, Activity, Variable), summarize, Mean=mean(Value)) 

##Exporting the file for upload
write.table(df2, file="df2.txt", row.name=FALSE)
