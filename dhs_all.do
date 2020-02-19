

***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************
** DHS Analysis
****************
****************
** This execution files generates all tables (in the main part of the paper and the on-line Supplementary Appenidx) using the DHS 
** Tables 8-9 and Appenidx Tables 39-42
**************************************************************************************************************************************************************
**************************************************************************************************************************************************************

clear 
clear mata
clear matrix
set mem 800M

describe all



** Run the CGMREG Program to gte double-clustered standard errors
***********************************************************************************************
***********************************************************************************************
run cgmreg.ado



**************************************************************************************************************************************************************
*** Table 8: Baseline results with wealth index and eduyears
**************************************************************************************************************************************************************

xi: cgmreg  wealth    split10pc migrant 																	i.wbcode				,  cluster( map loc_map )
est store a1
xi: cgmreg  wealth    split10pc migrant 	capdistance seadist bdist cap25pc                           	i.wbcode 				,  cluster( map loc_map )
est store a2
xi: cgmreg  wealth    split10pc migrant 	capdistance seadist bdist cap25pc  i.dob i.religion i.marita 	i.wbcode 				,  cluster( map loc_map )
est store a3
xi: cgmreg  wealth    split10pc migrant 																	i.wbcode	if bdist<.0795127,  cluster( map loc_map )
est store a1c
xi: cgmreg  wealth    split10pc migrant 	capdistance seadist bdist cap25pc                           	i.wbcode 	if bdist<.0795127,  cluster( map loc_map )
est store a2c
xi: cgmreg  wealth    split10pc migrant 	capdistance seadist bdist cap25pc  i.dob i.religion i.marita 	i.wbcode 	if bdist<.0795127,  cluster( map loc_map )
est store a3c
	   
	 
xi: cgmreg  eduyears    split10pc migrant 																	i.wbcode				,  cluster( map loc_map )
est store ed1
xi: cgmreg  eduyears    split10pc migrant 	capdistance seadist bdist cap25pc                           	i.wbcode 				,  cluster( map loc_map )
est store ed2
xi: cgmreg  eduyears    split10pc migrant 	capdistance seadist bdist cap25pc  i.dob i.religion i.marita 	i.wbcode 				,  cluster( map loc_map )
est store ed3
xi: cgmreg  eduyears    split10pc migrant 																	i.wbcode	if bdist<.0795127,  cluster( map loc_map )
est store ed1c
xi: cgmreg  eduyears    split10pc migrant   capdistance seadist bdist cap25pc 	                            i.wbcode 	if bdist<.0795127,  cluster( map loc_map )
est store ed2c
xi: cgmreg  eduyears    split10pc migrant 	capdistance seadist bdist cap25pc  i.dob i.religion i.marita 	i.wbcode 	if bdist<.0795127,  cluster( map loc_map )
est store ed3c


**************************************************************************************************************************************************************
*** Table 8: Baseline results with wealth index and eduyears
**************************************************************************************************************************************************************
*** double clustered standard errors at the ethnicity level and the ethnic homeland level
*** columns (1)-(6): Dep. Var is wealth
*** columns (7)-(12): Dep. Var is eduyears
*** columns (1)-(3); (7)-(9): all observations
*** columns (4)-(6); (10)-(12): observations close to the border
*** columns (1), (4), (7) and (10): simply conditioning on country fixed effects
*** columns (2), (5), (8) and (11): country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita
*** columns (3), (6), (9) and (12): country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita and distance terms
**************************************************************************************************************************************************************
estout a1 a2 a3  a1c a2c a3c ed1 ed2 ed3  ed1c ed2c ed3c, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc  migrant) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   
	   
	
***************************************************************************************************************************************************************	   
**** Table 9: distinguishing between Identity of respondnet and location
***************************************************************************************************************************************************************

