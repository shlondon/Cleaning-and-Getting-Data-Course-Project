train <- read.table("train/X_train.txt")
train_label <- read.table("train/y_train.txt")
features <- read.table("features.txt")
test <- read.table("test/X_test.txt")
test_label <- read.table("test/y_test.txt")
activity_label <- read.table("activity_labels.txt")
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")

names(train) <- features$V2
names(test) <- features$V2

#1.  Merges the training and the test sets to create one data set.
bd1 <- rbind.data.frame(train, test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
bd2 <- bd1[,grepl("-mean()|-std()", names(bd1))]
bd2 <- bd2[,!grepl("meanFreq()", names(bd2))]

#3. Uses descriptive activity names to name the activities in the data set
x <- rbind(train_label, test_label)
bd3 <- cbind.data.frame(bd2, x)
names(bd3)[67] <- "activity_code"

#Creo un vector nuevo que etiqueta según el código de actividad
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
bd4 <- cbind.data.frame(bd3, rbind(subject_train, subject_test))
names(bd4)[69] <- "subject"

bd4 <- cbind.data.frame(bd4, set = c(rep("train", 7352),
                                     rep("test", 2947)))
bd4$subject <- as.factor(bd4$subject)

#5. From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

library(dplyr)

#Código para que en el tidy date las actividades aparezcan en el mismo orden que en
#el archivo activity label
bd4$activity_name <- factor(bd4$activity_name, 
                            levels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                                       "SITTING", "STANDING", "LAYING"))
tidy_data <- group_by(bd4, activity_name, subject) %>% select(1:66)

tidy_data <- summarise_each(tidy_data, funs(mean))

#Se imprime el tidy data
tidy_data

