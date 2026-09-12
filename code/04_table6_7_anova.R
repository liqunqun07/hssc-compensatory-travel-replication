# =============================================================
# 04_table6_7_anova.R
# Study 2：情境限制强度（SDPC）x 限制时长（PCD）两因素方差分析与均值演变
# 对应手稿 Table 6 & Table 7
# =============================================================

source("00_data_cleaning.R")
suppressPackageStartupMessages({
  library(dplyr)
  library(broom)
})

df <- load_and_clean_total()

# Study 2 时长子样本（剔除异常时长；正式分期按包含起始日的 duration_days）
df_s2 <- df %>% filter(duration_days > 1)
cat(sprintf("Study 2 分析样本量 N = %d\n", nrow(df_s2)))

cat("\n===================================================\n")
cat("Table 6: 两因素方差分析（Two-factor ANOVA）\n")
cat("===================================================\n")

# 1. 无聊感 (BR)
aov_br <- aov(BR ~ period_group_manuscript * strict_group_manuscript, data = df_s2)
cat("\n>>> Dependent Variable: Boredom (BR) <<<\n")
print(summary(aov_br))

# 2. 感觉寻求 (SE)
aov_se <- aov(SE ~ period_group_manuscript * strict_group_manuscript, data = df_s2)
cat("\n>>> Dependent Variable: Sensation Seeking (SE) <<<\n")
print(summary(aov_se))

# 3. 旅游意愿 (WI)
aov_wi <- aov(WI ~ period_group_manuscript * strict_group_manuscript, data = df_s2)
cat("\n>>> Dependent Variable: Travel Intention (WI) <<<\n")
print(summary(aov_wi))

cat("\n===================================================\n")
cat("Table 7: 严格组与宽松组在各时期的均值 (M) 与标准差 (SD)\n")
cat("===================================================\n")

table7_means <- df_s2 %>%
  group_by(strict_group_manuscript, period_group_manuscript) %>%
  summarise(
    BR_M = mean(BR), BR_SD = sd(BR),
    SE_M = mean(SE), SE_SD = sd(SE),
    WI_M = mean(WI), WI_SD = sd(WI),
    N = n(), .groups = "drop"
  )
print(table7_means)

dir.create("../output", showWarnings = FALSE)
write.csv(tidy(aov_br), "../output/table6_anova_BR.csv", row.names = FALSE)
write.csv(tidy(aov_se), "../output/table6_anova_SE.csv", row.names = FALSE)
write.csv(tidy(aov_wi), "../output/table6_anova_WI.csv", row.names = FALSE)
write.csv(table7_means, "../output/table7_means_comparison.csv", row.names = FALSE)
cat("\n已保存结果至 ../output/ 目录。\n")
