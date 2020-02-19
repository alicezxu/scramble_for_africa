

use homelands825.dta


***************************************************************************************************************************************************************************************
*** Appendix Table 10. Test of Means and Medians for Main Civil Conflict Measures. 
*** Ethnic Homeland Level Analysis (825 Obs)
***************************************************************************************************************************************************************************************
***************************************************************************************************************************************************************************************
***************************************************************************************************************************************************************************************

** Preliminaries generate top percentile (top 1%) for the main conflict variables
********************************************************************************************************************************


d all battles vio riots state_prec onesided_prec nonstate_prec

foreach var of varlist all battles vio riots state_prec onesided_prec nonstate_prec  { 
	egen top_`var'=pctile(`var'), p(99)
}
********


* Notes
********
*********************************************************************************************************************************
* Note 1: We estimate test of mean with linear regressions so as to estimate double-clustered s.e.
* Note 2: We estimate test of median with quantile (LAD) regression to enable interpretation and estimate clustred s.e. 
* Note 3. Please note that the qreg2 routine does not run when the medians in both split and non-split groups is zero
*********************************************************************************************************************************

*** Test of means. ACLED & UCDP. all homelands. Likelihood Indicator. column (1)
*********************************************************************************************************************************
*********************************************************************************************************************************
cgmreg alld 					split10pc   , cluster(wbcode cluster)
est store tt1

cgmreg batd 					split10pc   , cluster(wbcode cluster)
est store tt2

cgmreg viod 					split10pc   , cluster(wbcode cluster)
est store tt3

cgmreg riotsd 					split10pc   , cluster(wbcode cluster)
est store tt4

cgmreg state_precd 				split10pc   , cluster(wbcode cluster)
est store tt5

cgmreg onesided_precd 			split10pc   , cluster(wbcode cluster)
est store tt6

cgmreg nonstate_precd  			split10pc   , cluster(wbcode cluster)
est store tt7


*** Test of means. ACLED & UCDP. all homelands. Number of Incidents. column (2)
*******************************************************************************************************************************
*******************************************************************************************************************************
cgmreg all 						split10pc   , 		cluster(wbcode cluster)
est store ct1

cgmreg battles 					split10pc   , 		cluster(wbcode cluster)
est store ct2

cgmreg vio 						split10pc   , 		cluster(wbcode cluster)
est store ct3

cgmreg riots 					split10pc   , 		cluster(wbcode cluster)
est store ct4

cgmreg state_prec 				split10pc   , 		cluster(wbcode cluster)
est store ct5

cgmreg onesided_prec 			split10pc   , 		cluster(wbcode cluster)
est store ct6

cgmreg nonstate_prec  			split10pc   , 		cluster(wbcode cluster)
est store ct7

*** Test of medians. ACLED & UCDP. all homelands. Number of Incidents. column (3)
*******************************************************************************************************************************
*******************************************************************************************************************************
qreg2 all 					split10pc   ,  cluster(wbcode)
est store qct1

qreg2 battles 				split10pc   ,  cluster(wbcode)
est store qct2

qreg2 vio 					split10pc   ,  cluster(wbcode)
est store qct3

qreg2 riots 				split10pc   ,  cluster(wbcode)
est store qct4

qreg2 state_prec  			split10pc   ,  cluster(wbcode)
est store qct5

qreg2 onesided_prec 		split10pc   ,  cluster(wbcode)
est store qct6

qreg2 onesided_prec 		split10pc   ,  cluster(wbcode)
est store qct7


*** Test of means. ACLED & UCDP. all homelands. Excluding Capitals. Number of Incidents. column (4)
********************************************************************************************************************************
********************************************************************************************************************************
cgmreg all 						split10pc   if capitald==0, cluster(wbcode cluster)
est store tc1

cgmreg battles 					split10pc   if capitald==0, cluster(wbcode cluster)
est store tc2

cgmreg vio 						split10pc   if capitald==0, cluster(wbcode cluster)
est store tc3

cgmreg riots 					split10pc   if capitald==0, cluster(wbcode cluster)
est store tc4

cgmreg state_prec 				split10pc   if capitald==0, cluster(wbcode cluster)
est store tc5

cgmreg onesided_prec 			split10pc   if capitald==0, cluster(wbcode cluster)
est store tc6

cgmreg nonstate_prec  			split10pc   if capitald==0, cluster(wbcode cluster)
est store tc7

*** Test of medians. ACLED & UCDP. all homelands. Excluding Capitals. Number of Incidents. column (5)
*******************************************************************************************************************************
*******************************************************************************************************************************
qreg2 all 					split10pc   if capitald==0,  cluster(wbcode)
est store qtc1

qreg2 battles 				split10pc   if capitald==0,  cluster(wbcode)
est store qtc2

qreg2 vio 					split10pc   if capitald==0,  cluster(wbcode)
est store qtc3

qreg2 riots 				split10pc   if capitald==0,  cluster(wbcode)
est store qtc4

qreg2 state_prec  			split10pc   if capitald==0,  cluster(wbcode)
est store qtc5

qreg2 onesided_prec 		split10pc   if capitald==0,  cluster(wbcode)
est store qtc6

