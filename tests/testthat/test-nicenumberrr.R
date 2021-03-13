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
    # toy dataframe for tests
    test_df <- data.frame(A = c(1000, 10000), B = c(1000000, 100000))
    human_df <- to_df(test_df, transform_type = "human")
    num_df <- to_df(human_df, transform_type = "num")

    # test expected errors raised
    test_that("Expected error not raised!", {
        expect_error(to_df(df = c(1, 2, 3)))
        expect_error(to_df(test_df, col_names = 1))
        expect_error(to_df(test_df, col_names = "X"))
        expect_error(to_df(test_df, transform_type = "wrong type"))
    })

    # test return values
    test_that("Incorrect return values!", {
        expect_equal(dim(to_df(test_df)), dim(test_df))
        expect_equal(to_df(test_df, col_names = "A")[1, 1], "1K")
        expect_equal(to_df(human_df, col_names = "A", transform_type = "num")[1, 1], 1000)
        expect_equal(num_df, test_df)
    })
}

test_to_color <- function() {
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
}

test_all()
