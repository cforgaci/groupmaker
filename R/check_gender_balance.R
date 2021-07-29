check_gender_balance <- function(students) {
  # Check the gender balance in groups
  gender_distr <- students %>%
    group_by(group) %>%
    count(gender) %>%
    ungroup() %>%
    arrange(gender) %>%
    group_by(gender) %>%
    mutate(diff = n - lag(n)) %>%
    ungroup() %>%
    mutate(diff_l = if_else(abs(diff) > 1, TRUE, FALSE)) %>%
    summarise(sum(diff_l, na.rm = TRUE)) %>%
    pull

  if (gender_distr == 0) {
    print("Gender distribution across groups: OK")
  }
}
