/* Problem 1: Producing Multiple Totals */
data work.parktypetraffic;
	set pg2.np_yearlyTraffic;
	where ParkType in ("National Monument", "National Park");

	if ParkType='National Monument' then
		MonumentTraffic+Count;
	else
		ParkTraffic+Count;
	format MonumentTraffic ParkTraffic comma15.;
run;

title 'Accumulating Traffic Totals for Park Types';

proc print data=work.parktypetraffic;
	var ParkType ParkName Location Count MonumentTraffic ParkTraffic;
	title;

/* Problem 2: Generating an Accumulating Column within Multiple Groups */

proc sort data=sashelp.shoes out=sorted_shoes;
	by Region Product;
run;

data profitsummary;
	set sorted_shoes;
	by Region Product;
	Profit=Sales-Returns;

	if First.Product 
	then TotalProfit=0;
	TotalProfit+Profit;

	if Last.Product=1;
	keep Region Product TotalProfit;
	format TotalProfit dollar12.;
run;

