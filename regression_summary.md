# Regression Results — Graduate Unemployment Rate

**Model:** `GURY = β0 + β1·TER + β2·EPR + β3·INF + β4·GDPpc + u`
**Sample:** 20 countries, cross-sectional
**Method:** OLS (Stata `regress`)

## Descriptive statistics

| Variable | Obs | Mean | Std. Dev. | Min | Max |
|---|---|---|---|---|---|
| TER (Tertiary Enrollment Rate) | 20 | 84.99 | 26.14 | 21.54 | 165.11 |
| EPR (Employment-to-Population Ratio) | 20 | 59.21 | 7.05 | 46.00 | 75.79 |
| INF (Inflation) | 20 | 5.11 | 2.35 | 1.63 | 11.53 |
| GDPpc (GDP per capita) | 20 | 60,937.56 | 26,445.78 | 22,145.26 | 131,407.68 |
| GURY (Graduate Unemployment Rate) | 20 | 3.64 | 1.68 | 1.28 | 8.15 |

## Model fit

| Statistic | Value |
|---|---|
| F(4, 15) | 9.00 |
| Prob > F | 0.0006 |
| R-squared | 0.7059 |
| Adj R-squared | 0.6275 |
| Root MSE | 1.0244 |

## Coefficients

| Variable | Coef. | Std. Err. | t | P>\|t\| | 95% CI |
|---|---|---|---|---|---|
| TER | 0.0174 | 0.0112 | 1.55 | 0.142 | [-0.0065, 0.0412] |
| EPR | -0.1480 | 0.0364 | -4.07 | **0.001** | [-0.2256, -0.0705] |
| INF | -0.3555 | 0.1090 | -3.26 | **0.005** | [-0.5878, -0.1233] |
| GDPpc | -0.0000012 | 0.0000114 | -0.10 | 0.919 | [-0.0000255, 0.0000231] |
| Constant | 12.8160 | 2.9143 | 4.40 | 0.001 | [6.6043, 19.0277] |

**Interpretation**
- EPR and INF are statistically significant predictors of GURY at the 1% level, both with a negative sign: a one-point rise in the employment-to-population ratio is associated with a 0.148-point fall in graduate unemployment, and a one-point rise in inflation is associated with a 0.356-point fall.
- TER (tertiary enrollment) and GDPpc are not statistically significant in this sample (p = 0.142 and p = 0.919 respectively).
- The model explains about 70.6% of the variation in GURY across the 20 countries (R² = 0.706), or 62.8% after adjusting for the number of predictors.

## Diagnostics

**Heteroskedasticity — Breusch-Pagan / Cook-Weisberg test**
- H0: constant variance
- chi2(1) = 0.15, Prob > chi2 = 0.6942
- Fails to reject H0 → no evidence of heteroskedasticity; OLS standard errors are valid as-is.

**Multicollinearity — Variance Inflation Factors**

| Variable | VIF | 1/VIF |
|---|---|---|
| GDPpc | 1.65 | 0.607 |
| TER | 1.55 | 0.647 |
| EPR | 1.19 | 0.839 |
| INF | 1.18 | 0.846 |
| **Mean VIF** | **1.39** | |

All VIFs are well below the conventional threshold of 5–10 → multicollinearity is not a concern.

## Graphs

Exported to this folder by `scripts/analysis.do`:
- `graph_residual_vs_fitted.png` — residuals vs. fitted values (checks linearity/homoskedasticity)
- `graph_fitted_vs_TER.png`
- `graph_fitted_vs_EPR.png`
- `graph_fitted_vs_INF.png`
- `graph_fitted_vs_GDPpc.png`
