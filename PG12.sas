/* Problem 1: Using Nested Iterative DO Loops (DATA Step with No SET Statement) */

/* b. */

data retirement;
	do Year=1 to 6;
		Invest+10000;
		output;
	end;
run;

title1 'Retirement Account Balance per Year';

proc print data=retirement noobs;
	format Invest dollar12.2;
run;

title;

/* d. */

data retirement;
	do Year=1 to 6;
		Invest+10000;

		do Quarter=1 to 4;
			Invest+(Invest*(.075/4));
		end;
		output;
	end;
run;

title1 'Retirement Account Balance per Year';

proc print data=retirement noobs;
	format Invest dollar12.2;
run;

title;

/* f. */

data retirement;
	do Year=1 to 6;
		Invest+10000;

		do Quarter=1 to 4;
			Invest+(Invest*(.075/4));
		end;
		output;
	end;
	drop Quarter;
run;

title1 'Retirement Account Balance per Year';

proc print data=retirement noobs;
	format Invest dollar12.2;
run;

title;

/* Problem 2: Using a Conditional DO Loop */

/* f. */

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0;

	do until (IncrDayVisits>100000);
		Year+1;
		IncrDayVisits=IncrDayVisits*1.06;
		output;
	end;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' run;
	IncrDayVisits='Increased Day Visitors';
	title;

/* African Burial Ground National Monument: 14
	Booker T. Washington National Monument: 25
	Fort Stanwix National Monument: 2 */

/* h. */

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0;

	do until (IncrDayVisits>100000);
		Year+1;
		IncrDayVisits=IncrDayVisits*1.06;
	end;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;

/* i. */

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0;

	do while (IncrDayVisits<=100000);
		Year+1;
		IncrDayVisits=IncrDayVisits*1.06;
	end;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;