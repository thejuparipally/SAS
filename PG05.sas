/* Problem 1: Creating Two-Way Frequency Reports */

proc freq data=pg1.np_codelookup order=freq nlevels;
	where type not like '%Other%';
	table type*region / nocol out=freq_table;
	title 'Park Types by Region';
run;

proc print data=freq_table;
	var region type count;
	sum count;
run;

/* The top 3 park types are National Historic Site, National Monument and National Park */

/* c */

ods graphics on;
ods noproctitle;
title1 'Selected Park Types by Region';
proc freq data=pg1.np_codelookup order=freq;
    tables Type*Region /  nocol crosslist 
    plots=freqplot(groupby=row scale=grouppercent orient=horizontal);
    where Type in ('National Historic Site', 'National Monument', 'National Park');
run;
title;
ods proctitle; 

/* Problem 2: Producing a Descriptive Statistic Report */

proc means data=pg1.np_westweather
  mean min max
  maxdec=2;
  class Year Name;
  var Precip Snow TempMin TempMax;
  title 'Weather Statistics by Year and Park';
run;





