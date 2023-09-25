/* Problem 1: Concatenating Like-Structured Tables */

data work.np_combine;
	set pg2.np_2015 pg2.np_2016;
	CampTotal=CampingOther + CampingTent + CampingRV + CampingBackcountry;
	where Month in(6, 7, 8);
	format CampTotal comma15.;
	drop Camping:;
run;

/* Problem 2: Writing Matches and Nonmatches to Separate Tables */

proc sort data=pg2.np_CodeLookup out=work.sortedCodes;
	by ParkCode;
run;

proc sort data=pg2.np_2016 out=work.sorted_code_2016;
	by ParkCode;
run;

data work.parkStats(keep=ParkCode ParkName Year Month DayVisits) 
		work.parkOther(keep=ParkCode ParkName);
	merge work.sorted_code_2016(in=inStats) work.sortedCodes;
	by ParkCode;

	if inStats=1 then
		output work.parkStats;
	else
		output work.parkOther;
run;