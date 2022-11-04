select agg.person_name, listagg(distinct agg.title,', ') within group (order by agg.title asc) as title_list, (sum(agg.revenue)/sum(agg.budget)) as profit_ratio
from
(select a.movie_id, a.title, b.person_id, c.person_name, b.cast_order, concat(a.movie_id, b.person_id, b.cast_order) as appearance_id, a.revenue, a.budget
from "MITCH"."GCP_SQLSERVER_TELEPORT_DEMO_MOVIES_DBO"."MOVIE" a 
join "MITCH"."GCP_SQLSERVER_TELEPORT_DEMO_MOVIES_DBO"."MOVIE_CAST" b on a.movie_id = b.movie_id
join "MITCH"."GCP_SQLSERVER_TELEPORT_DEMO_MOVIES_DBO"."PERSON" c on b.person_id = c.person_id
where budget != 0
and cast_order = 0
group by 1,2,3,4,5,6,7,8) as agg
group by 1
having count(distinct appearance_id) >= 5
order by profit_ratio desc