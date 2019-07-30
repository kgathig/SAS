/*********************************************************************/
/*created a dataset called WOMAN                                     */
/*Do loop for age between 18 and 99                                  */
/*Do loop for pets between 4 and 3175                                */
/*Do loop for address between 1 and 793                              */
/*Calculate x= AGE *PETS * ADDRESS                                   */
/*number of observations 206522658                                   */
/*The woman AGE is 37 and minimum number of PETS is 5                */
/*Program Assignment #6                                              */
/*Completed 7/5/2019                                                 */
/*Kelvin Gathigia                                                    */
/*********************************************************************/
Libname ECON581 "/folders/myfolders/ECON581";

data ECON581.WOMAN;
	do AGE=18 to 99;

		do PETS=4 to 3175;

			do ADDRESS=1 to 793;
			X=(AGE * PETS * ADDRESS);
				output;
			end;
			
		end;
		
	end;
run;

proc sort data=ECON581.WOMAN;
	by PETS;
run;

title1 "Possible Triples";

proc print data=econ581.woman noobs label;
	where (X=57165);
	var PETS AGE ADDRESS X;
	label X="Product";
	format PETS COMMA5.;
	format AGE 3.;
	format ADDRESS 3.;
	format X COMMA6.;
run;

