#!/bin/bash

# save my current directory

MY_DIR=$(pwd)

# create staging directory
mkdir ~/staging
mkdir ~/staging/exercise_1

# change to staging directory
cd ~/staging/exercise_1

# get file from data.medicare.gov
MY_URL="https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"
wget "$MY_URL" -O medicare_data.zip

# unzip the medicare data
unzip medicare_data.zip

# assign file name

hospitals="Hospital General Information.csv"
effective_care="Timely and Effective Care - Hospital.csv"
readmission="Readmissions and Deaths - Hospital.csv"
Measures="Measure Dates.csv"
surveys_responses="hvbp_hcahps_11_10_2016.csv"

# remove the first line and rename
tail -n +2 "$hospitals" >hospitals.csv
tail -n +2 "$effective_care" >effective_care.csv
tail -n +2 "$readmission" >readmission.csv
tail -n +2 "$Measures" >Measures.csv
tail -n +2 "$surveys_responses" >surveys_responses.csv

# create hdfs hospital compare
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/readmission
hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -mkdir /user/w205/hospital_compare/surveys_responses

# copy file to hdfs
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care
hdfs dfs -put readmission.csv /user/w205/hospital_compare/readmission
hdfs dfs -put Measures.csv /user/w205/hospital_compare/measures
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses
