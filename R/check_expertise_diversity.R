check_expertise_diversity <- function(students) {
  # Check the distribution of designers per group
  expertise_distr <- students %>%
    # Count the number of designers in each group
    dplyr::group_by(group) %>%
    dplyr::count(designer) %>%
    dplyr::mutate(no_designers = sum(designer)) %>%
    # Calculate the difference between groups
    dplyr::mutate(diff = n - lag(n)) %>%
    dplyr::ungroup() %>%
    # Check if the difference is more than 1
    dplyr::mutate(diff_l = if_else(abs(diff) > 1, TRUE, FALSE)) %>%
    dplyr::summarise(sum(diff_l, na.rm = TRUE)) %>%
    dplyr::pull()

  # If any group has more than one designer compared to other groups
  # then the disrtibution is considered
  if (expertise_distr == 0) {
    print("Expertise distribution across groups: OK")
  }
}
