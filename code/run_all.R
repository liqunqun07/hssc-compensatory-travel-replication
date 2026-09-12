# =============================================================
# run_all.R
# 一键自动运行全部论文实证复现脚本
# =============================================================

# 允许从任意目录调用本脚本；默认切换到本文件所在的 code/ 目录。
args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
if (length(file_arg) > 0) {
  script_path <- normalizePath(sub("^--file=", "", file_arg[1]), mustWork = TRUE)
  setwd(dirname(script_path))
}

cat("========================================================\n")
cat("正在启动论文全部实证结果一键复现流程...\n")
cat("========================================================\n")

scripts <- c(
  "00_data_cleaning.R",
  "01_table10_11_cfa.R",
  "02_table3_4_descriptive.R",
  "03_table5_mediation.R",
  "04_table6_7_anova.R",
  "05_table9_shanghai_regression.R",
  "07_table8_duration_regression.R",
  "06_export_manuscript_tables.R"
)

for (s in scripts) {
  cat(paste0("\n--------------------------------------------------------\n"))
  cat(paste0(">>> 执行脚本: ", s, " <<<\n"))
  cat(paste0("--------------------------------------------------------\n"))
  source(s)
}

cat("\n========================================================\n")
cat("【复现完成】重新估计结果已输出至 ../output/；匿名稿锁定值位于 ../output/manuscript/。\n")
cat("========================================================\n")
