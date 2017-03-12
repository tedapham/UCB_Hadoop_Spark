drop table transform_surveys;
create table transform_surveys as
select Provider_Number provider_id,

cast(Communication_with_Nurses_Performance_Rate as float) as nurse_rating,
cast(Communication_with_Doctors_Performance_Rate as float) as doctor_rating,
cast(Responsiveness_of_Hospital_Staff_Performance_Rate as float) as staff_rating,
cast(Pain_Management_Performance_Rate as float) as pain_rating,
cast(Communication_about_Medicines_Performance_Rate as float) as comm_about_meds_rating,
cast(Cleanliness_and_Quietness_of_Hospital_Environment_Performance_Rate as float) as environment_rating,
cast(Discharge_Information_Performance_Rate as float) as discharge_rating,
cast(Overall_Rating_of_Hospital_Performance_Rate as float) as overall_performance_rating


FROM surveys_responses;
