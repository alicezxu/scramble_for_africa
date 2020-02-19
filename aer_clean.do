
clear all
cd "C:\Users\eliaspapaioannou\Desktop\scramble_final\AER_revision"
use ready_all2013.dta
use ready_all2010.dta 


****************************************************************************************************
****************************************************************************************************

 * 
order 	id id_split name atlasname cluster wbcode inter ccountry country iso_a3 pwtcountry countryisocode shcode  region_c region_n region_s region_w region_e  ///
		fracnew pop60 lnpop60 pd60_new km2split lnkm2split lakedum riverdum capital coastal borderdist1 capdistance1 seadist1 median_bd ///
		mean_elev mean_suit diamondd malariasuit petroleum island city1400 ///
		v107-v99 distcon distemp exports exports_new wlngcp_pc_ppp wlngcp_pc_mer ///
		chapter dataquality lon_split lat_split fracsplit split_group split1pc split5pc split10pc split20pc split30pc nmbr_cntry nmbrcntrynew fracnew spil ///
		id fracconf pd60_new-nmbr_neigh_g_split10pc fneigh ///
		all alld  fatal allf allfd  allm allmd      battles batd vio viod riots riotsd ///
		govt govtd     riotprot riotprotd civilians civiliansd  intervention interventiond outside outsided ///
		rebels rebelsd mil mild civilians civiliansd external externald ///
		colony0- colony7 rlaw96 corrupt96  partitioned fractal independ ///
		island_dum legor_fr legor_uk land_area landlock area elf rq eth_fragm lang_fragm rel_fragm altelf ef cdiv elf1- ind_year /// 
		no 
	


** Drop various cross-country measures
******************************************************
	drop voice- ln_export_pop
	drop abs_latitude islam
	drop ln_avg_gold_pop- state_dev latitude exportersofmanufactures expprim expoil diversifiedexporters gi er ph diff_gi_elf
	drop legor_so- lnfrinstex
	drop lu60-tyr99
	drop count_lights- pdmedian60
	drop  lnpoptribe lnpopcluster unique stratclass1 slavery agriculture graug1 lnwaterkm lnsea_dist lncapdistance
	drop kmw50- pd050
	drop co_pop61- religion_C2
	drop cutoff98 class_strat pdmean00 bdcentr xaxis yaxis seadist wbcodenum 
	drop mal dia 
	drop mean_lights0708o- allcropsborder5
	drop rrddens rddens primrddens grpop60_00 poptibe pop_cluster
	drop  cou-xconst6000
	drop elf lnallm lnallmm
	drop vioa
	
** Drop data used for the construction of duration meaures
***********************************************************
	drop bild1-bild41  
	drop namepop00 - w
	drop durucdp_all
	drop all_td1- os_td22
	
 drop 	split1pc split20pc split30pc 
 drop 	fracconf
 drop 	bdist_min bdist_max bdist_range bdist_mean bdist_std
 drop 	clusternew nmbr_clusternew nmbr_g_clusternew nmbr_clusternew_g_same
 drop 	lakekm2 rivlength riverdist lakedist pop00 lnpop00
 drop 	govt_eth govt_reb govt_pol govt_civ reb_civ pol_civ type1 type2 type3 type4
 drop 	lnkm2group maxdist reldist number_diamond area_m centr_exp
 drop	waterdum gpwpdmean0 lnexports
 drop lnseadist1 lncapdistance1 lnborderdist1 lnbdcentr

** UCDP Data
gen 	onesidedd_prec=0 
replace onesidedd_prec=1 if sum_onesided_no>0 & sum_onesided_no!=.

drop nall_td1- nall_td22 nst_td1- nst_td22 nns_td1- nns_td22 nos_td1- nos_td22 
drop dataquality split_group fracsplit  sum_all_no sum_best_est sum_high_est sum_low_est sum_civilian_d
drop sum_civilian_d_st sum_civilian_d_ns sum_civilian_d_os sum_intd1-sum_intd9
drop best_est_st best_est_ns best_est_os high_est_st high_est_ns high_est_os low_est_st low_est_st low_est_os civilian_d_st civilian_d_ns civilian_d_os lettercode cid low_est_ns
drop ln1_civilians ln1_casualties_state ln1_casualties_nonstate
drop top_sum_best_est top5_sum_best_est top10_sum_best_est
drop top_sum_civilian_d top5_sum_civilian_d top10_sum_civilian_d
drop top_sum_all_no top5_sum_all_no top10_sum_all_no
drop state_event nonstate_event onesided_event 


