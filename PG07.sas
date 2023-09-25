/* Problem 1: Using PUTLOG Statements to Examine Execution Steps */

/* a. */

/* Log results before edit: NOTE: There were 51 observations read from the data set PG2.NP_FINAL. 
WHERE Type='PARK';
The data set WORK.NP_PARKS has 51 observations and 5 variables. */

data np_parks;
    set pg2.np_final(obs=5);
    putlog "NOTE: START DATA STEP ITERATION";
    keep Region ParkName AvgMonthlyVisitors Acres Size; length Size $ 6;
    where Type="PARK";
    format AvgMonthlyVisitors Acres comma10.;
    Type=propcase(Type);
    putlog Type=; AvgMonthlyVisitors=sum(DayVisits,Campers,OtherLodging)/12;
    if Acres<1000 then Size="Small";
    else if Acres<100000 then Size="Medium"; else Size="Large";
    putlog _all_; 
run;

/* 1. Statements that are compile-time only: KEEP, WHERE, and FORMAT

2. Size will have a length of 5 characters since its assigned to Small in DATA step */

/* Log messages after edit: There were 5 observations read from the data set PG2.NP_FINAL. WHERE Type='PARK';
The data set WORK.NP_PARKS has 5 observations and 5 variables. */

/* Problem 2: Conditionally Creating Columns and Output Tables */


data camping(keep=ParkName Month DayVisits CampTotal) lodging(keep=ParkName Month DayVisits LodgingOther);
    set pg2.np_2017;
    CampTotal=sum(of Camping:);
    if CampTotal > 0 then output camping;
    if LodgingOther > 0 then output lodging;
    format CampTotal comma15.; 
run;