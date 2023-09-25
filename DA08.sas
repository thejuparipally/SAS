/* Problem 1: Examining Residuals */

ods graphics / imagemap=on;

proc reg data=STAT1.BodyFat2 plots(only)=(QQ RESIDUALBYPREDICTED RESIDUALS);
	FORWARD: model PctBodyFat2=Abdomen Weight Wrist Forearm;
	id Case;
	title 'FORWARD Model - Plots of Diagnostic Statistics';
	run;
quit;

/* Generating Potential Outliers */

/* Part A */
ods graphics on;
ods output RSTUDENTBYPREDICTED=Rstud COOKSDPLOT=Cook DFFITSPLOT=Dffits 
	DFBETASPANEL=Dfbs;

proc reg data=STAT1.BodyFat2 plots(only label)=(RSTUDENTBYPREDICTED COOKSD 
		DFFITS DFBETAS);
	FORWARD: model PctBodyFat2=Abdomen Weight Wrist Forearm;
	id Case;
	title 'FORWARD Model - Plots of Diagnostic Statistics';
	run;
quit;

/* Part B */

data influential;
	merge Rstud Cook Dffits Dfbs;
	by observation;

	if (ABS(Rstudent)>3) or (Cooksdlabel ne ' ') or Dffitsout then
		flag=1;
	array dfbetas{*} _dfbetasout:;

	do i=2 to dim(dfbetas);

		if dfbetas{i} then
			flag=1;
	end;

	if ABS(Rstudent)<=3 then
		RStudent=.;

	if Cooksdlabel eq ' ' then
		CooksD=.;

	if flag=1;
	drop i flag;
run;

proc print data=influential;
	id observation ID1;
	var Rstudent CooksD Dffitsout _dfbetasout:;
run;

/* Assessing Collinearity */

/*Part A*/

ods graphics off;

proc reg data=STAT1.BodyFat2;
	FULLMODL: model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh 
		Knee Ankle Biceps Forearm Wrist / vif;
	title 'Collinearity -- Full Model';
	run;
quit;

ods graphics on;

/*Part B*/

ods graphics off;

proc reg data=STAT1.BodyFat2;
	NOWT: model PctBodyFat2=Age Height Neck Chest Abdomen Hip Thigh Knee Ankle 
		Biceps Forearm Wrist / vif;
	title 'Collinearity -- No Weight';
	run;
quit;

ods graphics on;