# Install the CRAN packages required by the replication pipeline.
# This script is safe to source locally or from GitHub Actions.

required <- c("readxl", "dplyr", "lavaan", "psych", "broom")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing) > 0) {
  options(repos = c(CRAN = "https://cloud.r-project.org"))
  install.packages(missing)
}

remaining <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
if (length(remaining) > 0) {
  stop("Required R packages could not be installed: ", paste(remaining, collapse = ", "))
}

cat("R package check passed: ", paste(required, collapse = ", "), "\n", sep = "")
