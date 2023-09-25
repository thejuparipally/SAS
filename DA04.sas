ods noproctitle;
ods graphics / imagemap=on;

proc reg data=STAT1.BODYFAT2 alpha=0.05 plots(only)=(diagnostics residuals 
		fitplot);
	model PctBodyFat2=Weight /;
	run;
quit;

/*

a. F value: 150.03, P-value: <.0001
The p value is small (less than 0.05), so we reject the null hypothesis. 
We can conclude that the simple linear regression model fits the data better than the baseline model. In other
words, Weight explains a significant amount of variability in PctBodyFat2

b. Predicted regression equation: 

PctBodyFat2= -12.05158 + 0.17439 * (Weight)

The model indicates that with additional weight there is approximately 0.17439 higher PctBodyFat2.

c. R-square: 0.3751

This means that the regression line explains 37.5% of the total variation in the response values.

*/
