

** Appendix Table 9. "Balancedeness Tests." Ethnic Partitioning and Geographic Characteristics within Countries 
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************


** Define Variable List
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
global allvars	 		lnkm2split  lakedum riverdum mean_elev mean_suit  malariasuit diamondd petroleum city1400 coastal capital seadist1 borderdist1 capdistance1   
set more off


** Panel A. All Country-Ethnic Homelands
***********************************************************************************************************************************************************************
foreach var of varlist $allvars   {
	
	xi: cgmreg `var'   	split10pc 		i.wbcode								if pop60!=0, cluster(wbcode  cluster)
	est store slt_`var'
	
	
}
**

** Panel B. Close to the National Border Country-Ethnic Homelands
***********************************************************************************************************************************************************************
foreach var of varlist $allvars   {
		
	xi: cgmreg `var'   	split10pc 		i.wbcode								if pop60!=0 & borderdist1<median_bd, cluster(wbcode  cluster)
	est store sltc_`var'
	
}
**
*************************************************************************************************************************************************************************
** Appendix Table 9. "Balancedeness Tests." Ethnic Partitioning and Geographic Characteristics within Countries .
** Test of means of all controls in the country-ethnic homeland
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************

** Panel A. All Country-Ethnic Homelands (1212 Obs)
**************************************************************************************************************************************************************************
estout slt_*, cells(b(star fmt(%9.4f)) se(par) p(fmt(%9.2f)))  keep(split10pc  )  ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square))  style(fixed)

** Mean Dependent Variable
	   tabstat  $allvars   if pop60!=0 , stats(mean ) 


** Panel B. Country-Ethnic Homelands close to the National Border (606 Obs)
**************************************************************************************************************************************************************************	   
estout sltc_*, cells(b(star fmt(%9.4f)) se(par) p(fmt(%9.2f)))  keep(split10pc  ) ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R-square))  style(fixed)

** Mean Dependent Variable	   
	   tabstat  $allvars   if pop60!=0 & borderdist1<median_bd, stats(mean ) 






