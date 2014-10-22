# I upload the requested package
library(dplyr)

##########################################
####### Part 1 ###########################
#### Merge training and test data set ####
##########################################

# I join the data in /train folder

setwd("./train")
IDTrain<-read.table("subject_train.txt", sep="\t")
actTrain<-read.table("y_train.txt", sep="\t")
featTrain<-read.table("X_train.txt", sep="")
trainDS<-cbind(IDTrain, actTrain, featTrain)
names(trainDS)[1]<-"ID"
names(trainDS)[2]<-"activity"

setwd("..")

# I join the data in /test folder

setwd("./test")
IDTest<-read.table("subject_test.txt", sep="\t")
actTest<-read.table("y_test.txt", sep="\t")
featTest<-read.table("X_test.txt", sep="")
testDS<-cbind(IDTest, actTest, featTest)
names(testDS)[1]<-"ID"
names(testDS)[2]<-"activity"

setwd("..")

# I join testDS and trainDS so to obtain a unique dataset

completeDS<-rbind(trainDS, testDS)

##############################################
####### Part 2 ###############################
#### Extract measurements on mean and std ####
##############################################

# Looking at the "activity_labels.txt" file, one can
# see that the requested values correspond to the 
# following columns of the original X_test (or X_train)
# dataset

# I consider just the features that are explicitly apply mean() and std() 
# on another variable. E.g. I exclude the features such as angle(tBodyAccJerkMean)


req<-c(seq(1,6), seq(41,46),seq(81,86),seq(121,126),seq(161,166),201,202,214
       ,215, 227,228,240,241,253,254,seq(266,271),seq(345,350),seq(424,429),
       503,504,516,517,529,530,542,543)

# I add 2 in order to have the column numbers in the new completeDS (I added two columns)
# at the beginning. I also record these two new columns.

req_compl<-2+req
req_compl=c(1,2,req_compl)


# I select the requested features

completeDS<-completeDS[,req_compl]

# I reorder the database according to the ID and, for the same ID, to the activity

completeDS<-completeDS[order(completeDS$ID, completeDS$activity),]

# ##############################################
# ####### Part 3 ###############################
# #### Descriptive names for activities ########
# ##############################################


completeDS$activity<-as.factor(completeDS$activity)
levels(completeDS$activity)<-c("Walking","Walking_up","Walking_down","Sitting",
                               "Standing","Laying")

# ##############################################
# ####### Part 4 ###############################
# #### Descriptive names for features ##########
# ##############################################

# I take again the names from the "features.txt" files

features<-read.table("features.txt", sep="")
features<-as.factor(features$V2)
names(completeDS)[seq(3,ncol(completeDS))]<-c(as.character(features[req]))

# ############################################################################
# ####### Part 5 #############################################################
# #### New tidy dataset with averages for each ID and each activity ##########
# ############################################################################

byIDandact<-group_by(completeDS, ID, activity)
tidy_dataset <- summarise_each(byIDandact,funs(mean)) 

write.table(tidy_dataset, "tidy_dataset.txt", row.names=FALSE)
