
*** Load epr_times_series_upload.dta
clear
use "Your Folder\epr_times_series_upload.dta"
*** Preliminaries
**
gen ewar_onset= newethonset

*******

global simple			lnpop60 lnkm2split  lakedum riverdum
global location 		capital borderdist1 capdistance1 seadist1 coastal 
global geo	 			mean_elev mean_suit diamondd malariasuit petroleum island city1400 
global rich1 			lnpop60 lnkm2split  lakedum riverdum capital borderdist1 capdistance1 seadist1 coastal mean_elev mean_suit diamondd malariasuit petroleum island city1400 
********

tssmooth ma ex5=excluded, window (5 0 0)
gen ex5b=0
replace ex5b=1 if ex5>0 & ex5!=.
label var ex5b "equals 1 if the group has been excluded from govt any of the last 5 years"

label var idmur "country-name in Murdock (1959) Map"
label var mur "country-name in Murdock (1959) Map; numeric"
label var malaria "climatic conditions favorable (suitability) for malaria"

****************************

tssmooth ma ex3=excluded, window (3 0 0)
gen ex3b=0
replace ex3b=1 if ex3>0 & ex3!=.
label var ex3b "equals 1 if the group has been excluded from govt any of the last 3 years"

g split10pc_ex3b = split10pc*ex3b
g split10pc_ex5b = split10pc*ex5b

g split5pc_ex3b = split5pc*ex3b
g split5pc_ex5b = split5pc*ex5b


**************************
** Table 34A: Columns 3-8
**************************
xi: areg ewar_onset split10pc                     $rich1  i.year if ex3b ==1 ,a( wbcode )  cluster(group)
est store p1

xi: areg ewar_onset split10pc                     $rich1  i.year if ex3b ==0 ,a( wbcode )  cluster(group)
est store p2

xi: areg ewar_onset split10pc ex3b split10pc_ex3b $rich1  i.year             ,a( wbcode )  cluster(group)
est store p3

xi: areg ewar_onset split10pc                     $rich1  i.year if ex5b ==1 ,a( wbcode )  cluster(group)
est store p4

xi: areg ewar_onset split10pc                     $rich1  i.year if ex5b ==0 ,a( wbcode )  cluster(group)
est store p5

xi: areg ewar_onset split10pc ex5b split10pc_ex5b $rich1  i.year             ,a( wbcode )  cluster(group)
est store p6


** all specifications: rich set of countrols country fixed-effects and year fixed effects
** Columns 1, 4: groups excluded from political power in national government
** Columns 2, 5: groups excluded from political power in national government
** Columns 3, 6: all groups
** even column: included
*****************************************************************************************
estout p1 p2 p3 p4 p5 p6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels( adjusted-R2 Obs)) keep(split10pc ex3b ex5b split10pc_ex3b split10pc_ex5b) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	   

	   
	   

**************************
** Table 34B: Columns 3-8
**************************
xi: areg ewar_onset split5pc                     $rich1  i.year if ex3b ==1 ,a( wbcode )  cluster(group)
est store pp1

xi: areg ewar_onset split5pc                     $rich1  i.year if ex3b ==0 ,a( wbcode )  cluster(group)
est store pp2

xi: areg ewar_onset split5pc ex3b split5pc_ex3b $rich1  i.year             ,a( wbcode )  cluster(group)
est store pp3

xi: areg ewar_onset split5pc                     $rich1  i.year if ex5b ==1 ,a( wbcode )  cluster(group)
est store pp4

xi: areg ewar_onset split5pc                     $rich1  i.year if ex5b ==0 ,a( wbcode )  cluster(group)
est store pp5

xi: areg ewar_onset split5pc ex5b split5pc_ex5b $rich1  i.year             ,a( wbcode )  cluster(group)
est store pp6


** all specifications: rich set of countrols country fixed-effects and year fixed effects
** Columns 1, 4: groups excluded from political power in national government
** Columns 2, 5: groups excluded from political power in national government
** Columns 3, 6: all groups
** even column: included
*****************************************************************************************
estout pp1 pp2 pp3 pp4 pp5 pp6, cells(b(star fmt(%9.4f)) se(par) t(fmt(%9.2f)))   ///
       stats(r2_a N , fmt(%9.3f %9.0g) labels( adjusted-R2 Obs)) keep(split5pc ex3b ex5b split5pc_ex3b split5pc_ex5b) starlevels(* 0.1 ** 0.05  *** 0.01) style(fixed)
	  
