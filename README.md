# Cleaning-and-Getting-Data-Course-Project

*Santiago Humberto Londoño Restrepo*

The run_analysis.R script take different data sets from data directory supplied by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, 
Luca Oneto and Xavier Parra, who ran a experiment called Human Activity Recognition Using Smartphones Data Set and it creates a tidy data set.

The data directory includes the following files:

- 'features.txt': List of all features.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Main steps in run_analysis.R script

1. it up data into R environment from data directory with named appropriately
2. it give names to train and test data.frames with the names stored in features data.frame
3. it merges the training and the test sets to create one data set.
4. it extracts only the measurements on the mean and standard deviation for each measurement
5. it creates a new vector with activity code
6. it creates a new vector with activity name
7. it creates a new vector with participants in the samsung´s experiment
8. it creates a independent tidy data set with the average of each variable for each activity and each subject.
9. it creaates a create a tidy_data.txt file


