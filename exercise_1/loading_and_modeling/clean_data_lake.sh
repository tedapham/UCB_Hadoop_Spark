#!/bin/bash

# remove staging directory and files
rm ~/staging/exercise_1/*
rmdir ~/staging/exercise_1
rmdir ~/staging
# remove hdfs files and directory


hdfs dfs -rm /user/w205/hospital_compare/hospitals/hospitals.csv
hdfs dfs -rm /user/w205/hospital_compare/effective_care/effective_care.csv
hdfs dfs -rm /user/w205/hospital_compare/readmission/readmission.csv
hdfs dfs -rm /user/w205/hospital_compare/measures/Measures.csv
hdfs dfs -rm /user/w205/hospital_compare/surveys_responses/surveys_responses.csv

hdfs dfs -rmdir /user/w205/hospital_compare/hospitals
hdfs dfs -rmdir /user/w205/hospital_compare/effective_care
hdfs dfs -rmdir /user/w205/hospital_compare/readmission
hdfs dfs -rmdir /user/w205/hospital_compare/measures
hdfs dfs -rmdir /user/w205/hospital_compare/surveys_responses

hdfs dfs -rmdir /user/w205/hospital_compare
# clean exit
exit

