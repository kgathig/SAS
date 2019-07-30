/******************************************************************************/
/*Acs2017 has 286 variables and 4404 observations                             */
/*Import Excel file and name it ACS2017                                       */
/*Delete all variables except WAPG<WKHP<FOD!P & AGEP                          */
/*creating a report of respondents with business degree                       */
/*Annual income and typical working hours greater than zero                   */
/*total income for each business major and and overall total                  */
/*Program Assignment #3                                                       */
/*Completed 06/20/2019                                                        */
/*Kelvin Gathigia                                                             */
/******************************************************************************/
Libname ECON581 "/folders/myfolders/ECON581";
Filename Mydata "/folders/myfolders/ECON581/ACS 2017 Madison and St Clair.xlsx";

proc import datafile=Mydata out=Econ581.acs2017 dbms=xlsx replace;
run;

data ECON581.Acs2017 (keep=WAGP WKHP AGEP FOD1P);
	set econ581.Acs2017;
run;

proc sort data=econ581.acs2017;
	by FOD1P descending WAGP;
run;

title "Income Data for Business Majors";
title3 "Taken from 2017 American Community Survey";

proc print data=ECON581.acs2017 noobs split='*';
	where (((FOD1P>=6200) & (FOD1P <=6299)) &((WAGP>0) & (WKHP>0)));
	by FOD1P;
	var AGEP WKHP;
	sum WAGP;
	pageby FOD1P;
	label AGEP="Age";
	label WKHP="Typical*weekly*hours";
	label WAGP="Income*2017";
	format AGEP 3.;
	format WKHP 3.;
	format WAGP Dollar10.;
run;