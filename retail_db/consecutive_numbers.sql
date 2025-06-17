SELECT DISTINCT o.num
FROM
(
SELECT c.id,
       c.num,
	   c.REPEAR_NUM +
	   lag(c.REPEAR_NUM) over (partition by c.num order by c.id asc) "sum_val"
FROM (
SELECT ID,
       NUM,
	   CASE WHEN NUM = LEAD(NUM) OVER (ORDER BY ID ASC)
	        THEN 1 ELSE 0 END REPEAR_NUM
	FROM
	 LOGS) c
) o
WHERE o.sum_val >= 2
