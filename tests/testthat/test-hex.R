context("hex module")

test_that("hex module behaves correctly", {

  shiny_logo <- test_path("../www/hex/shiny.png")
  reset <- reactiveValues(x = NULL)
  block <- reactiveValues(x = NULL)

  testServer(hex, {
    expect_equal(hex_logo, !!shiny_logo)

    # Initially, hexes are neither found nor visible.
    expect_false(click_status$found)
    expect_false(click_status$show)

    # If not already found, upon being clicked, the hex becomes visible.
    session$click("hex_click")
    expect_true(click_status$show)
  },
    hex_logo = shiny_logo,
    reset = reset,
    block = block
  )
})