

** This .do file runs all Negative Binomial (ML) models with the ACLED adta for Table4-Panel A in the main part of the paper.
** The NB-ML specifications are reported in Panel A. 
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************


** Preliminaries
*****************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************

* Notes:
********
** (1): To get double-clustered s.e. one needs to run the program three times, changing the cluster(); 
** (a) cluster (ethnic family); (b) wbcode (country); (c) inter (intersection of ethnic family and country)
************************************************************************************************************************************************************************




** Conditioning Sets
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

global regi 			region_n region_s region_w region_e 

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 




** Run the Empirical Specifications
***********************************
***********************************************************************************************************************************************************************




** Battles
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

** All Ethnic Homelands
xi: nbreg battles  split10pc spil	$simple                     					       				,  robust cluster(  cluster)
est store btnb1

xi: nbreg battles  split10pc spil	$simple                     	i.wbcode							,  robust cluster(  cluster)
est store btnb2

xi: nbreg battles split10pc spil	$simple           	$location 	i.wbcode							,  robust cluster(  cluster)
est store btnb3

xi: nbreg battles  split10pc spil	$simple  $rich1  	$location 	i.wbcode							,  robust cluster(  cluster)
est store btnb4

xi: nbreg battles  split10pc spil	$simple  $rich1  	$location 	i.wbcode if battles<top_battles		,  robust cluster(  cluster)
est store btnb5

xi: nbreg battles  split10pc spil	$simple  $rich1  	$location 	i.wbcode if capital==0				,  robust cluster(  cluster)
est store btnb6



** Areas close to the national border
xi: nbreg battles  split10pc spil	$simple                                if borderdist1<median_bd  & no==0,  robust cluster(  cluster)
est store cbtnb1

xi: nbreg battles  split10pc spil	$simple                       i.wbcode if borderdist1<median_bd & no==0,  robust cluster(  cluster)
est store cbtnb2

xi: nbreg battles  split10pc spil	$simple           	$location i.wbcode if borderdist1<median_bd  & no==0,  robust cluster(  cluster)
est store cbtnb3

xi: nbreg battles  split10pc spil	$simple  $rich1  	$location i.wbcode if borderdist1<median_bd  & no==0,  robust cluster(  cluster)
est store cbtnb4

xi: nbreg battles  split10pc spil	$simple  $rich1  	$location i.wbcode if borderdist1<median_bd  & no==0 & battles<top_battles,  robust cluster(  cluster)
est store cbtnb5

xi: nbreg battles  split10pc spil	$simple  $rich1  	$location i.wbcode if borderdist1<median_bd  & no==0 & capital==0,  robust cluster(  cluster)
est store cbtnb6

***********************************************************************************************************************************************************************
** Battles. all ethnic homelands
************************************************
************************************************
estout btnb1 btnb2 btnb3 btnb4  btnb5 btnb6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood Obs)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

   
** Battles. areas close to the national border
**************************************************
**************************************************
estout cbtnb1 cbtnb2 cbtnb3 cbtnb4  cbtnb5 cbtnb6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
	   
** Violence against the Civilian Population	 with deadly outcome (vio)
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

** All Ethnic Homelands
xi: nbreg vio  	split10pc spil 	$simple                                             	,  robust cluster(  cluster)
est store vnbi1

xi: nbreg vio 	split10pc spil 	$simple                    	i.wbcode					,  robust cluster(  cluster)
est store vnbi2

xi: nbreg vio  	split10pc spil 	$simple         $location 	i.wbcode					,  robust cluster(  cluster)
est store vnbi3

xi: nbreg vio  	split10pc spil	$simple  $rich1 $location 	i.wbcode					,  robust cluster(  cluster)
est store vnbi4

xi: nbreg vio  	split10pc spil 	$simple  $rich1 $location 	i.wbcode if vio<top_vio		,  robust cluster(  cluster)
est store vnbi5

xi: nbreg vio  	split10pc spil 	$simple  $rich1 $location 	i.wbcode if capital==0		,  robust cluster(  cluster)
est store vnbi6

** Areas close to the national border
xi: nbreg vio  split10pc spil $simple                                                            if borderdist1<median_bd  & no==0,  robust cluster( wbcode)
est store cvnbi1

