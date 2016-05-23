
#up data into environment
train <- read.table("data/train/X_train.txt")
train_label <- read.table("data/train/y_train.txt")
features <- read.table("data/features.txt")
test <- read.table("data/test/X_test.txt")
test_label <- read.table("data/test/y_test.txt")
activity_label <- read.table("data/activity_labels.txt")
subject_train <- read.table("data/train/subject_train.txt")
subject_test <- read.table("data/test/subject_test.txt")

#I give names to train and test databases with the names stored in features data.frame
names(train) <- features$V2
names(test) <- features$V2

#1.  Merges the training and the test sets to create one data set.
bd1 <- rbind.data.frame(train, test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
bd2 <- bd1[,grepl("-mean()|-std()", names(bd1))]
bd2 <- bd2[,!grepl("meanFreq()", names(bd2))]

#3. Uses descriptive activity names to name the activities in the data set
#I created a new vector with activity code
x <- rbind(train_label, test_label)
bd3 <- cbind.data.frame(bd2, x)
names(bd3)[67] <- "activity_code"

#I created a new vector with activity label (name)
y <- sapply(1:10299, function(x){
  if(bd3[x,67]==1){
    "WALKING"
  }else{
    if(bd3[x,67]==2){
      "WALKING_UPSTAIRS"
    }else{
      if(bd3[x,67]==3){
        "WALKING_DOWNSTAIRS" 
      }else{
        if(bd3[x,67]==4){
          "SITTING"
        }else{
          if(bd3[x,67]==5){
            "STANDING"
          }else{
            "LAYING"
          }
        }
      }
    }
  }
})
bd3 <- cbind.data.frame(bd3, y)
names(bd3)[68] <- "activity_name"

#4. Appropriately labels the data set with descriptive variable names.
#I created a new vector with participants in the samsung´s experiment
bd4 <- cbind.data.frame(bd3, rbind(subject_train, subject_test))
names(bd4)[69] <- "subject"
bd4$subject <- as.factor(bd4$subject)

#5. From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

#I load a nice package to manipulate complex data and to create tidy data
library(dplyr)

#I have organized levels in activity_name column, then tidy_data have the same order that
#features.txt data
bd4$activity_name <- factor(bd4$activity_name, 
                            levels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",

                                                                              "SITTING", "STANDING", "LAYING"))

#This code tidy data from step 5
tidy_data <- group_by(bd4, activity_name, subject) %>% select(1:66)
tidy_data <- summarise_each(tidy_data, funs(mean))

#Prin tidy_data
View(tidy_data)

#This code create a tidy data that follow submit instructions
write.table(tidy_data, "tidy_data.txt", row.names = F)




