# Determinants of Graduate Unemployment: A Cross-Country OLS Analysis

Cross-country OLS analysis of graduate unemployment determinants: tertiary enrollment, labour market conditions, and macroeconomic indicators, with full diagnostic testing in Stata.

## Research question
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

- **Sample:** 20 countries, cross-sectional (single time period)
- **Source:** World Bank WDI, ILOSTAT, OECD.

## Headline result
The model explains ~70.6% of cross-country variation in graduate unemployment (R² = 0.706, Adj. R² = 0.628; F(4,15) = 9.00, p = 0.0006). EPR and inflation are significant negative predictors (p = 0.001 and p = 0.005); tertiary enrollment and GDP per capita are not significant in this sample. No evidence of heteroskedasticity or multicollinearity.

Full coefficient table, diagnostics, and discussion: see [`REPORT.md`](REPORT.md).

## Repository structure
```
├── README.md                     # this file
├── REPORT.md                     # full write-up: results, diagnostics, interpretation, limitations
├── LICENSE
├── data/
│   └── ecotrix_data.csv          # cleaned cross-country dataset
├── scripts/
│   ├── analysis.do               # Stata do-file: import, regress, diagnostics, graphs
│   └── reproduce_and_plot.py     # Python reproduction (no Stata license needed) — regenerates output/graphs/
└── output/
    ├── regression_summary.md     # results as formatted tables
    └── graphs/                   # residual diagnostics + GURY-vs-regressor plots
```

## How to reproduce
**With Stata:**
```stata
cd "path/to/this/repo"
do "scripts/analysis.do"
```
**Without Stata (Python check / regenerate plots):**
```bash
pip install pandas numpy statsmodels matplotlib
python3 scripts/reproduce_and_plot.py
```
Both reproduce the same coefficients (verified to 3+ decimal places).

## Author
Riddhi Chowdhuri
