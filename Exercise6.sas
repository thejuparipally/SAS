/** 1. Using a Noncorrelated Subquery **/
/** a. **/

proc sql;
	select avg(Total_Retail_Price) as MeanPrice from orion.order_fact where 
		Order_Type=1;
quit;

/** b. **/

proc sql;
	select Customer_ID, avg(Total_Retail_Price) as MeanPrice format=8.2 from 
		orion.order_fact where Order_Type=1 group by Customer_ID having MeanPrice >
      (select avg(Total_Retail_Price) from orion.order_fact where 
		Order_Type=1);
quit;

/** 2. Using a Noncorrelated Subquery **/
/** a. **/

proc sql;
	select Employee_ID from orion.employee_payroll where 
		month(Employee_Hire_Date)=2;
quit;

/** b. **/
proc sql;
	select Employee_ID, scan(Employee_name, 2, ', ') format=$15. as FirstName 
		'First Name', scan(Employee_name, 1, ', ') format=$15. as LastName 
		'Last Name' from orion.employee_addresses where Employee_ID in
      (select Employee_ID from orion.employee_payroll where 
		month(Employee_Hire_Date)=2) order by LastName;
quit;

/** 3. Building Complex Queries with In-Line Views **/
/** a. **/

proc sql;
	select Department, sum(Salary) as Dept_Salary_Total from 
		orion.employee_payroll as pay, orion.employee_organization as org where 
		org.Employee_ID=pay.Employee_ID group by Department;
quit;

/** b. **/

proc sql;
	select adr.Employee_ID, Employee_Name, org.Department from 
		orion.employee_addresses as adr, orion.employee_organization as org where 
		adr.Employee_ID=org.Employee_ID;
quit;

/** c. **/

proc sql;
title "Employee Salaries as a Percent of Department Total";
	select emp.Department format=$22., emp.Employee_Name format=$28., Salary 
		format=comma9.2, Salary/Dept_Salary_Total as Percent format=percent6.2 from 
		orion.employee_payroll as pay, (select adr.Employee_ID, Employee_Name, 
		org.Department from orion.employee_addresses as adr, 
		orion.employee_organization as org where adr.Employee_ID=org.Employee_ID) as 
		emp, (select Department, sum(Salary) as Dept_Salary_Total from 
		orion.employee_payroll as pay, orion.employee_organization as org where 
		org.Employee_ID=pay.Employee_ID group by Department) as sum where 
		sum.Department=emp.Department and pay.Employee_ID=emp.Employee_ID order by 
		Department, Percent desc;
quit;
title;