xi: cgmreg  wealth    split10pc 	loc_split10pc                  migrant	capdistance seadist bdist cap25pc  							 i.wbcode				,  cluster( map loc_map )
est store ar1
xi: cgmreg  wealth    split10pc 	loc_split10pc                  migrant	capdistance seadist bdist cap25pc  i.dob i.religion i.marita i.wbcode 				,  cluster( map loc_map )
est store ar2
xi: cgmreg  wealth    split10pc 	loc_split10pc                  migrant	capdistance seadist bdist cap25pc  						 i.wbcode	if bdist<.0795127,  cluster( map loc_map )
est store ar1c
xi: cgmreg  wealth    split10pc 	loc_split10pc                  migrant	capdistance seadist bdist cap25pc  i.dob i.religion i.marita i.wbcode 	if bdist<.0795127,  cluster( map loc_map )
est store ar2c
xi: cgmreg wealth   split10pc loc_split10pc  split10pc_loc10pc     migrant  capdistance seadist bdist cap25pc                           i.wbcode,  cluster(map loc_map)
est store arint1
xi: cgmreg wealth   split10pc loc_split10pc  split10pc_loc10pc     migrant  capdistance seadist bdist cap25pc  i.dob i.religion i.marita i.wbcode,  cluster(map loc_map)
est store arint2

xi: cgmreg  eduyears    split10pc loc_split10pc                   migrant   capdistance seadist bdist cap25pc                         i.wbcode				,  cluster( map loc_map )
est store edr1
xi: cgmreg  eduyears    split10pc loc_split10pc                   migrant   capdistance seadist bdist cap25pc i.dob i.religion i.marita  i.wbcode 				,  cluster( map loc_map )
est store edr2
xi: cgmreg  eduyears    split10pc loc_split10pc                   migrant 	capdistance seadist bdist cap25pc                        i.wbcode	if bdist<.0795127,  cluster( map loc_map )
est store edr1c
xi: cgmreg  eduyears    split10pc loc_split10pc                   migrant   capdistance seadist bdist cap25pc i.dob i.religion i.marita  i.wbcode 	if bdist<.0795127,  cluster( map loc_map )
est store edr2c
xi: cgmreg eduyears     split10pc loc_split10pc split10pc_loc10pc migrant   capdistance seadist bdist cap25pc                         i.wbcode,  cluster(map loc_map)
est store edrint1
xi: cgmreg eduyears     split10pc loc_split10pc split10pc_loc10pc migrant   capdistance seadist bdist cap25pc i.dob i.religion i.marita i.wbcode,  cluster(map loc_map)
est store edrint2


	
***************************************************************************************************************************************************************	   
**** Table 9: Distinguishing between the Identity of respondent and Current Ethnic Homeland
***************************************************************************************************************************************************************

*** double clustered standard errors at the ethnicity level and the ethnic homeland level
*** columns (1)-(6): Dep. Var wealth; 
*** columns (7)-(12): Dep. Var eduyears; 
*** columns (1)-(2), (5)-(6), (8)-(12): all observations
*** columns (5)-(6), (11)-(12): whole sample allowing for an interaction term between split identity and split location
*** columns (3)-(4); (7)-(8): observations close to the border
*** even-numbered columns: simply conditioning on country fixed effects + "mover" dummy
*** odd-numbered columns:  country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita and distance terms
*********************************************************************************************************************************************************************
estout ar1 ar2 ar1c ar2c arint1 arint2 edr1 edr2 edr1c edr2c edrint1 edrint2, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc loc_split10pc split10pc_loc10pc migrant ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   
	   
***************************************************************************************************************************************************************
***************************************************************************************************************************************************************
***************************************************************************************************************************************************************
*** Supplementary Appendix Tables 
***************************************************************************************************************************************************************
***************************************************************************************************************************************************************
***************************************************************************************************************************************************************


*****************************************************
*** Appendix Table 39: Summary Statistics
***************************************************************************************************************************************************************
****************************************************************************************************************************************************************
tab split10pc loc_split10pc 
tab split10pc if loc_split10pc==1
tab migrant	

sum wealth eduyears split10pc loc_split10pc migrant if wealth!=.

