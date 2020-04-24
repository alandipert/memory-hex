context("hex module")

test_that("hex module behaves correctly", {

  shiny_logo <- test_path("../www/hex/shiny.png")
  reset <- reactiveValues(x = NULL)
  block <- reactiveValues(x = NULL)

  testServer(hex, {
    # Initially, hexes are neither found nor visible.
    expect_false(click_status$found)
    expect_false(click_status$show)

    # On the first click, the hex becomes visible.
    session$setInputs(hex_click = 0)
    expect_true(click_status$show)

    # Clicked again, the hex is hidden.
    session$setInputs(hex_click = input$hex+1)
    expect_false(click_status$show)

    # Click again to make visible.
    session$setInputs(hex_click = input$hex+1)
    expect_true(click_status$show)

    # Become hidden when the board is reset and this hex is visible but not
    # found.
    reset$x <- hex_logo
    session$flushReact()
    expect_false(click_status$found)
    expect_false(click_status$show)

    # Become visible once again.
    session$setInputs(hex_click = input$hex+1)
    expect_true(click_status$show)

    # Become found and permanently visible after an identical hex is
    # subsequently discovered.
    block$x <- hex_logo
    session$flushReact()
    expect_true(click_status$found)
    expect_true(click_status$show)

    # Once the hex is found, more additional clicks do not hide it, and its
    # status remains found.
    for (i in 1:10) {
      session$setInputs(hex_click = input$hex+1)
      expect_true(click_status$found)
      expect_true(click_status$show)
    }
  },
    hex_logo = shiny_logo,
    reset = reset,
    block = block
  )
})