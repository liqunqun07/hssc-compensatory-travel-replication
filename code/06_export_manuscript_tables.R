# =============================================================
# 06_export_manuscript_tables.R
# 将匿名投稿稿中的已报告数值导出为机器可读 CSV（Tables 3-11）
#
# 这些文件是“投稿稿锁定层”：它们保证代码交付物与
# 01_Manuscript/Manuscript_anonymous.docx 一致。重新估计的结果仍由
# 01-05/07 脚本从原始数据计算，两层不得混称。
# =============================================================

reported_dir <- "../output/manuscript"
dir.create(reported_dir, recursive = TRUE, showWarnings = FALSE)

write_reported <- function(x, number) {
  x$Source <- "Manuscript_anonymous.docx"
  write.csv(
    x,
    file.path(reported_dir, sprintf("table%d_reported.csv", number)),
    row.names = FALSE,
    na = ""
  )
}

# Table 3 -----------------------------------------------------------------
table3 <- data.frame(
  Context = c(
    rep("Area", 4), rep("Entertainment places", 4),
    rep("Workplace", 4), rep("Community", 4), rep("Working state", 6)
  ),
  Level = c(
    "Medium or high-risk area", "Low risk area", "t", "p",
    "Close", "Open", "t", "p",
    "Closed management", "Unclosed management", "t", "p",
    "Blocked", "Unblocked", "t", "p",
    "Work at home", "Study at home", "Offline office", "Offline learning", "F", "p"
  ),
  BR_M = c(3.49, 3.17, rep(NA, 2), 3.38, 3.21, rep(NA, 2), 3.38, 3.21, rep(NA, 2), 3.54, 3.09, rep(NA, 2), 3.38, 3.55, 2.97, 3.41, NA, NA),
  BR_SD = c(1.14, 1.20, rep(NA, 2), 1.17, 1.18, rep(NA, 2), 1.18, 1.16, rep(NA, 2), 1.15, 1.17, rep(NA, 2), 1.22, 1.06, 1.16, 1.11, NA, NA),
  SE_M = c(3.56, 3.39, rep(NA, 2), 3.48, 3.46, rep(NA, 2), 3.52, 3.39, rep(NA, 2), 3.60, 3.33, rep(NA, 2), 3.47, 3.67, 3.30, 3.45, NA, NA),
  SE_SD = c(.98, .97, rep(NA, 2), 1.01, .92, rep(NA, 2), 1.00, .94, rep(NA, 2), .97, .96, rep(NA, 2), 1.05, .84, .96, .89, NA, NA),
  WI_M = c(3.66, 3.54, rep(NA, 2), 3.60, 3.58, rep(NA, 2), 3.61, 3.57, rep(NA, 2), 3.70, 3.48, rep(NA, 2), 3.60, 3.75, 3.44, 3.60, NA, NA),
  WI_SD = c(1.18, 1.17, rep(NA, 2), 1.20, 1.12, rep(NA, 2), 1.19, 1.14, rep(NA, 2), 1.17, 1.17, rep(NA, 2), 1.27, 1.00, 1.17, 1.08, NA, NA),
  BR_Test = c(NA, NA, 4.43, NA, NA, NA, 2.30, NA, NA, NA, 2.26, NA, NA, NA, 6.22, NA, rep(NA, 4), 11.53, NA),
  BR_P = c(NA, NA, NA, "<0.001", NA, NA, NA, "0.02", NA, NA, NA, "0.02", NA, NA, NA, "<0.001", rep(NA, 5), "<0.001"),
  SE_Test = c(NA, NA, 2.83, NA, NA, NA, .31, NA, NA, NA, 1.95, NA, NA, NA, 4.55, NA, rep(NA, 4), 6.14, NA),
  SE_P = c(NA, NA, NA, "0.01", NA, NA, NA, "0.76", NA, NA, NA, "0.05", NA, NA, NA, "<0.001", rep(NA, 5), "<0.001"),
  WI_Test = c(NA, NA, 1.65, NA, NA, NA, .24, NA, NA, NA, .49, NA, NA, NA, 3.01, NA, rep(NA, 4), 2.98, NA),
  WI_P = c(NA, NA, NA, "0.10", NA, NA, NA, "0.81", NA, NA, NA, "0.62", NA, NA, NA, "<0.001", rep(NA, 5), "0.03")
)
write_reported(table3, 3)

# Table 4 -----------------------------------------------------------------
table4 <- data.frame(
  Variable = c("Boredom", "Sensation seeking", "Travel intention"),
  Mean = c(3.321, 3.473, 3.595),
  SD = c(1.178, .977, 1.175),
  BR_SE = c(NA, .567, NA),
  BR_WI = c(NA, NA, .510),
  SE_WI = c(NA, NA, .655)
)
write_reported(table4, 4)

