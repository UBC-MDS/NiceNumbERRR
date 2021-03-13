library(testthat)

test_all <- function() {
    test_to_human()
    test_to_numeric()
    test_to_df()
    test_to_color()
}

test_to_human <- function() {
    f <- to_human

    # test expected errors raised
    test_that("Expected error not raised!", {
        expect_error(f(n = 5, family = "wrong family"))
        expect_error(f(n = "5"))
        expect_error(f(n = c(1, 2)))
        expect_error(f(n = 1e30, prec = 3, errors = "throw"))
    })

    # test values converted correctly
    test_that("Incorrect conversion", {
        expect_equal(f(n = 0, prec = 0), "0")
        expect_equal(f(n = 0.12, prec = 2), "0.12")
        expect_equal(f(n = 4500, prec = 1), "4.5K")
        expect_equal(f(n = 4500, prec = 1, custom_suff = c("apple", "banana")), "4.5apple")
        expect_equal(f(n = 4510, prec = 2), "4.51K")
        expect_equal(f(n = 4510.1234, prec = 2), "4.51K")
        expect_equal(f(n = 4510000, prec = 2), "4.51M")
        expect_equal(f(n = 69420090000, prec = 3), "69.420B")
        expect_equal(f(n = 4510000, prec = 2, family = "filesize"), "4.51MB")

        expect_true(is.na(f(n = "69420090000", prec = 3, errors = "coerce")))
        expect_true(is.na(f(n = 1e30, prec = 3, errors = "coerce")))
    })
}

test_to_numeric <- function() {
    test_that("The output should be 88800 for input '$%#$#88.8k'", (
        expect_equal(to_numeric("$%#$#88.8k"), 88800)
    ))
    test_that("The output should be 99.999 for input 99.999", (
        expect_equal(to_numeric(99.999), 99.999)
    ))
    test_that("The output should be 88800 for input '$%#$#88.8k'", (
        expect_equal(to_numeric("1000mb", family = "filesize"), 1000000000)
    ))
    test_that("The function should throw an error with this input", (
        expect_error(to_numeric(list(1, 2, 3), custom_suff = list("LL")))
    ))
}

test_to_df <- function() {

}

test_to_color <- function() {
    
}

test_all()