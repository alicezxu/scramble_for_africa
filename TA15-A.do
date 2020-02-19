


** This program estimates the Conditional Negative Binomial ML Specifications reported in Appendix Table 15, Panel A and in Appendix Table 16, Panel A
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************



** Appendix Table 15. Ethnic Partitioning and Civil Conflict. Alternative Estimation Techniques. 
** Panel A. Conditional ML Estimates (Hausman, Hahn, and Griliches, 1984) 
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


** IMPORTANT. declare panel dimmension
encode wbcode, gen(ccode)
xtset ccode

*** All Conflcit Incidents/Events of any type (reported) 
**************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************
** all homelands
xi: xtnbreg all  	split10pc spil      		$simple                     					,   fe    
est store alxnb1

xi: xtnbreg all  	split10pc spil      		$simple                     					,   fe    
est store alxnb2

xi: xtnbreg all 	split10pc spil      		$simple         $location    					,   fe    
est store alxnb3

xi: xtnbreg all 	split10pc spil      		$simple  $rich1 $location    					,   fe    
est store alxnb4

xi: xtnbreg all 	split10pc spil    $regi		$simple  $rich1 $location     if all<top_all	,   fe    
est store alxnb5

xi: xtnbreg all 	split10pc spil      		$simple  $rich1 $location     if capital==0		,   fe    
est store alxnb6

** homelands close to the border 
xi: xtnbreg all  	split10pc spil      		$simple                        	if borderdist1<median_bd  & no==0				,   fe    
est store alxnb1c

xi: xtnbreg all  	split10pc spil      		$simple                       	if borderdist1<median_bd  & no==0				,   fe    
est store alxnb2c

xi: xtnbreg all 	split10pc spil      		$simple         $location     	if borderdist1<median_bd  & no==0				,   fe    
est store alxnb3c

xi: xtnbreg all 	split10pc spil      		$simple  $rich1 $location     	if borderdist1<median_bd  & no==0				,   fe    
est store alxnb4c

xi: xtnbreg all 	split10pc spil      		$simple  $rich1 $location     	if all<top_all & borderdist1<median_bd  & no==0	,   fe    
est store alxnb5c

xi: xtnbreg all 	split10pc spil      		$simple  $rich1 $location     	if capital==0 & borderdist1<median_bd  & no==0	,   fe    
est store alxnb6c



*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
*** Appendix Table 15. Ethnic Partitioning and Civil Conflict. Alternative Estimation Techniques
*** Panel A. Conditional NB ML Estimates 
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
** All events; all ethnic homelands; columns (1)-(6)
** All events; close to the border country-ethnic homelands; columns (7)-(12)
*************************************************************************************************************************************************************************
estout alxnb1 alxnb2 alxnb3 alxnb4   alxnb5 alxnb6 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil    ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

estout alxnb1c alxnb2c alxnb3c alxnb4c   alxnb5c alxnb6c , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(Log Likelihood)) keep(split10pc spil     ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
   
	   
	
	
	


*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
** Appendix Table 16. Ethnic Partitioning and Main Aspects of Civil Conflict. Alternative Estimation Techniques. 
** Panel A. Conditional NB ML Estimates 
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

***********************************************
** Battles
***********************************************************************************************************************************************************************************	
	

xi: xtnbreg battles  split10pc spil	$simple  $rich1  	$location 	 		,   fe 
est store btxnb

xi: xtnbreg battles  split10pc spil	$simple  $rich1  	$location    	if borderdist1<median_bd  & no==0 	,   fe
est store cbtxnb

** Violence against civilians. deadly events
****************************************************************************************   

xi: xtnbreg vio  	split10pc spil	$simple  $rich1 $location 	   				,   fe  
est store vxnb

xi: xtnbreg vio  	split10pc spil	$simple  $rich1 $location    	 	if borderdist1<median_bd  & no==0  			,   fe
est store cvxnb


** Riots and Protests
***********************************************************************************************************************************************************************************
xi: xtnbreg riots   	split10pc spil	$simple  $rich1 $location   			,  fe
est store rioxnb

xi: xtnbreg riots   	split10pc spil	$simple  $rich1 $location    		if borderdist1<median_bd  & no==0		,  fe
est store crioxnb

*******************



** Appendix Table 16. Panel B. Ethnic Partitioning and Main Aspects of Civil Conflict. Alternative Estimation Techniques
** Panel A. Conditional NB ML Estimates 
******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************
** all ethnic homelands; columns (1)-(3)
** close to the border country-ethnic homelands; columns (4)-(8)
** rich set of controls in all specifications
****************************************************************************************************************************************************************************** 
estout btxnb vxnb rioxnb cbtxnb cvxnb crioxnb, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(LogLikelihood Obs)) keep(split10pc spil ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	
	
	
	
	
	
	
	
	
	
	
	