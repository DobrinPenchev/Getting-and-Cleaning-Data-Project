---
title: "README"
author: "Dobrin Penchev"
date: "December 19, 2015"
---

Description of the files in this repo:

        1. Run_analysis.R

Run_analysis.R is an R script which creates a tidy data set from an initial data set with measurements of different variables in the UCI HAR Dataset. The latter represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The feature_info.txt and Readme_Sumsung_data.txt files provide more  information on the raw data set from which the tidy data set has been created. The script contains various comments along the lines which describe the steps taken to arrive from the raw data set to the tidy data set. For completeness those are presented here as well:

        a) Creates a separate folder in R working directory, downlaods the raw data set from a source website and unzips the file with the data. It also records the date when the file has been downloaded.
        
        b) Reads all relevant files from the folders and created a complete data set including both the training and the test data sets as well as the activities performed and the study participants for the different observation measurements in the data set.
        
        c) Assigns names to the columns in the complete data set based on information from a different file containing the column names.
        
        d) Replaces the activity ids in the complete data set with their names from a separate codebook file which maps activity ids to activity names.
        
        e) Removes duplicate columns from the complete data set. Duplicate columns are columns which have the same name. Those columns are non-essential to the columns containing the relevant data which the tidy data set is based on.
        
        f) Creates a sub-set of the complete data set. The sub-set contain only the columns in the complete data set which contain information about the mean and standard deviation of the measurements collected by the experiment.
        
        g) changes the column names of the sub-set so that those have user friendly names, do not contain special symbols and presumably the column headings are descriptive and can be understood by non-domain experts. The column names still have capital letters to allow the human reader to differentiate between the various parts of the name. A lower case string of all column name letters is deemed user-unfriendly.
        
        h) creates a tidy data set containig averages of the columns in the sub-set where classification of averages is performed by first grouping data by participant in the study and subsequently by activity type for each participant.
        
        i) finally, the script writes the tidy data set in a text file which appears in the initial parent folder where the raw data has been downloaded. 

        2. CodeBook.md is a file that describes the various varibales in the tidy data set, their units of measurement and  transformations performed on the raw data set to produce the clean data set.
        
        3. Feature_info.txt - contains description of the process of feature selection in the raw data set.
        
        4. README_Sumsung_data.txt describes the framework of the experiment which produced the raw data set as well as the input files used by the run_analysis.R script.

