/* Problem 1: Using Significance Level Model Selection Techniques */

/*Part A*/

ods graphics on;

proc glmselect data=STAT1.bodyfat2 plots=all;
	STEPWISESL: model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh 
		Knee Ankle Biceps Forearm Wrist / SELECTION=STEPWISE SELECT=SL;
	title 'STEPWISE Selection with PctBodyFat2';
run;

quit;

/*Part B*/

proc glmselect data=STAT1.bodyfat2 plots=all;
	FORWARDSL: model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh 
		Knee Ankle Biceps Forearm Wrist / SELECTION=FORWARD SELECT=SL;
	title 'FORWARD Selection with PctBodyFat2';
run;

quit;

/*Part C*/

proc glmselect data=STAT1.bodyfat2 plots=all;
	FORWARDSL: model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh 
		Knee Ankle Biceps Forearm Wrist / SELECTION=FORWARD SELECT=SL SLENTRY=0.05;
	title 'FORWARD (SLENTRY = 0.05) Selection with PctBodyFat2';
run;

quit;