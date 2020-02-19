
***************************************************************
***************************************************************
** Appendix Table 30. Ethnic Partitioning and Civil Conflict. Accounting for Measurement Error in the Civil Conflict Databases. State Conflict and Civilian Violence
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** This .do file has to be executed in the data file aer_acled2010 

** Preliminaries. Generate the dependent variables
**************************************************
************************************************************************************************************************************************************************

egen govstate=rmax(stated govtd)

egen bothord_state=rsum(stated govtd)

tab govstate
tab bothord_state


egen bothos=rmax(onesidedd civiliansd)

egen bothord_os=rsum(onesidedd civiliansd)

tab bothos
tab bothord_os
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************

*** Estimation. OLS and Linear Probability Model (LPM) Estimates with Country Fixed-Effects
**************************************************************************************************************************************************************************

*** State Conflcit 
xi: cgmreg bothord_state  		split10pc spil 		$simple      $rich1 $location    i.wbcode										,  cluster(wbcode cluster)
est store sgg1

xi: cgmreg govstate  			split10pc spil 		$simple      $rich1 $location    i.wbcode										,  cluster(wbcode cluster)
est store sgg2

xi: cgmreg bothord_state  		split10pc spil 		$simple      $rich1 $location    i.wbcode         	if borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
est store sggc1

xi: cgmreg govstate  			split10pc spil 		$simple      $rich1 $location    i.wbcode        	if borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
est store sggc2
	   

*** One-Sided Violence against Civilians
xi: cgmreg bothord_os  			split10pc spil 		$simple      $rich1 $location     i.wbcode										,  cluster(wbcode cluster)
est store osgg1

xi: cgmreg bothos  				split10pc spil 		$simple      $rich1 $location     i.wbcode										,  cluster(wbcode cluster)
est store osgg2

xi: cgmreg bothord_os  			split10pc spil 		$simple      $rich1 $location     i.wbcode	       	if borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
est store osggc1

xi: cgmreg bothos  				split10pc spil 		$simple      $rich1 $location     i.wbcode	    	if borderdist1<median_bd  & no==0,  cluster(wbcode cluster)
est store osggc2

** Appendix Table 30. Ethnic Partitioning and Civil Conflict. Accounting for Measurement Error in the Civil Conflict Databases. State Conflict and Civilian Violence
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** all columns: rich set of countrols and country fixed-effects
** columns (1) - (4): State-Conflict
** columns (5) - (8): One-sided Violence against Civilians  
** columns (1), (2), (5), (6): All Country-Ethnic Homelands 
** columns (3), (4), (7), (8): Country-ethnic Homelands close to the neational border  
****************************************************************************************************************************************
*****************************************************************************************************************************************
estout sgg1  sgg2  sggc1  sggc2 osgg1  osgg2  osggc1  osggc2 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N, fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   

