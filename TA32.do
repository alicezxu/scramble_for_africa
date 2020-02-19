

** Appendix Table 32. Ethnic Partitioning and Civil Conflict.  Heterogeneous Effects by Country Features 
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

***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************

*** Column (1). Ethnic Fractionalization. 
*****************************************************************************
** Preliminaries
by wbcode, sort: gen k=_n
sum  eth_fragm if k==1, det


egen 		md_eth_fragm=median( eth_fragm) if k==1
egen 		med_eth_fragm=mean( eth_fragm)

gen 		split10pc_eth_fragm_high=0
replace 	split10pc_eth_fragm_high=1 if split10pc==1 &  eth_fragm>med_eth_fragm


gen 		split10pc_eth_fragm_low=0
replace 	split10pc_eth_fragm_low=1 if split10pc==1 &  eth_fragm<=med_eth_fragm


** Estimation
xi: nbreg all 	 	split10pc_eth_fragm_high split10pc_eth_fragm_low		spil 	$simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store het1

xi: cgmreg alld 	split10pc_eth_fragm_high split10pc_eth_fragm_low		spil 	$simple  $rich1 $location i.wbcode 			,  cluster(wbcode  cluster)
est store het1l


***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************


*** Column (2). Linguistic Fractionalization. 
*****************************************************************************
** Preliminaries
sum  lang_fragm if k==1, det

egen 		md_lang_fragm=median( lang_fragm) if k==1
egen 		med_lang_fragm=mean( lang_fragm)

gen 		split10pc_lang_fragm_high=0
replace 	split10pc_lang_fragm_high=1 if split10pc==1 &  lang_fragm>med_lang_fragm

gen 		split10pc_lang_fragm_low=0
replace 	split10pc_lang_fragm_low=1 if split10pc==1 &  lang_fragm<=med_lang_fragm


** Estimation
xi: nbreg all 	 	split10pc_lang_fragm_high split10pc_lang_fragm_low		spil 	$simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store het2

xi: cgmreg alld 	split10pc_lang_fragm_high split10pc_lang_fragm_low		spil 	$simple  $rich1 $location i.wbcode 			,  cluster(wbcode  cluster)
est store het2l


*** Column (3). Religious Fractionalization. 
*****************************************************************************
** Preliminaries
sum  rel_fragm if k==1, det

egen 		md_rel_fragm=median( rel_fragm) if k==1
egen 		med_rel_fragm=mean( rel_fragm)

gen 		split10pc_rel_fragm_high=0
replace 	split10pc_rel_fragm_high=1 if split10pc==1 &  rel_fragm>med_rel_fragm

gen 		split10pc_rel_fragm_low=0
replace 	split10pc_rel_fragm_low=1 if split10pc==1 &  rel_fragm<=med_rel_fragm


** Estimation
xi: nbreg all 	 	split10pc_rel_fragm_high split10pc_rel_fragm_low		spil 	$simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store het3

xi: cgmreg alld 	split10pc_rel_fragm_high split10pc_rel_fragm_low		spil 	$simple  $rich1 $location i.wbcode 			,  cluster(wbcode  cluster)
est store het3l

*** Column (4). Landlocked - Costal Countries
******************************************************************************
** Preliminaries
gen 	split10pc_landlock=0
replace split10pc_landlock=1 if split10pc==1 & landlock==1

gen 	split10pc_coastal=0
replace split10pc_coastal=1  if split10pc==1 & landlock==0


egen land_area_med=pctile(land_area), p(50)

gen 	split10pc_big=0
replace split10pc_big=1 if split10pc==1 & land_area>land_area_med


gen 	split10pc_small=0
replace split10pc_small=1 if split10pc==1 & land_area<=land_area_med

** Estimation
xi: nbreg all 		split10pc_landlock 		split10pc_coastal  		spil 		$simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store het4

xi: cgmreg alld 	split10pc_landlock 		split10pc_coastal 		spil 		$simple   $rich1 $location i.wbcode 		,  cluster(wbcode  cluster)
est store het4l



***********************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************

*** Column (5). Country Size. Log Land Area 
*****************************************************************************
** Preliminaries
replace land_area=0.101 if wbcode=="ERI"
sum land_area  if k==1

egen 		md_land_area =median(land_area ) if k==1
egen 		med_land_area =mean(md_land_area )

gen 		split10pc_big=0
replace 	split10pc_big=1 if split10pc==1 & land_area>med_land_area 


gen 		split10pc_small=0
replace 	split10pc_small=1 if split10pc==1 & land_area<=med_land_area 


** Estimation
xi: nbreg all 	 	split10pc_big split10pc_small		spil 	$simple  $rich1 $location i.wbcode 			,  robust cluster(  cluster)
est store het5

xi: cgmreg alld 	split10pc_big split10pc_small		spil 	$simple  $rich1 $location i.wbcode 			,  cluster(wbcode  cluster)
est store het5l

