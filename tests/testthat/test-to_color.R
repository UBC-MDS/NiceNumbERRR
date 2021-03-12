test_that("Non-integer value for number should throw an error", {
  expect_error(to_color("1234"))
  expect_error(to_color(1234.23))
})

test_that("Default Colors are correct", {
  expect_identical(to_color(123456L), "\033[32m1\033[0m\033[33m2\033[0m\033[34m3\033[0m\033[31m4\033[0m\033[32m5\033[0m\033[33m6\033[0m")
})

test_that("Red Color are correct", {
  expect_identical(to_color(123456L, c("red")), "\033[31m1\033[0m\033[31m2\033[0m\033[31m3\033[0m\033[31m4\033[0m\033[31m5\033[0m\033[31m6\033[0m")
})

test_that("Blue Color are correct", {
  expect_identical(to_color(123456L, c("blue")), "\033[34m1\033[0m\033[34m2\033[0m\033[34m3\033[0m\033[34m4\033[0m\033[34m5\033[0m\033[34m6\033[0m")
})

test_that("Yellow Color are correct", {
  expect_identical(to_color(123456L, c("yellow")), "\033[33m1\033[0m\033[33m2\033[0m\033[33m3\033[0m\033[33m4\033[0m\033[33m5\033[0m\033[33m6\033[0m")
})
