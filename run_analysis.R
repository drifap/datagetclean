### Get colNames for X data -------------------------------------------------------------------------------------

column_names <- read.table("data/features.txt")                           # read in features.txt
features<- as.character(column_names[,2])                                 # factor into character and into list
rm(column_names)                                                          # remove unused df

### Read in training set data and tidy up ------------------------------------------------------------------------
train_x <- read.table("data/X_train.txt",header=F,col.names=features)     # Read in x & name columns
train_y <- read.table("data/y_train.txt",header=F,col.names="activity")   # read in y & name columns
train_subject <- read.table("data/subject_train.txt",header=F,
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

rm(train_subject,train_x,train_y,train_mean,train_std)                    # remove unused df
