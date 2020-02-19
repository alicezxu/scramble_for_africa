


** Table 3. Ethnic Partitioning and Civil Conflict Intensity. Country Fixed-Effects Estimates.
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
** (1): To get double-clustered s.e. for NB - ML and the Poisson ML specifications one needs to run the program three times, changing the cluster(); 
** (a) cluster (ethnic family); (b) wbcode (country); (c) inter (intersection of ethnic family and country)
** (2): For the linear probability models the cgmreg command estimates double-clustered s.e.
************************************************************************************************************************************************************************

** Conditioning Sets
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

global regi 			region_n region_s region_w region_e 

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 


*************************************************************************************************************************************************************************


** Results. Estimation
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

*** Number of deadly events (at least one fatality); columns (1) and (6)
*****************************************************************************************
*****************************************************************************************
xi: nbreg allf 		split10pc spil 		$simple   	$rich1   	$location 	i.wbcode													,  robust cluster( cluster)
est store efatnb

xi: nbreg allf 		split10pc spil 		$simple   	$rich1   	$location 	i.wbcode				if borderdist1<median_bd  & no==0	,  robust cluster( cluster)
est store efatnbc

*** Indicator for deadly events (at least one fatality); columns (2) and (7)
*****************************************************************************************
*****************************************************************************************
xi: cgmreg allfd 	split10pc spil 		$simple  $rich1 $location i.wbcode													,  cluster(wbcode cluster)
est store fallp

xi: cgmreg allfd 	split10pc spil 		$simple   $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  cluster(wbcode cluster)
est store fallpc


*** Number of fatalities/casualties; columns (3) and (8); excl. top 1% for convergence
*****************************************************************************************
*****************************************************************************************
xi: nbreg fatal 	split10pc spil 		$simple   	$rich1   	$location 		i.wbcode				if fatal<top_fatal									,  robust cluster( cluster)
est store fatnb

xi: nbreg fatal 	split10pc spil 		$simple   	$rich1   	$location 		i.wbcode				if borderdist1<median_bd  & no==0	& fatal<top_fatal,  robust cluster( cluster)
est store fatnbc

*** Duration of any type of events 
*****************************************************************************************
*****************************************************************************************
sum dur, d

xi: poisson dur 	split10pc spil $simple   $rich1 $location i.wbcode									,  robust cluster(  cluster)
est store tid

xi: poisson dur 	split10pc spil 	$simple   $rich1 $location i.wbcode if borderdist1<median_bd & no==0 ,  robust cluster(  cluster)
est store tidc

   
*** Duration of deadly events (excluding riots, protests and non-violent events)
*****************************************************************************************
*****************************************************************************************
sum durdead, d

xi: poisson durdead split10pc spil $simple   $rich1 $location i.wbcode,  robust cluster(  cluster)
est store tdi

xi: poisson durdead split10pc spil $simple   $rich1 $location i.wbcode if borderdist1<median_bd & no==0,  robust cluster(  cluster)
est store tdic

*********************************************************************************************************************************************************************







** Table 3. Ethnic Partitioning and Civil Conflict Intensity. Country Fixed-Effects Estimates.
*********************************************************************************************************************************************************************
*********************************************************************************************************************************************************************
** all specifications: rich set of countrols and country fixed-effects
** columns (1)-(5): All Country-Ethnic Homelands
** columns (6)-(10): Country-ethnic homelands close to the national border
*****************************************************************************************
estout efatnb fallp fatnb tid tdi efatnbc fallpc fatnbc tidc tdic, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll r2a_ N , fmt(%9.3f %9.0g) labels(LogLikelihood adjusted-R2 Obs)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   



	   
	   
	   

	   


	   

