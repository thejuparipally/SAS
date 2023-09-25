/* Problem 1*/

proc import datafile="/home/u63048800/PG1/data/eu_sport_trade.xlsx" dbms=xlsx 
		out=EU_SPORT_TRADE;
run;

proc contents data=EU_SPORT_TRADE;
run;

/* Problem 2*/

proc import datafile="/home/u63048800/PG1/data/np_traffic.csv" dbms=csv 
		out=traffic replace;
	guessingrows=max;
run;

proc contents data=traffic;
run;

/* Problem 3*/

proc import datafile="/home/u63048800/PG1/data/np_traffic.dat" dbms=dlm 
		out=traffic2 replace;
		delimiter= '|';
		getnames= yes;
		guessingrows= max;
run;

proc contents data=traffic2;
run;
