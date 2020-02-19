


***************************************************************
***************************************************************
** Appendix Table 29. Ethnic Partitioning and Civil Conflict. Accounting for Measurement Error in the Civil Conflict Databases
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** This .do file has to be executed in the data file acled2010 (though nothing major changes if one runs in with acled2013


** Preliminaries. Generate the dependent variables
**************************************************
************************************************************************************************************************************************************************

egen allucdpd=rmax(stated onesidedd nonstated)

egen bothord=rsum(allucdpd alld)
egen bothmord=rsum(allucdpd allmd)


gen 	bothorddum=0 
replace bothorddum=1 if alld==1 & allucdpd==1
gen 	bothmorddum=0 
replace bothmorddum=1 if allmd==1 & allucdpd==1

tab bothmord
tab bothmorddum


tab bothord
tab bothorddum

** Conditioning Sets
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

global regi 			region_n region_s region_w region_e 

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 

**************************************************************************************************************************************************************************

*** Estimation. OLS and Linear Probability Model (LPM) Estimates with Country Fixed-Effects
**************************************************************************************************************************************************************************
xi: cgmreg bothord  		split10pc spil 		$simple      $rich1 $location               		i.wbcode				,  cluster(wbcode cluster)
est store gg1

xi: cgmreg bothmord  		split10pc spil 		$simple      $rich1 $location               		i.wbcode				,  cluster(wbcode cluster)
est store gg2

xi: cgmreg bothorddum  		split10pc spil 		$simple      $rich1 $location               		i.wbcode				,  cluster(wbcode cluster)
est store gg3

xi: cgmreg bothmorddum  	split10pc spil 		$simple      $rich1 $location               		i.wbcode				,  cluster(wbcode cluster) 
est store gg4



xi: cgmreg bothord  		split10pc spil 		$simple      $rich1 $location             i.wbcode	  	if borderdist1<median_bd  		& no==0			,  cluster(wbcode cluster)
est store ggc1

xi: cgmreg bothmord  		split10pc spil 		$simple      $rich1 $location            i.wbcode	   	if borderdist1<median_bd  		& no==0			,  cluster(wbcode cluster)
est store ggc2

xi: cgmreg bothorddum  		split10pc spil 		$simple      $rich1 $location             i.wbcode	  	if borderdist1<median_bd  		& no==0			,  cluster(wbcode cluster)
est store ggc3

xi: cgmreg bothmorddum  	split10pc spil 		$simple      $rich1 $location             i.wbcode	  	if borderdist1<median_bd  		& no==0			,  cluster(wbcode cluster) 
est store ggc4

** Appendix Table 29. Ethnic Partitioning and Civil Conflict. Accounting for Measurement Error in the Civil Conflict Databases. OLS Estimates
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** all columns: rich set of countrols and country fixed-effects
** columns (1) - (4): All Country-Ethnic Homelands 
** columns (5) - (8): Country-ethnic Homelands close to the neational border  
****************************************************************************************************************************************
*****************************************************************************************************************************************
estout gg1 gg2 gg3 gg4 ggc1 ggc2 ggc3 ggc4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N, fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
