# Replication Package: Code & Data Guide

This directory contains the analysis scripts and the manuscript-reporting export used for the anonymous submission:
**"Restriction Intensity, Duration, and Compensatory Travel Intention: A Time-Contingent Test of Boredom and Sensation Seeking"**
Submitted to: *Humanities and Social Sciences Communications* (Springer Nature)

---

## 1. Execution Order & Pipeline

All analysis scripts are fully modularized and written in standard R (version >= 4.0). You can run individual scripts sequentially or execute the master pipeline:

```bash
# Option A: One-click automated reproduction (Recommended)
LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 Rscript run_all.R

# Option B: Step-by-step reproduction
Rscript 00_data_cleaning.R          # Global data processing & variable coding
Rscript 01_table10_11_cfa.R         # Table 10 & 11: CFA Measurement Model, CR, AVE, & Alpha
Rscript 02_table3_4_descriptive.R   # Table 3 & 4: Group differences (t/ANOVA) & Pearson r
Rscript 03_table5_mediation.R       # Table 5: Multi-step chain mediation Bootstrap test
Rscript 04_table6_7_anova.R         # Table 6 & 7: Two-factor ANOVA & mean comparisons
Rscript 05_table9_shanghai_regression.R # Table 9: Standardized subgroup multivariate regression
Rscript 07_table8_duration_regression.R # Table 8: duration-stratified regression
Rscript 06_export_manuscript_tables.R # exact values printed in Manuscript_anonymous.docx
```

---

## 2. Manuscript Table to Code Mapping

| Table / Analysis | Underlying Dataset | Corresponding Script | Output File in `../output/` |
|---|---|---|---|
| **Table 3** (Group Difference Tests: t / ANOVA) | `../data/raw/totaldatas.xlsx` (N=1,047) | `02_table3_4_descriptive.R` | Console output & `table4_correlation_matrix.csv` |
| **Table 4** (Descriptive Statistics & Correlation Matrix) | `../data/raw/totaldatas.xlsx` (N=1,047) | `02_table3_4_descriptive.R` | `table4_correlation_matrix.csv` |
| **Table 5** (Study 1 Chain Mediation Bootstrap Test) | `../data/raw/totaldatas.xlsx` (N=1,047) | `03_table5_mediation.R` | `table5_mediation_bootstrap.csv` |
| **Table 6** (Study 2 Two-Factor ANOVA) | `../data/raw/totaldatas.xlsx` (N=1,045) | `04_table6_7_anova.R` | `table6_anova_BR.csv`, `table6_anova_SE.csv`, `table6_anova_WI.csv` |
| **Table 7** (Strict vs. Loose Cohort Mean Comparisons) | `../data/raw/totaldatas.xlsx` (N=1,045) | `04_table6_7_anova.R` | `table7_means_comparison.csv` |
| **Table 9** (Shanghai Subgroup Duration-Stratified Regression) | `../data/raw/shanghai_data.csv` (N=900) | `05_table9_shanghai_regression.R` | `table9_shanghai_regression_exact.csv` |
| **Table 8** (Strict/home subgroup duration-stratified regression) | `../data/raw/totaldatas.xlsx` (N=1,047) | `07_table8_duration_regression.R` | `table8_duration_regression.csv` |
| **Table 10 & 11** (Measurement Model CFA, CR, AVE, Alpha) | `../data/raw/totaldatas.xlsx` (N=1,047) | `01_table10_11_cfa.R` | `table10_cfa_loadings.csv` |

The `../output/manuscript/table3_reported.csv` through
`table11_reported.csv` files are the exact machine-readable transcription of
the current anonymous manuscript. They are intentionally separate from the
`table*_estimated.csv`/analysis outputs, which are recomputed from the raw
data. This distinction matters because the manuscript contains a few rounded
or internally inconsistent cells (most visibly Table 6 and Table 11); those
cells cannot be recreated by a mathematically single analysis of the supplied
rows without silently changing data.

The corrected data definitions are now explicit in `00_data_cleaning.R`:
age code `>=3` is the 26+ group, and duration uses `period + 1` so the first
day is counted. Table 8 reports standardized beta coefficients with raw-scale
standard errors, matching the manuscript convention.

To verify the delivery, run from this `code` directory:

```bash
LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 Rscript run_all.R
LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 Rscript tests/test_manuscript_concordance.R
```

From the package root, use `Rscript --vanilla run_replication.R`; this entry point checks/installs the required packages, runs the full pipeline, and then runs the concordance test.

---

## 3. Required R Packages

Ensure the following packages are installed prior to execution:
```r
install.packages(c("readxl", "dplyr", "lavaan", "psych", "broom"))
```
