# Report: Determinants of Graduate Unemployment

## Overview
This project examines whether a country's tertiary education enrollment, employment-to-population ratio, inflation rate, and GDP per capita help explain cross-country variation in the graduate unemployment rate. Using a 20-country cross-section, we estimate an OLS regression and test the model for two standard econometric concerns — heteroskedasticity and multicollinearity — before interpreting the results.

## Methodology
We estimate:

```
GURY = β0 + β1·TER + β2·EPR + β3·INF + β4·GDPpc + ε
```

by OLS, then run standard post-estimation diagnostics:
- **Breusch–Pagan/Cook–Weisberg test** for heteroskedasticity
- **Variance Inflation Factor (VIF)** for multicollinearity
- **Residual-vs-fitted and residual-vs-regressor plots** for functional form / outlier checks

Full reproducible code: [`scripts/analysis.do`](scripts/analysis.do) (Stata) and [`scripts/reproduce_and_plot.py`](scripts/reproduce_and_plot.py) (Python cross-check).

## Descriptive statistics

| Variable | Obs | Mean | Std. Dev. | Min | Max |
|---|---|---|---|---|---|
| TER | 20 | 84.99 | 26.14 | 21.54 | 165.11 |
| EPR | 20 | 59.21 | 7.05 | 46.00 | 75.79 |
| INF | 20 | 5.11 | 2.35 | 1.63 | 11.53 |
| GDPpc | 20 | 60,937.56 | 26,445.78 | 22,145.26 | 131,407.68 |
| GURY | 20 | 3.64 | 1.68 | 1.28 | 8.15 |

## Results

**Model fit:** R² = 0.706, Adjusted R² = 0.628, F(4,15) = 9.00, p = 0.0006 — the model as a whole is statistically significant.

| Variable | Coefficient | Std. Error | t | p-value | Significant? |
|---|---|---|---|---|---|
| TER | 0.0174 | 0.0112 | 1.55 | 0.142 | No |
| EPR | -0.1480 | 0.0364 | -4.07 | 0.001 | Yes (1%) |
| INF | -0.3555 | 0.1090 | -3.26 | 0.005 | Yes (1%) |
| GDPpc | -0.0000012 | 0.0000114 | -0.10 | 0.919 | No |
| Constant | 12.816 | 2.914 | 4.40 | 0.001 | Yes (1%) |

**Diagnostics:**
- Breusch–Pagan test (Stata `estat hettest`): χ²(1) = 0.15, p = 0.694 → fail to reject constant variance; no evidence of heteroskedasticity.
- Mean VIF = 1.39, all individual VIFs < 2 → no meaningful multicollinearity.
- The Python cross-check (`reproduce_and_plot.py`) reproduces identical coefficients, standard errors, R², and F-statistic. It reports its own Breusch–Pagan p-value (0.587) using a different LM-based test formulation than Stata's `hettest`; both agree on the substantive conclusion (no heteroskedasticity).

## Interpretation
- **Employment-to-Population Ratio (EPR)** is negatively and significantly associated with graduate unemployment: countries with a higher share of the working-age population employed tend to have lower graduate unemployment, consistent with tighter overall labour markets absorbing graduates more easily.
- **Inflation (INF)** is also negatively and significantly associated with graduate unemployment in this sample. This is worth discussing rather than taking at face value — it could reflect a Phillips-curve-type relationship, but could equally reflect confounding factors not captured in this small cross-section (e.g., countries with stronger nominal growth also tend to have tighter labour markets). We flag this as a pattern in the data, not a causal claim.
- **Tertiary Enrollment Rate (TER)** and **GDP per capita (GDPpc)** are not statistically significant at conventional levels in this sample — we cannot reject the possibility that they have no linear relationship with graduate unemployment once the other variables are controlled for.
- Diagnostics support the model: residuals show no significant heteroskedasticity, and regressors are not problematically collinear.

## Graphs
All plots are in [`output/graphs/`](output/graphs/):
- `graph_residual_vs_fitted.png` — residuals vs. fitted values
- `resid_vs_TER.png`, `resid_vs_EPR.png`, `resid_vs_INF.png`, `resid_vs_GDPpc.png` — residuals vs. each regressor
- `graph_fitted_vs_TER.png`, `graph_fitted_vs_EPR.png`, `graph_fitted_vs_INF.png`, `graph_fitted_vs_GDPpc.png` — GURY vs. each regressor with a linear fit

## Limitations
- **Small sample (n = 20):** cross-country OLS with only 20 observations has limited statistical power; results should be read as suggestive, not definitive.
- **Cross-sectional design:** a single time period cannot establish causal direction or rule out omitted country-level factors (e.g., labour market institutions, education quality) that could confound the TER/GURY or INF/GURY relationships.
- **Omitted variable risk:** factors like labour market regulation, industry composition, or the strictness of each country's "graduate" definition are not controlled for and could bias the coefficients shown above.
- **Scale/definition comparability:** TER and GDPpc are measured on very different scales across countries with differing national statistical conventions, which is a caveat for direct coefficient comparison.
