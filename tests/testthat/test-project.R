context("project")

test_that("get_projects returns a data.frame", {
  expect_is(get_projects(), "data.frame")
})

test_that("get_project returns a data.frame", {
  expect_is(get_project(id = 1), "data.frame")
})