*****************************************************
*** Appendix Table 40: Enumeration Area Fixed Effects
*****************************************************
****************************************************************************************************************************************************************
****************************************************************************************************************************************************************
xi: areg  wealth       split10pc migrant                                                  , a(addgps) cluster( map  )
est store v1
xi: areg  wealth       split10pc migrant   i.dob i.religion i.marita	                  , a(addgps) cluster( map  )
est store v2
xi: areg  eduyears    split10pc migrant                                                  , a(addgps) cluster( map  )
est store ved1
xi: areg  eduyears    split10pc migrant    i.dob i.religion i.marita 	 		          , a(addgps) cluster( map  )
est store ved2
xi: areg  wealth       split10pc migrant 		 		                  if bdist<.0795127, a(addgps) cluster( map  )
est store v1c
xi: areg  wealth       split10pc migrant   i.dob i.religion i.marita      if bdist<.0795127, a(addgps) cluster( map  )
est store v2c
xi: areg  eduyears    split10pc migrant	                                  if bdist<.0795127, a(addgps) cluster( map  )
est store ved1c
xi: areg  eduyears    split10pc migrant    i.dob i.religion i.marita 	  if bdist<.0795127, a(addgps) cluster( map  )
est store ved2c


	   
*****************************************************
*** Appendix Table 40: Enumeration Area Fixed Effects
**************************************************************************************************************************************************************
**************************************************************************************************************************************************************
*** standard errors clustered at the ethnicity level (double clustering delivers slightly smaller standard errors)
*** columns (1)-(4): all observations
*** columns (5)-(8): observations close to the border
*** columns (1), (3), (5) and (7): village FE
*** columns (2), (4), (6) and (8): village FE plus rich set of individual controls. i.dob i.religion i.marita
**************************************************************************************************************************************************************
estout v1 v2 ved1 ved2 v1c v2c ved1c ved2c, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared Obs)) keep(split10pc migrant) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   

	 
	   
**********************************************************************************
*** Appendix Table 41: Looking at Movers and Non-Movers Separately
**********************************************************************************
**************************************************************************************************************************************************************
**************************************************************************************************************************************************************
xi: cgmreg wealth    split10pc  capdistance seadist bdist cap25pc                                                             i.wbcode if migrant==0,  cluster(map loc_map)
est store am1
xi: cgmreg wealth    split10pc  capdistance seadist bdist cap25pc i.dob i.religion i.marita i.wbcode if migrant==0,  cluster(map loc_map)
est store am2
xi: cgmreg wealth    split10pc  capdistance seadist bdist cap25pc                                                             i.wbcode if migrant==1 & loc_split10pc==0,  cluster(map loc_map)
est store am3
xi: cgmreg wealth    split10pc  capdistance seadist bdist cap25pc i.dob i.religion i.marita i.wbcode if migrant==1 & loc_split10pc==0,  cluster(map loc_map)
est store am4
xi: cgmreg wealth    split10pc  capdistance seadist bdist cap25pc                                                           i.wbcode if migrant==1 & loc_split10pc==1,  cluster(map loc_map)
est store am5
xi: cgmreg wealth    split10pc  capdistance seadist bdist cap25pc i.dob i.religion i.marita i.wbcode if migrant==1 & loc_split10pc==1,  cluster(map loc_map)
est store am6

xi: cgmreg  eduyears split10pc  capdistance seadist bdist cap25pc                                                            i.wbcode if migrant==0,  cluster(map loc_map)
est store ame1
xi: cgmreg  eduyears split10pc  capdistance seadist bdist cap25pc i.dob i.religion i.marita i.wbcode if migrant==0,  cluster(map loc_map)
est store ame2
xi: cgmreg  eduyears split10pc  capdistance seadist bdist cap25pc                                                            i.wbcode if migrant==1 & loc_split10pc==0,  cluster(map loc_map)
est store ame3
xi: cgmreg  eduyears split10pc  capdistance seadist bdist cap25pc i.dob i.religion i.marita i.wbcode if migrant==1 & loc_split10pc==0,  cluster(map loc_map)
est store ame4
xi: cgmreg  eduyears split10pc  capdistance seadist bdist cap25pc                                                            i.wbcode if migrant==1 & loc_split10pc==1,  cluster(map loc_map)
est store ame5
xi: cgmreg  eduyears split10pc  capdistance seadist bdist cap25pc i.dob i.religion i.marita i.wbcode if migrant==1 & loc_split10pc==1,  cluster(map loc_map)
est store ame6

