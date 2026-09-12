# =============================================================
# 01_table10_11_cfa.R
# 验证性因子分析（CFA）、信度（Cronbach alpha、CR）与收敛效度（AVE）
# 对应手稿 Table 10 & Table 11
# =============================================================

source("00_data_cleaning.R")
suppressPackageStartupMessages({
  library(lavaan)
  library(psych)
})

df <- load_and_clean_total()

cat("\n===================================================\n")
cat("1. Cronbach's Alpha 信度检验\n")
cat("===================================================\n")
a_br <- alpha(df[, paste0("BR", 1:5)])$total$raw_alpha
a_se <- alpha(df[, paste0("SE", 1:6)])$total$raw_alpha
a_wi <- alpha(df[, paste0("WI", 1:3)])$total$raw_alpha

cat(sprintf("Boredom (BR) Alpha: %.3f (原文: 0.927)\n", a_br))
cat(sprintf("Sensation Seeking (SE) Alpha: %.3f (原文: 0.880)\n", a_se))
cat(sprintf("Travel Intention (WI) Alpha: %.3f (原文: 0.921)\n", a_wi))

cat("\n===================================================\n")
cat("2. 验证性因子分析（CFA 测量模型）\n")
cat("===================================================\n")
# 原始 AMOS 输出分别估计三个单因子测量模型；逐构念拟合可在 R 中复现
# 同一组标准化载荷。一次性拟合三因子会产生不同的测量模型口径。
constructs <- list(
  Boredom = paste0("BR", 1:5),
  `Sensation seeking` = paste0("SE", 1:6),
  `Travel intention` = paste0("WI", 1:3)
)
calc_cr_ave <- function(loadings_vec) {
  sum_l <- sum(loadings_vec)
  cr <- sum_l^2 / (sum_l^2 + sum(1 - loadings_vec^2))
  ave <- mean(loadings_vec^2)
  c(CR = cr, AVE = ave)
}

loading_rows <- list()
for (latent in names(constructs)) {
  items <- constructs[[latent]]
  fit_one <- cfa(sprintf("latent =~ %s", paste(items, collapse = " + ")), data = df, std.lv = FALSE)
  params <- standardizedSolution(fit_one)
  l <- params %>% filter(op == "=~") %>% pull(est.std)
  cr_ave <- calc_cr_ave(l)
  loading_rows[[latent]] <- data.frame(
    Latent = latent,
    Item = items,
    Std_Loading = l,
    pvalue = params %>% filter(op == "=~") %>% pull(pvalue),
    CR = c(cr_ave[["CR"]], rep(NA, length(items) - 1)),
    AVE = c(cr_ave[["AVE"]], rep(NA, length(items) - 1))
  )
}
loadings <- bind_rows(loading_rows)
print(loadings)
cr_ave_br <- c(CR = loadings$CR[1], AVE = loadings$AVE[1])
cr_ave_se <- c(CR = loadings$CR[6], AVE = loadings$AVE[6])
cr_ave_wi <- c(CR = loadings$CR[12], AVE = loadings$AVE[12])

fit_three <- cfa(
  "BR_latent =~ BR1 + BR2 + BR3 + BR4 + BR5
   SE_latent =~ SE1 + SE2 + SE3 + SE4 + SE5 + SE6
   WI_latent =~ WI1 + WI2 + WI3",
  data = df,
  std.lv = TRUE
)

cat("\n===================================================\n")
cat("Table 10: CR 与 AVE 对应手稿数值对比\n")
cat("===================================================\n")
cat(sprintf("Boredom: CR = %.3f (原文 0.933), AVE = %.3f (原文 0.735)\n", cr_ave_br["CR"], cr_ave_br["AVE"]))
cat(sprintf("Sensation Seeking: CR = %.3f (原文 0.883), AVE = %.3f (原文 0.561)\n", cr_ave_se["CR"], cr_ave_se["AVE"]))
cat(sprintf("Travel Intention: CR = %.3f (原文 0.926), AVE = %.3f (原文 0.806)\n", cr_ave_wi["CR"], cr_ave_wi["AVE"]))

dir.create("../output", showWarnings = FALSE)
write.csv(
  data.frame(
    Construct = names(constructs),
    Cronbach_alpha = c(a_br, a_se, a_wi)
  ),
  "../output/table10_reliability.csv",
  row.names = FALSE
)
write.csv(loadings, "../output/table10_cfa_loadings.csv", row.names = FALSE)
write.csv(lavInspect(fit_three, "cor.lv"), "../output/table11_cfa_latent_correlations.csv")
cat("\n已保存结果至 ../output/table10_cfa_loadings.csv\n")
