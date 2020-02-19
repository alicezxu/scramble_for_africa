
********************************************************************************************************************************************************************
********************************************************************************************************************************************************************
** Robustness. Differential effect based on border artificiality. <<fractalfinal>>
** Unconditional NB ML models and linear probability models
** outcome varaible. all main events (excl. riots and protests)
*******************************************************************************************************************************************************************



** Specification (6). Border Artificiality
********************************************************************
********************************************************************

** Preliminaries
sum fractalfinal, d
egen med_fractal=pctile(fractalfinal), p(50)

gen split10pc_art=0
replace split10pc_art=1 if split10pc==1 & fractalfinal<=med_fractal & fractalfinal!=.

gen split10pc_org=0
replace split10pc_org=1 if split10pc==1 & fractalfinal>med_fractal & fractalfinal!=.

gen minor_split=0
replace minor_split=1 if split10pc==1 & fractalfinal==.


*** Estimation NB-ML
xi: nbreg allm 		split10pc_art split10pc_org spil		$simple  $rich1 $location i.wbcode 	 						if minor_split==0,  robust cluster( cluster)
est store hetnb5
  
***	Estimation LPM	
xi: cgmreg allmd 	split10pc_art split10pc_org spil 		$simple  $rich1 $location i.wbcode   						if minor_split==0,  cluster(wbcode cluster)
est store hetls5
	 
	   
	

** Specification (7). Same versus Different Colonial Border
********************************************************************
********************************************************************
foreach var of varlist colony0 colony1 colony2 colony3 colony4 colony5 colony6 {
	replace `var'=0 if wbcode=="ERI"
	}
replace colony7=1 if wbcode=="ERI"
*****************

** Preliminaries
bysort name: egen mean_uk=mean(colony1) if split10pc==1
bysort name: egen sd_uk=sd(colony1) if split10pc==1

gen same_uk=0
replace same_uk=1 if sd_uk==0 & mean_uk==1


bysort name: egen mean_fr=mean(colony2) if split10pc==1
bysort name: egen sd_fr=sd(colony2) if split10pc==1

gen same_fr=0
replace same_fr=1 if sd_fr==0 & mean_fr==1

bysort name: egen mean_be=mean(colony4) if split10pc==1
bysort name: egen sd_be=sd(colony4) if split10pc==1

gen same_be=0
replace same_be=1 if sd_be==0 & mean_be==1

egen same=rmax(same_uk same_fr same_be)

gen same_split10pc=0
replace same_split10pc=1 if split10pc==1 & same==1

gen differ_split10pc=0
replace differ_split10pc=1 if split10pc==1 & same==0

*** Estimation NB-ML
xi: nbreg allm 		same_split10pc differ_split10pc spil		$simple  $rich1 $location i.wbcode 	 						if minor_split==0,  robust cluster( cluster)
est store hetnb5
  
***	Estimation LPM	
xi: cgmreg allmd 	same_split10pc differ_split10pc spil 		$simple  $rich1 $location i.wbcode   						if minor_split==0,  cluster(wbcode cluster)
est store hetls5   
	   


** Specification (8). Two-Way Splits versus Three-or-More Splits
********************************************************************
********************************************************************
** Preliminaries
gen 	two_way_split=0
replace two_way_split=1 if nmbr_cntry==2 & split10pc==1


gen 	more_way_split=0
replace more_way_split=1 if nmbr_cntry>2 & split10pc==1 



*** Estimation NB-ML
xi: nbreg allm 		two_way_split more_way_split spil		$simple  $rich1 $location i.wbcode 	 						,  robust cluster( cluster)
est store hetnb8
  
***	Estimation LPM	
xi: cgmreg allmd 	two_way_split more_way_split spil 		$simple  $rich1 $location i.wbcode   						,  cluster(wbcode cluster)
est store hetls8	   
	   
	   
	   
	   
	   

** Comment on it. Intrecation between SPLIT10pc & SPIL
********************************************************************
********************************************************************
** Preliminaries
gen 	split10pc_spil=spil* split10pc 



*** Estimation NB-ML
xi: nbreg allm 		split10pc spil split10pc_spil 		$simple  $rich1 $location i.wbcode 	 						,  robust cluster( cluster)
xi: nbreg allm 		split10pc spil split10pc_spil 		$simple  $rich1 $location i.wbcode 	 		if capital==0	,  robust cluster( cluster)
xi: nbreg allm 		split10pc spil split10pc_spil 		$simple  $rich1 $location i.wbcode 	 		if allm<top_allm	,  robust cluster( cluster)

  
  
***	Estimation LPM	
xi: cgmreg allmd 	split10pc spil split10pc_spil 		$simple  $rich1 $location i.wbcode   						,  cluster(wbcode cluster)
	   
	
	   
	   
	   
	   
	   
	   
	   