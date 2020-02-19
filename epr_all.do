
***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************

** EPR Analysis
****************

** This execution files generates all tables (in the main part of the paper and the on-line Supplementary Appenidx) using the Ethnic Power Relations Database
**************************************************************************************************************************************************************
** Table 7 and Appendix Tables 33-38
**********************************************************************************************************************************************************************************

** Preliminaries
*****************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************

** Run the CGMREG Program to gte double-clustered standard errors
***********************************************************************************************
***********************************************************************************************
run cgmreg.ado

** Label Variables
*******************************************************************************************************
*******************************************************************************************************

label var cluster 		"Ethnic Family Name. Source: Murdock Ethnolinguistic Atlas"
label var wbcode 		"Wold Bank 3-letter Country Code"


label var lnpop60 		"Logarithm of Population in the 1960s. Source: UNESCO "
label var lnkm2split	"Log Land Surface Area of the Country-Ethnicity Region."
label var lakedum 		"Lake indicator at the country-ethnic homeland."
label var riverdum 		"Main River indicator at the country-ethnic homeland."
label var coastal 		"Indicator for country-ethnic homelands adjacent to the seacoast."
label var capital 		"Indicator for country-ethnic homelands where capital cities fall."
label var island		"Indicator for country-ethnic homelands in an island."

label var borderdist1 	"Geodesic distance of the centroid of each country-ethnic area to the closest national border." 
label var capdistance1  "Geodesic distance of the centroid of each country-ethnic area to the capital city." 
label var seadist1		"Geodesic distance of the centroid of each country-ethnic area to the sea coast." 

label var mean_elev 	"Mean elevation of each country-ethnic homeland."
label var mean_suit		"Mean soil quality (suitability) for agriculture."
label var malariasuit	"Mean climatic conditions favorable (suitability) for malaria."

label var city1400		"Identifier for country-ethnic regions with a major city around 1400. Source: Chandler (1987)"
label var petroleum		"Indicator for country-ethnic regions with an on-shore oil field or gas deposit."
label var diamondd		"Indicator for country-ethnic regions with a diamond mine."

label var split10pc		"Identifier for partitioned (split) ethnic groups, using 10% cutoff."
label var split5pc		"Identifier for partitioned (split) ethnic groups, using 5% cutoff."
label var fneigh 		"Share of adjacent split groups to total number of neighboring groups. same as spil"


** Generate Ordered (0, 1, 2) index of political violence; following Besley and Persson (QJE 2011)
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
gen order=0
replace order=1 if dis==1 & etwar==0
replace order=2 if etwar==1


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

** Desriptive Patters
**********************
**********************
tab dis etwar
tab dis etwar if split10pc==1
tab dis etwar if split10pc==0



** Table 7. Baseline Estimates
***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************


** Columns (1)-(4): discrimination from central government
***********************************************************************************************************************************************************************************
xi: cgmreg dis  split10pc                                                           ,  robust cluster(cluster wbcode)
est store d1

xi: cgmreg dis  split10pc                                                 	i.wbcode,  robust cluster(cluster wbcode)
est store d2

xi: cgmreg dis split10pc 		$simple $location 	$rich1  				i.wbcode,  robust cluster(cluster wbcode)
est store d3

xi: cgmreg dis  split10pc fneigh $simple $location  $rich1  				i.wbcode,  robust cluster(cluster wbcode)
est store d4

** Columns (5)-(8): ethnic war
***********************************************************************************************************************************************************************************	
xi: cgmreg etwar  split10pc                                                           ,  robust cluster(cluster wbcode)
est store w1

xi: cgmreg etwar  split10pc                                                 i.wbcode,  robust cluster(cluster wbcode)
est store w2

xi: cgmreg etwar split10pc 			$simple $rich1	$location				i.wbcode,  robust cluster(cluster wbcode)
est store w3

xi: cgmreg etwar  split10pc fneigh 	$simple $rich1  $location				i.wbcode,  robust cluster(cluster wbcode)
est store w4

