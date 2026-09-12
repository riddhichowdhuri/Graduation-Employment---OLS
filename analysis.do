*==============================================================================
* Project   : Graduate Unemployment Rate — Cross-Country OLS Analysis
* File      : analysis.do
* Data      : data/ecotrix_data.csv  (20 countries, cross-sectional)
* Author    : Group B2
* Purpose   : Reproducible do-file for the regression, diagnostics, and
*             graphs reported in the write-up. Reconstructed and cleaned
*             from the original session log (Group_B2.log).
*==============================================================================

clear all
set more off

*------------------------------------------------------------------------
* 1. Import data
*    Update the path below to point to the data file on your machine,
*    or run from the repo root so the relative path resolves.
*------------------------------------------------------------------------
import delimited "data/ecotrix_data.csv", clear varnames(1)

* Rename to match original variable names used throughout the analysis
rename gdppc GDPpc
rename gury  GURY

*------------------------------------------------------------------------
* 2. Label variables
*------------------------------------------------------------------------
label variable TER   "Tertiary Enrollment Rate"
label variable EPR   "Employment to Population ratio"
label variable INF   "Inflation"
label variable GDPpc "GDP per capita"
label variable GURY  "Graduate Unemployment Rate"

describe
summarize TER EPR INF GDPpc GURY

*------------------------------------------------------------------------
* 3. OLS regression
*    GURY = b0 + b1*TER + b2*EPR + b3*INF + b4*GDPpc + u
*------------------------------------------------------------------------
regress GURY TER EPR INF GDPpc

* Store results for reference / export
estimates store main_model

*------------------------------------------------------------------------
* 4. Diagnostics
*------------------------------------------------------------------------
* Heteroskedasticity: Breusch-Pagan / Cook-Weisberg
estat hettest

* Multicollinearity: Variance Inflation Factors
estat vif

* Fitted values and residuals
predict yhat, xb
predict resid, resid

*------------------------------------------------------------------------
* 5. Diagnostic and relationship graphs
*------------------------------------------------------------------------
scatter resid yhat, ///
    title("Residuals vs Fitted Values") ///
    ytitle("Residuals") xtitle("Fitted values")
graph export "output/graph_residual_vs_fitted.png", as(png) replace

twoway (scatter GURY TER) (lfit GURY TER), ///
    title("GURY vs Tertiary Enrollment Rate") legend(off)
graph export "output/graph_fitted_vs_TER.png", as(png) replace

twoway (scatter GURY EPR) (lfit GURY EPR), ///
    title("GURY vs Employment to Population Ratio") legend(off)
graph export "output/graph_fitted_vs_EPR.png", as(png) replace

twoway (scatter GURY INF) (lfit GURY INF), ///
    title("GURY vs Inflation") legend(off)
graph export "output/graph_fitted_vs_INF.png", as(png) replace

twoway (scatter GURY GDPpc) (lfit GURY GDPpc), ///
    title("GURY vs GDP per capita") legend(off)
graph export "output/graph_fitted_vs_GDPpc.png", as(png) replace

*------------------------------------------------------------------------
* 6. Save the working dataset
*------------------------------------------------------------------------
save "output/stata_work_b2.dta", replace

*==============================================================================
* End of do-file
*==============================================================================
