library(testthat)
#library(NiceNumbERRR)

#test_check("NiceNumbERRR")
test_that("The output should be 88800 for input '$%#$#88.8k'",(
  expect_equal(to_numeric("$%#$#88.8k"), 88800)
))
test_that("The output should be 99.999 for input 99.999",(
  expect_equal(to_numeric(99.999), 99.999)
))
test_that("The output should be 88800 for input '$%#$#88.8k'",(
  expect_equal(to_numeric("1000mb", family = "filesize"), 1000000000)
))
test_that("The function should throw an error with this input",(
  expect_error(to_numeric(list(1, 2, 3), custom_suff = list("LL")))
))
