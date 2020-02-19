

** Appendix Table 17. Ethnic Partitioning and Civil Conflict Actors. Poisson ML Country Fixed-Effects Estimates.
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

** Note (2): Please run this program after running T5. 

** Note (3): The program estimates Poisson ML specifications for 9 outcomes.
** 			(i): government
** 			(ii): rebel groups
** 			(iii): militias
** 			(iv): rebel and militia groups
** 			(v): riots and protests
** 			(vi): civilians
** 			(vii): all external 
** 			(viii): interventions of nearby African countries
** 			(ix): outside multinational interventions (UN, NATO, African Union)
**
** For brevity in  Appendix Table 17 we report estimates with government troops, rebels and militias, interventions from nearby countries, and other external
************************************************************************************************************************************************************************


** Preliminaries
****************
****************

** Sum riots & protests
** Sum rebels and militias
***********************************************************************************************************************************************************************
gen rebmil=rebels+mil
gen rebmild=0
replace rebmild=1 if rebmil>0 & rebmil!=.
gen riotprot=rioters+protesters

sum govt rebels mil rebmil riotprot civilians external intervention 

** Generate Identifier Variables for countries without variability (no conflict) for each type of actor-based conflict
**** For all country-ethnic homelands and for country-ethnic homelands close to the national border
***********************************************************************************************************************************************************************

by wbcode, sort: egen jgo=sd(govt)
by wbcode, sort: egen jre=sd(rebels)
by wbcode, sort: egen jmi=sd(mil)
by wbcode, sort: egen jrm=sd(rebmil)
by wbcode, sort: egen jrp=sd(riotprot)
by wbcode, sort: egen jci=sd(civilians)
by wbcode, sort: egen jex=sd(external)
by wbcode, sort: egen jin=sd(intervention)
by wbcode, sort: egen jou=sd(outside)


by wbcode, sort: egen hgo=sd(govt) 			if borderdist1<=median_bd & no==0
by wbcode, sort: egen hre=sd(rebels) 		if borderdist1<=median_bd & no==0
by wbcode, sort: egen hmi=sd(mil) 			if borderdist1<=median_bd & no==0
by wbcode, sort: egen hrm=sd(rebmil) 		if borderdist1<=median_bd & no==0
by wbcode, sort: egen hrp=sd(riotprot) 		if borderdist1<=median_bd & no==0
by wbcode, sort: egen hci=sd(civilians) 	if borderdist1<=median_bd & no==0
by wbcode, sort: egen hex=sd(external) 		if borderdist1<=median_bd & no==0
by wbcode, sort: egen hin=sd(intervention) 	if borderdist1<=median_bd & no==0
by wbcode, sort: egen hou=sd(outside) 		if borderdist1<=median_bd & no==0

****************



** Generate Top1 and Top5 of actor-based conflict
************************************************************************************************************************************************************************
foreach var of varlist govt rebels mil rebmil  riotprot civilians external {
	sum `var', det
	egen top_`var'=pctile(`var'), p(99)
	egen top5_`var'=pctile(`var'), p(95)
}
**




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


	   
** Appendix Table 17. Ethnic Partitioning and Conflict Actors. Poisson ML Estimates with Country Fixed-Effects (excl. outliers)
***************************************************************************************************************************************************************
***************************************************************************************************************************************************************	   
estout apo1 apo4 apo8 apo9 apoc1 apoc4 apoc8 apoc9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)	
	
	
	   
	   
