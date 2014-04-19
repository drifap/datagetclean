### Get colNames for X data -------------------------------------------------------------------------------------

column_names <- read.table("UCI HAR Dataset/features.txt")                # read in features.txt
features<- as.character(column_names[,2])                                 # factor into character and into list
rm(column_names)                                                          # remove unused df


### Read in training set data and tidy up ------------------------------------------------------------------------

train_x <- read.table("UCI HAR Dataset/train/X_train.txt",header=F,col.names=features)     # Read in x & name columns
train_y <- read.table("UCI HAR Dataset/train/y_train.txt",header=F,col.names="activity")   # read in y & name columns
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt",header=F,
                            col.names="subject")                          # read in subject & name col

train_mean <- subset(train_x,                                             # extract mean columns from data
                     select=c(grep("mean",names(train_x),value=T)))
train_std <- subset(train_x,                                              # extract std columns from data                                             
                    select=c(grep("std",names(train_x),value=T)))

train_y$activity <- factor(train_y$activity,1:6,                          # activity variable into factor and label
                           labels=c("WALKING","WALKING_UPSTAIRS",
                                    "WALKING_DOWNSTAIRS",
                                    "SITTING","STANDING","LAYING"))

train <- data.frame(train_subject,train_y,train_mean,train_std)           # combine into train df
train <- train[,-grep("meanFreq",names(train))]                           # remove meanfreq from train df
rm(train_subject,train_x,train_y,train_mean,train_std)                    # remove unused df


### Read in testing set data and tidy up ---------------------------------------------------------------------------

test_x <- read.table("UCI HAR Dataset/test/X_test.txt",header=F,col.names=features)       # Read in x & name col
test_y <- read.table("UCI HAR Dataset/test/y_test.txt",header=F,col.names="activity")     # read in y & name col
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt",header=F,
                           col.names="subject")                           # read in subject & name col

test_mean <- subset(test_x,                                               # extract mean columns from data
                    select=c(grep("mean",names(test_x),value=T)))
test_std <- subset(test_x,                                                # extract std columns from data
                   select=c(grep("std",names(test_x),value=T)))

test_y$activity <- factor(test_y$activity,1:6,                            # activity variable into factor and label
                          labels=c("WALKING","WALKING_UPSTAIRS",
                                   "WALKING_DOWNSTAIRS",
                                   "SITTING","STANDING","LAYING"))

test <- data.frame(test_subject,test_y,test_mean,test_std)                # combine all test data into data frame
test <- test[,-grep("meanFreq",names(test))]                              # remove meanfreq from test df
rm(test_subject,test_x,test_y,test_mean,test_std)                         # remove unused df

### Merge training and testing sets into one df - raw data -------------------------------------------------------

raw_data <- rbind(test,train)
rm(test,train,features)                                                   # remove unused df

### Create a new dataset based on the average of each variable for each activity and each subject
require(reshape2)                                                         # for melt and acast

melted <- melt(raw_data, id.vars=c("subject","activity"))                 # melt df to use acast
tidy_data <- data.frame(acast(melted, subject~activity, mean))            # acast to get the average of subj and activ
                                                                          # used data.frame to put into a df.

write.table(tidy_data,"tidy_data.txt")
