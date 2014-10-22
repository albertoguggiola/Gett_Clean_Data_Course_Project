---
title: "README for run_analysis.R file"
author: "Alberto Guggiola"
date: "22/10/2014"
output: html_document
---

## Part 1: Merging train and test datasets

### Merging separately the train and the test datasets

The working directory is changed to the "./train" subdirectory. The three files ("subject_train.txt", "y_train.txt" and "X_train.txt") giving respectively the ID of each data row, the activity done and all the measured features are separately read. 

The three files are merged by a cbind command, leading to a new trainDS dataset with all the information above described for each observation.

The same is done in the "./test" subdirectory.

The trainDS and testDS datasets are eventually merged using a rbind command, leading to a completeDS.

The names of the two first columns are changed, for clarity, to "ID" and "activity".


## Part 2: Extracting mean and std features

The requested columns are selected according to the descriptions given in the "features.txt" file. It has been chosen to select just the columns corresponding to an explicit application of mean() or std() functions, excluding cases such as "angle(tBodyAccJerkMean)".

The first two columns of the completeDS (ID and activity) are also selected.

For simplicity, the database is also reordered according to IDs and, for the same ID, to the activities.

## Part 3: Assigning descriptive names to activities


Using the levels() function, and verifying on the "activity_labels.txt" file the correspondance, the levels of the "activity" factors are renamed with the mapping (1,2,3,4,5,6)->("Walking", "Walking_up", "Walking_down", "Sitting", "Standing", "Laying")


## Part 4: Assigning descriptive names to features

The name of the columns associated to the different features are renamed according to the corresponding lines of the "features.txt" file. The selected rows are the same as the selected columns of Part 2.

## Part 5: Creating a new tidy dataset with averages over IDs and activities

For each ID and activity, several rows are present in the dataset. The objective of this part is to obtain a new tidy dataset with the mean values of all the features for all the observations corresponding to a same pair (ID, activity). This is done by making use of two functions available in the dplyr package ("group_by" and "summarise_each").

Finally, the obtained table is written to the file "tidy_dataset.txt". The correct approach for reading it is to give a View(read.table("tidy_dataset.txt")) command.


