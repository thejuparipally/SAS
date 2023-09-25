/** 1. Inner Joins **/
proc sql;
	select Employee_Name 'Name', int(('1FEB2013'd-Employee_Hire_Date)/365.25) as 
		YOS 'Years of Service' from orion.employee_addresses as ea, 
		orion.employee_payroll as ep where ea.Employee_ID=ep.Employee_ID and 
		calculated YOS gt 30 order by Employee_Name;
quit;

/** 2. Creating a Summary Report from Two Tables **/
proc sql;
	select pd.Product_ID, Product_Name, sum(Quantity) 'Total Sold' from 
		orion.product_dim as pd, orion.order_fact as of where 
		pd.Product_ID=of.Product_ID and Order_Date>='01Jan2010'd group by 
		pd.Product_ID, Product_Name order by 3 desc, Product_Name;
quit;

/** 3. Outer Join **/
proc sql;
	select Employee_Name 'Name' format=$35., City, Job_Title from 
		orion.employee_addresses as ea left join orion.sales as os on 
		ea.Employee_ID=os.Employee_ID order by City, Job_Title, Employee_Name;
quit;

/** 4. Outer Join **/
proc sql;
	select Product_Name, pd.Product_ID, Quantity from orion.product_dim as pd left 
		join orion.order_fact as of on pd.Product_ID=of.Product_ID where Order_ID is 
		missing;
quit;

/** 5. Self-Join **/
proc sql;
	select a1.Employee_ID 'Employee ID', a1.Employee_Name 'Employee_ Name', 
		Job_Title, a2.Employee_ID 'Manager ID', a2.Employee_Name 'Manager Name' from 
		orion.employee_addresses as a1, orion.employee_addresses as a2, orion.staff 
		as s where a1.Employee_ID=s.Employee_ID and s.Manager_ID=a2.Employee_ID and
(Job_Title contains 'Trainee' or Job_Title contains 'Temp') order by 
		a1.Employee_ID;
quit;