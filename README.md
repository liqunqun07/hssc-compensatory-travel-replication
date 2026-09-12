# Manuscript Data and Code Replication Package

This repository contains the data and analysis code supporting the manuscript:

*Restriction Intensity, Duration, and Compensatory Travel Intention: A Time-Contingent Test of Boredom and Sensation Seeking*

## Run the analyses

On macOS, double-click `run_replication.command`.

From a terminal:

```bash
Rscript --vanilla run_replication.R
```

The workflow requires R (>= 4.0) and installs/checks `readxl`, `dplyr`, `lavaan`, `psych`, and `broom`. It runs the complete analysis pipeline and the manuscript-concordance test.

GitHub Actions can run the same pipeline: open **Actions**, select **Reproduce manuscript analyses**, and choose **Run workflow**.

## Contents

- `data/raw/`: screened, de-identified analysis datasets.
- `data/questionnaire/`: Chinese questionnaire instruments.
- `data/*CODEBOOK*`: variable definitions and coding information.
- `code/`: analysis scripts, package installer, and concordance test.
- `output/`: regenerated estimates and manuscript-reporting tables.
- `run_replication.R`: cross-platform master entry point.
- `run_replication.command`: macOS double-click entry point.
- `.github/workflows/replication.yml`: GitHub Actions workflow.

## Study background

The study examines restriction intensity, restriction duration, boredom, sensation seeking, and compensatory travel intention. The questionnaires were distributed through Wenjuanxing (问卷星) and Jianshu (见数) to residents in Chinese cities experiencing COVID-19-related restrictions between 30 November 2021 and 30 January 2022. The main dataset contains N = 1,047 respondents, and the independent Shanghai duration-tracking dataset contains N = 900 respondents.

Before analysis, excessively short completion responses and duplicate submissions had already been excluded. The uploaded datasets are de-identified copies with participant contact responses, survey identifiers, exact longitude/latitude, and detailed location information removed.
