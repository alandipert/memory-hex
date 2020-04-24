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

    # On the first click, the hex becomes visible.
    session$setInputs(hex_click = 0)
    expect_true(click_status$show)

    # Clicked again, the hex is hidden.
    session$setInputs(hex_click = input$hex+1)
    expect_false(click_status$show)

    # Click again to make visible
    session$setInputs(hex_click = input$hex+1)
    expect_true(click_status$show)

    # Simulate another module being clicked while this one is still visible.
    block$x <- hex_logo
    shiny:::flushReact()
    expect_true(click_status$found)

  },
    hex_logo = shiny_logo,
    reset = reset,
    block = block
  )
})