****************************************************************************************
** Columns (1)-(4): ethnic war 
** Columns (5)-(8): discrimination from central government
** columns (1) & (5): unconditional estimates
** columns (2) & (6): only country fixed-effects
** columns (3) & (7): country fixed-effects and rich set of controls
** columns (4) & (8): country fixed-effects and rich set of controls and spillovers
*******************************************************************************************************************************************************************************
*******************************************************************************************************************************************************************************
estout w1 w2 w3 w4 d1 d2 d3 d4 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R2 Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
** columns (9)-(10). Ordered Index of Political Violence. Ordered Logit Estimates
*******************************************************************************************************************************************************************************	    
xi: ologit  order split10pc              $simple   $rich1 $location  $regi	,  robust cluster(  cluster)
est store olo1

xi: ologit  order split10pc      fneigh  $simple   $rich1 $location  $regi	,  robust cluster(  cluster)
est store olo2


estout olo1 olo2 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll  N , fmt(%9.3f %9.0g) labels(LL  Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)


** columns (11)-(12). Fixed-Effects Ordered Logit (following Besley and Persson (QJE 2011))
*******************************************************************************************************************************************************************************	   
**Simple program to implement the FF and BP ordered logit
bysort wbcode: egen av_ord=mean(order)
gen    	binary=0 if av_ord!=.
replace binary=1 if order>av_ord  


	   
clogit 	binary split10pc              				  									, group(wbcode)    cluster(wbcode)
est store cl0	   
	   
clogit 	binary split10pc              			$simple   $rich1  	$location			, group(wbcode)    cluster(wbcode)
est store cl1	   
	   
clogit 	binary split10pc              fneigh   	$simple   $rich1	$location		  	, group(wbcode)    cluster(wbcode)
est store cl2	   
	   
	   	   
estout cl1 cl2 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(LL  Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   

	   

** Table 7. Baseline Estimates
***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************	   

****************************************************************************************
** Columns (1)-(4): ethnic war 
** Columns (5)-(8): discrimination from central government
** Columns (9)-(10): ordered logit with regional constants and rich set of controls
** Columns (11)-(12): fixed-effects order logit estimates and rich set of controls
** columns (1) & (5): unconditional estimates
** columns (2) & (6): only country fixed-effects
** columns (3) & (7): country fixed-effects and rich set of controls
** columns (4) & (8): country fixed-effects and rich set of controls and spillovers
*******************************************************************************************************************************************************************************
*******************************************************************************************************************************************************************************
estout w1 w2 w3 w4 d1 d2 d3 d4 olo1 olo2 cl1 cl2, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a ll N , fmt(%9.3f %9.0g) labels(R2 LL Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
*** Appendix Table 33. : Ethnic Partitioning and Political Violence.  Desriptive Patters 
********************************************************************************************************************************************************************************
********************************************************************************************************************************************************************************	   

** Panel A 
**********************
**********************
tab dis etwar
tab dis etwar if split10pc==1
tab dis etwar if split10pc==0
	   
	   
	
** Panel B 
**********************
**********************
tab dis order
tab dis order if split10pc==1
tab dis order if split10pc==0   
	   

	   
*** Appendix Table 34A-34B : Columns 1 and 2
*** Ethnic Partitioning, Exclusion from the National Government and Involvement in Ethnic Wars
********************************************************************************************************************************************************************************
********************************************************************************************************************************************************************************

** OLS
**************
** Columns (1)-(2) of Appendix Table 34A
***********************************************************************************************************************************************************************************
xi: cgmreg etwar  split10pc      $simple $location  $rich1     i.wbcode if ex==1,  robust cluster(cluster wbcode)
est store ex1

xi: cgmreg etwar  split10pc      $simple $location  $rich1     i.wbcode if ex==0,  robust cluster(cluster wbcode)
est store ex2

** Columns (1)-(2) of Appendix Table 34B
***********************************************************************************************************************************************************************************
xi: cgmreg etwar  split5pc 		$simple $location 	$rich1     i.wbcode if ex==1,  robust cluster(cluster wbcode)
est store ex3

xi: cgmreg etwar  split5pc      $simple $location  $rich1  	   i.wbcode if ex==0,  robust cluster(cluster wbcode)
est store ex4


estout  ex1 ex2 ex3 ex4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R2 Obs)) keep(split10pc split5pc) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	 
	   	   
		   
		   
		   
	   
*** Appendix Table 35. : Ethnic Partitioning and Political Violence (Ordered Index of Political Violence). 
*** Sensitivity Analysis. Alternative Estimation Techniques
********************************************************************************************************************************************************************************
********************************************************************************************************************************************************************************

