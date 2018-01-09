context("project")

test_that("get_projects returns a data.frame", {
  expect_is(get_projects(), "data.frame")
})