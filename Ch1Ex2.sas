/* 1.   Eliminating Duplicates */

proc sql;
select distinct City 
from orion.employee_addresses ;
quit;

/* 2.   Subsetting Data */

proc sql;
select Employee_ID, Recipients, sum(Qtr1,Qtr2,Qtr3,Qtr4) as Total
from orion.Employee_Donations
where calculated Total > 90;
quit;

/* 3.   Subsetting Data Using the ESCAPE Clause */

proc sql;
select Employee_ID, Recipients, 
COUNT(case when Qtr1 >= 1 then 1 end) + count(case when Qtr2 >= 1 then 1 end) + 
count(case when Qtr3 >= 1 then 1 end) + count(case when Qtr4 >= 1 then 1 end) as No_of_Contribs
from orion.employee_donations
where Recipients like '%0_,%'
group by Employee_ID
having No_of_Contribs <=2;   
quit;



