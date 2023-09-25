/* A */

ods noproctitle;
ods graphics / imagemap=on;

proc corr data=STAT1.BODYFAT2 pearson plots=scatter(ellipse=none nvar=8 
		nwith=8);
	var Age Weight Height;
	with PctBodyFat2;
run;

/* 
1) It is unlikely that straight lines will adequately describe the relationships between these 
variables. From the scatter plot the relationship between age/height and percent body fat are 
nonlinear. It may be necessary to use more complex models to describe the relationships more 
accurately. But in case of weight and percent body fat there is strong relationship therefore
it can be explained using a straight line atleast when compared to the other two variables.

2) There are quite a few outliers in each graph at the ends of extreme top and bottom and the 
sides which can be investigated further as to what caused it. Because they can affect our model, 
they can evaluated using other methods to see their direct effect on our model.

3) The highest correlation of PctBodyFat2 is with Weight with a correlation of 0.6124

a) The p-value is <.0001.

b) Yes, since the value is <.0001, it is lower then .05. So it is considered to be statistically
significant, in which case the null hypothesis should be rejected.  This means that less that 
<.0001 is the result of chance. */

/* B */

ods noproctitle;
ods graphics / imagemap=on;

proc corr data=STAT1.BODYFAT2 pearson plots=scatter(ellipse=none nvar=8);
	var Age Weight Height;
run;

/* From the scatter plots and Correlation Coefficients height and weight seem to have a notable
realtionship when compared to the other two which seem to be non linear and more scattered. 
More complex models may be necessary to describe the relationships more accurately. */

ods noproctitle;
ods graphics / imagemap=on;

proc corr data=STAT1.BODYFAT2 pearson nosimple noprob rank plots=none;
	var Weight Density Age Height Adioposity FatFreeWt Neck Chest Abdomen Hip 
		Thigh Knee Ankle Biceps Forearm Wrist;
	with PctBodyFat2;
run;

/* Density has negative correlation while Adiposty, Chest and Abdemon meet the .70 threshold.*/

/* Tried formatting it but has an error, could not figure out how to solve it */

proc format;
  picture correlations &big -< 1 = '009.99' (prefix="*")
                         -1 <- -&big = '009.99' (prefix="*")
                         -&big <-< &big = '009.99';
run;

proc corr data=STAT1.BODYFAT2 out=pearson;
    var Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle Biceps Forearm Wrist;
    with PctBodyFat2;
run;

proc print data=pearson;
    format _numeric_ correlations.; 
run;

%let NewVariable = 0.7;

data bigcorr;
    set pearson;
    array vars{*} Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle Biceps Forearm Wrist;
    do i=1 to dim(vars);
        if abs(vars{i})<&NewVariable then vars{i}=.;
    end;
    if type="CORR";
    drop i type;
run;












