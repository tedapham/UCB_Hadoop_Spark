drop table best_states;
create table best_states as
select state, sum(rank) state_rank, count(*) count
from best_hospitals
group by state
order by state_rank asc;

select state, state_rank/count state_avg
from best_states 
where count > 10
order by state_avg asc
limit 10;
