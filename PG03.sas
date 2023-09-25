/* Filtering Rows in a Listing Report Using Character Data */

proc print data=pg1.np_summary;
	var Type ParkName;
	where ParkName like "%Preserve%";
run;

/* Which codes are used for preserves?

Type: PRE, NPRE and PRESERVE
Region Code: A, IM, PW, SE, MW.

Creating a Listing Report for Missing Data */

proc print data=pg1.eu_occ;
	where Hotel is missing and ShortStay is missing and Camp is missing;
run;

/* There are 101 rows */

proc print data=pg1.eu_occ;
	where Hotel > 40000000;
run;

/* Months are July and August

Sorting Data to Remove Duplicate Rows */

proc sort data=pg1.np_largeparks out=park_clean nodupkey dupout=parks_dups;
	by _ALL_;
run;