/* Problem 1: Performing Two-Way ANOVA */

/* a. */

proc sgplot data=STAT1.drug; 
    vline DrugDose / group=Disease
                     stat=mean 
                     response=BloodP
                     markers; 
    format DrugDose dosefmt.;
run;

/* b. */ 

ods noproctitle;
ods graphics / imagemap=on;

proc glm data=STAT1.DRUG;
	class DrugDose Disease;
	model BloodP=DrugDose Disease DrugDose*Disease / ss1 ss3;
quit;

/* Problem 2: Multiple Regression */

/* Performing Multiple Regression Using the REG Procedure*/

proc reg data=stat1.BodyFat2;
    model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle Biceps Forearm Wrist;
    title 'Regression of PctBodyFat2 on All Predictors';
run;
quit;

/* Simplifying the Model */

proc reg data=stat1.BodyFat2;
    model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Ankle Biceps Forearm Wrist;
    title 'Remove Knee';
run;
quit;

/* More Simplifying of the Model */ 

proc reg data=stat1.BodyFat2;
    model PctBodyFat2=Age Weight Height Neck Abdomen Hip Thigh Ankle Biceps Forearm Wrist;
    title 'Remove Knee and Chest';
run;
quit;
