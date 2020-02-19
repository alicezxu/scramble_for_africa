


***************************************************************
***************************************************************
** Appendix Table 26. Ethnic Partitioning and Civil Conflict.  Accounting for pre-colonial conflict (slave trades and kingdoms/empires)
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************

d distcon distemp exports exports_dummy 

** Preliminaries
*****************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************

* Notes:
********
** Note (1): To get double-clustered s.e. for NB - ML and Poisson ML specifications one needs to run the program three times, changing the cluster(); 
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

***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************

d distcon distemp exports

**dummy for ethnic areas with conflict and distance to conflcit
******************************************************************************************
******************************************************************************************
gen 	precondummy=1 	if distcon==0
replace precondummy=0 	if distcon>0
tab precondummy

gen 	lndistcon=ln(1+distcon)
replace distcon=distcon/1000


**Dummy for ethnic areas that were part of large empires/kingdoms and distnace to kingdoms
*******************************************************************************************
*******************************************************************************************
gen empire=1 if distemp==0
replace empire=0 if distemp>0

gen lndistemp=ln(1+distemp)

** log slave trades; standradization and logarithmic transformation follows Nunn (2008)
*******************************************************************************************
*******************************************************************************************
gen lnexports1=ln(1+(exports*fracnew)/km2group)



*** Estimation. Accounting for pre-colonial conflict (slave trades and kingdoms/empires)
***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************

xi: nbreg allm 	  		split10pc	spil	precondummy lndistcon $simple  $rich1 $location i.wbcode 	  										,  robust cluster( cluster)
est store pcw1

xi: nbreg allm 	  		split10pc 	spil	precondummy lndistcon $simple  $rich1 $location i.wbcode    if borderdist1<median_bd  & no==0		,  robust cluster( cluster)
est store pcw1c

xi: cgmreg allmd 	  	split10pc 	spil	precondummy lndistcon $simple  $rich1 $location i.wbcode    										,  cluster(wbcode cluster)
est store pcw2
  
xi: cgmreg allmd 	  	split10pc 	spil	precondummy lndistcon $simple  $rich1 $location i.wbcode    if borderdist1<median_bd  & no==0		,  cluster(wbcode cluster)
est store pcw2c
	
***	

xi: nbreg allm 	  		split10pc	spil	empire lndistemp $simple  $rich1 $location i.wbcode 	  										,  robust cluster( cluster)
est store pcw3

xi: nbreg allm 	  		split10pc 	spil	empire lndistemp $simple  $rich1 $location i.wbcode    if borderdist1<median_bd  & no==0		,  robust cluster( cluster)
est store pcw3c

xi: cgmreg allmd 	  	split10pc 	spil	empire lndistemp $simple  $rich1 $location i.wbcode    										,  cluster(wbcode cluster)
est store pcw4
  
xi: cgmreg allmd 	  	split10pc 	spil	empire lndistemp $simple  $rich1 $location i.wbcode    if borderdist1<median_bd  & no==0		,  cluster(wbcode cluster)
est store pcw4c	
	
***	
xi: nbreg allm 	  		split10pc	spil	lnexports1 		$simple  $rich1 $location i.wbcode 	  										,  robust cluster( cluster)
est store pcw5

xi: nbreg allm 	  		split10pc 	spil	lnexports1 		$simple  $rich1 $location i.wbcode    if borderdist1<median_bd  & no==0		,  robust cluster( cluster)
est store pcw5c

xi: cgmreg allmd 	  	split10pc 	spil	lnexports1 		$simple  $rich1 $location i.wbcode    										,  cluster(wbcode cluster)
est store pcw6
  
xi: cgmreg allmd 	  	split10pc 	spil	lnexports1 		$simple  $rich1 $location i.wbcode    if borderdist1<median_bd  & no==0		,  cluster(wbcode cluster)
est store pcw6c		
	

	
	
** Appendix Table 26. Ethnic Partitioning and Civil Conflict.  Accounting for pre-colonial conflict (slave trades and kingdoms/empires)
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** outcome varaible. all main events (excl. riots and protests)
** all columns: rich set of controls and country fixed-effects
** columns (1) & (4); controlling for dummy for pre-colonial  conflcit and log distance to pre-colonial conflict (Besley and Reynal-Querrol)
** columns (2) & (5): controlling for log slave exports, using data and standardization of Nunn (2008) 
** columns (3) & (6): controlling for dummy for pre-colonial 	empire and log distance to empire (Besley and Reynal-Querrol)
** columns (1)-(3): all ethnic homelads; columns (4)-(6): areas close to the national border
*************************************************************************************************************************************************************************

** NB-ML with country fixed-effects
*************************************************************************************************************************************************************************
estout  pcw1 pcw5 pcw3  pcw1c  pcw5c pcw3c   , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(LogLikelihood Obs)) keep(  split10pc  spil precondummy lndistcon empire lndistemp lnexports1) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   

** LP - OLS linear probability models with country fixed-efefcts. CGMREG. 
****************************************************************************************************************************************************************************
estout pcw2 pcw6 pcw4  pcw2c  pcw6c pcw4c   , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjustedR-square Obs)) keep(  split10pc  spil precondummy lndistcon empire lndistemp lnexports1 ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)



   
	   

