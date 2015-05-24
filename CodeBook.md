# Code Book - Tidy Data (Output of run_analysis.R script)
This code book explains the variables, summaries calculated for the programming assignment including any data transformations applied

The site where the data was obtained:
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###### Except for adding two new variables to the summarized data set (tidy data file), all the other variable names and description are the same as in the README.txt of the source data with the only Exception that the tidy data set has the variables averaged for each Subject and the Activity. ######

##### Data Transformations #####
1. Used the 'features' data to extract the column names required for the final data set i.e the mean and std of the measurements.
2. Also did clean up on the feature names to remove the "()" to beautify the column names of the final data set
3. After reading both the TEST and TRAIN versions of the data sets, removed the columns not required using the filtered 'features' list
4. Added the Subjects and Activities as new columns to both the TEST and TRAIN data sets before merging them as these were provided on separate files.
5. Merged (basically appended) the TEST and TRAIN data frames by rows (instead of columns)
6. Added a factor to replaced activity codes by labels denoting the activities in the merged data set
7. Grouped the merged data set by Subjects and then Activities and finally summarized each activity group by taking a average/mean of the measurements for that Subject and Activity.