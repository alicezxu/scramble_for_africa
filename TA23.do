

***************************************************************
***************************************************************
** Appendix Table 23. Ethnic Partitioning and Civil Conflict. Dropping Iteratively a Different African Region
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************



** Preliminaries
*****************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************

* Notes:
********
** Note (1): To get double-clustered s.e. for NB - ML specifications one needs to run the program three times, changing the cluster(); 
** 			(a) cluster (ethnic family); (b) wbcode (country); (c) inter (intersection of ethnic family and country) 
** Note (2): For the linear probability models the cgmreg command estimates double-clustered s.e.

** Conditioning Sets
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

global regi 			region_n region_s region_w region_e 

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 

**********************************************************************************************************************************************************************

** Generate Indicators for Africa regions. Classification follows Nunn (2007)
*******************************************************************************
gen north=region_n
gen south=region_s
gen west=region_w
gen east=region_e
gen centr=region_c


** Estimation. NB ML and LPM Estimates with country fixed-effects
*********************************************************************************************************************************************************************

foreach var of varlist north south west east centr {
	
	xi: nbreg allm 		split10pc spil		$simple  $rich1 $location i.wbcode 		if `var'==0										,  robust cluster( cluster)
		est store no`var'1

	xi: nbreg allm 		split10pc spil 		$simple  $rich1 $location i.wbcode 		if `var'==0	 & borderdist1<median_bd  & no==0	,  robust cluster( cluster)
		est store no`var'2
  
	xi: cgmreg allmd 	split10pc spil 		$simple  $rich1 $location i.wbcode 		if `var'==0										,  cluster(wbcode cluster)
		est store no`var'3
 
	xi: cgmreg allmd 	split10pc spil 		$simple  $rich1 $location i.wbcode 		if `var'==0	& 	borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
		est store no`var'4
	   
  }
  ********
 
	   


** Appendix Table 23. Ethnic Partitioning and Civil Conflict. Dropping Iteratively a Different African Region
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** outcome varaible. all main events (excl. riots and protests)
** all columns: rich set of controls 	
** Odd-numbered columns: all ethnic homelads; Even-numbered columns: ethnic areas close to the national border
***********************************************************************************************************************************************************************

** NBREG. 
***********************************************************************************************************************************************************************
estout  nonorth1 nonorth2 nosouth1 nosouth2 nowest1 nowest2 noeast1 noeast2 nocentr1     nocentr2, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(LogLikelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
** LP - OLS linear probability models.
************************************************************************************************************************************************************************
estout nonorth3 nonorth4 nosouth3 nosouth4 nowest3 nowest4 noeast3 noeast4 nocentr3     nocentr4 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
	   
	   
	   
	   
	
*******
