


** This .do file runs Linear Probability Models models with the ACLED data for Table 4 - Panel B in the main part of the paper.
** The LPM specifications are reported in Table 4. Panel B. 
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************


** Preliminaries
*****************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************

* Notes:
********
** need to download the cgmreg.ado routine that implements the multi-way clustering method of Cameron, Gelbach, and Miller (2011)
** s.e. are clustred at the ethnic family (cluster) and the the country level (wbcode)
************************************************************************************************************************************************************************




** Conditioning Sets
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

global regi 			region_n region_s region_w region_e 

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 





** Estimate Regressions. Dependent Variable. Indicator for country-ethnic homelands experencing a conflict event 
*************************************************************************************************************************************************************************


** Battles Indicator; batd
*************************************************************************************************************************************************************************

** All Ethnic Homelands
xi: cgmreg batd  split10pc spil	$simple                     					       				,  cluster(wbcode  cluster)
est store btlp1

xi: cgmreg batd  split10pc spil	$simple                     	i.wbcode							,  cluster(wbcode  cluster)
est store btlp2

xi: cgmreg batd split10pc spil	$simple           	$location 	i.wbcode							,  cluster(wbcode  cluster)
est store btlp3

xi: cgmreg batd  split10pc spil	$simple  $rich1  	$location 	i.wbcode							,  cluster(wbcode  cluster)
est store btlp4

xi: cgmreg batd  split10pc spil	$simple  $rich1  	$location 	i.wbcode if batd<top_battles		,  cluster(wbcode  cluster)
est store btlp5

xi: cgmreg batd  split10pc spil	$simple  $rich1  	$location 	i.wbcode if capital==0				,  cluster(wbcode  cluster)
est store btlp6

** Areas close to the national border
xi: cgmreg batd  split10pc spil	$simple                                if borderdist1<median_bd  & no==0,  cluster(wbcode  cluster)
est store cbtlp1

xi: cgmreg batd  split10pc spil	$simple                       i.wbcode if borderdist1<median_bd & no==0,  cluster(wbcode  cluster)
est store cbtlp2

xi: cgmreg batd  split10pc spil	$simple           	$location i.wbcode if borderdist1<median_bd  & no==0,  cluster(wbcode  cluster)
est store cbtlp3

xi: cgmreg batd  split10pc spil	$simple  $rich1  	$location i.wbcode if borderdist1<median_bd  & no==0,  cluster(wbcode  cluster)
est store cbtlp4

xi: cgmreg batd  split10pc spil	$simple  $rich1  	$location i.wbcode if borderdist1<median_bd  & no==0 & batd<top_battles , cluster(wbcode  cluster)
est store cbtlp5

xi: cgmreg batd  split10pc spil	$simple  $rich1  	$location i.wbcode if borderdist1<median_bd  & no==0 & capital==0,  cluster(wbcode  cluster)
est store cbtlp6


** Battles. Linear probability models. 
******************************************************************************************************************************************************************
estout btlp1 btlp2 btlp3 btlp4  btlp5 btlp6 cbtlp1 cbtlp2 cbtlp3 cbtlp4  cbtlp5 cbtlp6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

   
	   
	   
*** Indicator for Violence against the Civilian Population. deadly incidents. viod 	   
******************************************************************************************************************************************************************

** All Ethnic Homelands
xi: cgmreg viod  	split10pc spil 	$simple                                             ,  cluster(wbcode  cluster)
est store vlpi1

xi: cgmreg viod 	split10pc spil 	$simple                    	i.wbcode				,  cluster(wbcode  cluster)
est store vlpi2

xi: cgmreg viod  	split10pc spil 	$simple         $location 	i.wbcode				,  cluster(wbcode  cluster)
est store vlpi3

xi: cgmreg viod  	split10pc spil	$simple  $rich1 $location 	i.wbcode				,  cluster(wbcode  cluster)
est store vlpi4

xi: cgmreg viod  	split10pc spil 	$simple  $rich1 $location 	i.wbcode if vio<top_vio	,  cluster(wbcode  cluster)
est store vlpi5

xi: cgmreg viod  	split10pc spil 	$simple  $rich1 $location 	i.wbcode if capital==0	,  cluster(wbcode  cluster)
est store vlpi6


