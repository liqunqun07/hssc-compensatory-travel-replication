# =============================================================
# 05_table9_shanghai_regression.R
# Study 2：上海独立样本分时段多元回归分析（精确复现 Table 9）
# 数据源：../data/shanghai_data.csv (N=900)
# =============================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(broom)
})

cat("正在载入上海独立问卷数据集 (N=900)...\n")
sh_path <- if (file.exists("../data/raw/shanghai_data.csv")) {
  "../data/raw/shanghai_data.csv"
} else if (file.exists("../data/shanghai_data.csv")) {
  "../data/shanghai_data.csv"
} else {
  "data/raw/shanghai_data.csv"
}
sh <- read.csv(sh_path, fileEncoding = "UTF-8")

# 1. 题项转数值并计算构念均值
scale_cols <- c("BR1","BR2","BR3","BR4","BR5","SE1","SE2","SE3","SE4","SE5","SE6","WI1","WI2","WI3")
for (c in scale_cols) {
  sh[[c]] <- as.numeric(sh[[c]])
}
sh$BR <- rowMeans(sh[, paste0("BR", 1:5)])
sh$SE <- rowMeans(sh[, paste0("SE", 1:6)])
sh$WI <- rowMeans(sh[, paste0("WI", 1:3)])

# 2. 控制变量处理
sh$education_num <- as.numeric(sh$education)
sh$tourtime_num  <- as.numeric(sh$tourtime)
sh$age_binary    <- ifelse(as.numeric(sh$age) >= 3, 1, 0) # 26岁及以上=1
sh$gender_binary <- ifelse(sh$gender == 1, 1, 0)         # 男=1

# 3. 封控时长分组（block_time: 1-2级=T1, 3-4级=T2, 5-6级=T3）
sh$T_group <- case_when(
  sh$block_time %in% c(1, 2) ~ "T1(<=2周)",
  sh$block_time %in% c(3, 4) ~ "T2(2-4周)",
  sh$block_time %in% c(5, 6) ~ "T3(>4周)"
)

cat("上海子样本分期人数：\n")
print(table(sh$T_group))

cat("\n===================================================\n")
cat("Table 9: 上海独立样本分时段全标准化多元回归 (Standardized Beta)\n")
cat("===================================================\n")

res_list <- list()
for (tg in c("T1(<=2周)", "T2(2-4周)", "T3(>4周)")) {
  sub <- sh %>% filter(T_group == tg)
  # 投稿稿报告标准化 beta，但括号内保留原始尺度回归的标准误。
  raw_fit <- lm(WI ~ BR + SE + education_num + tourtime_num + age_binary + gender_binary, data = sub)
  sub_scale <- sub %>% mutate(across(c(WI, BR, SE, education_num, tourtime_num, age_binary, gender_binary), scale))
  fit <- lm(WI ~ BR + SE + education_num + tourtime_num + age_binary + gender_binary, data = sub_scale)
  
  cat(paste0("\n>>> 阶段: ", tg, " (N = ", nrow(sub), ") <<<\n"))
  print(summary(fit))
  
  raw_tidy <- tidy(raw_fit)
  tidy_df <- tidy(fit) %>%
    mutate(
      Std_Error_Raw_Scale = raw_tidy$std.error[match(term, raw_tidy$term)]
    ) %>%
    mutate(Stage = tg, N = nrow(sub), Adj_R2 = summary(fit)$adj.r.squared, F_stat = summary(fit)$fstatistic[1])
  res_list[[tg]] <- tidy_df
}

table9_final <- bind_rows(res_list)
dir.create("../output", showWarnings = FALSE)
write.csv(table9_final, "../output/table9_shanghai_regression_exact.csv", row.names = FALSE)
cat("\n已保存精确复现结果至 ../output/table9_shanghai_regression_exact.csv\n")
