

** Table 5. Ethnic Partitioning and Civil Conflict Actors. Country Fixed-Effects Estimates.
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

** Note (3): The program estimates NB-ML, LPM, and Poisson ML specifications for 9 outcomes.
** 			(i): government
** 			(ii): rebel groups
** 			(iii): militias
** 			(iv): rebel and militia groups
** 			(v): riots and protests
** 			(vi): civilians
** 			(vii): all external 
** 			(viii): interventions of nearby African countries
** 			(ix): outside multinational interventions (UN, NATO, African Union)
** For brevity in Table 5 and Appendix Table 17 we report estimates with government troops, rebels and militias, interventions from nearby countries, and other external
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


** Merge Miltias and Rebels
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
gen rebmil=rebels+mil
label var rebmil "Number of conflict events by rebels or militias. ACLED."

gen rebmild=0
replace rebmild=1 if rebmil>0 & rebmil!=.

label var rebmild "Indicator (dummy) variable for activity by rebels or militias. ACLED."

** Merge riots and protesters
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
gen riotprot=rioters+protesters

** Summary Statistics and Variable Definitions
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
sum govt rebels mil rebmil riotprot civilians external intervention 
d 	govt rebels mil rebmil riotprot civilians external intervention

** Generate Identifier Variables for countries without any conflict by actor (needed for NB estimation, so as to avoid non-converegnce)
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

** All country-ethnic homelands
by wbcode, sort: egen jgo=sd(govt)
by wbcode, sort: egen jre=sd(rebels)
by wbcode, sort: egen jmi=sd(mil)
by wbcode, sort: egen jrm=sd(rebmil)
by wbcode, sort: egen jrp=sd(riotprot)
by wbcode, sort: egen jci=sd(civilians)
by wbcode, sort: egen jex=sd(external)
by wbcode, sort: egen jin=sd(intervention)
by wbcode, sort: egen jou=sd(outside)

** Close to the national border country-ethnic homelands
by wbcode, sort: egen hgo=sd(govt) 			if borderdist1<=median_bd & no==0
by wbcode, sort: egen hre=sd(rebels) 		if borderdist1<=median_bd & no==0
by wbcode, sort: egen hmi=sd(mil) 			if borderdist1<=median_bd & no==0
by wbcode, sort: egen hrm=sd(rebmil) 		if borderdist1<=median_bd & no==0
by wbcode, sort: egen hrp=sd(riotprot) 		if borderdist1<=median_bd & no==0
by wbcode, sort: egen hci=sd(civilians) 	if borderdist1<=median_bd & no==0
by wbcode, sort: egen hex=sd(external) 		if borderdist1<=median_bd & no==0
by wbcode, sort: egen hin=sd(intervention) 	if borderdist1<=median_bd & no==0
by wbcode, sort: egen hou=sd(outside) 		if borderdist1<=median_bd & no==0

**************************************************************************************************************************************************************************


** Generate variable with the top 1% and top 5% of events by each conflict by actor (needed for NB estimation, so as to avoid non-converegnce)
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
foreach var of varlist govt rebels mil rebmil  riotprot civilians external intervention  outside {
	sum `var', det
	egen top_`var'=pctile(`var'), p(99)
	egen top5_`var'=pctile(`var'), p(95)
}
**


*************************************************************************************************************************************************************************
** Estimation. Panel A. Negative Binomial ML Estimates
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

** All homelands
xi: nbreg govt  		split10pc spil 	$simple    $rich1  $location   i.wbcode if jgo!=0		,  robust cluster(  cluster)
est store a1

xi: nbreg rebels  		split10pc spil 	$simple  	$rich1  $location   i.wbcode if jre!=0		,  robust cluster(  cluster)
est store a2

xi: nbreg mil 			split10pc spil	$simple  	$rich1  $location   i.wbcode if jmi!=0		,  robust cluster(  cluster)
est store a3

xi: nbreg rebmil 		split10pc spil	$simple  	$rich1  $location   i.wbcode if jrm!=0		,  robust cluster(  cluster)
est store a4

xi: nbreg riotprot  	split10pc spil	$simple  	$rich1  $location   i.wbcode if jrp!=0		,  robust cluster(  cluster)
est store a5

xi: nbreg civilians  	split10pc spil	$simple  	$rich1  $location   i.wbcode if jci!=0		,  robust cluster(  cluster)
est store a6

xi: nbreg external  	split10pc spil	$simple  	$rich1  $location   i.wbcode if jex!=0		,  robust cluster(  cluster)
est store a7

xi: nbreg intervention 	split10pc spil	$simple  	$rich1  $location   i.wbcode if jin!=0		,  robust cluster(  cluster)
est store a8

xi: nbreg outside	  	split10pc spil	$simple  	$rich1  $location   i.wbcode if jou!=0		,  robust cluster(  cluster)
est store a9

