library(testthat)
library(shiny)

testthat::test_dir(
  "./testthat",
  reporter = c("summary", "fail"),
  env = loadSupport()
)