xi: nbreg vio split10pc spil $simple                                                    i.wbcode if borderdist1<median_bd  & no==0,  robust cluster( wbcode)
est store cvnbi2

xi: nbreg vio  split10pc spil $simple         $location i.wbcode if borderdist1<median_bd & no==0,  robust cluster( wbcode)
est store cvnbi3

xi: nbreg vio  split10pc spil $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0,  robust cluster( wbcode)
est store cvnbi4

xi: nbreg vio  split10pc spil $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0 & vio<top_vio,  robust cluster( wbcode)
est store cvnbi5

xi: nbreg vio  split10pc spil $simple  $rich1 $location i.wbcode if borderdist1<median_bd  & no==0 & capital==0,  robust cluster( wbcode)
est store cvnbi6


***********************************************************************************************************************************************************************
** Civilian Violence. all ethnic homelands
********************************************************
********************************************************
estout vnbi1 vnbi2 vnbi3 vnbi4 vnbi5 vnbi6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)


** Civilian Violence. areas close to the national border
*********************************************************
*********************************************************
estout cvnbi1 cvnbi2 cvnbi3 cvnbi4 cvnbi5 cvnbi6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	    




******************************************************************************************************************************************************************
******************************************************************************************************************************************************************
*** Riots and Protests
******************************************************************************************************************************************************************
******************************************************************************************************************************************************************

** All Ethnic Homelands
xi: nbreg riots   	split10pc spil 	$simple                                             ,  robust cluster(  cluster)
est store rionbi1

xi: nbreg riots  	split10pc spil 	$simple                    	i.wbcode				,  robust cluster(  cluster)
est store rionbi2

xi: nbreg riots   	split10pc spil 	$simple         $location 	i.wbcode				,  robust cluster(  cluster)
est store rionbi3

xi: nbreg riots   	split10pc spil	$simple  $rich1 $location 	i.wbcode				,  robust cluster(  cluster)
est store rionbi4

xi: nbreg riots   	split10pc spil 	$simple  $rich1 $location 	i.wbcode if riots<top_riots 	,  robust cluster(  cluster)
est store rionbi5

xi: nbreg riots   	split10pc spil 	$simple  $rich1 $location 	i.wbcode if capital==0	,  robust cluster(  cluster)
est store rionbi6


** Areas close to the national border	   
xi: nbreg riots   split10pc spil	$simple                                 if borderdist1<median_bd  & no==0			,  robust cluster(  cluster)
est store crionbi1

xi: nbreg riots  	split10pc spil	$simple                    i.wbcode 	if borderdist1<median_bd  & no==0			,  robust cluster(  cluster)
est store crionbi2

xi: nbreg riots   split10pc spil	$simple         $location 	i.wbcode 	if borderdist1<median_bd & no==0			,  robust cluster(  cluster)
est store crionbi3

xi: nbreg riots   split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0			,  robust cluster(  cluster)
est store crionbi4

xi: nbreg riots   split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0 & riots<top_riots ,  robust cluster(  cluster)
est store crionbi5

xi: nbreg riots   split10pc spil	$simple  $rich1 $location 	i.wbcode 	if borderdist1<median_bd  & no==0 & capital==0,  robust cluster(  cluster)
est store crionbi6

*****************************************************************************************************************************************************************


** Riots and Protests
******************************************************************************************************************************************************************
******************************************************************************************************************************************************************
** Riots and Protests. areas close to the national border
*********************************************************
*********************************************************
estout rionbi1 rionbi2 rionbi3 rionbi4 rionbi5 rionbi6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood Obs)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

** Riots and Protests. areas close to the national border
*********************************************************
*********************************************************
estout crionbi1 crionbi2 crionbi3 crionbi4 crionbi5 crionbi6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood Obs)) keep(split10pc spil) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)


	   
	   
*******************************************************************************************************************************************************************
*******************************************************************************************************************************************************************
** Table 4. Panel A. Ethnic Partitioning and Civil Conflict Aspects
** Negative Binomial ML Estimates with country Fixed-Effects
********************************************************************

** all specifications: rich set of countrols and country fixed-effects
** columns (1)-(3): All Country-Ethnic Homelands
** columns (4)-(6): Country-ethnic homelands close to the national border
*********************************************************************************************************************************************************************
estout btnb4 vnbi4  rionbi4 cbtnb4 cvnbi4 crionbi4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
	   
	   
