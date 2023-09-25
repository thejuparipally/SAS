/* Problem 1
a. */
PROC UNIVARIATE DATA=STAT1.normtemp;
	HISTOGRAM BodyTemp HeartRate;
	inset mean std n;
RUN;

/* b. */
proc ttest data=STAT1.NORMTEMP sides=2 h0=98.6 plots(showh0);
	var BodyTemp;
run;

/* 1)   What is the value of the t-statistic and the corresponding p-value?

t-statistic: -5.45, p-value: <.0001

2)   Do you reject or fail to reject the null hypothesis at the 0.05 level that the average temperature is 98.6 degrees?

If the p-value is less than 0.05, then we would reject the null hypothesis that the average temperature is 98.6 degrees. A p-value less than 0.001 is even more statistically significant, providing even stronger evidence against the null hypothesis.

Problem 2 */

PROC TTEST DATA=STAT1.german;
	class Group;
	var Change;
RUN;

PROC TTEST DATA=STAT1.german;
	var Change;
RUN;

/* c. Do the two groups appear to be approximately normally distributed?


The two groups are not really normally distributed, as the data set does not have a bell-shaped symmetrical curve centered around the mean and the graph does not lie between 1 standard deviation. The graph leans more towards the right therefore its more of a left skewed.


d.   Do the two groups have approximately equal variances?


Since our F value from equality of variances table for two groups is 2.97 that is close to 1 they are said to have approximately equal variances. Since the p-value from these tests is 0.0660 i.e, greater than a pre-determined significance level (> 0.05), then we fail to reject the null hypothesis that the variances are equal. In other words, we assume that the variances are approximately equal.


e.   Does the new teaching technique seem to result in significantly different change scores compared with the standard technique?


A t-value of -0.94 and a p-value of 0.3576 from a t-test for dependent means suggests that there is not strong evidence to suggest a significant difference in change scores between the new and standard techniques.

The t-value of -0.94 indicates that the mean of the new technique is lower than the mean of the standard technique, but the difference between the means is small relative to the variability of the data.

The p-value of 0.3576 tells you the probability of observing a t-value as extreme or more extreme than the one obtained from the sample data, if the null hypothesis is true (i.e., there is no difference in change scores between the two techniques). In this case, the p-value of 0.3576 is greater than a typical significance level of 0.05, which means that there is not strong evidence to suggest that the observed difference between the means is statistically significant.


*/



