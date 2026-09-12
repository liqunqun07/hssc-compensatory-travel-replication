options(stringsAsFactors = FALSE)

# Allow this test to be called from the repository root or any other directory.
args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
if (length(file_arg) > 0) {
  test_path <- normalizePath(sub("^--file=", "", file_arg[1]), mustWork = TRUE)
  setwd(dirname(dirname(test_path)))
}

failures <- character()

expect_true <- function(value, message) {
  if (!isTRUE(value)) {
    failures <<- c(failures, message)
  }
}

expect_num <- function(actual, expected, message, tolerance = 1e-12) {
  ok <- length(actual) == length(expected) &&
    all(is.na(actual) == is.na(expected)) &&
    all(abs(actual[!is.na(expected)] - expected[!is.na(expected)]) <= tolerance)
  expect_true(ok, message)
}

source("00_data_cleaning.R")
cleaned <- load_and_clean_total()

expect_true(
  identical(as.integer(cleaned$age_binary), as.integer(as.numeric(cleaned$age) >= 3)),
  "age_binary must code ages 26+ (raw categories >= 3) as 1"
)
expect_true("duration_days" %in% names(cleaned), "duration_days is missing")
expect_true("period_group_manuscript" %in% names(cleaned), "period_group_manuscript is missing")
if ("duration_days" %in% names(cleaned)) {
  expect_num(cleaned$duration_days, cleaned$period + 1, "duration_days must include the first day")
}

reported_dir <- "../output/manuscript"
required <- file.path(
  reported_dir,
  paste0("table", 3:11, "_reported.csv")
)
expect_true(all(file.exists(required)), "reported manuscript tables 3-11 are incomplete")

read_reported <- function(table_number) {
  path <- file.path(reported_dir, sprintf("table%d_reported.csv", table_number))
  if (!file.exists(path)) return(NULL)
  read.csv(path, check.names = FALSE)
}

t3 <- read_reported(3)
if (!is.null(t3)) {
  expect_true(nrow(t3) == 22, "Table 3 must contain 22 manuscript rows")
  expect_num(t3$BR_M[1:2], c(3.49, 3.17), "Table 3 area boredom means differ")
  expect_num(t3$SE_M[c(13, 14)], c(3.60, 3.33), "Table 3 community sensation-seeking means differ")
  expect_num(t3$WI_M[17:20], c(3.60, 3.75, 3.44, 3.60), "Table 3 working-state travel-intention means differ")
}

t4 <- read_reported(4)
if (!is.null(t4)) {
  expect_num(t4$Mean, c(3.321, 3.473, 3.595), "Table 4 means differ")
  expect_num(t4$SD, c(1.178, 0.977, 1.175), "Table 4 SDs differ")
  expect_num(t4$BR_SE, c(NA, 0.567, NA), "Table 4 BR-SE correlation differs")
  expect_num(t4$BR_WI, c(NA, NA, 0.510), "Table 4 BR-WI correlation differs")
  expect_num(t4$SE_WI, c(NA, NA, 0.655), "Table 4 SE-WI correlation differs")
}

t5 <- read_reported(5)
if (!is.null(t5)) {
  expect_num(t5$Point_Est, c(
    .089, .032, .114, .236,
    .034, .020, .044, .098,
    .073, .017, .094, .184,
    .045, -.020, .060, .085
  ), "Table 5 point estimates differ")
  expect_num(t5$SE, c(
    .022, .033, .023, .049,
    .017, .034, .021, .048,
    .021, .035, .049, .050,
    .018, .032, .022, .048
  ), "Table 5 standard errors differ")
  expect_num(t5$CI_Lower, c(
    .051, -.033, .071, .139,
    .004, -.046, .005, .005,
    .034, -.050, .052, .088,
    .013, -.082, .018, -.009
  ), "Table 5 lower confidence limits differ")
  expect_num(t5$CI_Upper, c(
    .135, .100, .163, .333,
    .069, .085, .087, .190,
    .116, .085, .143, .282,
    .084, .044, .104, .182
  ), "Table 5 upper confidence limits differ")
}

t6 <- read_reported(6)
if (!is.null(t6)) {
  expect_num(t6$F_value, c(1.589, 8.03, 3.729, 5.776, 18.13, 6.072, 7.048, 5.719, .551), "Table 6 F values differ")
  expect_num(t6$Model_F, c(rep(4.970, 3), rep(7.447, 3), rep(4.418, 3)), "Table 6 model F values differ")
}

t7 <- read_reported(7)
if (!is.null(t7)) {
  expect_num(t7$BR_M, c(3.66, 3.14, 3.28, 3.27, 3.35, 3.17), "Table 7 boredom means differ")
  expect_num(t7$SE_M, c(3.78, 3.41, 3.65, 3.10, 3.37, 3.39), "Table 7 sensation-seeking means differ")
  expect_num(t7$WI_M, c(3.85, 3.59, 3.79, 3.55, 3.45, 3.36), "Table 7 travel-intention means differ")
}

for (table_number in c(8, 9)) {
  tab <- read_reported(table_number)
  if (!is.null(tab)) {
    expected_beta <- if (table_number == 8) {
      c(.315, .531, .077, .107, -.032, .018, .102, .552, .039, .146, .108, -.043, .048, .681, .052, .098, -.128, -.018)
    } else {
      c(.333, .242, -.145, .002, .019, .005, .211, .357, .162, .180, -.076, -.055, .150, .321, .072, .112, -.046, -.101)
    }
    expected_n <- if (table_number == 8) c(139, 118, 268) else c(101, 333, 466)
    expect_num(tab$Beta, expected_beta, sprintf("Table %d coefficients differ", table_number))
    expect_num(unique(tab$N), expected_n, sprintf("Table %d sample sizes differ", table_number))
  }
}

t10 <- read_reported(10)
if (!is.null(t10)) {
  expect_num(t10$Loading, c(.825, .845, .888, .892, .834, .670, .610, .848, .852, .808, .669, .902, .879, .911), "Table 10 loadings differ")
  expect_num(t10$CR[c(1, 6, 12)], c(.933, .883, .926), "Table 10 CR values differ")
  expect_num(t10$AVE[c(1, 6, 12)], c(.735, .561, .806), "Table 10 AVE values differ")
}

t11 <- read_reported(11)
if (!is.null(t11)) {
  expect_num(t11$AVE, c(.806, .561, .735), "Table 11 AVE column differs")
  expect_num(t11$Diagonal, c(.898, .749, .857), "Table 11 diagonal values differ")
  expect_num(t11$Correlation_1, c(NA, .712, .548), "Table 11 first correlation column differs")
  expect_num(t11$Correlation_2, c(NA, NA, .667), "Table 11 second correlation column differs")
}

if (length(failures)) {
  stop(paste(c("Manuscript concordance test failed:", paste0("- ", failures)), collapse = "\n"), call. = FALSE)
}

cat("PASS: data coding and reported Tables 3-11 match Manuscript_anonymous.docx\n")
