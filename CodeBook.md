# Tidy and Averaged UCI Human Activity Recognition Using Smartphones Data Set
# Code Book

## Overview from the [original](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

> Attribute Information:

> For each record in the dataset it is provided: 

> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
> - Triaxial Angular velocity from the gyroscope. 
> - A 561-feature vector with time and frequency domain variables. 
> - Its activity label. 
> - An identifier of the subject who carried out the experiment.


## Tidy datasets

The dataset has been tidied into the following tables:

- averages_by_activity_and_subject.txt
- tidy/subjects.txt
- tidy/activities.txt
- tidy/HAR_sensor_measurements.txt

### Averages by activity and subject

averages_by_acitivity_and_subject.txt inclues 187 records, consisting of the 86 mean and standard deviation of all original variables, further averaged by activity and subject. 

### Subjects

tidy/subjects.txt includes two self-explanatory variables and has 30 records:

- `subject_id`
- `sample_type` (`test` vs. `train`)

### Activities

tidy/activities.txt includes an `activity_id` and `activity_name` for the six activites, in their original, all-caps form as mentioned in the original above (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

### HAR sensor measurements

For tidy/HAR_sensor_measurements.csv, the experiments table has been filtered to only include the 86 mean and standard deviation measurements for all the variables. Columns have been renamed to more descriptive labels, as described below. `activity_id` and `subject_id` columns have been added to link to their respective tables. The table consists of 10,299 sample windows. As mentioned above in the original documentation above, each window summarizes 128 readings "in fixed-width sliding windows of 2.56 sec[onds] and 50% overlap."

#### Summary of the measurement column names

As in the original, the following components make up the measurement columns (renamed to be more descriptive):

- `time` vs. `frequency` (renamed from 't' vs. 'f'), indicating the domain of the measurement. Note that "Features are normalized and bounded within [-1,1]." The exact units of time and frequency are not clearly specified.
- `body` vs. `gravity` acceleration, indicating estimates for body vs. gravity contribution to total acceleration. These are accelerometer readings ('Acc' in the original).
- `body angular velocity`. These are gyrometer readings ('Gyro' in the original).
- `jerk` signals, as described in the original: "the body linear acceleration and angular velocity were derived in time to obtain Jerk signals".
- `magnitude` of the three-dimensional jerk signals "were calculated using the Euclidean norm".
- `X`, `Y` or `Z` `axial`, "to denote the 3-axial signals in the X, Y and Z directions.""
- `mean` and `standard deviation` estimated from the signals
- `sample average angle` for "Additional vectors obtained by averaging the signals in a signal window sample." The original variables were named "angle(..)"

Putting all these components together, the following 86 measurement variables result:

 [1] "time_body_acceleration_mean_X_axial"                                  
 [2] "time_body_acceleration_mean_Y_axial"                                  
 [3] "time_body_acceleration_mean_Z_axial"                                  
 [4] "time_body_acceleration_standard_deviation_X_axial"                    
 [5] "time_body_acceleration_standard_deviation_Y_axial"                    
 [6] "time_body_acceleration_standard_deviation_Z_axial"                    
 [7] "time_gravity_acceleration_mean_X_axial"                               
 [8] "time_gravity_acceleration_mean_Y_axial"                               
 [9] "time_gravity_acceleration_mean_Z_axial"                               
[10] "time_gravity_acceleration_standard_deviation_X_axial"                 
[11] "time_gravity_acceleration_standard_deviation_Y_axial"                 
[12] "time_gravity_acceleration_standard_deviation_Z_axial"                 
[13] "time_body_acceleration_jerk_mean_X_axial"                             
[14] "time_body_acceleration_jerk_mean_Y_axial"                             
[15] "time_body_acceleration_jerk_mean_Z_axial"                             
[16] "time_body_acceleration_jerk_standard_deviation_X_axial"               
[17] "time_body_acceleration_jerk_standard_deviation_Y_axial"               
[18] "time_body_acceleration_jerk_standard_deviation_Z_axial"               
[19] "time_body_angular_velocity_mean_X_axial"                              
[20] "time_body_angular_velocity_mean_Y_axial"                              
[21] "time_body_angular_velocity_mean_Z_axial"                              
[22] "time_body_angular_velocity_standard_deviation_X_axial"                
[23] "time_body_angular_velocity_standard_deviation_Y_axial"                
[24] "time_body_angular_velocity_standard_deviation_Z_axial"                
[25] "time_body_angular_velocity_jerk_mean_X_axial"                         
[26] "time_body_angular_velocity_jerk_mean_Y_axial"                         
[27] "time_body_angular_velocity_jerk_mean_Z_axial"                         
[28] "time_body_angular_velocity_jerk_standard_deviation_X_axial"           
[29] "time_body_angular_velocity_jerk_standard_deviation_Y_axial"           
[30] "time_body_angular_velocity_jerk_standard_deviation_Z_axial"           
[31] "time_body_acceleration_magnitude_mean"                                
[32] "time_body_acceleration_magnitude_standard_deviation"                      
[33] "time_gravity_acceleration_magnitude_mean"                                 
[34] "time_gravity_acceleration_magnitude_standard_deviation"                   
[35] "time_body_acceleration_jerk_magnitude_mean"                               
[36] "time_body_acceleration_jerk_magnitude_standard_deviation"                 
[37] "time_body_angular_velocity_magnitude_mean"                                
[38] "time_body_angular_velocity_magnitude_standard_deviation"                  
[39] "time_body_angular_velocity_jerk_magnitude_mean"                           
[40] "time_body_angular_velocity_jerk_magnitude_standard_deviation"             
[41] "frequency_body_acceleration_mean_X_axial"                                 
[42] "frequency_body_acceleration_mean_Y_axial"                                 
[43] "frequency_body_acceleration_mean_Z_axial"                                 
[44] "frequency_body_acceleration_standard_deviation_X_axial"                   
[45] "frequency_body_acceleration_standard_deviation_Y_axial"                   
[46] "frequency_body_acceleration_standard_deviation_Z_axial"                   
[47] "frequency_body_acceleration_mean_frequency_X_axial"                       
[48] "frequency_body_acceleration_mean_frequency_Y_axial"                       
[49] "frequency_body_acceleration_mean_frequency_Z_axial"                       
[50] "frequency_body_acceleration_jerk_mean_X_axial"                            
[51] "frequency_body_acceleration_jerk_mean_Y_axial"                            
[52] "frequency_body_acceleration_jerk_mean_Z_axial"                            
[53] "frequency_body_acceleration_jerk_standard_deviation_X_axial"              
[54] "frequency_body_acceleration_jerk_standard_deviation_Y_axial"              
[55] "frequency_body_acceleration_jerk_standard_deviation_Z_axial"              
[56] "frequency_body_acceleration_jerk_mean_frequency_X_axial"                  
[57] "frequency_body_acceleration_jerk_mean_frequency_Y_axial"                  
[58] "frequency_body_acceleration_jerk_mean_frequency_Z_axial"                  
[59] "frequency_body_angular_velocity_mean_X_axial"                             
[60] "frequency_body_angular_velocity_mean_Y_axial"                             
[61] "frequency_body_angular_velocity_mean_Z_axial"                             
[62] "frequency_body_angular_velocity_standard_deviation_X_axial"               
[63] "frequency_body_angular_velocity_standard_deviation_Y_axial"               
[64] "frequency_body_angular_velocity_standard_deviation_Z_axial"               
[65] "frequency_body_angular_velocity_mean_frequency_X_axial"                   
[66] "frequency_body_angular_velocity_mean_frequency_Y_axial"                   
[67] "frequency_body_angular_velocity_mean_frequency_Z_axial"                   
[68] "frequency_body_acceleration_magnitude_mean"                               
[69] "frequency_body_acceleration_magnitude_standard_deviation"                 
[70] "frequency_body_acceleration_magnitude_mean_frequency"                     
[71] "frequency_body_body_acceleration_jerk_magnitude_mean"                     
[72] "frequency_body_body_acceleration_jerk_magnitude_standard_deviation"       
[73] "frequency_body_body_acceleration_jerk_magnitude_mean_frequency"           
[74] "frequency_body_body_angular_velocity_magnitude_mean"                      
[75] "frequency_body_body_angular_velocity_magnitude_standard_deviation"        
[76] "frequency_body_body_angular_velocity_magnitude_mean_frequency"            
[77] "frequency_body_body_angular_velocity_jerk_magnitude_mean"                 
[78] "frequency_body_body_angular_velocity_jerk_magnitude_standard_deviation"   
[79] "frequency_body_body_angular_velocity_jerk_magnitude_mean_frequency"       
[80] "sample_average_angle_time_body_acceleration_mean_by_gravity"              
[81] "sample_average_angle_time_body_acceleration_jerk_mean_by_gravity_mean"    
[82] "sample_average_angle_time_body_angular_velocity_mean_by_gravity_mean"     
[83] "sample_average_angle_time_body_angular_velocity_jerk_mean_by_gravity_mean"                          
[84] "sample_average_angle_X_axial_by_gravity_mean"                             
[85] "sample_average_angle_Y_axial_by_gravity_mean"                             
[86] "sample_average_angle_Z_axial_by_gravity_mean"

## References

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