**********************************************************************************
*** Appendix Table 41: Looking at Movers and Non-Movers Separately
**************************************************************************************************************************************************************
**************************************************************************************************************************************************************
*** double clustered standard errors at the ethnicity level and the ethnic homeland level
*** columns (1), (2), (7) and (8) : all those that are not movers
*** columns (3), (4), (9) and (10): all those that are movers residing in non-split homelands
*** columns (5), (6), (11) and (12): all those that are movers residing in split homelands
*** Odd-Numbered Columns: Only country fixed effects
*** Even-Numbered Columns:  country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita and distance terms
**************************************************************************************************************************************************************
estout am1 am2 am3 am4 am5 am6 ame1 ame2 ame3 ame4 ame5 ame6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	
	   

*********************************************************************************************************************************************************************
*********************************************************************************************************************************************************************
**** Appendix Table 42 **** Looking at Different cohorts
*********************************************************************************************************************************************************************
**** young generations;  born >= 1977
**** old generations:  born < 1977
*********************************************************************************************************************************************************************

xi: cgmreg  wealth    	split10pc 					migrant capdistance seadist bdist cap25pc       i.dob i.religion i.marita 	i.wbcode  	if	dob<1977				,  cluster( map loc_map )
est store c1o
xi: cgmreg  wealth    	split10pc 					migrant capdistance seadist bdist cap25pc       i.dob i.religion i.marita 	i.wbcode 	if 	dob>=1977				,  cluster( map loc_map )
est store c1y
xi: cgmreg  wealth    	split10pc 	loc_split10pc	migrant capdistance seadist bdist cap25pc       i.dob i.religion i.marita 	i.wbcode  	if	dob<1977				, cluster( map loc_map )
est store c2o
xi: cgmreg  wealth    	split10pc 	loc_split10pc	migrant capdistance seadist bdist cap25pc       i.dob i.religion i.marita 	i.wbcode 	if 	dob>=1977				,  cluster( map loc_map )
est store c2y

xi: cgmreg  eduyears    split10pc 					migrant capdistance seadist bdist cap25pc       i.dob i.religion i.marita 	i.wbcode  	if	dob<1977					,  cluster( map loc_map )
est store edc1o
xi: cgmreg  eduyears    split10pc 					migrant capdistance seadist bdist cap25pc       i.dob i.religion i.marita 	i.wbcode 	if 	dob>=1977				,  cluster( map loc_map )
est store edc1y
xi: cgmreg  eduyears    split10pc 	loc_split10pc	migrant capdistance seadist bdist cap25pc       i.dob i.religion i.marita 	i.wbcode  	if	dob<1977					,  cluster( map loc_map )
est store edc2o
xi: cgmreg  eduyears    split10pc 	loc_split10pc	migrant capdistance seadist bdist cap25pc       i.dob i.religion i.marita 	i.wbcode 	if 	dob>=1977				,  cluster( map loc_map )
est store edc2y

*********************************************************************************************************************************************************************
**** Appendix Table 42 **** Looking at Different cohorts; young generations;  born >= 1977 ; **** old generations:  born < 1977
*********************************************************************************************************************************************************************
*** double clustered standard errors at the ethnicity level and the ethnic homeland level
*** columns (1)-(8): all observations
*** columns (1)-(4): Dep. Var is wealth
*** columns (1)-(4): Dep. Var is eduyears
*** Odd-numbered columns: Born on or Before 1977
*** Even-numbered columns: Born After 1977
*** All specifications include country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita and distance terms
**************************************************************************************************************************************************************
estout c1o c1y c2o c2y edc1o edc1y edc2o edc2y, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc loc_split10pc bdist seadist capdistance cap25pc migrant) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	
*********************************************************************************************************************************************************************
*********************************************************************************************************************************************************************
*********************************************************************************************************************************************************************
*********************************************************************************************************************************************************************
** All Tables with Results with DHS data
*********************************************************************************************************************************************************************
*********************************************************************************************************************************************************************	
*********************************************************************************************************************************************************************
*********************************************************************************************************************************************************************
	
	
	