****************************************************************************************
estout a1 a2 a3 a4 a5 a6 a7 a8 a9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   

** Homelands close to the national border
xi: nbreg govt  		split10pc spil	$simple   	$rich1  $location  	i.wbcode if  borderdist1<median_bd  & hgo!=0 & no==0,  robust cluster(  cluster)
est store ac1

xi: nbreg rebels  		split10pc spil	$simple  	$rich1  $location   i.wbcode if  borderdist1<median_bd  & hre!=0 & no==0,  robust cluster(  cluster)
est store ac2

xi: nbreg mil 			split10pc spil	$simple   	$rich1  $location   i.wbcode if  borderdist1<median_bd  & hmi!=0 & no==0,  robust cluster(  cluster)
est store ac3

xi: nbreg rebmil 		split10pc spil	$simple   	$rich1  $location   i.wbcode if  borderdist1<median_bd  & hrm!=0 & no==0,  robust cluster(  cluster)
est store ac4

xi: nbreg riotprot  	split10pc spil	$simple  	$rich1  $location   i.wbcode if  borderdist1<median_bd  & hrp!=0 & no==0,  robust cluster(  cluster)
est store ac5

xi: nbreg civilians  	split10pc spil	$simple  	$rich1  $location   i.wbcode if borderdist1<median_bd   & hci!=0 & no==0,  robust cluster(  cluster)
est store ac6

xi: nbreg external  	split10pc spil	$simple  	$rich1  $location   i.wbcode if  borderdist1<median_bd  & hex!=0 & no==0,  robust cluster(  cluster)
est store ac7

xi: nbreg intervention 	split10pc spil	$simple  	$rich1  $location   i.wbcode if  borderdist1<median_bd  & 		  no==0,  robust cluster(  cluster)
est store ac8

xi: nbreg outside	  	split10pc spil	$simple  	$rich1  $location   i.wbcode if  borderdist1<median_bd  & hou!=0 & no==0,  robust cluster(  cluster)
est store ac9



****************************************************************************************
estout ac1 ac2 ac3 ac4 ac5 ac6 ac7 ac8 ac9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)




*************************************************************************************************************************************************************************
** Estimation. Panel B. Linear Probability Model (LPM) Estimates
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

** All Homelands
xi: cgmreg govtd  		split10pc spil	$simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als1

xi: cgmreg rebelsd  	split10pc spil	$simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als2

xi: cgmreg mild 		split10pc spil	$simple   	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als3

xi: cgmreg rebmild 		split10pc spil	$simple   	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als4

xi: cgmreg riotprotd 	split10pc spil	$simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als5

xi: cgmreg civiliansd  	split10pc spil	$simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als6

xi: cgmreg externald  	split10pc spil	$simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als7

xi: cgmreg interventiond split10pc spil	$simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als8

xi: cgmreg outsided  	split10pc spil	$simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store als9


****************************************************************************************
estout als1 als2 als3 als4 als5 als6 als7 als8 als9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
** Homelands close to the National Border
xi: cgmreg govtd  		split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls1

xi: cgmreg rebelsd  	split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls2

xi: cgmreg mild 		split10pc spil	$simple   	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls3

xi: cgmreg rebmild 		split10pc spil	$simple   	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls4

xi: cgmreg riotprotd 	split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls5

xi: cgmreg civiliansd  	split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls6

xi: cgmreg externald  	split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls7

xi: cgmreg interventiond split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls8

xi: cgmreg outsided  	split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store acls9


****************************************************************************************
estout acls1 acls2 acls3 acls4 acls5 acls6 acls7 acls8 acls9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   



*************************************************************************************************************************************************************************
** Estimation. Poisson ML Estimates dropping outliers (top 5%); Appendix Table 17
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
** All Homelands
xi: poisson govt  			split10pc spil 	$simple  	$rich1  $location   i.wbcode if jgo!=0	& govt<top5_govt	,  robust cluster(  cluster)
est store apo1

xi: poisson rebels  		split10pc spil 	$simple  	$rich1  $location   i.wbcode if jre!=0	& rebels<top5_rebels	,  robust cluster(  cluster)
est store apo2

xi: poisson mil 			split10pc spil	$simple  	$rich1  $location   i.wbcode if jmi!=0	& mil<top5_mil	,  robust cluster(  cluster)
est store apo3

xi: poisson rebmil 			split10pc spil	$simple  	$rich1  $location   i.wbcode if jrm!=0	& rebmil<top5_rebmil	,  robust cluster(  cluster)
est store apo4

* xi: poisson riotprot  		split10pc spil	$simple  	$rich1  $location   i.wbcode if jrp!=0	& riotprot< top5_riotprot	,  robust cluster(  cluster)
* est store apo5

xi: poisson civilians  		split10pc spil	$simple  	$rich1  $location   i.wbcode if jci!=0	& civilians<top5_civilians	,  robust cluster(  cluster)
est store apo6