** Label Variables
*******************************************************************************************************
*******************************************************************************************************
label var id	 		"Country-Ethnicity Homeland."
label var id_split 		"Numeric Identifier for Country-Ethnicity Homelands"
label var atlasname 	"Ethnicity Name, as in Murdock Ethnolinguistic Atlas"
label var cluster 		"Ethnic Family Name. Source: Murdock Ethnolinguistic Atlas"
label var wbcode 		"Wold Bank 3-letter Country Code"
label var country 		"country name"
label var iso_a3 		"Country ISO Code"
label var pwtcountry 	"Penn World Tables Country Name"
label var inter			"Intersction of country and ethnicity" 

label var pop60 		"Population Country-Ethnicity Homeland in the 1960s. Source: UNESCO "
label var lnpop60 		"Logarithm of Population in the 1960s. Source: UNESCO "
label var km2split 		"Land Surface Area of the Country-Ethnicity Region. Source: Global Mapping International"
label var lnkm2split	"Log Land Surface Area of the Country-Ethnicity Region."
label var nmbrcntrynew	"Number of countries that an ethnic group is found. range 1-6."
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
label var exports_dummy	"Indicator for regions that were affcted by the slave trades. Source: Nunn."

label var v107 			"Society Name. Murdock (1967). All v1-v113 variables come from Murdock (1967)"
label var chapter		"Chapter where each ethnic group is discussed in Murdock (1959)."


label var lon_split		"Longitude. centroid of each country-ethnic area."
label var long1			"Longitude. centroid of each country-ethnic area."

label var lat_split		"Latitude. centroid of each country-ethnic area."
label var lat1			"Latitude. centroid of each country-ethnic area."

label var split10pc		"Identifier for partitioned (split) ethnic groups, using 10% cutoff."
label var split5pc		"Identifier for partitioned (split) ethnic groups, using 5% cutoff."
label var nmbr_cntry	"Number of countries that an ethnic group is found. range 1-6."
label var spil 			"Share of adjacent split groups to total number of neighboring groups."

label var fractalfinal	"Index of straightness of national borders. As in Alesina, et al. (JEEA 2013)"
label var distcon		"Distance to main pre-colonial conflict areas. Besley and Reynal (APSR 2014)"
label var distemp		"Distance to main pre-colonial kingdoms/empires. Besley and Reynal (APSR 2014)"
label var exports		"Total slave exports at the ethnicity level, 1400-1913. Source: Nunn (QJE 2008)"
label var no			"Identifier for country-ethnicity observations with no variation close to borders"
label var median_bd		"Median distance to the national border. based on borderdist1"
label var pd60_new		"Population density at the country-ethnic homeland around independence"


** Label ACLED Variables
*******************************************************************************************************
*******************************************************************************************************
label var all 			"All civil conflict events/incidents (of all types). Source: ACLED."
label var alld			"Identifier variable for country-ethnic regions with any type of conflict. ACLED" 
label var fatal 		"Fatalities at the country-ethnic area level from all types of conflcit. ACLED"
label var allf			"Fatal civil conflcit events (of all types). Source: ACLED."
label var allfd			"Identifier for country-ethnic regions with any type of fatal conflict. ACLED" 
label var allm 			"Main civil conflict events/incidents (excl. riots-protests). Source: ACLED."
label var allmd			"Identifier variable for main conflict (excl. riots and protests). ACLED" 
label var allmm 		"Civil conflict events (excl. riots-protests and non-violent). Source: ACLED."
label var allmmd		"Identifier for conflict (excl. riots and protests and non-violent). ACLED" 

