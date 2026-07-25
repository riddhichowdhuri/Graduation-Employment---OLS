*==============================================================
* Project: Determinants of Graduate Unemployment — Cross-Country OLS
* Group: B2
* Course: Econometrics
* Description:
*   Examines whether tertiary enrollment, employment-to-population
*   ratio, inflation, and GDP per capita predict the graduate
*   unemployment rate (GURY) across a 20-country cross-section.
*==============================================================

* --- Load data ---
import excel "data/Ecotrix_Data.xlsx", sheet("Sheet1") firstrow clear

* --- Inspect structure ---
describe
summarize

* --- Label variables for clarity ---
label variable EPR   "Employment to Population ratio"
label variable GDPpc "GDP per capita"
label variable GURY  "Graduate Unemployment Rate"
label variable INF   "Inflation"
label variable TER   "Tertiary Enrollment Rate"

describe
summarize

* --- Main OLS regression ---
regress GURY TER EPR INF GDPpc

* --- Diagnostics ---
* Heteroskedasticity: Breusch-Pagan/Cook-Weisberg test
estat hettest

* Predicted values and residuals
predict yhat
predict resid, resid

* Residual diagnostic plots
scatter resid yhat
graph save "Graph" "output/graphs/resid_vs_fitted.gph", replace

scatter resid TER
graph save "Graph" "output/graphs/resid_vs_TER.gph", replace

scatter resid EPR
graph save "Graph" "output/graphs/resid_vs_EPR.gph", replace

scatter resid INF
graph save "Graph" "output/graphs/resid_vs_INF.gph", replace

scatter resid GDPpc
graph save "Graph" "output/graphs/resid_vs_GDPpc.gph", replace

* Multicollinearity: Variance Inflation Factor
estat vif

* --- Save working dataset ---
save "data/Stata_Work_B2.dta", replace

log close
