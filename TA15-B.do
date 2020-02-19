



** This program estimates the country fixed-effects Poisson ML Specifications reported in Appendix Table 15, Panel B and in Appendix Table 16, Panel B
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************



** Appendix Table 15. Ethnic Partitioning and Civil Conflict. Alternative Estimation Techniques. 
** Panel B. Poisson ML Estimates with Country Fixed-Effects. Excl. Outliers 
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
** To get double-clustered s.e. for NB - ML specifications one needs to run the program three times, changing the cluster(); 
** (a) cluster (ethnic family); (b) wbcode (country); (c) inter (intersection of ethnic family and country)

** Dropping top 5% of observations (outliers(

** Conditioning Sets
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

global regi 			region_n region_s region_w region_e 

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 


*** All Conflcit Incidents/Events of any type (reported) 
**************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************
** all homelands
xi:   poisson all  	split10pc spil 		$simple                     					if all<top5_all,  robust cluster( cluster)
est store alpoi1

xi:   poisson all  	split10pc spil 		$simple                  i.wbcode				if all<top5_all,  robust cluster( cluster)
est store alpoi2

xi:   poisson all 	split10pc spil 		$simple         $location i.wbcode				if all<top5_all,  robust cluster( cluster)
est store alpoi3

xi:   poisson all 	split10pc spil 		$simple  $rich1 $location i.wbcode				if all<top5_all,  robust cluster( cluster)
est store alpoi4

xi:   poisson all 	split10pc spil		$simple  $rich1 $location i.wbcode 				if all<top5_all & capital==0,  robust cluster( cluster)
est store alpoi5

** homelands close to the border 
xi:   poisson all  	split10pc spil 		$simple                           	if all<top5_all & borderdist1<median_bd  & no==0					,  robust cluster( cluster)
est store alpoi1c

xi:   poisson all  	split10pc spil 		$simple                   i.wbcode 	if all<top5_all &  borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store alpoi2c

xi:   poisson all 	split10pc spil 		$simple         $location i.wbcode 	if all<top5_all &  borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store alpoi3c

xi:   poisson all 	split10pc spil 		$simple  $rich1 $location i.wbcode 	if all<top5_all &  borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store alpoi4c

xi:   poisson all 	split10pc spil 		$simple  $rich1 $location i.wbcode 	if all<top5_all & borderdist1<median_bd  & no==0	& capital==0	,  robust cluster( cluster)
est store alpoi5c



*** All Main Events (excluding Riots and Protests); Not Reported
**************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************
** all homelands
xi:   poisson allm  split10pc spil 		$simple                                             if allm<top5_allm,  robust cluster( cluster)
est store allpoi1

xi:   poisson allm  split10pc spil 		$simple                   i.wbcode					if allm<top5_allm,  robust cluster( cluster)
est store allpoi2

xi:   poisson allm split10pc spil 		$simple         $location i.wbcode					if allm<top5_allm,  robust cluster( cluster)
est store allpoi3

xi:   poisson allm split10pc spil 		$simple  $rich1 $location i.wbcode					if allm<top5_allm,  robust cluster( cluster)
est store allpoi4

xi:   poisson allm split10pc spil 		$simple  $rich1 $location i.wbcode 					if allm<top5_allm & capital==0	,  robust cluster( cluster)
est store allpoi5

** close to the border 
xi:   poisson allm  split10pc spil 		$simple                             if allm<top5_allm & borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store allpoi1c

xi:   poisson allm  split10pc spil 		$simple                    i.wbcode if allm<top5_allm & borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store allpoi2c

xi:   poisson allm split10pc spil 		$simple         $location i.wbcode if allm<top5_allm & borderdist1<median_bd  & no==0					,  robust cluster( cluster)
est store allpoi3c

xi:   poisson allm split10pc spil 		$simple  $rich1 $location i.wbcode if allm<top5_allm & borderdist1<median_bd  & no==0					,  robust cluster( cluster)
est store allpoi4c

xi:   poisson allm split10pc spil 		$simple  $rich1 $location i.wbcode if allm<top5_allm & capital==0 & borderdist1<median_bd  & no==0	,  robust cluster( cluster)
est store allpoi5c



*** All Main Events (excluding Riots and Protests and Non-Violent Events); not reported
**************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************
** all homelands
xi:   poisson allmm  split10pc 	spil 		$simple                                            if allmm<top5_allmm 				,  robust cluster( cluster)
est store alllpoi1

xi:   poisson allmm	 split10pc 	spil 		$simple                   i.wbcode					if allmm<top5_allmm 			,  robust cluster( cluster)
est store alllpoi2

xi:   poisson allmm split10pc 	spil 		$simple         $location i.wbcode					if allmm<top5_allmm 			,  robust cluster( cluster)
est store alllpoi3

xi:   poisson allmm split10pc 	spil 		$simple  $rich1 $location i.wbcode					if allmm<top5_allmm 			,  robust cluster( cluster)
est store alllpoi4

xi:   poisson allmm split10pc 	spil 		$simple  $rich1 $location i.wbcode if  allmm<top5_allmm 	& capital==0			,  robust cluster( cluster)
est store alllpoi5

** close to the border 
xi:   poisson allmm  split10pc 	spil 		$simple                             if allmm<top5_allmm & borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store alllpoi1c

xi:   poisson allmm  split10pc 	spil 		$simple                    i.wbcode if allmm<top5_allmm & borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store alllpoi2c

xi:   poisson allmm split10pc 	spil 		$simple         $location i.wbcode if allmm<top5_allmm & borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store alllpoi3c

xi:   poisson allm split10pc 	spil 		$simple  $rich1 $location i.wbcode if allmm<top5_allmm & borderdist1<median_bd  & no==0				,  robust cluster( cluster)
est store alllpoi4c

xi:   poisson allmm split10pc 	spil 		$simple  $rich1 $location i.wbcode if allmm<top5_allmm & capital==0 & borderdist1<median_bd  & no==0,  robust cluster( cluster)
est store alllpoi5c






*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
*** Appendix Table 15. Ethnic Partitioning and Civil Conflict. Alternative Estimation Techniques
*** Panel B. Fixed-Effects Poisson ML Estimates (excl. Outliers)
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
** All events; all ethnic homelands; columns (1)-(6), (5) ommited
** All events; close to the border country-ethnic homelands; columns (7)-(12); (11) omitted
*************************************************************************************************************************************************************************
estout alpoi1 alpoi2 alpoi3 alpoi4  alpoi5 alpoi1c alpoi2c alpoi3c alpoi4c  alpoi5c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(LogLikelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   


*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
** Appendix Table 16. Panel B. Ethnic Partitioning and Main Aspects of Civil Conflict. Alternative Estimation Techniques. 
** Panel B. Fixed-Effects Poisson ML Estimates (excl. Outliers)
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

***********************************************
** Battles
***********************************************************************************************************************************************************************************

xi: poisson battles  split10pc spil	$simple  $rich1  	$location 	 i.wbcode	if 									battles<top5_battles	,   cluster( cluster)    
est store btxpo

xi: poisson battles  split10pc spil	$simple  $rich1  	$location    i.wbcode	if borderdist1<median_bd  & no==0 & battles<top5_battles 	,   cluster( cluster)    
est store cbtxpo

** Violence against civilians. deadly events
****************************************************************************************   

xi: poisson vio  	split10pc spil	$simple  $rich1 $location 	   	i.wbcode	if 									vio<top5_vio 			,   cluster( cluster)    
est store vxpoi

xi: poisson vio  	split10pc spil	$simple  $rich1 $location    	i.wbcode 	if borderdist1<median_bd  & no==0 & vio<top5_vio 			,   cluster( cluster) 
est store cxvnbi


** Riots and Protests
***********************************************************************************************************************************************************************************
xi: poisson riots   	split10pc spil	$simple  $rich1 $location   	i.wbcode	if 									riots<top5_riots	,  cluster (cluster)
est store rioxpoi

xi: poisson riots   	split10pc spil	$simple  $rich1 $location    	i.wbcode	if borderdist1<median_bd  & no==0	& riots<top5_riots	,  cluster (cluster)
est store crioxpoi

*******************



** Appendix Table 16. Panel B. Ethnic Partitioning and Main Aspects of Civil Conflict. Alternative Estimation Techniques
** Panel B. Fixed-Effects Poisson ML Estimates (excl. Outliers)
******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************
** all ethnic homelands; columns (1)-(3)
** close to the border country-ethnic homelands; columns (4)-(8)
** rich set of controls in all specifications and country fixed-effects
estout btxpo vxpoi rioxpoi cbtxpo cxvnbi crioxpoi, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(LogLikelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