label var battles 		"Civil Conflict - Number of Battles. Source: ACLED."
label var batd			"Identifier variable for country-ethnic regions with battles. ACLED" 
label var vio 			"Civil Conflict - Number of Violence against Civilians. Source: ACLED."
label var viod			"Identifier variable for country-ethnic regions with civilian violence. ACLED" 
label var riots 		"Civil Conflict - Number of Riots and Protests. Source: ACLED."
label var riotsd		"Identifier variable for country-ethnic regions with riots and protests. ACLED" 

label var govt 			"Civil Conflict with Government Forces. Source: ACLED."
label var govtd			"Identifier for conflict with Government Forces. ACLED" 
label var civilians 	"Number of Civilian Violence Events. Based on Actors. Source: ACLED."
label var civiliansd	"Identifier for civilian violence. Based on Actors. ACLED" 
label var riotprot 		"Civil Conflict - Number of Riots and Protests. Based on Actors. Source: ACLED."
label var riotprotd		"Identifier for country-ethnic regions with riots and protests. Based on Actors. ACLED" 
label var rebels		"Number of Civil Conflict Events with Rebel Forces. Source: ACLED."
label var rebelsd		"Identifier for conflict with rebel forces. ACLED" 
label var mil			"Number of Civil Conflict Events with Militias. Source: ACLED."
label var mild			"Identifier for conflict with Militias. ACLED" 

label var external 		"Conflict with Foreign (External) Intervention. Source: ACLED."
label var externald		"Identifier for conflict with Foreign/External Intervention. ACLED" 
label var intervention	"Conflict with Intervention from Neighboring Country. Source: ACLED."
label var interventiond	"Identifier for conflict with intervention from neighboring country. ACLED" 
label var outside		"Conflict with Intervention from Outside Force (UN, NATO, AU). Source: ACLED."
label var outsided		"Identifier for conflict with intervention from UN, NATO, AU. ACLED" 

label var dur			"Duration (in years) that a country-ethnic homeland has suffered from any type of conflict. ACLED"
label var durm			"Duration (in years) of main civil conflict types (excl. riots & protests). ACLED"
label var durdead		"Duration (in years) of deadly civil coflict of any type. ACLED"


label var top_all			"Top 1% of respective variable. All conflict events, ACLED"
label var top_allm			"Top 1% of respective variable. Main conflict events (no riots-protests), ACLED"
label var top_allmm			"Top 1% of respective variable. Conflict events (no riots-protests and non-violence), ACLED"
label var top_battles		"Top 1% of respective variable. Battles, ACLED"
label var top_vio			"Top 1% of respective variable. Violent events against civilians, ACLED"
label var top_nonvio		"Top 1% of respective variable. Non-Violent events by conflict actor, ACLED"
label var top_riots			"Top 1% of respective variable. Riots and Protests, ACLED"
label var top_fatal			"Top 1% of respective variable. All fatalities, ACLED"
label var top_allf			"Top 1% of respective variable. All fatal conflict events, ACLED"


label var top5_all			"Top 5% of respective variable. All conflict events, ACLED"
label var top5_allm			"Top 5% of respective variable. Main conflict events (no riots-protests), ACLED"
label var top5_allmm		"Top 5% of respective variable. Conflict events (no riots-protests and non-violence), ACLED"
label var top5_battles		"Top 5% of respective variable. Battles, ACLED"
label var top5_vio			"Top 5% of respective variable. Violent events against civilians, ACLED"
label var top5_nonvio		"Top 5% of respective variable. Non-Violent events by conflict actor, ACLED"
label var top5_riots			"Top 5% of respective variable. Riots and Protests, ACLED"
label var top5_fatal		"Top 5% of respective variable. All fatalities, ACLED"
label var top5_allf			"Top 5% of respective variable. All fatal conflict events, ACLED"




** Label UCDP Variables
*******************************************************************************************************
*******************************************************************************************************
label var sum_state_no		"Total Number of State Coflict Events 1989-2010. High-precision. UCDP"
label var sum_onesided_no	"Total Number of One-Sided Civilian Violence Events 1989-2010. UCDP"
label var sum_nonstate_no	"Total Number of Non-State Coflict Events 1989-2010. UCDP"


