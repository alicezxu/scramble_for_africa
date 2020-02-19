



** Appendix Table 28. Ethnic Partitioning and Civil Conflict Actors.  Accounting for Regional Development (using data from G-Econ Project)
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
	   

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



** Generate sum of rebels and militias and corresponding indicator variable
** this is needed only if you run just this program or your have cleared the estimates
** these variables are also generated in Appendix Table 17
****************************************************************************************
****************************************************************************************
gen rebmil=rebels+mil
gen rebmild=0
replace rebmild=1 if rebmil>0 & rebmil!=.


**** Estimation. Linear Probability Model (LPM) estimates with country fixed-effects
***********************************************************************************************************************************************************************************	   
***********************************************************************************************************************************************************************************
xi: cgmreg alld  		split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals0

xi: cgmreg govtd  		split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals1

xi: cgmreg rebelsd  	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals2

xi: cgmreg mild 		split10pc spil	wlngcp_pc_mer $simple   $rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals3

xi: cgmreg rebmild 		split10pc spil	wlngcp_pc_mer $simple   $rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals4

xi: cgmreg riotprotd 	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals5

xi: cgmreg civiliansd  	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals6

xi: cgmreg externald  	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals7

xi: cgmreg interventiond split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals8

xi: cgmreg outsided  	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode,  robust cluster( cluster wbcode)
est store gals9


xi: cgmreg alld  		split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls0

xi: cgmreg govtd  		split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls1

xi: cgmreg rebelsd  	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls2

xi: cgmreg mild 		split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls3

xi: cgmreg rebmild 		split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls4

xi: cgmreg riotprotd 	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls5

xi: cgmreg civiliansd  	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls6

xi: cgmreg externald  	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls7

xi: cgmreg interventiond split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls8

xi: cgmreg outsided  	split10pc spil	wlngcp_pc_mer $simple  	$rich1  $location   	i.wbcode if  borderdist1<median_bd  & no==0,  robust cluster( cluster wbcode)
est store gacls9





** Appendix Table 28. Ethnic Partitioning and Civil Conflict Actors.  Accounting for Regional Development (using data from G-Econ Project)
***********************************************************************************************************************************************************************
***********************************************************************************************************************************************************************
** all columns: rich set of controls and country fixed-effects and log of GDP p.c in 2000 (G-Econ Project)
** Linear Probability Model Estimates
** columns (1) & (7) : government forces
** columns (2) & (8) : rebels and militias 
** columns (3) & (9) : civilian violence
** columns (4) & (10): riots and protests
** columns (3) & (11): external interventions from nearby countries
** columns (4) & (12): external interventions from NATO, AU, etc
** columns (1) - (6): all ethnic homelads; columns (7) - (12): areas close to the national border
************************************************************************************************************************************************************************
estout gals1 gals4 gals5 gals6 gals8 gals9 gacls1 gacls4 gacls5 gacls6 gacls8 gacls9, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(adjsuted r-square)) keep(split10pc spil wlngcp_pc_mer) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed) 
	




