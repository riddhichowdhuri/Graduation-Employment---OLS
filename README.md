# Determinants of Graduate Unemployment: A Cross-Country OLS Analysis

**Course project — Econometrics (Group B2)**

## Overview

This project examines whether a country's tertiary education enrollment, employment-to-population ratio, inflation rate, and GDP per capita help explain cross-country variation in the **graduate unemployment rate**. Using a 20-country cross-section, we estimate an OLS regression and test the model for two standard econometric concerns — heteroskedasticity and multicollinearity — before interpreting the results.

## Research Question

Do labour-market conditions (employment-to-population ratio), macroeconomic conditions (inflation, GDP per capita), and the scale of higher education (tertiary enrollment) predict how high a country's graduate unemployment rate is?

## Data

| Variable | Description |
|---|---|
| `country` | Country name |
| `TER` | Tertiary Enrollment Rate |
| `EPR` | Employment-to-Population Ratio |
| `INF` | Inflation rate |
| `GDPpc` | GDP per capita |
| `GURY` | Graduate Unemployment Rate (dependent variable) |

- **Sample**: 20 countries, cross-sectional (single time period)
- **Source**: `data/Ecotrix_Data.xlsx` *(add your original source citation here — e.g. World Bank, ILO, OECD — before publishing the repo)*

## Methodology

We estimate:

```
GURY = β₀ + β₁·TER + β₂·EPR + β₃·INF + β₄·GDPpc + ε
```

by OLS, then run standard post-estimation diagnostics:
- **Breusch–Pagan/Cook–Weisberg test** for heteroskedasticity
- **Variance Inflation Factor (VIF)** for multicollinearity
- **Residual-vs-fitted and residual-vs-regressor plots** for functional form / outlier checks

Full reproducible code: [`scripts/analysis.do`](scripts/analysis.do)

## Results

**Model fit**: R² = 0.706, Adjusted R² = 0.628, F(4,15) = 9.00, p = 0.0006 — the model as a whole is statistically significant.

| Variable | Coefficient | Std. Error | t | p-value | Significant? |
|---|---|---|---|---|---|
| TER | 0.0174 | 0.0112 | 1.55 | 0.142 | No |
| EPR | −0.1480 | 0.0364 | −4.07 | 0.001 | **Yes (1%)** |
| INF | −0.3555 | 0.1090 | −3.26 | 0.005 | **Yes (1%)** |
| GDPpc | −0.0000012 | 0.0000114 | −0.10 | 0.919 | No |
| Constant | 12.816 | 2.914 | 4.40 | 0.001 | **Yes (1%)** |

**Diagnostics**:
- Breusch–Pagan test: χ²(1) = 0.15, p = 0.694 → fail to reject constant variance; **no evidence of heteroskedasticity**.
- Mean VIF = 1.39 (all variables < 2) → **no meaningful multicollinearity**.

## Interpretation

- **Employment-to-Population Ratio (EPR)** is negatively and significantly associated with graduate unemployment: countries with a higher share of the working-age population employed tend to have lower graduate unemployment, consistent with tighter overall labour markets absorbing graduates more easily.
- **Inflation (INF)** is also negatively and significantly associated with graduate unemployment in this sample. This is worth discussing rather than taking at face value — it could reflect a Phillips-curve-type relationship, but could equally reflect confounding factors not in this small cross-section (e.g., countries with strong nominal growth also tend to have tighter labour markets). We flag this as a limitation, not a causal claim.
- **Tertiary Enrollment Rate (TER)** and **GDP per capita (GDPpc)** are not statistically significant at conventional levels in this sample — we cannot reject the possibility that they have no linear relationship with graduate unemployment once the other variables are controlled for.
- Diagnostics support the model: residuals show no significant heteroskedasticity, and regressors are not problematically collinear.

## Limitations

- **Small sample (n = 20)**: cross-country OLS with only 20 observations has limited statistical power; results should be read as suggestive, not definitive.
- **Cross-sectional design**: a single time period cannot establish causal direction or rule out omitted country-level factors (e.g., labour market institutions, education quality) that could confound the TER/GURY or INF/GURY relationships.
- **Omitted variable risk**: factors like labour market regulation, industry composition, or education quality are not controlled for and could bias the coefficients shown above.

## Repository Structure

```
├── README.md
├── data/
│   └── Ecotrix_Data.xlsx        # raw dataset (add source citation)
├── scripts/
│   └── analysis.do              # full reproducible Stata do-file
└── output/
    └── graphs/                  # residual diagnostic plots
```

## How to Reproduce

1. Open Stata.
2. Set your working directory to the repository root.
3. Run `scripts/analysis.do`.

## Authors

Riddhi Chowdhuri
