/** 1. Enhancing Output by Ordering the Rows and Adding Titles and Formats **/

proc sql;
title "Single Male Employee Salaries";
select Employee_ID 'Employee ID', Salary format=comma10.2 'Annual Salary',
Salary/3 format=comma10.2 as Tax 'Federal Tax Withdrawn' from orion.employee_payroll
where Marital_Status="S" and Employee_Gender ="M" and Employee_Term_Date is missing
order by Salary desc;
quit;
title

/** 2. Using Formats to Limit the Width of Columns in the Output **/

proc sql;
title "Australian Clothing Products"; 
select Supplier_Name 'Supplier'format=$18., Product_Group 'Group' format=$12., Product_Name 'Product' format=$30.
from orion.product_dim
where Supplier_Country="AU" and Product_Category="Clothes"
order by Product_Name;
quit; 
title;

/** 3. Enhancing Output with Multiple Techniques **/

proc sql;
title "Orion Employees Hired at 18 or Younger";
select 
    Employee_ID 'Employee ID' format=z7.,
    Salary format=comma10.2 'Salary',
    intck('Year', Birth_Date, Hire_Date) 'Age when Hired' as Age,
    catx(', ', City, Country) 'Location',
    intck('year', Hire_Date, today()) 'Years with Company' as Year
from orion.employees
where calculated Age <= 18
order by Year desc;
quit;
title;


