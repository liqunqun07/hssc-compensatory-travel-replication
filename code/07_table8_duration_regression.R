# =============================================================
# 07_table8_duration_regression.R
# Study 2：严格情境且居家工作/学习子样本的分时段回归
# =============================================================

source("00_data_cleaning.R")
suppressPackageStartupMessages({
  library(dplyr)
  library(broom)
})

df <- load_and_clean_total()
sub <- df %>% filter(duration_days > 1, strict_group_manuscript == "Strict", home_based == 1)
sub$stage <- cut(
  sub$duration_days,
  breaks = c(-Inf, 7, 21, Inf),
  labels = c("T1", "T2", "T3"),
  right = TRUE
)

rows <- list()
for (stage in levels(sub$stage)) {
  d <- sub %>% filter(.data$stage == .env$stage)
  raw_fit <- lm(WI ~ BR + SE + education_num + tourtime_num + age_binary + gender_binary, data = d)
  z <- d %>% mutate(across(c(WI, BR, SE, education_num, tourtime_num, age_binary, gender_binary), scale))
  std_fit <- lm(WI ~ BR + SE + education_num + tourtime_num + age_binary + gender_binary, data = z)
  raw <- tidy(raw_fit)
  std <- tidy(std_fit)
  rows[[stage]] <- std %>%
    filter(term != "(Intercept)") %>%
    transmute(
      Stage = stage,
      Term = recode(
        term,
        BR = "Boredom",
        SE = "Sensation seeking",
        education_num = "Education",
        tourtime_num = "Travel frequency",
        age_binary = "Age 26+",
        gender_binary = "Male"
      ),
      Beta = estimate,
      SE = raw$std.error[match(term, raw$term)],
      N = nrow(d),
      F_value = summary(raw_fit)$fstatistic[1],
      Adjusted_R2 = summary(raw_fit)$adj.r.squared,
      P_value = p.value
    )
}

result <- bind_rows(rows)
dir.create("../output", showWarnings = FALSE)
write.csv(result, "../output/table8_duration_regression.csv", row.names = FALSE)
cat("已保存 Table 8 重新估计结果至 ../output/table8_duration_regression.csv\n")
