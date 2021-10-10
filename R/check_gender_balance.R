#' Check Gender Balance in a Group
#'
#' After groups have been made, check gender balance.
#'
#' @param students A data frame.
#'
#' @return Return a message and the value TRUE if gender distribution is OK, FALSE otherwise.
#'
#' @import dplyr
#' @importFrom rlang .data
#'
#' @export
#'
#' @examples
#' # Check gender balance on the example dataset included in the makegroups package
#' check_gender_balance(make_groups(students, 3))
check_gender_balance <- function(students) {
  # Check the gender balance in groups
  gender_distr <- students %>%
    dplyr::group_by(group) %>%
    dplyr::count(gender) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(gender) %>%
    dplyr::group_by(gender) %>%
    dplyr::mutate(diff = n - lag(n)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(diff_l = if_else(abs(diff) > 1, TRUE, FALSE)) %>%
    dplyr::summarise(sum(diff_l, na.rm = TRUE)) %>%
    dplyr::pull()

  if (gender_distr == 0) {
    print("Gender distribution across groups: OK")
  }
}
