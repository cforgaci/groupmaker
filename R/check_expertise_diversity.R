#' Check Expertise Diversity Across Groups
#'
#' After groups have been made, check expertise distribution.
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
#' # Check expertise diversity on the example dataset included in the makegroups package
#' check_expertise_diversity(make_groups(students, 3))
check_expertise_diversity <- function(students) {
  # Check the distribution of designers per group
  expertise_distr <- students %>%
    # Count the number of designers in each group
    dplyr::group_by(.data, .data$group) %>%
    dplyr::count(.data$designer) %>%
    dplyr::mutate(no_designers = sum(.data$designer)) %>%
    # Calculate the difference between groups
    dplyr::mutate(diff = .data$n - lag(.data$n)) %>%
    dplyr::ungroup() %>%
    # Check if the difference is more than 1
    dplyr::mutate(diff_l = if_else(abs(.data$diff) > 1, TRUE, FALSE)) %>%
    dplyr::summarise(sum(.data$diff_l, na.rm = TRUE)) %>%
    dplyr::pull()

  # If any group has more than one designer compared to other groups
  # then the disrtibution is considered
  if (expertise_distr == 0) {
    print("Expertise distribution across groups: OK")
  }
}
