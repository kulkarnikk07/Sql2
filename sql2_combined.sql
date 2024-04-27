#Problem 1 : Rank Scores		(https://leetcode.com/problems/rank-scores/ )

select 
score
, dense_rank() over (order by score desc)  "rank"
from scores

#Problem 2 : Exchange Seats	(https://leetcode.com/problems/exchange-seats/ )

select
(
    case
    when mod(id,2)!= 0 and id!= c.cnts then id+1
    when mod(id,2)!=0 and id = c.cnts then id
    else id-1
    end
)id
, student
from seat, (select count(id) cnts from seat) c
order by id

#Problem 3 : Tree Node		(https://leetcode.com/problems/tree-node/ )

select id,
(
    case
        when id = (select id from tree where p_id is null) then 'Root'
        when id not in (select distinct p_id from tree where p_id is not null) then 'Leaf'
        else 'Inner'
    End
) as Type

from Tree

#Problem 4 : Deparment Top 3 Salaries		(https://leetcode.com/problems/department-top-three-salaries/ )

with CTE as
(
select d.name as Department, e.name as Employee, e.salary as Salary
, dense_rank() over (partition by d.name order by e.salary desc) as rnk
from employee e
left join department d
on e.departmentId = d.id
) 

select CTE.Department, CTE.Employee, CTE.Salary
from CTE
where rnk <=3