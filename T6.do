

** Table 6. Ethnic Partitioning and Civil Conflict Types. UCDP GED 
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************


** Conditioning Sets
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

global regi 			region_n region_s region_w region_e 

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 

*** Preliminaries
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************

** Number of State-driven Conflict Events, One-sided Violence against Civilians and Non-State Conflict  (high precision)
***********************************************************************************************************************************************************************
gen state_prec		=sum_state_no
gen onesided_prec	=sum_onesided_no
gen nonstate_prec	=sum_nonstate_no


**
sum durucdp_state, d
sum durucdp_nonstate, d
sum durucdp_onesided, d




************************************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************************
** Panel A. State Conflict. UCDP
************************************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************************
xi: nbreg state_prec  		split10pc  	spil 	$simple  	$rich1  $location 	i.wbcode									,  robust cluster( cluster) nolog
est store st1

xi: nbreg state_prec  		split10pc  	spil 	$simple  	$rich1  $location 	i.wbcode if borderdist1<median_bd & no==0	,  robust cluster( cluster) nolog
est store st1c

xi: cgmreg stated 			split10pc  	spil  	$simple  	$rich1  $location 	i.wbcode 									,  robust cluster (  cluster wbcode)
est store st2	 
	   	 
xi: cgmreg stated 			split10pc  	spil  	$simple  	$rich1  $location 	i.wbcode 	if borderdist1<median_bd & no==0,  robust cluster (  cluster wbcode)
est store st2c	 

xi: nbreg durucdp_state 	split10pc 	spil 	$simple   	$rich1 $location 	i.wbcode									,  robust cluster( wbcode)
est store st3

xi: nbreg durucdp_state 	split10pc 	spil 	$simple   	$rich1 $location 	i.wbcode	if borderdist1<median_bd & no==0,  robust cluster( wbcode)
est store st3c

** Panel B. One-sided Violence against Civilians. UCDP
************************************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************************
xi: nbreg onesided_prec   	split10pc  	spil 	$simple  	$rich1  $location 	i.wbcode									,  robust cluster( cluster) nolog
est store os1

xi: nbreg onesided_prec   	split10pc  	spil 	$simple  	$rich1  $location 	i.wbcode if borderdist1<median_bd & no==0	,  robust cluster( cluster) nolog
est store os1c

xi: cgmreg onesidedd 		split10pc  	spil  	$simple  	$rich1  $location 	i.wbcode 									,  robust cluster (  cluster wbcode)
est store os2	 
	   	 
xi: cgmreg onesidedd	 	split10pc  	spil  	$simple  	$rich1  $location 	i.wbcode 	if borderdist1<median_bd & no==0,  robust cluster (  cluster wbcode)
est store os2c	 

xi: nbreg durucdp_onesided 	split10pc 	spil 	$simple   	$rich1 $location 	i.wbcode									,  robust cluster( wbcode)
est store os3

xi: nbreg durucdp_onesided 	split10pc 	spil 	$simple   	$rich1 $location 	i.wbcode	if borderdist1<median_bd & no==0,  robust cluster( wbcode)
est store os3c

** Panel C. Non-State Conflict. UCDP
************************************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************************
xi: nbreg nonstate_prec   	split10pc  	spil 	$simple  	$rich1  $location 	i.wbcode									,  robust cluster( cluster) nolog
est store ns1

xi: nbreg nonstate_prec   	split10pc  	spil 	$simple  	$rich1  $location 	i.wbcode if borderdist1<median_bd & no==0	,  robust cluster( cluster) nolog
est store ns1c

xi: cgmreg nonstated 		split10pc  	spil  	$simple  	$rich1  $location 	i.wbcode 									,  robust cluster (  cluster wbcode)
est store ns2	 
	   	 
xi: cgmreg nonstated 		split10pc  	spil  	$simple  	$rich1  $location 	i.wbcode 	if borderdist1<median_bd & no==0,  robust cluster (  cluster wbcode)
est store ns2c	 

xi: nbreg durucdp_nonstate 	split10pc 	spil 	$simple   	$rich1 $location 	i.wbcode									,  robust cluster( wbcode)
est store ns3

xi: nbreg durucdp_nonstate 	split10pc 	spil 	$simple   	$rich1 $location 	i.wbcode	if borderdist1<median_bd & no==0,  robust cluster( wbcode)
est store ns3c

*********************************************************************************************************************************************************************
** Table 6: Ethnic Partitioning and Civil Conflict Types. UCDP GED
*******************************************************************
*******************************************************************
** columns (1) - (3): All Homelands 
** columns (4) - (6): Country-ethnic Homelands close to the neational border  
** all columns; country FE and rich set of controls
** columns (1) & (4): NB-ML number of events/incidents (deadly) 
** columns (2) & (5): LPM with likelihood of deadly events
** columns (3) & (6): NB-ML duration (in years) of deadly events/incidents
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** Panel A: State Conflict
estout st1 st2 st3 st1c st2c st3c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll r2_a N , fmt(%9.3f %9.0g) labels(LogLikelihood R2 Obs)) keep(split10pc   spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

** Panel B: One-Sided Violence against Civilians
estout os1 os2 os3 os1c os2c os3c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll r2_a N , fmt(%9.3f %9.0g) labels(LogLikelihood R2 Obs)) keep(split10pc   spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
** Panel C: Non-State Conflict
estout ns1 ns2 ns3 ns1c ns2c ns3c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll r2_a N , fmt(%9.3f %9.0g) labels(LogLikelihood R2 Obs)) keep(split10pc   spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

