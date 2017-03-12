drop table transform_readmissions;


create table transform_readmissions as
select
provider_id,
measure_id,
measure_name,
cast(score as float) score
from readmissions 
where (score not like 'Not%') or
(score is not null);
