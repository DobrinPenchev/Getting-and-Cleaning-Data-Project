---
title: "CodeBook"
author: "Dobrin Penchev"
date: "December 19, 2015"
---

This file describes the variables in the tidy data set, the units of the variables as well as the transformations accomplished on the raw data to produce the tidy data set. For more information on how the run_analysis.R script works, please refer to the README.md file in the repo.

For more information and description of the variables and data collection process of the raw data set, please, refer to features_info.txt and README_Sumsung_Data.txt files in the repository.

Cleaning the complete (raw) data set:
=====================================

        1. The complete data set has been constructed from subject_train.txt, subject_test.txt, X_train, y_train, X_test and y_test data files. The content of the latter is described in README_Sumsung_Data.txt file. Activity type labels are taken from the mapping provided in activity_labels.txt file while complete data set column names come from the features.txt data file. All the files are downloaded by the run_analysis.R script.
        
        2. The columns with duplicate names have been removed from the complete data set.
        
        3. A sub-set has been created from the columns in the complete data set which contain mean() and std() in their names. Please, refer to the README.txt file for more information on the steps.
        
        4. The column names of the sub-set have been manipulated to result in non-domain user friendly readable format. For more information, please, refer to README.md file.
        
Tidy Data Set Variables Description, Units and Manipulation:
===========================================================

        1. StudyParticipant - an integer from 1 to 30 corresponding to each of the study participants.
        2. ActivityType - a string; there are 6 activity types performed by each participant - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
        3. Variable - a string; contains the user friendly names of the averages and standard deviations for the various measurements in the complete data set created from the raw data.
        4. Average - a double; this column contains the equally weighted averages of the data in the mean and respectively standard deviation columns of the measurements performed by the Sumsung Smartphone Study. The averages are computed for each activity type performed by the respective study participant.

