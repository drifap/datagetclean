### Train data -----------------------------------
train_x <- read.table("data/X_train.txt",header=F)                     # Read in train_x data & column labels
column_names <- read.table("data/features.txt")
head(column_names)                                                     # view col labels
column_names$V1 <- NULL                                                # remove first column
column_names$V2 <- as.character(column_names$V2)                       # factor into character
features <- column_names$V2                                            # into list for combining
colnames(train_x) <- features                                          # use list for colnames

train_mean <- subset(train_x,                                          # extract mean columns from data
                     select=c(grep("mean",names(train_x),value=T)))
train_std <- subset(train_x,                                           # extract std columns from data                                             
                    select=c(grep("std",names(train_x),value=T)))

train_y <- read.table("data/y_train.txt",header=F)                     # read in train_y data
colnames(train_y) <- "activity"                                        # name column
train_y$activity <- factor(train_y$activity,1:6,                       # activity into factor and label
                           labels=c("WALKING","WALKING_UPSTAIRS",
                                    "WALKING_DOWNSTAIRS",
                                    "SITTING","STANDING","LAYING"))
table(train_y$activity)                                                # view variable 

train_subject <- read.table("data/subject_train.txt",header=F)         # read in train_subject data
colnames(train_subject) <- "subject"                                   # name column


train <- data.frame(train_subject,train_y,train_mean,train_std)        # combine into final
head(train)                                                            # view new data frame


rm(train_subject,train_x,train_y,column_names,train_mean,train_std)    # remove unused df


### Test data ------------------------
test_x <- read.table("data/X_test.txt",header=F)                       # Read in test_x data & column labels
column_names <- read.table("data/features.txt")
head(column_names)                                                     # view col labels
column_names$V1 <- NULL                                                # remove first column
column_names$V2 <- as.character(column_names$V2)                       # factor into character
features <- column_names$V2                                            # into list for combining
colnames(test_x) <- features                                           # use list for colnames

test_mean <- subset(test_x,                                            # extract mean columns from data
                    select=c(grep("mean",names(test_x),value=T)))
test_std <- subset(test_x,                                             # extract std columns from data
                   select=c(grep("std",names(test_x),value=T)))

test_y <- read.table("data/y_test.txt",header=F)                       # read in test_y data
colnames(test_y) <- "activity"                                         # name column
test_y$activity <- factor(test_y$activity,1:6,                         # activity into factor and label
                           labels=c("WALKING","WALKING_UPSTAIRS",
                                    "WALKING_DOWNSTAIRS",
                                    "SITTING","STANDING","LAYING"))
table(test_y$activity)                                                 # view variable 

test_subject <- read.table("data/subject_test.txt",header=F)           # read in test_subject data
colnames(test_subject) <- "subject"                                    # name column

test <- data.frame(test_subject,test_y,test_mean,test_std)             # combine all test data into data frame
head(test)                                                             # view new data frame
rm(test_subject,test_x,test_y,column_names,test_mean,test_std)         # remove unused df

train <- train[,-grep("meanFreq",names(train))]                        # remove meanfreq from train df
head(train)                                                            # view 

test <- test[,-grep("meanFreq",names(test))]                           # remove meanfreq from test df
head(test)

### combine into 1 data.frame
merged <- rbind(test,train)
rm(test,train,features)                                                # remove unused df

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
library(reshape2)

melted <- melt(merged, id.vars=c("subject","activity"))                # melt df to use acast
tidy_data <- data.frame(acast(melted, subject~activity, mean))         # acast to get the average of subj and activ
                                                                       # used data.frame to put into a df.
