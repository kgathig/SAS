libname ECON581 "/folders/myfolders/ECON581";
filename Mydata "/folders/myfolders/ECON581/ACS 2017 Madison and St Clair.xlsx";

proc import datafile=Mydata dbms=xlsx out=ECON581.ACS2017 replace;
run;

data ECON581.ACS2017;
	set ECON581.ACS2017(keep=WAGP FOD1P AGEP);

	if (WAGP ^= .);
run;

proc format;
	Value Degreeform 
	6200-6299="Business degree."
    .="No Bachelor's degree."
    OTHER="Non-Business degree.";
run;

proc sort data=ECON581.ACS2017;
	by descending WAGP;
run;

title1 "Income Data for 30-Year-Old Metro East Residents";
title3 "Taken from 2017 American Community Survey";

proc print data=ECON581.ACS2017 noobs split="*";
	where (AGEP=30);
	var AGEP WAGP FOD1P;
	label WAGP="Income*2016";
	label AGEP='Age';
	label FOD1P='Degree';
	format AGEP 3.;
	format WAGP Dollar10.;
	format FOD1P Degreeform.;
run;
