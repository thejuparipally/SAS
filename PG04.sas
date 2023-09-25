/* Creating New Columns with Character and Date Functions */

data eu_occ_total;
	set pg1.eu_occ;
	Year=substr(YearMon, 1, 4);
	Month=substr(YearMon, 6, 2);
	ReportDate=mdy(Month, "01", Year);
	Total=Hotel + ShortStay + Camp;
	format Hotel ShortStay Camp Total comma10.0 ReportDate monyy7.;
	keep Country Hotel ShortStay Camp ReportDate Total;
run;

/* Processing Statements Conditionally with DO Groups */

libname out "/home/u63048800/PG1/output";

data out.parks out.monuments;
	set pg1.np_summary;
	Campers=OtherCamping+TentCampers+RVCampers+BackcountryCampers;
	keep Reg ParkName DayVisits OtherLodging Campers ParkType;
	format Campers commal0.0;
	length ParkType $ 8;

	if Type="NP" then
		do;
			ParkType="Park";
			output out.parks;
		end;
	else if Type="NM" then
		do;
			ParkType="Monument";
			output out.monuments;
		end;
run;