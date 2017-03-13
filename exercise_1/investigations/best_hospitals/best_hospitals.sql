


drop table temp_hospitals;

create table temp_hospitals as
select provider_id, hospital_name, state,
rating,

case when (mortality like 'Above%') then 2
when (mortality like 'Same%') then 1
when (mortality like 'Below%') then -1
else 0
end as mortality_score,

case when (safety like 'Above%') then 2
when (safety like 'Same%') then 1
when (safety like 'Below%') then -1
else 0
end as safety_score,

case when (readmission like 'Above%') then 2
when (readmission like 'Same%') then 1
when (readmission like 'Below%') then -1
else 0
end as readmission_score,

case when (p_experience like 'Above%') then 2
when (p_experience like 'Same%') then 1
when (p_experience like 'Below%') then -1
else 0
end as p_experience_score,

case when (e_care like 'Above%') then 2
when (e_care like 'Same%') then 1
when (e_care like 'Below%') then -1
else 0
end as e_care_score,

case when (t_care like 'Above%') then 2
when (t_care like 'Same%') then 1
when (t_care like 'Below%') then  -1
else 0
end as t_care_score,

case when (m_image like 'Above%') then 2
when (m_image like 'Same%') then 1
when (m_image like 'Below%') then -1
else 0
end as m_image_score
from transform_hospitals;

drop table hospitals_general_score;
create table hospitals_general_score as
select provider_id, hospital_name, state,
(0.7*rating + 0.3*(mortality_score + safety_score + readmission_score + p_experience_score + e_care_score + t_care_score + m_image_score)) hospitals_general_score
from temp_hospitals;

drop table hospitals_general_rank;
create table hospitals_general_rank as
select provider_id, hospital_name, state,
rank() over(order by hospitals_general_score desc) hospitals_general_rank
from hospitals_general_score;

drop table temp_hospitals;
drop table hospitals_general_score;




drop table effective_care_metric;
create table effective_care_metric as
select * from transform_effective_care
where measure_id in ('ED_1b','ED_2b','OP_20','OP_22','OP_1','OP_18b','OP_21','OP_3b','OP_5','PC_01');

drop table effective_care_metric_rank;
create table effective_care_metric_rank as
select provider_id, measure_id,
rank() over(partition by measure_id order by score asc) as rank
from effective_care_metric;

drop table effective_care_score;
create table effective_care_score as
select provider_id, count(*) count, sum(rank) total
from effective_care_metric_rank
group by provider_id
having count > 1;

drop table effective_care_average;
create table effective_care_average as
select provider_id, total/count avg_rank
from effective_care_score;


drop table effective_care_rank;
create table effective_care_rank as
select provider_id,
rank() over(order by avg_rank asc) effective_care_rank
from effective_care_average;



drop table readmissions_metric;
create table readmissions_metric as
select provider_id, measure_id, score,
rank() over(partition by measure_id order by score asc) as rank
from transform_readmissions;

drop table readmissions_avg_rank;
create table readmissions_avg_rank as
select provider_id, count(*) count, sum(rank) total
from readmissions_metric
group by provider_id;

drop table readmissions_avg_average;
create table readmissions_avg_average as
select provider_id, total/count avg_rank
from readmissions_avg_rank;

drop table readmissions_rank;
create table readmissions_rank as
select provider_id,
rank() over(order by avg_rank asc) readmissions_rank
from readmissions_avg_average;


drop table best_hospitals;
create table best_hospitals as
select g.provider_id, g.hospital_name, g.state, (g.hospitals_general_rank + 2*e.effective_care_rank + 2*r.readmissions_rank)/5 rank
from hospitals_general_rank g, effective_care_rank e, readmissions_rank r
where g.provider_id = e.provider_id and
g.provider_id = r.provider_id and
e.provider_id = r.provider_id
order by rank asc;

select * from best_hospitals limit 10;

