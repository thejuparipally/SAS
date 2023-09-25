/* Load the data */
/* Conduct ANOVA */

proc means data=stat1.garlic;
	class fertilizer;
	var bulbwt;
	output out = mean mean=mean;
	run;

Title;
ods noproctitle;
ods graphics / imagemap=on;

proc glm data=STAT1.GARLIC plots(only)=(boxplot diagnostics);
	class Fertilizer;
	model BulbWt=Fertilizer;
	means Fertilizer / hovtest=levene welch plots=none;
	lsmeans Fertilizer / adjust=tukey pdiff alpha=.05 plots=(diffplot);
	run;
quit;

/*The F statistic is 6.85 which is significantly larger than 1, it supports rejecting the null hypothesis, concluding that the treatment means are not equal.

The F statistic and corresponding p value are reported in the Analysis of Variance table. 
Because the reported p value 0.0013 is less than 0.05, you reject the null hypothesis of no difference between the means.

The R square value explains about 42% of the variability between bulb weight and fertilizer

Looking at the Quantile-Quantile plot, there appears to be no severe departure from normality because the observations all lie close to the diagonal reference line. This conclusion is not contradicted by the residual histogram at the lower left.

From the Summary Statistics MEANS Procedure, the means are somewhat different across Fertilizer values.

The box-and-whisker plots do not provide much additional information. There are simply too few observations per group for them to be very informative.

The result from the Levene's Test for Homogeneity of BulbWt Variance. The null hypothesis is that the variances are not equal. The p-value of 0.2257 is smaller than the alpha level of 0.05 and therefore we reject the null hypothesis. 

*/

Title;
ods noproctitle;
ods graphics / imagemap=on;


proc glm data=STAT1.GARLIC plots(only);
	class Fertilizer;
	model BulbWt=Fertilizer;
	means Fertilizer / welch plots=none;
	lsmeans Fertilizer / adjust=dunnett pdiff=control('4') alpha=.05 
		plots=(diffplot);
	run;
quit;

/* From the Least Squares Means table we can see that 3 and 4 are the only significant fertilizers, the rest are not significant different.*/

/* Dunnett comparison with chemical fertilizer as control */

ods graphics on / width=700;
ods trace on;

proc glm data=STAT1.GARLIC;
    class Fertilizer;
    model BulbWt=Fertilizer;             /*****/
    lsmeans Fertilizer / pdiff=all adjust=tukey;
    lsmeans Fertilizer / pdiff=controlu('4') adjust=dunnett;
    lsmeans Fertilizer / pdiff=all adjust=t;
    title "Garlic Data: Multiple Comparisons";
run;
quit;
title;

/* The only significant pairwise difference is between fertilizer 1 and fertilizer 4. The p-value of 0.0144 is less than your alpha, meaning that the bulb weights of these two fertilizers are significantly different from one another.*/

/* Unadjusted pairwise comparisons */

proc glm data=STAT1.GARLIC;
    class Fertilizer;
    model BulbWt=Fertilizer;             /*****/
    lsmeans Fertilizer / pdiff;
run;

/*
From the Dunnett LSMEANS comparisons, only fertilizer 4 is the only one that is not statistically significantly different from that control level.
*/