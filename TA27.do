

***************************************************************
***************************************************************
** Appendix Table 27. Ethnic Partitioning and Civil Conflict.  Accounting for Regional Development (using data from G-Econ Project)
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

***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************


**** Estimation. Panel A. NB-ML with country fixed-effects
*********************************************************************************************************************************************************************************
xi: nbreg all 		split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store wnb1

xi: nbreg battles 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store wnb2

xi: nbreg vio 		split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store wnb3

xi: nbreg riots 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store wnb4

xi: nbreg all 		split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  robust cluster(  cluster)
est store wnb1c

xi: nbreg battles 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  robust cluster(  cluster)
est store wnb2c

xi: nbreg vio 		split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  robust cluster(  cluster)
est store wnb3c

xi: nbreg riots 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  robust cluster(  cluster)
est store wnb4c


**** Estimation. Panel B. Linear Probability Model with country fixed-effects
*********************************************************************************************************************************************************************************
xi: cgmreg alld 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode 												,  cluster(wbcode  cluster)
est store ww1

xi: cgmreg batd 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode 												,  cluster(wbcode  cluster)
est store ww2

xi: cgmreg viod 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode 												,  cluster(wbcode  cluster)
est store ww3

xi: cgmreg riotsd 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode 												,  cluster(wbcode  cluster)
est store ww4

xi: cgmreg alld 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  cluster(wbcode  cluster)
est store ww1c

xi: cgmreg batd 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  cluster(wbcode  cluster)
est store ww2c

xi: cgmreg viod 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  cluster(wbcode  cluster)
est store ww3c

xi: cgmreg riotsd 	split10pc spil 		wlngcp_pc_mer $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0				,  cluster(wbcode  cluster)
est store ww4c


** Appendix Table 27. Ethnic Partitioning and Civil Conflict.  Accounting for Regional Development (using data from G-Econ Project)
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** all columns: rich set of controls and country fixed-effects and log of GDP p.c in 2000 (G-Econ Project)
** columns (1) & (5); all events
** columns (2) & (6): battles 
** columns (3) & (7): civilian violence
** columns (4) & (8): riots and protests
** columns (1) - (4): all ethnic homelads; columns (5) - (8): areas close to the national border
************************************************************************************************************************************************************************
** Panel A. NB-ML with country fixed-effects
************************************************************************************************************************************************************************
estout wnb1 wnb2 wnb3 wnb4 wnb1c wnb2c wnb3c wnb4c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil wlngcp_pc_mer) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed) 
	   
** Panel B. Linear Probability Model with country fixed-effects
*********************************************************************************************************************************************************************************	   
estout ww1 ww2 ww3 ww4 ww1c ww2c ww3c ww4c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjsuted r-square)) keep(split10pc spil wlngcp_pc_mer) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed) 
