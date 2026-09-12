"""
Reproduces the Stata regression in scripts/analysis.do using Python,
and generates all diagnostic + relationship plots for the repo.
Not a required part of the analysis (Stata is the source of truth) —
this exists purely to regenerate output/graphs/*.png reproducibly
without needing a Stata license.
"""
import pandas as pd
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt

df = pd.read_csv("/home/claude/fixed_repo/data/ecotrix_data.csv")

X = df[["TER", "EPR", "INF", "GDPpc"]]
X = sm.add_constant(X)
y = df["GURY"]

model = sm.OLS(y, X).fit()
print(model.summary())

df["yhat"] = model.fittedvalues
df["resid"] = model.resid

# Breusch-Pagan test
from statsmodels.stats.diagnostic import het_breuschpagan
bp_test = het_breuschpagan(model.resid, model.model.exog)
print("\nBreusch-Pagan test: LM stat=%.4f, LM p-value=%.4f, F-stat=%.4f, F p-value=%.4f" % bp_test)

# VIF
from statsmodels.stats.outliers_influence import variance_inflation_factor
vif_data = pd.DataFrame()
vif_data["Variable"] = X.columns
vif_data["VIF"] = [variance_inflation_factor(X.values, i) for i in range(X.shape[1])]
print("\nVIF:\n", vif_data)

plt.rcParams.update({"figure.dpi": 150, "font.size": 10})

# 1. Residuals vs fitted
plt.figure(figsize=(6, 4.5))
plt.scatter(df["yhat"], df["resid"], color="#2c3e50")
plt.axhline(0, color="red", linestyle="--", linewidth=1)
plt.xlabel("Fitted values")
plt.ylabel("Residuals")
plt.title("Residuals vs Fitted Values")
plt.tight_layout()
plt.savefig("/home/claude/fixed_repo/output/graphs/graph_residual_vs_fitted.png")
plt.close()

# 2-5. Residuals vs each regressor (matches original repo's resid_vs_X.jpg files)
for var in ["TER", "EPR", "INF", "GDPpc"]:
    plt.figure(figsize=(6, 4.5))
    plt.scatter(df[var], df["resid"], color="#2c3e50")
    plt.axhline(0, color="red", linestyle="--", linewidth=1)
    plt.xlabel(var)
    plt.ylabel("Residuals")
    plt.title(f"Residuals vs {var}")
    plt.tight_layout()
    plt.savefig(f"/home/claude/fixed_repo/output/graphs/resid_vs_{var}.png")
    plt.close()

# 6-9. GURY vs each regressor with fitted line (matches analysis.do's twoway lfit graphs)
for var in ["TER", "EPR", "INF", "GDPpc"]:
    plt.figure(figsize=(6, 4.5))
    plt.scatter(df[var], df["GURY"], color="#2c3e50", label="Observed")
    z = np.polyfit(df[var], df["GURY"], 1)
    xs = np.linspace(df[var].min(), df[var].max(), 100)
    plt.plot(xs, np.polyval(z, xs), color="#e74c3c", label="Linear fit")
    plt.xlabel(var)
    plt.ylabel("GURY")
    plt.title(f"GURY vs {var}")
    plt.legend()
    plt.tight_layout()
    plt.savefig(f"/home/claude/fixed_repo/output/graphs/graph_fitted_vs_{var}.png")
    plt.close()

print("\nAll plots saved to output/graphs/")
