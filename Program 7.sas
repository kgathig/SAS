/***************************************************************/
/*read ps8 dataset                                             */
/*convert numeric to character and vice-versa                  */
/*Use mod() function                                           */
/*Program Assignment #8                                        */
/*Completed 07/26/2019                                         */
/*Kelvin Gathigia                                              */
/***************************************************************/
Libname ECON581 "/folders/myfolders/ECON581";

data ECON581.ps8 (drop=CHAR_ID1 CHAR_ID2 CHAR_ID3 CHAR_CHECKSUM);
	set econ581.ps8;
	CHAR_TRANS=put(TRANSACTION, 5.);
	CHAR_ID1=substr(CHAR_TRANS, 1, 1);
	ID1=input(CHAR_ID1, 1.);
	CHAR_ID2=substr(CHAR_TRANS, 2, 1);
	ID2=input(CHAR_ID2, 1.);
	CHAR_ID3=substr(CHAR_TRANS, 3, 1);
	ID3=input(CHAR_ID3, 1.);
	CHAR_CHECKSUM=substr(CHAR_TRANS, 4, 2);
	CHECKSUM=input(CHAR_CHECKSUM, 2.);
	TARGET=mod(((1*ID1)+(2*ID2)+(3*ID3)), 11);
	length STATUS $70;

	if (TARGET=CHECKSUM) then
		STATUS="OK.";
	else
		STATUS=trim("Transaction number" ||TRANSACTION || ", for $"||AMOUNT || ", is illegitimate");

	if(TARGET^=CHECKSUM);
run;

proc sort data=econ581.ps8;
	by TRANSACTION;
run;

title1 "Illegitimate Transactions.";

proc print data=ECON581.ps8 noobs split='*';
	var TRANSACTION TARGET CHECKSUM STATUS;
	label TRANSACTION="Transaction*Number";
	label TARGET="Expected* Checksum";
	label CHECKSUM="Actual* Checksum";
	label STATUS="Warning* Message";
	format TRANSACTION 5.;
	format TARGET 2.;
	format CHECKSUM 2.;
	format STATUS $70.;
run;