** Areas close to the national border	   
xi: cgmreg viod  split10pc spil	$simple                                 if borderdist1<median_bd  & no==0			,  cluster(wbcode  cluster)
est store cvlpi1

xi: cgmreg viod	split10pc spil	$simple                    i.wbcode 	if borderdist1<median_bd  & no==0			,  cluster(wbcode  cluster)
est store cvlpi2

xi: cgmreg viod  split10pc spil	$simple         $location 	i.wbcode 	if borderdist1<median_bd & no==0			,  cluster(wbcode  cluster)
est store cvlpi3

xi: cgmreg viod  split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0			,  cluster(wbcode  cluster)
est store cvlpi4

xi: cgmreg viod  split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0 & vio<top_vio,  cluster(wbcode  cluster)
est store cvlpi5

xi: cgmreg viod  split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0 & capital==0,  cluster(wbcode  cluster)
est store cvlpi6


** Violence against the Civilian Population. deadly incidents 
*****************************************************************************************************************************************************************
estout vlpi1 vlpi2 vlpi3 vlpi4 vlpi5 vlpi6 cvlpi1 cvlpi2 cvlpi3 cvlpi4 cvlpi5 cvlpi6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square Obs)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)


	   
*** Indicator for Riots and Protests. riotsd 	   
******************************************************************************************************************************************************************

** All Ethnic Homelands
xi: cgmreg riotsd   	split10pc spil 	$simple                                             ,  cluster(wbcode  cluster)
est store riolpi1

xi: cgmreg riotsd  		split10pc spil 	$simple                    	i.wbcode				,  cluster(wbcode  cluster)
est store riolpi2

xi: cgmreg riotsd   	split10pc spil 	$simple         $location 	i.wbcode				,  cluster(wbcode  cluster)
est store riolpi3

xi: cgmreg riotsd   	split10pc spil	$simple  $rich1 $location 	i.wbcode				,  cluster(wbcode  cluster)
est store riolpi4

xi: cgmreg riotsd   	split10pc spil 	$simple  $rich1 $location 	i.wbcode if riots<top_riots 	,  cluster(wbcode  cluster)
est store riolpi5

xi: cgmreg riotsd   	split10pc spil 	$simple  $rich1 $location 	i.wbcode if capital==0	,  cluster(wbcode  cluster)
est store riolpi6


** Country-Ethnic Areas close to the national border	 
xi: cgmreg riotsd   split10pc spil	$simple                                 if borderdist1<median_bd  & no==0			,  cluster(wbcode  cluster)
est store criolpi1

xi: cgmreg riotsd  	split10pc spil	$simple                    i.wbcode 	if borderdist1<median_bd  & no==0			,  cluster(wbcode  cluster)
est store criolpi2

xi: cgmreg riotsd   split10pc spil	$simple         $location 	i.wbcode 	if borderdist1<median_bd & no==0			,  cluster(wbcode  cluster)
est store criolpi3

xi: cgmreg riotsd   split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0			,  cluster(wbcode  cluster)
est store criolpi4

xi: cgmreg riotsd   split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0 & riots<top_riots ,  cluster(wbcode  cluster)
est store criolpi5

xi: cgmreg riotsd   split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0 & capital==0,  cluster(wbcode  cluster)
est store criolpi6

*******************


** Riots and Protests
**********************************************************************************************************************************************************************

estout riolpi1 riolpi2 riolpi3 riolpi4 riolpi5 riolpi6 criolpi1 criolpi2 criolpi3 criolpi4 criolpi5 criolpi6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square Obs)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   
	   
	   
	   

*******************************************************************************************************************************************************************
*******************************************************************************************************************************************************************
** Table 4. Panel B. Ethnic Partitioning and Civil Conflict Aspects
** Linear Probability Model (LPM) Estimates with country Fixed-Effects
***********************************************************************

** all specifications: rich set of countrols and country fixed-effects
** columns (1)-(3): All Country-Ethnic Homelands
** columns (4)-(6): Country-ethnic homelands close to the national border
*********************************************************************************************************************************************************************
estout btlp4 vlpi4  riolpi4 cbtlp4 cvlpi4 criolpi4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   	   
	   
	   
	   
