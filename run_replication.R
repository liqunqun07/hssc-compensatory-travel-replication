# Cross-platform master entry point for local use and GitHub Actions.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
if (length(file_arg) == 0) {
  stop("Please run this file with Rscript so its location can be detected.")
}

script_path <- normalizePath(sub("^--file=", "", file_arg[1]), mustWork = TRUE)
repo_root <- dirname(script_path)
setwd(repo_root)

source(file.path("code", "install_packages.R"))

rscript <- file.path(R.home("bin"), "Rscript")
run_script <- function(script) {
  status <- system2(rscript, c("--vanilla", script))
  if (!identical(status, 0L)) {
    stop("Replication step failed: ", script)
  }
}

cat("Starting the replication pipeline...\n")
run_script(file.path("code", "run_all.R"))
run_script(file.path("code", "tests", "test_manuscript_concordance.R"))
cat("Replication completed and concordance test passed.\n")
