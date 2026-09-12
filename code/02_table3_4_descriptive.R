# =============================================================
# 02_table3_4_descriptive.R
# 描述统计、相关分析与组间差异检验
# 对应手稿 Table 3 & Table 4
# =============================================================

source("00_data_cleaning.R")
df <- load_and_clean_total()

cat("\n===================================================\n")
cat("Table 4: 描述统计与相关系数矩阵 (Pearson r)\n")
cat("===================================================\n")
cat(sprintf("Boredom (BR): Mean = %.3f (SD = %.3f) [原文 M=3.321, SD=1.178]\n", mean(df$BR), sd(df$BR)))
cat(sprintf("Sensation Seeking (SE): Mean = %.3f (SD = %.3f) [原文 M=3.473, SD=0.977]\n", mean(df$SE), sd(df$SE)))
cat(sprintf("Travel Intention (WI): Mean = %.3f (SD = %.3f) [原文 M=3.595, SD=1.175]\n", mean(df$WI), sd(df$WI)))

cor_mat <- cor(df[, c("BR", "SE", "WI")])
print(round(cor_mat, 3))

cat("\n===================================================\n")
cat("Table 3: 限制情境下的均值差异检验 (t 检验与 ANOVA)\n")
cat("===================================================\n")

run_t_table3 <- function(label, group_col) {
  cat(paste0("\n--- ", label, " ---\n"))
  t_br <- t.test(BR ~ get(group_col), data = df)
  t_se <- t.test(SE ~ get(group_col), data = df)
  t_wi <- t.test(WI ~ get(group_col), data = df)
  
  cat(sprintf("BR: Group1=%.2f, Group2=%.2f | t=%.2f, p=%.3f\n", t_br$estimate[1], t_br$estimate[2], abs(t_br$statistic), t_br$p.value))
  cat(sprintf("SE: Group1=%.2f, Group2=%.2f | t=%.2f, p=%.3f\n", t_se$estimate[1], t_se$estimate[2], abs(t_se$statistic), t_se$p.value))
  cat(sprintf("WI: Group1=%.2f, Group2=%.2f | t=%.2f, p=%.3f\n", t_wi$estimate[1], t_wi$estimate[2], abs(t_wi$statistic), t_wi$p.value))
}

run_t_table3("Area (High-risk vs Low-risk)", "highrisk")
run_t_table3("Entertainment places (Closed vs Open)", "entertain")
run_t_table3("Workplace (Closed vs Unclosed)", "closed")
run_t_table3("Community (Blocked vs Unblocked)", "block")

cat("\n--- Working state (居家/办公4水平 ANOVA) ---\n")
aov_br <- summary(aov(BR ~ factor(wfh), data = df))[[1]]
aov_se <- summary(aov(SE ~ factor(wfh), data = df))[[1]]
aov_wi <- summary(aov(WI ~ factor(wfh), data = df))[[1]]

cat(sprintf("BR: F=%.2f, p=%.4f (原文 F=11.53***, p<0.001)\n", aov_br["factor(wfh)", "F value"], aov_br["factor(wfh)", "Pr(>F)"]))
cat(sprintf("SE: F=%.2f, p=%.4f (原文 F=6.14***, p<0.001)\n", aov_se["factor(wfh)", "F value"], aov_se["factor(wfh)", "Pr(>F)"]))
cat(sprintf("WI: F=%.2f, p=%.4f (原文 F=2.98*, p=0.03)\n", aov_wi["factor(wfh)", "F value"], aov_wi["factor(wfh)", "Pr(>F)"]))

dir.create("../output", showWarnings = FALSE)
write.csv(cor_mat, "../output/table4_correlation_matrix.csv")
cat("\n已保存结果至 ../output/table4_correlation_matrix.csv\n")