# Table 5 -----------------------------------------------------------------
ivs <- rep(c(
  "Community block", "Closed management of workplace",
  "Work or study at home", "Closure of entertainment venues"
), each = 4)
paths <- rep(c("ind1", "ind2", "ind3", "total_ind"), 4)
table5 <- data.frame(
  IV = ivs,
  Path = paths,
  Point_Est = c(.089, .032, .114, .236, .034, .020, .044, .098, .073, .017, .094, .184, .045, -.020, .060, .085),
  SE = c(.022, .033, .023, .049, .017, .034, .021, .048, .021, .035, .049, .050, .018, .032, .022, .048),
  CI_Lower = c(.051, -.033, .071, .139, .004, -.046, .005, .005, .034, -.050, .052, .088, .013, -.082, .018, -.009),
  CI_Upper = c(.135, .100, .163, .333, .069, .085, .087, .190, .116, .085, .143, .282, .084, .044, .104, .182)
)
write_reported(table5, 5)

# Table 6 -----------------------------------------------------------------
table6 <- data.frame(
  Outcome = rep(c("Boredom", "Sensation seeking", "Travel intention"), each = 3),
  Term = rep(c("PCD", "SDPC", "PCD x SDPC"), 3),
  F_value = c(1.589, 8.03, 3.729, 5.776, 18.13, 6.072, 7.048, 5.719, .551),
  P_value = c("0.205", "0.005", "0.024", "0.003", "<0.001", "0.002", "0.001", "0.017", "0.576"),
  Model_F = c(rep(4.970, 3), rep(7.447, 3), rep(4.418, 3)),
  Model_P = c(rep("<0.001", 6), rep("0.001", 3))
)
write_reported(table6, 6)

# Table 7 -----------------------------------------------------------------
table7 <- data.frame(
  Time = rep(c("T1", "T2", "T3"), each = 2),
  Group = rep(c("Strict", "Loose"), 3),
  BR_M = c(3.66, 3.14, 3.28, 3.27, 3.35, 3.17),
  BR_SD = c(1.14, 1.19, 1.22, 1.04, 1.18, 1.11),
  SE_M = c(3.78, 3.41, 3.65, 3.10, 3.37, 3.39),
  SE_SD = c(.95, .97, .97, .88, 1.00, .87),
  WI_M = c(3.85, 3.59, 3.79, 3.55, 3.45, 3.36),
  WI_SD = c(1.05, 1.16, 1.21, 1.04, 1.24, 1.16)
)
write_reported(table7, 7)

regression_table <- function(beta, se, n, f, adj_r2, stars) {
  data.frame(
    Stage = rep(c("T1", "T2", "T3"), each = 6),
    Term = rep(c("Boredom", "Sensation seeking", "Education", "Travel frequency", "Age 26+", "Male"), 3),
    Beta = beta,
    SE = se,
    Stars = stars,
    N = rep(n, each = 6),
    F_value = rep(f, each = 6),
    P_value = "<0.001",
    Adjusted_R2 = rep(adj_r2, each = 6)
  )
}

# Table 8 -----------------------------------------------------------------
table8 <- regression_table(
  beta = c(.315, .531, .077, .107, -.032, .018, .102, .552, .039, .146, .108, -.043, .048, .681, .052, .098, -.128, -.018),
  se = c(.064, .079, .112, .065, .125, .137, .088, .110, .205, .127, .194, .203, .067, .078, .113, .057, .116, .105),
  n = c(139, 118, 268),
  f = c(29.44, 12.7, 58.68),
  adj_r2 = c(.553, .375, .565),
  stars = c("***", "***", "", "", "", "", "", "***", "", "", "", "", "", "***", "", "*", "**", "")
)
write_reported(table8, 8)

# Table 9 -----------------------------------------------------------------
table9 <- regression_table(
  beta = c(.333, .242, -.145, .002, .019, .005, .211, .357, .162, .180, -.076, -.055, .150, .321, .072, .112, -.046, -.101),
  se = c(.145, .181, .214, .152, .268, .240, .073, .081, .103, .067, .122, .121, .059, .071, .088, .056, .102, .119),
  n = c(101, 333, 466),
  f = c(5.08, 26.64, 20.23),
  adj_r2 = c(.197, .315, .199),
  stars = c("**", "*", "", "", "", "", "***", "***", "***", "***", "", "", "**", "***", "", "*", "", "*")
)
write_reported(table9, 9)

# Table 10 ----------------------------------------------------------------
table10 <- data.frame(
  Construct = c(rep("Boredom", 5), rep("Sensation seeking", 6), rep("Travel intention", 3)),
  Item = c(paste0("BR", 1:5), paste0("SE", 1:6), paste0("WI", 1:3)),
  Loading = c(.825, .845, .888, .892, .834, .670, .610, .848, .852, .808, .669, .902, .879, .911),
  CR = c(.933, rep(NA, 4), .883, rep(NA, 5), .926, NA, NA),
  AVE = c(.735, rep(NA, 4), .561, rep(NA, 5), .806, NA, NA)
)
write_reported(table10, 10)

# Table 11 ----------------------------------------------------------------
# 按匿名稿当前显示顺序原样锁定。其标签/相关系数与重新估计层的结果存在
# 转录矛盾，详见 README 的“已知稿件不一致”。
table11 <- data.frame(
  Variable = c("Sensation seeking", "Travel intention", "Boredom"),
  AVE = c(.806, .561, .735),
  Correlation_1 = c(NA, .712, .548),
  Correlation_2 = c(NA, NA, .667),
  Diagonal = c(.898, .749, .857)
)
write_reported(table11, 11)

cat(sprintf("已导出匿名投稿稿锁定值：%s\n", normalizePath(reported_dir)))
