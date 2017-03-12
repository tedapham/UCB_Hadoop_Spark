drop table transform_measures;
create table transform_measures as 
select
measure_id,
measure_name,
measure_start_date,
measure_end_date
from measures;
