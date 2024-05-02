# script for making main (i.e. not trianing) Trials csv for SOAL
# Written by YS 
# 27/2/22

setwd("C:\\Users\\Oz\\Documents\\make_SOAL_exp\\make_SOAL_exp")

# Setup #######
library(tidyverse)
#load parameters
source("parameters_make_main_trials.R")
#load functions
source("functions_make_main_trials.R")

# loading templates#####

# template of number of trials number  per block, BF location, and delay
tmplt_num_trials<-read_csv("UI_realexperiment_combined_template_19092023.csv",show_col_types = FALSE)

example_line<-read_csv("example_line.csv",show_col_types = FALSE)

#Preliminary processing ####
#making string out of subject numbers
sub_name_vec<-(sub_num_vec%>%str_glue_data("sub{num}"))

#get vector of block numbers
blck_indx<-unique(tmplt_num_trials$Block)

#get vector of first trial index per block
init_trial_val_per_blk<-get_init_trial_val(tmplt_num_trials)

#### Getting to WORK!  ######
## looping over subject vector
for (sub_num in seq_along(sub_name_vec))
{
  
  # collector variable
  trial_df<-tibble()
  
  ## add calibration line
  trial_df<-bind_rows(trial_df,make_calibration(example_line,pic_num_calibration))
  
  ## making blocks via loop
  for(blk_num in seq_along(blck_indx)){
    #extracting template specfic to block
    blk_tmplt<-tmplt_num_trials%>%
      filter(Block==blk_num)
    
    #making block
    blk_df<-make_block(example_line,blk_tmplt,init_trial_val_per_blk[blk_num])
    
    trial_df<-bind_rows(trial_df,blk_df)
    
    #adding mini-break
    trial_df<-bind_rows(trial_df,make_pic_line(example_line,blk_num,pic_num_break))
  }
  
  ## adding finish line instead of mini break at the end of experiment
  trial_df[nrow(trial_df),]<-make_pic_line(example_line,blk_num,pic_num_finish)
  
  
  
  ###Adding experiment-specfic lines with pics ####
  # IF YOU DON"T NEED THIS, COMMENT OUT TILL THE EXPORTING SECTION
  # this is done with dplyr's add_row function 
  
  ## Modify in case you want to add special lines with additional pictures (these are for the stress experiment)
  
  # adding pic of training
  #trial_df<-add_row(trial_df,make_pic_line(example_line,pic_num_train_blk,pic_num_train_blk),.after=which(trial_df$`#trial number`==0))
  
  # adding questions about mood- neutral block
  #trial_df<-add_row(trial_df,make_pic_line(example_line,pic_num_assess_mood,pic_num_assess_mood),.before = which(trial_df$`#trial number`==-1))
  
  #replacing the middle break with test block
  #trial_df[which(trial_df$`#trial number`==-3),]<-make_pic_line(example_line,pic_num_test_blk,pic_num_test_blk)
  
  # adding questions about mood- test block
  #trial_df<-add_row(trial_df,make_pic_line(example_line,pic_num_assess_mood,pic_num_assess_mood),.before = which(trial_df$`#trial number`==-4))
  
  #### exporting #####
  #creating name and path
  csv_name<-file.path(path_export,str_glue("Trials_",sub_name_vec[sub_num],".csv"))
  
  #exporting
  write_csv(trial_df,csv_name)
  
}

