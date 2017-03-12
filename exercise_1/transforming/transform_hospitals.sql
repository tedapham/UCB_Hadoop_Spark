drop table transform_hospitals;

create table transform_hospitals as
select provider_id,
hospital_name,
state,
case when (hospital_overall_rating like 'Not%') then 0
else cast(hospital_overall_rating as float) 
end as rating,
mortality_national_comparison mortality,
safety_of_care_national_comparison safety,
readmission_national_comparison readmission,
patient_experience_national_comparison p_experience,
effectiveness_of_care_national_comparison e_care,
timeliness_of_care_national_comparison t_care,
efficient_use_of_medical_imaging_national_comparison m_image
from hospitals;
