


** Appendix Table 21. Ethnic Partitioning and Civil Conflict. Controlling for Unobservables. Distance to the Border. 4th-order poly1nomial 
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


** Generate higher-order poly1nomial terms
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
global poly1 			borderdist2 borderdist3 borderdist4
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

** NB ML 
xi: nbreg all   	split10pc spil	$simple   $rich1    $location $poly1	i.wbcode 				,  robust cluster(  wbcode)
est store opnn1

xi: nbreg battles   split10pc spil	$simple   $rich1    $location $poly1	i.wbcode 				,  robust cluster(  wbcode)
est store opnn2

xi: nbreg vio   	split10pc spil	$simple   $rich1   	$location $poly1	i.wbcode 				,  robust cluster(  wbcode)
est store opnn3

xi: nbreg riots   	split10pc spil	$simple   $rich1   	$location $poly1	i.wbcode 				,  robust cluster(  wbcode)
est store opnn4

xi: nbreg all   	split10pc spil	$simple   $rich1    $location 	$poly1 i.wbcode 	if borderdist1<median_bd & no==0			,  robust cluster(  wbcode)
est store opnnc1

xi: nbreg battles   split10pc spil	$simple   $rich1    $location 	$poly1 i.wbcode 	if borderdist1<median_bd & no==0			,  robust cluster(  wbcode)
est store opnnc2

xi: nbreg vio   	split10pc spil	$simple   $rich1   	$location 	$poly1 i.wbcode 	if borderdist1<median_bd & no==0			,  robust cluster(  wbcode)
est store opnnc3

xi: nbreg riots   	split10pc spil	$simple   $rich1     $location 	$poly1 i.wbcode 	if borderdist1<median_bd & no==0			,  robust cluster(  wbcode)
est store opnnc4

** LPM	   
xi: cgmreg alld 	split10pc spil	$simple  $rich1  	$location $poly1	i.wbcode	,  cluster(wbcode  cluster)
est store opa1
	   
xi: cgmreg batd 	split10pc spil	$simple  $rich1  	$location $poly1	i.wbcode		,  cluster(wbcode  cluster)
est store opa2
	   
xi: cgmreg viod 	split10pc spil	$simple  $rich1  	$location $poly1	i.wbcode		,  cluster(wbcode  cluster)
est store opa3
	   
xi: cgmreg riotsd 	split10pc spil	$simple  $rich1  	$location $poly1	i.wbcode		,  cluster(wbcode  cluster)
est store opa4
	   
	   
xi: cgmreg alld 	split10pc spil	$simple  $rich1  	$location $poly1	i.wbcode	if borderdist1<median_bd  & no==0	,  cluster(wbcode  cluster)
est store opa1c
	   
xi: cgmreg batd 	split10pc spil	$simple  $rich1  	$location $poly1	i.wbcode	if borderdist1<median_bd  & no==0	,  cluster(wbcode  cluster)
est store opa2c
	   
xi: cgmreg viod 	split10pc spil	$simple  $rich1  	$location $poly1	i.wbcode	if borderdist1<median_bd  & no==0	,  cluster(wbcode  cluster)
est store opa3c
	   
xi: cgmreg riotsd 	split10pc spil	$simple  $rich1  	$location $poly1	i.wbcode	if borderdist1<median_bd  & no==0	,  cluster(wbcode  cluster)
est store opa4c




** Appendix Table 21. Ethnic Partitioning and Civil Conflict. Controlling for Unobservables. Distance to the Border. 4th-order poly1nomial 
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** all columns: rich set of controls; and 4th-order polynomial on distnace to national the border
** column (1) and (4): all events 
** column (2) and (5): battles
** column (3) and (6): violence against civilians	
** column (4) and (8):  riots and protests
** columns (1)-(4): all ethnic homelads; columns (5)-(8): areas close to the national border
***********************************************************************************************************************************************************************

** Panel A. Negative Binomial ML with country Fixed-Effects
************************************************************************************************************************************************************************
estout opnn1 opnn2 opnn3 opnn4 opnnc1 opnnc2 opnnc3 opnnc4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll r2_a N, fmt(%9.3f %9.0g) labels(LogLikelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   
** Panel B. Linear Probability Model Estimates with Country Fixed-Effects
************************************************************************************************************************************************************************
estout opa1 opa2 opa3 opa4 opa1c opa2c opa3c opa4c, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N, fmt(%9.3f %9.0g) labels(adjustedR2 Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)


