The file run_analysis.R is run from the same directory as the UCI HAR Dataset.  The file requests data from the data set and modifies, reshapes it, and creates a tidy date set.  Information of the  run_analysis.R operation is below followed by more detail on the data set.   For more details on the code see the codebook.md in this directory.

Run_analysis.R operation
========================

The libraries of ddplr and reshape2 are loaded and then the training data set is loaded into traindata from X_train.txt 
and the features.txt file is loaded to create the column names.  

Two additional columns are created.  Action_ID is from the y_train.txt file and has digit from 1-6 denoting the type of activity.
Person_ID has the number of the test volunteers from the subject_train.txt.  Action_ID and PersonID are then added to the 
traindata with rbind.  

The features.txt file is used to create featureslist which is then loased into the column names of the traindata.  Finally the Action_ID and Person_ID columns are named.

The same process is repeated with the test data directory to create the testdata dataframe.  Then traindata and testdata are joined together with rbind to make bigdata.  

The Action_ID column is then converted from number 1-6 format to the descriptive activity name WALKING SITTING, etc.  

The column names are then converted to more decriptive names with a series of gsub cammands removing -, (), and certain lower
case letters from the column names.

bigdata is then converted to DataShow and DataView with the melt and dcast commands.  
These commands use the Action_ID and Person_ID as identifiers and average all of the other readings for each column name.  

The DataView is converted to DataView.txt file with columns aligned and significant digits reduced to 5 to keep with 
a tidy data set.  This the output of run_analysis.R.


==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.




License:
========
Use of the Run_Analysis.R script is free for all users.

Use of the resulting dataset "tidy_movement_data.txt" in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the author for its use or misuse. Any commercial use is prohibited.