label var stated			"Indicator (dummy) variable for State Coflict during 1989-2010. UCDP"
label var onesidedd			"Indicator (dummy) variable for One-sided Violence during 1989-2010. UCDP"
label var onesidedd_prec	"Indicator (dummy) variable for One-sided Violence during 1989-2010. UCDP"
label var nonstated			"Indicator (dummy) variable for Non-State Coflict during 1989-2010. UCDP"

label var durucdp_state				"Duration (in years) of state conflict (1989-2010). UCDP"
label var durucdp_nonstate			"Duration (in years) of non-state conflict (1989-2010). UCDP"
label var durucdp_onesided			"Duration (in years) of one-sided violence (1989-2010). UCDP"

label var sum_best_est_st		"Sum of Fatalities (best estimate) of state conflict 1989-2010. UCDP"
label var sum_best_est_os		"Sum of Fatalities (best estimate) of one-sided violence 1989-2010. UCDP"
label var sum_best_est_ns		"Sum of Fatalities (best estimate) of non-state conflict 1989-2010. UCDP"


label var sum_low_est_st		"Sum of Fatalities (low estimate) of state conflict 1989-2010. UCDP"
label var sum_low_est_os		"Sum of Fatalities (low estimate) of one-sided violence 1989-2010. UCDP"
label var sum_low_est_ns		"Sum of Fatalities (low estimate) of non-state conflict 1989-2010. UCDP"

label var sum_high_est_st		"Sum of Fatalities (high estimate) of state conflict 1989-2010. UCDP"
label var sum_high_est_os		"Sum of Fatalities (high estimate) of one-sided violence 1989-2010. UCDP"
label var sum_high_est_ns		"Sum of Fatalities (high estimate) of non-state conflict 1989-2010. UCDP"



** Other
*******************************************************************************************************
*******************************************************************************************************
label var top_sum_best_est_st    	"Top 1% of respective variable (sum_best_st). Fatalities State-Conflict"
label var top5_sum_best_est_st   	"Top 5% of respective variable (sum_best_st). Fatalities State-Conflict"
label var top10_sum_best_est_st    	"Top 10% of respective variable (sum_best_st). Fatalities State-Conflict"

label var top_sum_best_est_ns    	"Top 1% of respective variable (sum_best_ns). Fatalities Non-State-Conflict"
label var top5_sum_best_est_ns   	"Top 5% of respective variable (sum_best_ns). Fatalities Non-State-Conflict"
label var top10_sum_best_est_ns    	"Top 10% of respective variable (sum_best_ns). Fatalities Non-State-Conflict"

label var top_sum_best_est_os    	"Top 1% of respective variable (sum_best_os). Fatalities One-sided Violence"
label var top5_sum_best_est_os   	"Top 5% of respective variable (sum_best_os). Fatalities One-sided Violence"
label var top10_sum_best_est_os    	"Top 10% of respective variable (sum_best_os). Fatalities One-sided Violence"


label var top_sum_state_no    		"Top 1% of respective variable. Number State Conflict Events. UCDP"
label var top5_sum_state_no   		"Top 5% of respective variable. Number State Conflict Events. UCDP"
label var top10_sum_state_no    	"Top 10% of respective variable. Number State Conflict Events. UCDP"

label var top_sum_nonstate_no    	"Top 1% of respective variable. Number Non-State Conflict Events. UCDP"
label var top5_sum_nonstate_no   	"Top 5% of respective variable. Number Nno-State Conflict Events. UCDP"
label var top10_sum_nonstate_no    	"Top 10% of respective variable. Number Non-State Conflict Events. UCDP"

label var top_sum_onesided_no    	"Top 1% of respective variable. Number Onesided Violence  Events. UCDP"
label var top5_sum_onesided_no   	"Top 5% of respective variable. Number Onesided Violence Events. UCDP"
label var top10_sum_onesided_no    	"Top 10% of respective variable. Number Onesided Violence Events. UCDP"
