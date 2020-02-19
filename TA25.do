


***************************************************************
***************************************************************
** Appendix Table 25. Ethnic Partitioning and Civil Conflict. Accounting for  spillovers at the Country Level and at the Ethnic Family Level
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************



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

**************************************************************************************************************************************************************************

** Generate number of events in each country and in each ethno-linguistic cluster/family, excl. events in a group's own ethnic homeland
***************************************************************************************************************************************************************************
bysort cluster: egen allm_cluster=sum(allm)
bysort wbcode:  egen allm_wbcode=sum(allm)
*Note: one has to use egen -rather than gen


gen allm_family=allm_cluster-allm
gen allm_country=allm_wbcode-allm

gen lnallm_family=ln(1+allm_family)
gen lnallm_country=ln(1+allm_country)

gen lnallm=ln(allm+1)


** Results. Estimation
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

** NB_ML Main Conflict Events (excl. riots and protests); columns (1) and (7)
******************************************************************************************
******************************************************************************************
xi: nbreg allm 		split10pc   		lnallm_countr	lnallm_family $simple   $rich1 	$location 	$regi											,  robust cluster( cluster)
est store spi1

xi: nbreg allm 		split10pc   		lnallm_countr	lnallm_family $simple   $rich1 	$location 	$regi				if borderdist1<median_bd    ,  robust cluster( cluster)
est store spi1c


** Linear Probability Models. Main Conflict Events Indicator; columns (2) and (8)
******************************************************************************************
******************************************************************************************
xi: cgmreg allmd 	split10pc   		lnallm_countr	lnallm_family $simple  $rich1 $location $regi 											,  cluster(wbcode cluster)
est store spi2  
  
xi: cgmreg allmd 	split10pc   		lnallm_countr	lnallm_family $simple  $rich1 $location $regi  if 	 	borderdist1<median_bd    		,  cluster(wbcode cluster)
est store spi2c


** OLS Models. Log (1+Main Conflict Events); columns (3) and (9)
******************************************************************************************
******************************************************************************************
xi: cgmreg lnallm 	split10pc   		lnallm_countr	lnallm_family 	$simple  $rich1 $location $regi 									,  cluster(wbcode cluster)
est store spi3  
  
xi: cgmreg lnallm 	split10pc   		lnallm_countr	lnallm_family 	$simple  $rich1 $location $regi  if 	 	borderdist1<median_bd    ,  cluster(wbcode cluster)
est store spi3c


*** Number of deadly events (at least one fatality); columns (4) and (10)
*****************************************************************************************
*****************************************************************************************
xi: nbreg allf 		split10pc   		lnallm_family	lnallm_country $simple   	$rich1   	$location 	$regi								,  robust cluster( cluster)
est store spi4

xi: nbreg allf 		split10pc   		lnallm_family	lnallm_country $simple   	$rich1   	$location 	$regi	if borderdist1<median_bd    ,  robust cluster( cluster)
est store spi4c

   
*** Duration of main conflcit events; columns (5) and (11)
*****************************************************************************************
*****************************************************************************************
xi: poisson durm 	split10pc   		lnallm_family	lnallm_country $simple   $rich1 $location $regi,  robust cluster(  cluster)
est store spi5

xi: poisson durm 	split10pc   		lnallm_family	lnallm_country $simple   $rich1 $location $regi if borderdist1<median_bd ,  robust cluster(  cluster)
est store spi5c


*** Duration of deadly conflcit events; columns (6) and (12)
*****************************************************************************************
*****************************************************************************************
xi: poisson durdead split10pc   		lnallm_family	lnallm_country $simple   $rich1 $location $regi,  robust cluster(  cluster)
est store spi6

xi: poisson durdead split10pc   		lnallm_family	lnallm_country $simple   $rich1 $location $regi if borderdist1<median_bd ,  robust cluster(  cluster)
est store spi6c

*********************************************************************************************************************************************************************





* Appendix Table 25. Ethnic Partitioning and Civil Conflict. Accounting for spillovers at the Country Level and at the Ethnic Family Level
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** all specifications: rich set of countrols and region fixed-effects
** columns (1)-(6): All Country-Ethnic Homelands
** columns (7)-(12): Country-ethnic homelands close to the national border
*****************************************************************************************
estout spi1 spi2 spi3 spi4 spi5 spi6 spi1c spi2c spi3c spi4c spi5c spi6c, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll r2_a N , fmt(%9.3f %9.0g) labels(LogLikelihood adjusted-R2 Obs)) keep(split10pc  lnallm_family	lnallm_country ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   




