Readme for the script run_analysis

The script assumes that the data is in a folder "UCI HAR Dataset" in the homefolder set in R.

The packages "Reshape" and "plyr" needs to be installed.

The script imports and merges all the files and names the columns. The the appropriate columns are selected and the 
data narrowed down as instructed. Then final dataset is of the tall variety.

The script does the following:
  -Imports all the different datasets
  -Selecting only the variables with mean and standard deviation for the accelerometer and gyroscope.
      My interpretation of the instructions is that raw data that further data, such as "jerk" is derived from.
      Therefore I keep only those fewer variables. The instructions leave quite a bit of room form interpretation.
      
