/** 1.Summarizing Data **/

proc sql;
title "Cities Where Employees Live";
select City, Count(*) as Count from orion.employee_addresses
group by City
order by City;
quit; 
title;

/** 2. Using SAS Functions **/

proc sql;
title "Age at Employment";
select Employee_ID 'Employee ID', Birth_Date format=mmddyy10. 'Birth Date', 
Employee_Hire_Date format=mmddyy10. 'Hire Date', 
int((Employee_Hire_Date-Birth_Date)/365.25)as Age 'Age'
from orion.employee_payroll;
quit;
title;

/** 3. Summarizing Data **/

proc sql;
title "Customer Demographics: Gender by Country"; select Country, Count(*) as Customers,
sum(Gender="M") as Men,
sum(Gender ="F") as Women,
calculated Men/calculated Customers 'Percent Male'
          format=percent6.1
   from orion.customer
   group by Country
   order by 5;
quit;
title;

/** 7. Summarizing Data in Groups **/

proc sql;
title "Countries with more Female than Male Customers"; select Country 'Country',
       sum(Gender="M") as M "Male Customers",
       sum(Gender="F") as F "Female Customers"
   from orion.customer
   group by Country
   having F > M
   order by F desc;
quit;
title;

/** 8. Advanced Summarizing Data in Groups **/

proc sql;
title "Countries and Cities Where Employees Live"; select upcase(Country) 'Country',
       propcase(City) 'City',
       count(*) 'Employees'
   from orion.employee_addresses
group by 1,2
order by 1,2;
quit;
title;