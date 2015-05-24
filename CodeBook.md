#Getting and Cleaning Data Project


##Source Data

Full description of data used in project can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data for this project can be found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##Attribute Information

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment. 

##1. Merges the training and the test sets to create one data set.

Source directory for the files set & tabulate:

features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt
Column names assigned and merge to one data set.

##2. Extracts only the measurements on the mean and standard deviation for each measurement.

Logical vector created containing TRUE values for the ID, mean and stdev columns and FALSE values for the others. Subset data to keep necessary columns.

##3. Uses descriptive activity names to name the activities in the data set

Merge data subset with the activityType table for inclusion of descriptive activity names

##4. Appropriately labels the data set with descriptive variable names.

 gsub function used to clean up the data labels.

##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Data set with the average of each veriable for each activity and subject is produced
