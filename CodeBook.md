# Codebook for GetData_PeerAssesment1

The data was originally obtained from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), where the whole data description is available.

The fixed version of the data set used for analysis can be found under the [link]{https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip}.

## Data Set Origin

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Attribute Information

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

## Codebook for the result dataset

While merging the given data the following datasets have been introduced:
1. A table `person.number` containing `"PERSON_NUMBER"` - a subject number for both training (added first) and testing (added last) set;
2. A table `activity.number` containing `"ACTIVITY_NUMBER"` - an activity number for both training (added first) and testing (added last) set;
3. A table `activity.name` containing `"ACTIVITY_NAME"` - an activity name (factor, can be one of the 6 values) for both training (added first) and testing (added last) set;
4. A table `measures` containing 561 features of different measurements of activity tracker (variables are just the same as in `features.txt` in the original data set) also for both training (added first) and testing (added last) set;
5. A table `tidy.measures` containing tables `person.number`, `activity.name`, and `measures` correspondingly
6. A table `tidy.mean.sd` which is the subtable of `tidy.measures` and contain `"PERSON_NUMBER"`, `"ACTIVITY_NAME"` and those measurements which are either mean or standard deviation of a measurement
7. A table `tidy.final` which contains the average of each variable for each activity `"ACTIVITY_NAME"` and each subject `"PERSON_NUMBER"` of the table `tidy.mean.sd`