** OLS
**************
xi: cgmreg 	order split10pc                									,  robust cluster( wbcode cluster)
est store oli1

xi: cgmreg 	order split10pc                							i.wbcode,  robust cluster( wbcode cluster)
est store oli2

xi: cgmreg 	order split10pc              $simple   $rich1 $location  i.wbcode,  robust cluster( wbcode cluster)
est store oli3

xi: cgmreg 	order split10pc     fneigh   $simple   $rich1 $location  i.wbcode,  robust cluster( wbcode cluster)
est store oli4

estout  oli1 oli2 oli3 oli4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R2 Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	 
	   
** Ordered Probit ML
**********************
xi: oprobit  order split10pc                              							,  robust cluster(  cluster)
est store opo1

xi: oprobit  order split10pc                              	$regi					,  robust cluster(  cluster)
est store opo2

xi: oprobit  order split10pc        		$location      $simple   $rich1   $regi	,  robust cluster(  cluster)
est store opo3

xi: oprobit  order split10pc     fneigh  	$location      $simple   $rich1   $regi	,  robust cluster(  cluster)
est store opo4

estout  opo1 opo2 opo3 opo4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(ll N , fmt(%9.3f %9.0g) labels(LL R2 Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
   
*** Appendix Table 35. : Ethnic Partitioning and Political Violence (Ordered Index of Political Violence).  Sensitivity Analysis. Alternative Estimation Techniques
********************************************************************************************************************************************************************************
********************************************************************************************************************************************************************************
** Columns (1)-(4): OLS 
** Columns (5)-(8): Ordered Probit ML
** columns (1) & (5): unconditional estimates
** columns (2) - (4): country fixed-effects
** columns (6) - (8): regional fixed-effects 
** columns (3), (4), (7) & (8): adding rich rich set of controls and spillovers
*******************************************************************************************************************************************************************************
*******************************************************************************************************************************************************************************
estout  oli1 oli2 oli3 oli4 opo1 opo2 opo3 opo4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a ll N , fmt(%9.3f %9.0g) labels(R2 LL Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   
	   
	   
 
** Appendix Table 36.  Ethnic Partitioning, Ethnic-based Political Discrimination, and Major Ethnic Civil Wars. 
** Sensitivity Analysis. Alternative Index of Ethnic Partitioning. Linear Probability Model Estimates
**********************************************************************************************************************************************************************************
**********************************************************************************************************************************************************************************

** Columns (1)-(4): ethnic war
***********************************************************************************************************************************************************************************	
xi: cgmreg etwar    split5pc                                                           ,  robust cluster(cluster wbcode)
est store aw1

xi: cgmreg etwar    split5pc                                                    i.wbcode,  robust cluster(cluster wbcode)
est store aw2

xi: cgmreg etwar   split5pc 			$simple $rich1	$location				i.wbcode,  robust cluster(cluster wbcode)
est store aw3

xi: cgmreg etwar    split5pc fneigh 	$simple $rich1  $location				i.wbcode,  robust cluster(cluster wbcode)
est store aw4

** Columns (5)-(8): discrimination from central government
***********************************************************************************************************************************************************************************
xi: cgmreg dis    split5pc                                                           ,  robust cluster(cluster wbcode)
est store ad1

xi: cgmreg dis    split5pc                                                 	i.wbcode,  robust cluster(cluster wbcode)
est store ad2

xi: cgmreg dis    split5pc 		  $simple $location  $rich1  				i.wbcode,  robust cluster(cluster wbcode)
est store ad3

xi: cgmreg dis    split5pc fneigh $simple $location  $rich1  				i.wbcode,  robust cluster(cluster wbcode)
est store ad4



** Appendix Table 36.  Ethnic Partitioning, Ethnic-based Political Discrimination, and Major Ethnic Civil Wars. 
** Sensitivity Analysis. Alternative Index of Ethnic Partitioning. Linear Probability Model Estimates
**********************************************************************************************************************************************************************************
****************************************************************************************
** Columns (1)-(4): ethnic war 
** Columns (5)-(8): discrimination from central government
** columns (1) & (5): unconditional estimates
** columns (2) & (6): only country fixed-effects
** columns (3) & (7): country fixed-effects and rich set of controls
** columns (4) & (8): country fixed-effects and rich set of controls and spillovers
*******************************************************************************************************************************************************************************
*******************************************************************************************************************************************************************************
estout aw1 aw2 aw3 aw4 ad1 ad2 ad3 ad4 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R2 Obs)) keep(  split5pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	     
   
   


** Appendix Table 37. Excluding Each Time a Different African Region
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
xi: cgmreg etwar  split10pc fneigh $simple  $rich1  $location i.wbcode if region_n==0,  robust cluster( wbcode cluster)
est store wn_1

xi: cgmreg etwar  split10pc fneigh $simple  $rich1  $location i.wbcode if region_e==0,  robust cluster( wbcode cluster)
est store we_2

xi: cgmreg etwar  split10pc fneigh $simple  $rich1  $location i.wbcode if region_w==0,  robust cluster( wbcode cluster)
est store ww_3

xi: cgmreg etwar  split10pc fneigh $simple  $rich1  $location i.wbcode if region_c==0,  robust cluster( wbcode cluster)
est store wc_4

xi: cgmreg etwar  split10pc fneigh $simple  $rich1  $location i.wbcode if region_s==0,  robust cluster( wbcode cluster)
est store ws_5

xi: cgmreg dis    split10pc fneigh $simple  $rich1  $location i.wbcode if region_n==0,  robust cluster( wbcode cluster)
est store dn_1

xi: cgmreg dis    split10pc fneigh $simple  $rich1  $location i.wbcode if region_e==0,  robust cluster( wbcode cluster)
est store de_2

xi: cgmreg dis    split10pc fneigh $simple  $rich1  $location i.wbcode if region_w==0,  robust cluster( wbcode cluster)
est store dw_3

xi: cgmreg dis    split10pc fneigh $simple  $rich1  $location i.wbcode if region_c==0,  robust cluster( wbcode cluster)
est store dc_4

xi: cgmreg dis    split10pc fneigh $simple  $rich1  $location i.wbcode if region_s==0,  robust cluster( wbcode cluster)
est store ds_5



** Appendix Table 37. Excluding Each Time a Different African Region
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
** all specifications include rich set of control variables and country fixed-effects
** columns (1)-(5): ethnic-based civil war serves as the dependent variable
** columns (6)-(10): ethnic-based political discrimination from the national government  serves as the dependent variable
*************************************************************************************************************************************************************************
estout wn_1 we_2 ww_3 wc_4 ws_5 dn_1 de_2 dw_3 dc_4 ds_5 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R-Squared Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
   
   
   
 
** Appendix Table 38. Excluding Each Time a Different African Region and Employing an Alternative Index of Ethnic Partitioning
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************   
xi: cgmreg etwar  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_n==0,  robust cluster( wbcode cluster)
est store wn5_1

xi: cgmreg etwar  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_e==0,  robust cluster( wbcode cluster)
est store we5_2

xi: cgmreg etwar  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_w==0,  robust cluster( wbcode cluster)
est store ww5_3

xi: cgmreg etwar  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_c==0,  robust cluster( wbcode cluster)
est store wc5_4

xi: cgmreg etwar  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_s==0,  robust cluster( wbcode cluster)
est store ws5_5


xi: cgmreg dis  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_n==0,  robust cluster( wbcode cluster)
est store dn5_1

xi: cgmreg dis  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_e==0,  robust cluster( wbcode cluster)
est store de5_2

xi: cgmreg dis  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_w==0,  robust cluster( wbcode cluster)
est store dw5_3

xi: cgmreg dis  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_c==0,  robust cluster( wbcode cluster)
est store dc5_4

xi: cgmreg dis  	split5pc fneigh $simple  $rich1  $location i.wbcode if region_s==0,  robust cluster( wbcode cluster)
est store ds5_5

** Appendix Table 38. Excluding Each Time a Different African Region and Employing an Alternative Index of Ethnic Partitioning
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************   	   
** columns (1)-(5): ethnic-based civil war serves as the dependent variable
** columns (6)-(10): ethnic-based political discrimination from the national government  serves as the dependent variable
*************************************************************************************************************************************************************************      
estout wn5_1 we5_2 ww5_3 wc5_4 ws5_5 dn5_1 de5_2 dw5_3 dc5_4 ds5_5 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R-Squared Obs)) keep(split5pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
  
   
 
 
***********************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************	   
************************************************************************************************************************************************************************************
** All Tables
************************************************************************************************************************************************************************************	   
************************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************	   


** Table 7. Baseline Estimates
***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************	   
** Columns (1)-(4): ethnic war 
** Columns (5)-(8): discrimination from central government
** Columns (9)-(10): ordered logit with regional constants and rich set of controls
** Columns (11)-(12): fixed-effects order logit estimates and rich set of controls
** columns (1) & (5): unconditional estimates
** columns (2) & (6): only country fixed-effects
** columns (3) & (7): country fixed-effects and rich set of controls
** columns (4) & (8): country fixed-effects and rich set of controls and spillovers
*******************************************************************************************************************************************************************************
*******************************************************************************************************************************************************************************
estout w1 w2 w3 w4 d1 d2 d3 d4 olo1 olo2 cl1 cl2, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a ll N , fmt(%9.3f %9.0g) labels(R2 LL Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   

	   
*** Appendix Table 33. : Ethnic Partitioning and Political Violence.  Desriptive Patters 
********************************************************************************************************************************************************************************
********************************************************************************************************************************************************************************	   

** Panel A 
**********************
**********************
tab dis etwar
tab dis etwar if split10pc==1
tab dis etwar if split10pc==0
	
** Panel B 
**********************
**********************
tab dis order
tab dis order if split10pc==1
tab dis order if split10pc==0   
	   

	     
*** Appendix Table 35. : Ethnic Partitioning and Political Violence (Ordered Index of Political Violence).  Sensitivity Analysis. Alternative Estimation Techniques
********************************************************************************************************************************************************************************
********************************************************************************************************************************************************************************
** Columns (1)-(4): OLS 
** Columns (5)-(8): Ordered Probit ML
** columns (1) & (5): unconditional estimates
** columns (2) - (4): country fixed-effects
** columns (6) - (8): regional fixed-effects 
** columns (3), (4), (7) & (8): adding rich rich set of controls and spillovers
*******************************************************************************************************************************************************************************
*******************************************************************************************************************************************************************************
estout  oli1 oli2 oli3 oli4 opo1 opo2 opo3 opo4, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a ll N , fmt(%9.3f %9.0g) labels(R2 LL Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   

** Appendix Table 36.  Ethnic Partitioning, Ethnic-based Political Discrimination, and Major Ethnic Civil Wars. 
** Sensitivity Analysis. Alternative Index of Ethnic Partitioning. Linear Probability Model Estimates
**********************************************************************************************************************************************************************************
****************************************************************************************
** Columns (1)-(4): ethnic war 
** Columns (5)-(8): discrimination from central government
** columns (1) & (5): unconditional estimates
** columns (2) & (6): only country fixed-effects
** columns (3) & (7): country fixed-effects and rich set of controls
** columns (4) & (8): country fixed-effects and rich set of controls and spillovers
*******************************************************************************************************************************************************************************
*******************************************************************************************************************************************************************************
estout aw1 aw2 aw3 aw4 ad1 ad2 ad3 ad4 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R2 Obs)) keep(  split5pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   

** Appendix Table 37. Excluding Each Time a Different African Region
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************
** all specifications include rich set of control variables and country fixed-effects
** columns (1)-(5): ethnic-based civil war serves as the dependent variable
** columns (6)-(10): ethnic-based political discrimination from the national government  serves as the dependent variable
*************************************************************************************************************************************************************************
estout wn_1 we_2 ww_3 wc_4 ws_5 dn_1 de_2 dw_3 dc_4 ds_5 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R-Squared Obs)) keep(split10pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
   
   
  
** Appendix Table 38. Excluding Each Time a Different African Region and Employing an Alternative Index of Ethnic Partitioning
*************************************************************************************************************************************************************************
*************************************************************************************************************************************************************************   	   
** columns (1)-(5): ethnic-based civil war serves as the dependent variable
** columns (6)-(10): ethnic-based political discrimination from the national government  serves as the dependent variable
*************************************************************************************************************************************************************************      
estout wn5_1 we5_2 ww5_3 wc5_4 ws5_5 dn5_1 de5_2 dw5_3 dc5_4 ds5_5 , cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels(R-Squared Obs)) keep(split5pc fneigh) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
   
	      
 
 
 
 