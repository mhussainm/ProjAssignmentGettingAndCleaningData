# Getting and Cleaning Data - R Programming Assignment
A walkthrough of the data clean-up and summarization done to meet the project submission guidelines.

1. Load the required 'dplyr' library
2. Load the 'features' file to find the column/variable names for the observations in data sets
..1. Since the Step #2 of the instructions reads *"Extracts only the measurements on the mean and standard deviation for each measurement"*, only the feature/variable names containing the keyword "mean" or "std" are to be retained for analysis
..2. Thus created a subset of the 'features' table holding the feature names containing "mean" or "std" using grep().
..3. Since I will be using the $featureName to replace the column names of the data sets later I have removed the ugly "()" from the column names using the sub() and regular expression *"\\(\\)"* to find a match.
3. Load the 'activities' file to find the activity names for the observations in data sets
4. Load TEST subjects from the "test/subject_test.txt" file
5. Load TEST activities from the "test/y_test.txt" file
6. Load TEST data set of observations from the "test/X_test.txt" file
..1. Retain only the columns/variables holding the "mean" or "std" by select() on the filtered features list from 3(ii)
..2. Rename the columns to appropriate names derived from the features list from 3(iii)
7. Add the TEST subjects and activities are two new columns to the TEST data set
8. Performed **Steps 3 to 7 on the TRAIN data set** 
9. Merged the TEST and TRAIN data sets using the rbind() function since we need to merge the data frames by rows and not columns.
10. Added a factor to replace the activity codes with the activity names on the merged data frame.
11. Sorted the merged data frame by Subjects and then Activity.
12. Used the group_by() and summarise_each() functions to derive the average i.e. mean of the measurements by the Subjects and the Activities.
13. Wrote the **tidy and summarized data set** to the file as required.