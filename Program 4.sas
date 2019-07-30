/***************************************************************************/
/*Import Excel file ACS 2017 Madison county and St. clare named it ACS2017 */
/*delete all variables except WAGP WKHP FOD1P AGEP SCHL                    */
/*create a new dataset name BIZ2017                                        */
/*keep people between age 25 and 55 and have business degrees              */
/*new variable EDUC with different levels of education                     */
/*import ACS Earnings and named it US2017                                  */
/*Merged US2017 and BIZ2017 into a new dataset called BOTH2017             */
/*Created new Character variable named  STATUS                             */
/*Acs2017 has 286 variables and 4404 observations                          */
/*creating a report of respondents with business degree                    */
/*Annual income and typical working hours greater than zero                */
/*Program Assignment #5                                                    */
/*Completed 7/5/2019                                                       */
/*Kelvin Gathigia                                                          */
/***************************************************************************/
Libname ECON581 "/folders/myfolders/ECON581";
Filename Mydata "/folders/myfolders/ECON581/ACS 2017 Madison and St Clair.xlsx";
Filename Mydata2 "/folders/myfolders/ECON581/ACS Earnings.xlsx";
options obs=max;

proc import datafile=Mydata out=ECON581.ACS2017 dbms=xlsx replace;
run;

data ECON581.BIZ2017;
	set ECON581.ACS2017 (keep=WAGP WKHP FOD1P AGEP SCHL);
	where ((AGEP>=25) & (AGEP <=55) & ((FOD1P>=6200) & (FOD1P <=6299)));

	if ((SCHL=.) or ((SCHL >=1) & (SCHL <=15))) then
		EDUC=0;
	else if ((SCHL=16) & (SCHL=17)) then
		EDUC=1;
	else if ((SCHL>=18) & (SCHL<=20)) then
		EDUC=2;
	else if (SCHL=21) then
		EDUC=3;
	else
		EDUC=4;
run;

proc import datafile=Mydata2 out=ECON581.US2017 dbms=xlsx replace;
run;

proc sort data=ECON581.BIZ2017;
	by EDUC;
run;

data ECON581.BOTH2017;
	merge ECON581.BIZ2017 ECON581.US2017;
	by EDUC;

	if (WAGP< MEDIAN_EARNINGS) then
		STATUS="Income lower than median.";
	else if (WAGP> MEDIAN_EARNINGS) then
		STATUS="Income higher than median.";
	else
		STATUS="Income equal to median.";

	if EDUC>=3;
run;

proc sort data=ECON581.BOTH2017;
	by FOD1P descending WAGP;
run;

title1 "Income Data for Business Majors";
title3 "Taken from 2017 American Community Survey";

proc print data=ECON581.BOTH2017 noobs split='*';
	var AGEP SCHL WAGP STATUS;
	by FOD1P;
	pageby FOD1P;
	label AGEP="Age";
	label SCHL="Education*Level";
	label WAGP="Income*2016";
	label STATUS="Comparison";
	format AGEP 3.;
	format WKHP 3.;
	format WAGP Dollar10.;
	format SCHL 2.;
	format STATUS $28.;
run;