**************************************************************************************************************************************************************
*** Table 8: Baseline results with wealth index and Education
**************************************************************************************************************************************************************
*** double clustered standard errors at the ethnicity level and the ethnic homeland level
*** columns (1)-(6): Dep. Var is Wealth
*** columns (7)-(12): Dep. Var is Education
*** columns (1)-(3); (7)-(9): all observations
*** columns (4)-(6); (10)-(12): observations close to the border
*** columns (1), (4), (7) and (10): simply conditioning on country fixed effects
*** columns (2), (5), (8) and (11): country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita
*** columns (3), (6), (9) and (12): country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita and distance terms
**************************************************************************************************************************************************************
estout a1 a2 a3  a1c a2c a3c ed1 ed2 ed3  ed1c ed2c ed3c, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc   migrant) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   
	   
	   
***************************************************************************************************************************************************************	   
**** Table 9: Distinguishing between the Identity of respondent and Current Ethnic Homeland
***************************************************************************************************************************************************************
*** double clustered standard errors at the ethnicity level and the ethnic homeland level
*** columns (1)-(6): Dep. Var Wealth; 
*** columns (7)-(12): Dep. Var Education; 
*** columns (1)-(2), (5)-(6), (8)-(12): all observations
*** columns (5)-(6), (11)-(12): whole sample allowing for an interaction term between split identity and split location
*** columns (3)-(4); (7)-(8): observations close to the border
*** even-numbered columns: simply conditioning on country fixed effects + "mover" dummy
*** odd-numbered columns:  country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita and distance terms
*********************************************************************************************************************************************************************
estout ar1 ar2 ar1c ar2c arint1 arint2 edr1 edr2 edr1c edr2c edrint1 edrint2, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc loc_split10pc split10pc_loc10pc migrant ) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   
*****************************************************
*** Appendix Table 39: Summary Statistics
***************************************************************************************************************************************************************
tab split10pc loc_split10pc 
tab split10pc if loc_split10pc==1
tab migrant	

sum wealth eduyears split10pc loc_split10pc migrant if wealth!=.
		   
*****************************************************
*** Appendix Table 40: Enumeration Area Fixed Effects
***************************************************************************************************************************************************************
*** standard errors clustered at the ethnicity level (double clustering delivers slightly smaller standard errors)
*** columns (1)-(4): all observations
*** columns (5)-(8): observations close to the border
*** columns (1), (3), (5) and (7): village FE
*** columns (2), (4), (6) and (8): village FE plus rich set of individual controls. i.dob i.religion i.marita
**************************************************************************************************************************************************************
estout v1 v2 ved1 ved2 v1c v2c ved1c ved2c, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)

	   
**********************************************************************************
*** Appendix Table 41: Looking at Movers and Non-Movers Separately
***************************************************************************************************************************************************************
*** double clustered standard errors at the ethnicity level and the ethnic homeland level
*** columns (1), (2), (7) and (8) : all those that are not movers
*** columns (3), (4), (9) and (10): all those that are movers residing in non-split homelands
*** columns (5), (6), (11) and (12): all those that are movers residing in split homelands
*** Odd-Numbered Columns: Only country fixed effects
*** Even-Numbered Columns:  country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita and distance terms
**************************************************************************************************************************************************************
estout am1 am2 am3 am4 am5 am6 ame1 ame2 ame3 ame4 ame5 ame6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc loc_split10pc bdist seadist capdistance cap25pc) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	
	
	   
*********************************************************************************************************************************************************************
**** Appendix Table 42 **** Looking at Different cohorts
*********************************************************************************************************************************************************************
**** young generations;  born >= 1977
**** old generations:  born < 1977
*********************************************************************************************************************************************************************

*** double clustered standard errors at the ethnicity level and the ethnic homeland level
*** columns (1)-(8): all observations
*** columns (1)-(4): Dep. Var is Wealth
*** columns (1)-(4): Dep. Var is Education
*** Odd-numbered columns: Born on or Before 1977
*** Even-numbered columns: Born After 1977
*** All specifications include country fixed effects, plus rich set of individual controls. i.dob i.religion i.marita and distance terms
**************************************************************************************************************************************************************
estout c1o c1y c2o c2y edc1o edc1y edc2o edc1y, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(N r2_a, fmt(%9.3f %9.0g) labels(R-squared)) keep(split10pc loc_split10pc bdist seadist capdistance cap25pc migrant) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)	   
	   
	   
	   

	   
	   
	   
	      
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
