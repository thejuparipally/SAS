/* Problem 1: Working with Date/Time Values */

data rainsummary;
	set pg2.np_hourlyrain;
	by Month;

	if first.Month=1 then
		MonthlyRainTotal=0;
	MonthlyRainTotal+Rain;

	if last.Month=1;
	Date=datepart(DateTime);
	MonthEnd=intnx('month', Date, 0, 'end');
	format Date MonthEnd date9.;
	keep StationName MonthlyRainTotal Date MonthEnd;
run;

/* Problem 2: Searching for Character Strings */

data parks;
	set pg2.np_monthlytraffic;
	where ParkName like '%NP';
	Park=substr(ParkName, 1, find(ParkName, 'NP')-2);
	Location=compbl(propcase(Location));
	Gate=tranwrd(Location, 'Traffic Count At ', ' ');
	GateCode=catx('-', ParkCode, Gate);
run;

proc print data=parks;
	var Park GateCode Month Count;
run;