/*1. Querying a Table */

/* a. */

proc sql;
select * from orion.employee_payroll;
quit;

/* b. */

proc sql;
select Employee_ID, Employee_Gender, Marital_Status, Salary 
from orion.employee_payroll;
quit;

/*2. Calculating a Column */ 

proc sql;
select Employee_ID, Employee_Gender, Marital_Status, Salary, Salary/3 as Tax
from orion.employee_payroll;
quit;

/*3. Creating a New Table*/ 

proc sql;
create table work.bonus as
select Employee_ID, Salary, Salary*0.04 as Bonus
from orion.employee_payroll;
quit;

/* 4. Simple report */

proc sql;
select Employee_ID, Job_Title, Salary,
case
when  scan(Job_Title, -1, ' ') = 'Manager' and salary < 50000 then 'Low'
when scan(Job_Title, -1, ' ') = 'Manager' and salary > 50000 and salary < 80000 then 'Medium'
else 'High'
end as Salary_Range
from orion.employee_information
where Job_Title like'%Manager';
quit;

