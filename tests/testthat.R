library(testthat)
library(shiny)

loadSupport()

testthat::test_dir(
  "./testthat",
  reporter = c("summary", "fail"),
  env = environment()
)