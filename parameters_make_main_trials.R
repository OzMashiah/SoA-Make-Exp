# Parameters for making main trials SOAL

##### File names and locations #####

# ENTER here the subjects' NUMBER (e.g. 33)
# this will be added to string 33-> sub33. 
#  this will be added to Trials.csv name, so it  is Trials_XXX.csv (XXX= sub_name)
sub_num_vec<-data.frame(num=c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
                              15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
                              27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
                              39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
                              51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62,
                              63, 64, 65, 66, 67, 68, 69, 70)) # DEFINE HERE SUBJECT NUMBERS 

#Define where to store Trials.csv
# ensure that folder exists. 
# path is relative to working directory
path_export='ui_realexperiment\\combined'



#### Picture numbers #####
#Values need to correspond with those in Questions.csv
##neccesary pics
pic_num_calibration<-9999
pic_num_break<-1
pic_num_finish<-2

#optional- used in stress exp. 
pic_num_train_blk<-300
pic_num_test_blk<-400 # this starts with calling the experimenter
pic_num_assess_mood<-500 # questions to asses mood, the three pics are stringed after each other




