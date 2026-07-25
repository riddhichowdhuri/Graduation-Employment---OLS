# Determinants of Graduate Unemployment: A Cross-Country OLS Analysis
RIDDHI CHOWDHURI 

---

## 1. Introduction

Graduate unemployment — the inability of tertiary-educated individuals to find work commensurate with their qualifications — is a persistent policy concern across both developed and developing economies. While a country's overall labour market health, macroeconomic stability, and the scale of its higher education system are all plausible drivers, their relative importance is not obvious a priori: a large graduate pool could either signal a skilled, competitive workforce or an oversupply of degree-holders relative to available skilled jobs.

This report investigates whether four commonly cited factors — the Tertiary Enrollment Rate, the Employment-to-Population Ratio, the Inflation Rate, and GDP per capita — help explain cross-country variation in the Graduate Unemployment Rate (GURY).

## 2. Research Question

Do labour-market conditions, macroeconomic conditions, and the scale of higher education jointly and individually predict a country's graduate unemployment rate?

## 3. Data

| Variable | Description |
|---|---|
| `country` | Country name |
| `TER` | Tertiary Enrollment Rate |
| `EPR` | Employment-to-Population Ratio |
| `INF` | Inflation rate |
| `GDPpc` | GDP per capita |
| `GURY` | Graduate Unemployment Rate (dependent variable) |

- **Sample**: 20 countries, single cross-section (one time period).
- **Source**: *(insert citation — e.g. World Bank Open Data, ILOSTAT, OECD.Stat — specify exact year/vintage of pull)*

Descriptive statistics:

| Variable | Obs | Mean | Std. Dev. | Min | Max |
|---|---|---|---|---|---|
| TER | 20 | 84.99 | 26.14 | 21.54 | 165.11 |
| EPR | 20 | 59.21 | 7.05 | 46.00 | 75.79 |
| INF | 20 | 5.11 | 2.35 | 1.63 | 11.53 |
| GDPpc | 20 | 60,937.56 | 26,445.78 | 22,145.26 | 131,407.70 |
| GURY | 20 | 3.64 | 1.68 | 1.28 | 8.15 |

## 4. Methodology

We estimate the following linear model by Ordinary Least Squares:

```
GURY = β₀ + β₁·TER + β₂·EPR + β₃·INF + β₄·GDPpc + ε
```

Following standard practice for small cross-sectional OLS, we run two post-estimation diagnostic checks before interpreting coefficients:

- **Breusch–Pagan / Cook–Weisberg test** — tests whether residual variance is constant (homoskedasticity), a core OLS assumption.
- **Variance Inflation Factor (VIF)** — tests whether regressors are too collinear with one another to separately identify their individual effects.

We also inspect residual-vs-fitted and residual-vs-regressor scatterplots visually, since diagnostic test statistics alone can miss non-linear patterns that a plot reveals directly.

## 5. Results

### 5.1 Model fit

| Statistic | Value |
|---|---|
| R² | 0.706 |
| Adjusted R² | 0.628 |
| F(4, 15) | 9.00 |
| Prob > F | 0.0006 |

The model is statistically significant overall (p = 0.0006), and explains roughly 63% of cross-country variation in graduate unemployment after adjusting for the number of predictors — a reasonably strong fit for a 20-observation cross-section.

### 5.2 Coefficient estimates

| Variable | Coefficient | Std. Error | t | p-value | 95% CI |
|---|---|---|---|---|---|
| TER | 0.0174 | 0.0112 | 1.55 | 0.142 | [−0.0065, 0.0412] |
| EPR | −0.1480 | 0.0364 | −4.07 | **0.001** | [−0.2256, −0.0705] |
| INF | −0.3555 | 0.1090 | −3.26 | **0.005** | [−0.5878, −0.1233] |
| GDPpc | −0.0000012 | 0.0000114 | −0.10 | 0.919 | [−0.0000255, 0.0000231] |
| Constant | 12.816 | 2.914 | 4.40 | **0.001** | [6.604, 19.028] |

### 5.3 Diagnostics

- **Heteroskedasticity**: Breusch–Pagan χ²(1) = 0.15, p = 0.694 → fail to reject H₀ of constant variance. No evidence of heteroskedasticity.
- **Multicollinearity**: Mean VIF = 1.39, with all individual VIFs below 2 (GDPpc: 1.65, TER: 1.55, EPR: 1.19, INF: 1.18). Well below the conventional concern threshold of 10, so multicollinearity is not distorting the coefficient estimates.
- **Residual plots**: Residuals plotted against fitted values and against each regressor (TER, EPR, INF, GDPpc) show no obvious funnel shape or systematic pattern, visually supporting the homoskedasticity conclusion from the formal test.

## 6. Discussion

**Employment-to-Population Ratio** is the strongest and most robust predictor in the model: a higher share of the working-age population in employment is associated with significantly lower graduate unemployment (p = 0.001). This is intuitive — a generally tight labour market should absorb graduates more easily than a slack one.

**Inflation** is also significantly negatively associated with graduate unemployment (p = 0.005). This result deserves caution rather than a causal reading. In a 20-country cross-section, INF may be partly proxying for other unobserved country characteristics correlated with both inflation and labour market tightness (e.g., economies running "hot" tend to have both higher inflation and lower unemployment, a dynamic closer to a short-run Phillips-curve pattern than a stable structural relationship). We do not have the country-level controls needed to rule this out definitively.

**Tertiary Enrollment Rate** and **GDP per capita** are not statistically significant at conventional levels once EPR and INF are controlled for. This does not mean these factors are irrelevant to graduate unemployment in general — it means that, in this particular 20-country sample, we cannot distinguish their effect from zero with the precision this data allows.

## 7. Limitations

- **Small sample (n = 20)**: limits statistical power and makes the model sensitive to individual influential observations; results should be read as suggestive rather than conclusive.
- **Cross-sectional design**: a single time period cannot establish causal direction, and cannot rule out reverse causality (e.g., high graduate unemployment could itself affect enrollment decisions or macro conditions) or omitted country-level confounders (labour market institutions, industry composition, education quality, informal sector size).
- **No country fixed effects or regional controls**: countries at similar income levels may share unobserved institutional features not captured by GDP per capita alone.
- **Data vintage**: results are specific to whatever year(s) the underlying dataset covers; relationships may not generalize to other periods.

## 8. Conclusion

Across this 20-country sample, general labour market tightness (EPR) is the clearest and most statistically robust predictor of lower graduate unemployment, while the role of higher-education scale (TER) and national income (GDPpc) is not distinguishable from zero once labour market and macro conditions are accounted for. The inflation result is suggestive but should not be over-interpreted causally given the cross-sectional design. A natural extension would be a panel version of this model across multiple years, which would allow country and year fixed effects to address several of the limitations noted above.
