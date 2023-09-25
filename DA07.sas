/* Problem 1: Using Other Model Selection Techniques */

ods graphics on;

proc glmselect data=STAT1.bodyfat2 plots=all;
	STEPWISESBC: model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh 
		Knee Ankle Biceps Forearm Wrist / SELECTION=STEPWISE SELECT=SBC;
	title 'SBC STEPWISE Selection with PctBodyFat2';
run;

quit;

/*Part B*/

proc glmselect data=STAT1.bodyfat2 plots=all;
	STEPWISEAIC: model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh 
		Knee Ankle Biceps Forearm Wrist / SELECTION=STEPWISE SELECT=AIC;
	title 'AIC STEPWISE Selection with PctBodyFat2';
run;

quit;

/* Problem 2: Using All-Regression Techniques */

ods graphics / imagemap=on;

proc reg data=STAT1.BodyFat2 plots(only)=(cp);
	model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle 
		Biceps Forearm Wrist / selection=cp best=60;
	title "Using Mallows Cp for Model Selection";
	run;
quit;