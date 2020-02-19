

** Appendix Table 24. Ethnic Partitioning and Civil Conflict. Spillovers with Formal Spatial Econometric Tools 
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

*** Generate Weighting Matrices
**************************************************************************************************************************************
**************************************************************************************************************************************
* lat1  is latitude
* long1 is longitude

keep if lnpop60!=.
spwmatrix gecon lat1 long1, wname(winv) 	wtype(inv) alpha(1) eignvar(eigwinv) 	rowstand replace
spwmatrix gecon lat1 long1, wname(winvsq) 	wtype(inv) alpha(2) eignvar(eigwinvsq) 	rowstand replace

keep if lat1!=. & long1!=.


** Estimation 
*************************************************************************************************************************************************************************

** Panel A. Dependent Variable. Main Events Indicator
**************************************************************

xi: spmlreg allmd split10pc $simple $location  $rich1 	i.wbcode, weights(winv) wfrom(Stata) eignvar(eigwinv) model(sac)
est store bgs1

xi: spmlreg allmd split10pc $simple $location $rich1  	i.wbcode, weights(winvsq) wfrom(Stata) eignvar(eigwinvsq) model(sac)
est store bgs2

xi: spmlreg allmd split10pc $simple $location  $rich1 i.wbcode, weights(winv) wfrom(Stata) eignvar(eigwinv) model(durbin)
est store bgs3

xi: spmlreg allmd split10pc $simple $location $rich1  	i.wbcode, weights(winvsq) wfrom(Stata) eignvar(eigwinvsq) model(durbin)
est store bgs4

xi: spmlreg allmd split10pc $simple $location  $rich1 	i.wbcode, weights(winv) wfrom(Stata) eignvar(eigwinv) model(lag)
est store bgs5

xi: spmlreg allmd split10pc $simple $location  $rich1 	i.wbcode, weights(winvsq) wfrom(Stata) eignvar(eigwinv) model(lag)
est store bgs6


****************************************************************************************************************************************************************
****************************************************************************************************************************************************************


** Panel B. Dependent Variable. Ln (1+Number of Main Events)
**************************************************************
xi: spmlreg lnallm split10pc $simple $location  $rich1 	i.wbcode, weights(winv) wfrom(Stata) eignvar(eigwinv) model(sac)
est store gs1

xi: spmlreg lnallm split10pc $simple  $location $rich1  	i.wbcode, weights(winvsq) wfrom(Stata) eignvar(eigwinvsq) model(sac)
est store gs2

xi: spmlreg lnallm split10pc $simple   $location  $rich1 i.wbcode, weights(winv) wfrom(Stata) eignvar(eigwinv) model(durbin)
est store gs3

xi: spmlreg lnallm split10pc $simple  $location $rich1  	i.wbcode, weights(winvsq) wfrom(Stata) eignvar(eigwinvsq) model(durbin)
est store gs4

xi: spmlreg lnallm split10pc $simple  $location  $rich1 	i.wbcode, weights(winv) wfrom(Stata) eignvar(eigwinv) model(lag)
est store gs5

xi: spmlreg lnallm split10pc $simple  $location  $rich1 	i.wbcode, weights(winvsq) wfrom(Stata) eignvar(eigwinv) model(lag)
est store gs6





** Appendix Table 24. Ethnic Partitioning and Civil Conflict. Spillovers with Formal Spatail Econometric Tools 
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************
** All specifications; rich set of controls and country fixed-effects
** columns (1)-(3); linear W-matrix
** columns (4)-(6); quadratic W-matrix
** columns (1) & (4): Spatial Lag Model
** columns (2) & (5): Durbin Model
** columns (3) & (6): Generalized Spatial Lag Model
************************************************************************************************************************************************************************

** Panel A. Dependent Variable. Main Events Indicator
************************************************************************************************************************************************************************
estout bgs1 bgs2 bgs3 bgs4 bgs5 bgs6  , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll ll_0 N rho lamda, fmt(%9.3f %9.0g) ) keep(split10pc ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

** Panel B. Dependent Variable. Ln (1+Number of Main Events)
****************************************************************************************************************************************************************
estout gs5 gs6 gs3 gs4 gs1 gs2   , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll ll_0 N rho lamda, fmt(%9.3f %9.0g) ) keep(split10pc ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)







