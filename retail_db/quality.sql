select q.query_name,
		round(sum(q.quality)/count(q.result),2) "quality",
		round(count(q.rating_ls_3)::decimal/count(q.result),2) "poor_query_percentage"
from (
SELECT query_name,
 	   result,
	   position,
	   rating,
	   round(rating::decimal/position,2) "quality",
	   case when rating <= 3 then 1 else null end "rating_ls_3"
	FROM queries
	) q
group by query_name;
