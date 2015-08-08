# Coursera-Getting-and-Cleaning-Data-Course-Project

This is the repository for the Coursera Getting and Cleaning Data Course project.
The R script, `run_analysis.R`, does the following:

1. Download and unzip the dataset if it does not already exist in the working directory
2. Load and merge the training and tests datasets
3. Keeping only the columns which contain mean and standard deviation measurements from the datasets
4. Load the activity and subject data and set its column name to be descriptive
5. Merge all data into one dataset all_data, including datasets, activity and subject data
6. Create a new tidy dataset that consists of the mean value of each variable for each value of subject and activity, will consist of 180 rows, 81 columns and 79 mean measurements columns
7. The end result is shown in the file `tidy_data.txt`.
