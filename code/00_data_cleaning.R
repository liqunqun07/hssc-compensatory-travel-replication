# =============================================================
# 00_data_cleaning.R
# 数据清洗与变量构建（Study 1 & Study 2 共用）
# 数据源：../data/totaldatas.xlsx (N=1047)
# =============================================================

# macOS/Linux 的 C locale 会把中文列名转成 <U+...>，导致同一脚本在
# 不同终端下行为不同；在可用时统一使用 UTF-8。
try(Sys.setlocale("LC_CTYPE", "en_US.UTF-8"), silent = TRUE)

suppressPackageStartupMessages({
  library(readxl)
  library(dplyr)
  library(psych)
})

load_and_clean_total <- function(path = NULL) {
  if (is.null(path)) {
    if (file.exists("../data/raw/totaldatas.xlsx")) {
      path <- "../data/raw/totaldatas.xlsx"
    } else if (file.exists("../data/totaldatas.xlsx")) {
      path <- "../data/totaldatas.xlsx"
    } else if (file.exists("data/raw/totaldatas.xlsx")) {
      path <- "data/raw/totaldatas.xlsx"
    } else {
      stop("Cannot find totaldatas.xlsx in ../data/raw/ or ../data/")
    }
  }
  df <- as.data.frame(read_excel(path))
  
  # 1. 时间变量处理
  df$time      <- as.Date(df$"提交答卷时间")
  df$begintime <- as.Date(df$first_time)
  df$period    <- as.numeric(df$time - df$begintime)
  # 论文中的“持续天数”包含起始日。例如 12 月 2 日至 12 月 8 日为 7 天，
  # 而 Date 相减为 6。保留 period 供旧代码核对，正式分期使用 duration_days。
  df$duration_days <- df$period + 1
  
  # 2. 量表题项转为数值型
  scale_cols <- c("BR1","BR2","BR3","BR4","BR5",
                  "be1","be2","be3","be4",
                  "SE1","SE2","SE3","SE4","SE5","SE6",
                  "PS1","PS2","PS3","PS4",
                  "WI1","WI2","WI3")
  for (col in scale_cols) {
    if (col %in% names(df)) {
      df[[col]] <- as.numeric(df[[col]])
    }
  }
  
  # 3. 计算各构念均值（合成得分）
  df$BR <- rowMeans(df[, paste0("BR", 1:5)], na.rm = TRUE)
  df$SE <- rowMeans(df[, paste0("SE", 1:6)], na.rm = TRUE)
  df$WI <- rowMeans(df[, paste0("WI", 1:3)], na.rm = TRUE)
  
  # 4. 控制变量编码
  df$tourtime_num  <- as.numeric(df$tourtime)
  df$education_num <- as.numeric(df$education)
  # 原问卷：1=18岁以下，2=18-25岁，3=26-30岁，……；论文二分口径为
  # 25岁以下/25岁以上，因此代码 3 及以上归入年龄较高组。
  df$age_binary    <- ifelse(as.numeric(df$age) >= 3, 1, 0)
  df$gender_binary <- ifelse(df$gender == 1, 1, 0)         # 男=1
  
  # 5. 四项情境限制措施编码（二分变量，1=是，0=否）
  df$community_block  <- ifelse(df$block == 1, 1, 0)
  df$entertain_closed <- ifelse(df$entertain == 1, 1, 0)
  df$workplace_closed <- ifelse(df$closed == 1, 1, 0)
  df$home_based       <- ifelse(df$wfh %in% c(1, 2), 1, 0)
  
  # 6. 限制强度分组（严格组 vs 宽松组）
  # 手稿正文口径：小区封控 + 娱乐场所关闭 + 学校/企业封闭管理 >= 2
  df$strict_count_manuscript <- df$community_block + df$entertain_closed + df$workplace_closed
  df$strict_group_manuscript <- factor(ifelse(df$strict_count_manuscript >= 2, "Strict", "Loose"))
  
  # 遗留代码口径：小区封控 + 居家办公学习 + 娱乐场所关闭 >= 2
  df$strict_count_legacy <- df$community_block + df$home_based + df$entertain_closed
  df$strict_group_legacy <- factor(ifelse(df$strict_count_legacy >= 2, "Strict", "Loose"))
  
  # 7. 限制时长阶段划分
  # T1(<=7天), T2(8-21天), T3(>21天)
  df$period_group_7_21 <- cut(df$period, breaks = c(-Inf, 7, 21, Inf),
                              labels = c("T1(<=7days)", "T2(8-21days)", "T3(>21days)"),
                              right = TRUE)
  # 匿名投稿稿口径：按包含起始日的持续天数分为 <=7、8-21、>21 天。
  df$period_group_manuscript <- cut(
    df$duration_days,
    breaks = c(-Inf, 7, 21, Inf),
    labels = c("T1(<=7days)", "T2(8-21days)", "T3(>21days)"),
    right = TRUE
  )
  # 14天-28天划分
  df$period_group_14_28 <- cut(df$period, breaks = c(-Inf, 14, 28, Inf),
                               labels = c("<=14days", "14-28days", ">28days"),
                               right = TRUE)
  
  return(df)
}

if (sys.nframe() == 0) {
  df <- load_and_clean_total()
  cat("全量数据清洗完毕，样本量 N =", nrow(df), "\n")
}
