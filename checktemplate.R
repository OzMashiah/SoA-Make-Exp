setwd("C:\\Users\\Oz\\Documents\\make_SOAL_exp\\make_SOAL_exp")

# Setup #######
library(tidyverse)
#load parameters
source("parameters_make_main_trials.R")
#load functions
source("functions_make_main_trials.R")

# template of number of trials number  per block, BF location, and delay
tmplt_num_trials<-read_csv("UI_newloc_template_num_trials_per_block_19012023.csv",show_col_types = FALSE)

example_line<-read_csv("example_line.csv",show_col_types = FALSE)

#tmplt_num_trials<-tmplt_num_trials[,c("Butterfly side", "Delay",
#                                      "Butterfly Number", "Angle")]
tmplt_num_trials1<-tmplt_num_trials[,c("Delay","Angle")]
tmplt_num_trials2<-tmplt_num_trials[,c("Block","Butterfly side", "Butterfly Number")]

conditions <- tmplt_num_trials1 %>% group_by_all() %>% summarise(COUNT = n())
blockloc <- tmplt_num_trials2 %>% group_by_all() %>% summarise(COUNT = n())