xi: poisson external  		split10pc spil	$simple  	$rich1  $location   i.wbcode if jex!=0	& external<top5_external	,  robust cluster(  cluster)
est store apo7

xi: poisson intervention	split10pc spil	$simple  	$rich1  $location   i.wbcode if jin!=0	& external<top5_external	,  robust cluster(  cluster)
est store apo8

xi: poisson outside  		split10pc spil	$simple  	$rich1  $location   i.wbcode if jou!=0	& external<top5_external	,  robust cluster(  cluster)
est store apo9


** Homelands close to the National Border
xi: poisson govt  			split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & hgo!=0	& govt<top5_govt & no==0,  robust cluster(  cluster)
est store apoc1

xi: poisson rebels  		split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & hre!=0 	& rebels<top5_rebels & no==0,   robust cluster(  cluster)
est store apoc2

xi: poisson mil 			split10pc spil	$simple   	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & hmi!=0 	& mil<top5_mil & no==0,  robust cluster(  cluster)
est store apoc3

xi: poisson rebmil 			split10pc spil	$simple   	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & hrm!=0 	& rebmil<top5_rebmil & no==0,  robust cluster(  cluster)
est store apoc4

* xi: poisson riotprot  		split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & hrp!=0 	& riotprot<top5_riotprot & no==0,  robust cluster(  cluster)
* est store apoc5

xi: poisson civilians  		split10pc spil	$simple  	$rich1  $location   	i.wbcode if borderdist1<median_bd   & hci!=0 	& civilians<top5_civilians & no==0,  robust cluster(  cluster)
est store apoc6

xi: poisson external  		split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & hex!=0  	& external<top5_external & no==0,  robust cluster(  cluster)
est store apoc7

xi: poisson intervention	split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & hin!=0  	& external<top5_external & no==0,  robust cluster(  cluster)
est store apoc8

xi: poisson outside  		split10pc spil	$simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & hou!=0  	& external<top5_external & no==0,  robust cluster(  cluster)
est store apoc9

****************************************************************************************



** All Results
******************************************************************
******************************************************************



** NBREG with country Fixed Effects
*****************************************************************************************************************************************************
*****************************************************************************************************************************************************	  
estout a1 a2 a3 a4 a5 a6 a7 a8 a9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
estout ac1 ac2 ac3 ac4 ac5 ac6 ac7 ac8 ac9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

*** Linear Probability Modles. CGMREG
*****************************************************************************************************************************************************
*****************************************************************************************************************************************************
estout als1 als2 als3 als4 als5 als6 als7 als8 als9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed) 	   
	   
estout acls1 acls2 acls3 acls4 acls5 acls6 acls7 acls8 acls9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)	   
	   

** Poisson estimates with country fixed-effects; excluding top 5%
** rich set of controls in all specifications
******************************************************************
******************************************************************
****************************************************************************************
estout apo1 apo2 apo3 apo4  apo6 apo7 apo8 apo9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   

estout apoc1 apoc2 apoc3 apoc4  apoc6 apoc7 apoc8 apoc9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)


	   
	   
	   
	   
** Table 5. Ethnic Partitioning and Conflict Actors
***************************************************************************************************************************************************************
***************************************************************************************************************************************************************    
** all specifications: rich set of countrols and country fixed-effects
** columns (1)-(4): All Country-Ethnic Homelands
** columns (5)-(8): Country-ethnic homelands close to the national border
************************************************************************** 
** columns (1) & (5): government
** columns (2) & (6): rebel and militia groups
** columns (3) & (7): interventions of nearby African countries
** columns (4) & (8): outside multinational interventions (UN, NATO, African Union)	   
******************************************************************************************	   

** Panel A: Negative Binomial ML estimates
*****************************************************************************************************************************************************************
estout a1 a4 a8 a9 ac1 ac4 ac8 ac9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(LogLikelihood Obs)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)	   
	
** Panel B: Linear Probability Model (LPM) estimates
****************************************************************************************************************************************************************
estout als1 als4 als8 als9 acls1 acls4 acls8 acls9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjustedR2 Obs)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed) 	
	
	   
** Appendix Table 17. Ethnic Partitioning and Conflict Actors. Poisson ML Estimates with Country Fixed-Effects (excl. outliers)
***************************************************************************************************************************************************************
***************************************************************************************************************************************************************	   
estout apo1 apo4 apo8 apo9 apoc1 apoc4 apoc8 apoc9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)	
	
	
	
	
global actors govt govtd rebmil rebmild riotprot riotprotd civilians civiliansd intervention interventiond outside outsided 

tabstat $actors if pop60!=0 , stats(n mean sd p50 min p99 max) col(stats)

tabstat $actors if pop60!=0 & borderdist1<median_bd  , stats(n mean sd p50 min p99 max) col(stats)
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
