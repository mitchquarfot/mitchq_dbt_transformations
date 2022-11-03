select person_name, listagg(distinct title,', ') within group (order by title asc), (sum(revenue)/sum(budget)) as profit_ratio
from
(select a.movie_id, title, b.person_id, person_name, cast_order, concat(a.movie_id, b.person_id, b.cast_order) as appearance_id, revenue, budget
from "MITCH"."GCP_SQLSERVER_TELEPORT_DEMO_MOVIES_DBO"."MOVIE" a 
join "MITCH"."GCP_SQLSERVER_TELEPORT_DEMO_MOVIES_DBO"."MOVIE_CAST" b on a.movie_id = b.movie_id
join "MITCH"."GCP_SQLSERVER_TELEPORT_DEMO_MOVIES_DBO"."PERSON" c on b.person_id = c.person_id
where budget != 0
and cast_order = 0
group by 1,2,3,4,5,6,7,8)
group by 1
having count(distinct appearance_id) >= 5
order by profit_ratio desc;