Analysis Procedure:

1. The following libraries are necessary to be loaded in RStudio: magrittr and plyr
2. Download and unzip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. In this case, I this these 2 steps manually.
3. All the necessary files are placed in the working directory. These files are as follows:

- activity_labels.txt
- features.txt
- subject_test.txt
- subject_train.txt
- X_test.txt
- X_train.txt
- y_test.txt
- y_train.txt

4. The above files are read using read.table. The data are stored in corresponding data frames with descriptive column names
5. The following Train data are combined together using cbind: X_train, y_train and subject_train
6. The following Test data are combined together using cbind: X_test, y_test and subject_test
7. Combined Train and Test data will then be merged together using rbind
8. Afterwhich, we only retrieve the following variables from the merged Train and Test data from #7: activityId, subjectId and all variables names with std and mean
9. Then we attach the activityType from activity_labels to provide descriptive name for each activityId
10. Finally, using pipe operator, we do the following:

- take the mean of all variable names with std and mean grouping the observations by subjectId and activityId
- order the result by subjectId and activityId
- then write the final result in a txt file using write.table