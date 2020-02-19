



** Appendix Table 22. Ethnic Partitioning and Civil Conflict. Controlling for Unobservables. Ethnic-Family Fixed-Effects Specifications
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************


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



********************************************************************************************************************************************************************
********************************************************************************************************************************************************************
** Panel A. all events 
*******************************************************************************************************************************************************************

**
xi: nbreg all 	split10pc spil		$simple  $rich1 $location i.wbcode 	i.cluster													,  robust cluster( cluster)
est store dd1

xi: nbreg all 	split10pc spil 		$simple  $rich1 $location i.wbcode i.cluster if borderdist1<median_bd  & no==0					,  robust cluster( cluster)
est store dd1c
  
***	
xi: cgmreg alld 	split10pc spil 		$simple  $rich1 $location i.wbcode i.cluster 						,  cluster(wbcode cluster)
est store dd2  
  
xi: cgmreg alld 	split10pc spil 		$simple  $rich1 $location i.wbcode i.cluster if 				 	borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
est store dd2c
	   
***	   
xi: poisson dur 	split10pc spil		$simple  $rich1 $location i.wbcode 	i.cluster													,  robust cluster( cluster)
est store dd3

xi: poisson dur 	split10pc spil 		$simple  $rich1 $location i.wbcode i.cluster if borderdist1<median_bd  & no==0					,  robust cluster( cluster)
est store dd3c	   
	   

********************************************************************************************************************************************************************
********************************************************************************************************************************************************************
** Panel B. all main events (excl. riots and protests)
*******************************************************************************************************************************************************************

**
xi: nbreg allm 	split10pc spil		$simple  $rich1 $location i.wbcode 	i.cluster													,  robust cluster( cluster)
est store ddm1

xi: nbreg allm 	split10pc spil 		$simple  $rich1 $location i.wbcode i.cluster if borderdist1<median_bd  & no==0					,  robust cluster( cluster)
est store ddm1c
  
***	
xi: cgmreg allmd 	split10pc spil 		$simple  $rich1 $location i.wbcode i.cluster 						,  cluster(wbcode cluster)
est store ddm2  
  
xi: cgmreg allmd 	split10pc spil 		$simple  $rich1 $location i.wbcode i.cluster if 				 	borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
est store ddm2c
	   
***	   
xi: poisson durm 	split10pc spil		$simple  $rich1 $location i.wbcode 	i.cluster													,  robust cluster( cluster)
est store ddm3

xi: poisson durm 	split10pc spil 		$simple  $rich1 $location i.wbcode i.cluster if borderdist1<median_bd  & no==0					,  robust cluster( cluster)
est store ddm3c	   





***************************************************************
***************************************************************
** Appendix Table 22. Ethnic Partitioning and Civil Conflict. Controlling for Unobservables. Ethnic-Family Fixed-Effects Specifications
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** all columns: rich set of controls
** all columns: country fixed-effects and ethnic family (cluster) fixed effects
** columns (1)-(3): all ethnic homelands; columns (4)-(6): areas close to the national border
***********************************************************************************************************************************************************************
** Panel A. NB-ML, LPM, and Poisson ML estimates using all conflict events (of any type) 
***********************************************************************************************************************************************************************
estout  dd1 dd2 dd3 dd1c  dd2c  dd3c, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll r2_a N , fmt(%9.3f %9.0g) labels(LogLikelihood R2 Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
** Panel B. NB-ML, LPM, and Poisson ML estimates using all conflict events (of any type) 
***********************************************************************************************************************************************************************
estout ddm1 ddm2 ddm3 ddm1c  ddm2c  ddm3c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll r2_a N , fmt(%9.3f %9.0g) labels(LogLikelihood R2 Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
	   
	   
