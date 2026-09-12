# =============================================================
# 03_table5_mediation.R
# Study 1：情境限制措施对旅游意愿的多重链式中介效应检验（Bootstrap）
# 对应手稿 Table 5
# =============================================================

source("00_data_cleaning.R")
suppressPackageStartupMessages({
  library(lavaan)
  library(dplyr)
})

df <- load_and_clean_total()
set.seed(20250110)

run_mediation_analysis <- function(iv_var, iv_label, n_boot = 1000) {
  cat(paste0("\n>>> 正在运行中介模型检验: ", iv_label, " (Bootstrap = ", n_boot, ") <<<\n"))
  
  sub_data <- df %>%
    select(IV = all_of(iv_var), BR, SE, WI, tourtime_num, age_binary, education_num, gender_binary) %>%
    na.omit()
    
  model_syntax <- '
    BR ~ a1*IV + tourtime_num + age_binary + education_num + gender_binary
    SE ~ a2*IV + d*BR + tourtime_num + age_binary + education_num + gender_binary
    WI ~ cp*IV + b1*BR + b2*SE + tourtime_num + age_binary + education_num + gender_binary
    
    # 间接路径
    ind1 := a1 * b1               # IV -> BR -> WI
    ind2 := a2 * b2               # IV -> SE -> WI
    ind3 := a1 * d * b2           # IV -> BR -> SE -> WI (链式中介)
    total_ind := ind1 + ind2 + ind3
  '
  
  fit <- sem(model_syntax, data = sub_data, se = "bootstrap", bootstrap = n_boot)
  res <- parameterEstimates(fit, boot.ci.type = "perc", level = 0.95) %>%
    filter(label %in% c("ind1", "ind2", "ind3", "total_ind")) %>%
    select(Path = label, Point_Est = est, SE = se, CI_Lower = ci.lower, CI_Upper = ci.upper, pvalue) %>%
    mutate(IV = iv_label)
    
  return(res)
}

iv_list <- list(
  c("community_block", "Community block"),
  c("workplace_closed", "Closed management of workplace"),
  c("home_based", "Work or study at home"),
  c("entertain_closed", "Closure of entertainment venues")
)

all_mediation_res <- list()
for (item in iv_list) {
  res <- run_mediation_analysis(item[1], item[2], n_boot = 1000)
  print(res)
  all_mediation_res[[item[2]]] <- res
}

final_df <- bind_rows(all_mediation_res)
dir.create("../output", showWarnings = FALSE)
write.csv(final_df, "../output/table5_mediation_bootstrap.csv", row.names = FALSE)
cat("\n已保存中介结果至 ../output/table5_mediation_bootstrap.csv\n")
