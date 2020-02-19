


** Appendix Table 18. Ethnic Partitioning and Civil Conflict. Not Accounting for Spillovers. 
** Panel A. NB ML Estimates with Country Fixed-Effects. 
** Panel B. Linear Probability Model Estimates with Country Fixed-Effects
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
** To get double-clustered s.e. for NB - ML specifications one needs to run the program three times, changing the cluster(); 
** (a) cluster (ethnic family); (b) wbcode (country); (c) inter (intersection of ethnic family and country)


** Conditioning Sets
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

global regi 			region_n region_s region_w region_e 

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 

*** Using Main Conflict Events (no riots and protests) 
*********************************************************************************************************************************************
*********************************************************************************************************************************************

** NB ML Models
xi: nbreg allm 	  split10pc			$simple  $rich1 $location i.wbcode 	  														,  robust cluster( cluster)
est store fmfroalnb1

xi: nbreg allm 	  split10pc			$simple  $rich1 $location i.wbcode 	   if allm<top_allm										,  robust cluster( cluster)
est store fmfroalnb2

xi: nbreg allm 	  split10pc 		$simple  $rich1 $location i.wbcode 	   if capital==0										,  robust cluster( cluster)
est store fmfroalnb3

**
xi: nbreg allm 	  split10pc 		$simple  $rich1 $location i.wbcode    if borderdist1<median_bd  & no==0						,  robust cluster( cluster)
est store fmfroalnb1c

xi: nbreg allm 	  split10pc 		$simple  $rich1 $location i.wbcode    if allm<top_allm & borderdist1<median_bd  & no==0		,  robust cluster( cluster)
est store fmfroalnb2c

xi: nbreg allm 	  split10pc 		$simple  $rich1 $location i.wbcode    if capital==0 & borderdist1<median_bd  & no==0		,  robust cluster( cluster)
est store fmfroalnb3c
  
** LPM Specifications	
xi: cgmreg allmd 	  split10pc 		$simple  $rich1 $location i.wbcode    													,  cluster(wbcode cluster)
est store fmfrolp1
	   
xi: cgmreg allmd 	  split10pc 		$simple  $rich1 $location i.wbcode    if all<top_all 									,  cluster(wbcode cluster)
est store fmfrolp2

xi: cgmreg allmd 	  split10pc 		$simple  $rich1 $location i.wbcode    if capital==0 									,  cluster(wbcode cluster)
est store fmfrolp3
  
  
xi: cgmreg allmd 	  split10pc 		$simple  $rich1 $location i.wbcode    if 				 	borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
est store fmfrolp1c
	   
xi: cgmreg allmd 	  split10pc 		$simple  $rich1 $location i.wbcode    if all<top_all 	& 	borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
est store fmfrolp2c

xi: cgmreg allmd 	  split10pc 		$simple  $rich1 $location i.wbcode    if capital==0 	& 	borderdist1<median_bd  & no==0	,  cluster(wbcode cluster)
est store fmfrolp3c
  
	   

	   

** Appendix Table 18. Ethnic Partitioning and Civil Conflict. Not Accounting for Spillovers. 
** Panel A. NB ML Estimates with Country Fixed-Effects. 
** Panel B. Linear Probability Model Estimates with Country Fixed-Effects
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** outcome varaible. all main events (excl. riots and protests)
** all columns: rich set of controls
** column (1) and (4): all observatins 
** column (2) and (5): dropping outliers
** column (3) and (6): dropping capitals 		
** columns (1)-(3): all ethnic homelads; columns (4)-(6): areas close to the national border
***********************************************************************************************************************************************************************

** Negative Binomial ML with country Fixed-Effects
************************************************************************************************************************************************************************
estout  fmfroalnb1 fmfroalnb2 fmfroalnb3 fmfroalnb1c fmfroalnb2c fmfroalnb3c, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(  split10pc  ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
** LPM -  linear probability models with country Fixed-Effects 
***********************************************************************************************************************************************************************
estout fmfrolp1 fmfrolp2 fmfrolp3  fmfrolp1c fmfrolp2c fmfrolp3c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square)) keep(  split10pc ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
