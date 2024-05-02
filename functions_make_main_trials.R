#functions for making main trials

#function that makes block of trials
#INPUT
make_block<-function(example_line,tmplt_num_trials_blk,init_trial_number){
  #making trials as specfied by the template#####
  
  blk_trial<-tibble()
  
  #looping through the tmplt lines (one day change to map and not loop)
  for (i in seq_along(1:nrow(tmplt_num_trials_blk))){
    #extracting specfic lines
    tmplt_num_trials_line<-tmplt_num_trials_blk[i,]
    #making new Trial.csv lines
    new_lines<-make_new_lines(example_line,tmplt_num_trials_line)
    #concating
    blk_trial<-bind_rows(blk_trial,new_lines)
  }
  
  #Shuffling
  blk_trial<-blk_trial%>%
    slice_sample(n = nrow(blk_trial), replace = FALSE)
  
  #add Trail Number
  blk_trial$`#trial number`<-c(init_trial_number:(init_trial_number+nrow(blk_trial)-1))
  
  return(blk_trial)
}

#Function to transfor single template line into Trial.csv lines
make_new_lines<-function(example_line,tmplt_num_trials_line){
  new_line<-example_line
  #change block number
  new_line$`block number`<-tmplt_num_trials_line$Block
  
  #change delay
  new_line$`SensoMotoric Delay`<-tmplt_num_trials_line$Delay
  
  #change angle
  new_line$`angleChange`<-tmplt_num_trials_line$Angle
  
  #change BF number
  new_line$`setup task Number`<-tmplt_num_trials_line$`Butterfly Number`
  
  #change Question number
  new_line$`Question Number`<-tmplt_num_trials_line$`Question Number`
  
  #duplicating rows according to Num Trails in tmplt_num_trials
  new_line_dup<-new_line%>%
    slice(rep(1:n(), each =tmplt_num_trials_line$`Num trials`))
  
  return(new_line_dup)
}

# Function to get trial index of each Block's first trial 
get_init_trial_val<-function(tmplt_num_trials){
  t<-tmplt_num_trials%>%
    mutate(cumcount=cumsum(`Num trials`))%>%
    group_by(Block)%>%
    summarize(m=dplyr::last(cumcount))
  t2<-as.vector(t$m)
  t2<-t2[-length(t2)]
  t2<-t2+1
  t2<-c(1,t2)
}

# # Function to make a line in which a picture is simply presented. 
# for example a mini break line
# INPUT: 
#line_num: determines trial number and block number- automaticly given a negative value 
# pic num: number detrermined by Questions.csv
make_pic_line<-function(example_line,line_num,pic_num){
 break_line<-example_line
 break_line$`#trial number`<-line_num*-1
 break_line$`block number`<-line_num*-1
 break_line$`room Duration`<-0
 break_line$`black Screen Duration`<-1
 break_line$`Question Number`<-pic_num
 return(break_line)
}


# Function to make calibration line
make_calibration<-function(example_line,pic_num_calibration,room_duration=60){
  cal_line<-example_line
  cal_line$`#trial number`<-0
  cal_line$`block number`<-0
  cal_line$`room Duration`<-room_duration
  cal_line$`line type`<-"Calibration"
  cal_line$`Question Number`<-pic_num_calibration
  
  return(cal_line)
}