qreg2 onesided_prec 		split10pc   if capitald==0,  cluster(wbcode)
est store qtc7

*** Test of means. ACLED & UCDP. all homelands. Excluding Outliers. Number of Incidents. column (6)
******************************************************************************************************************************
******************************************************************************************************************************
cgmreg all 						split10pc   if all<top_all						, cluster(wbcode cluster)
est store cc1

cgmreg battles 					split10pc   if battles<top_battles				, cluster(wbcode cluster)
est store cc2

cgmreg vio 						split10pc   if vio<top_vio						, cluster(wbcode cluster)
est store cc3

cgmreg riots 					split10pc   if riots<top_riots					, cluster(wbcode cluster)
est store cc4

cgmreg state_prec 				split10pc   if state_prec<top_state_prec		, cluster(wbcode cluster)
est store cc5

cgmreg onesided_prec 			split10pc   if onesided_prec<top_onesided_prec	, cluster(wbcode cluster)
est store cc6

cgmreg nonstate_prec  			split10pc   if nonstate_prec<top_nonstate_prec	, cluster(wbcode cluster)
est store cc7

*** Test of medians. ACLED & UCDP. all homelands. Excluding Outliers. Number of Incidents. column (7)
*******************************************************************************************************************************
*******************************************************************************************************************************
qreg2 all 					split10pc   if all<top_all==0,  cluster(wbcode)
est store qcc1

qreg2 battles 				split10pc   if battles<top_battles	,  cluster(wbcode)
est store qcc2

qreg2 vio 					split10pc   if vio<top_vio,  cluster(wbcode)
est store qcc3

qreg2 riots 				split10pc   if riots<top_riots,  cluster(wbcode)
est store qcc4

qreg2 state_prec  			split10pc   if state_prec<top_state_prec,  cluster(wbcode)
est store qcc5

qreg2 onesided_prec 		split10pc   if onesided_prec<top_onesided_prec,  cluster(wbcode)
est store qcc6

qreg2 onesided_prec 		split10pc   if nonstate_prec<top_nonstate_prec,  cluster(wbcode)
est store qcc7




***************************************************************************************************************************************************************************************
*** Appendix Table 10. Test of Means and Medians for Main Civil Conflict Measures. 
*** Ethnic Homeland Level Analysis 
***************************************************************************************************************************************************************************************

** Panel A. All Ethnic Homelands (825 Obs.)
*******************************************
*******************************************


*** column (1). Test of means. ACLED & UCDP. all homelands. Likelihood Indicator. 
****************************************************************************************************************************************************************************************
estout tt1 tt2 tt3 tt4 tt5 tt6 tt7			, cells(b(fmt(%9.4f)) se(par) p(fmt(%9.2f))) stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc _cons) style(fixed)

*** column (2). Test of means. ACLED & UCDP. all homelands. Number of Incidents. 
****************************************************************************************************************************************************************************************
estout ct1 ct2 ct3 ct4 ct5 ct6 ct7			, cells(b(fmt(%9.4f)) se(par) p(fmt(%9.2f))) stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc _cons) style(fixed)

*** column (3). Test of medians. ACLED & UCDP. all homelands. Number of Incidents. 
****************************************************************************************************************************************************************************************
estout qct1 qct2 qct3 qct4 qct5 qct6 qct7 	, cells(b(fmt(%9.4f)) se(par) p(fmt(%9.2f))) stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc _cons) style(fixed)

*** column (4). Test of means. ACLED & UCDP. all homelands. No Capitals. Number of Incidents. 
****************************************************************************************************************************************************************************************
estout tc1 tc2 tc3 tc4 tc5 tc6 tc7			, cells(b(fmt(%9.4f)) se(par) p(fmt(%9.2f))) stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc _cons) style(fixed)

*** column (5). Test of medians. ACLED & UCDP. No Capitals. Number of Incidents. 
****************************************************************************************************************************************************************************************
estout qtc1 qtc2 qtc3 qtc4 qtc5 qtc6 qtc7 	, cells(b(fmt(%9.4f)) se(par) p(fmt(%9.2f))) stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc _cons) style(fixed)

*** column (6). Test of means. ACLED & UCDP. all homelands. No Outliers. Number of Incidents. 
****************************************************************************************************************************************************************************************
estout cc1 cc2 cc3 cc4 cc5 cc6 cc7			, cells(b(fmt(%9.4f)) se(par) p(fmt(%9.2f))) stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc _cons) style(fixed)

*** column (7). Test of medians. ACLED & UCDP. No Outliers. Number of Incidents. 
****************************************************************************************************************************************************************************************
estout qcc1 qcc2 qcc3 qcc4 qcc5 qcc6 qcc7 	, cells(b(fmt(%9.4f)) se(par) p(fmt(%9.2f))) stats(r2_a N , fmt(%9.3f %9.0g) labels(adjusted R2)) keep(split10pc _cons) style(fixed)


estimates clear



** To get the test of means/medians for ethnic homelands close to the border:
*****************************************************************************
** (1): drop observatoions close to the border "keep if borddist<=median_bd" 
** (2): rerun the above program 
