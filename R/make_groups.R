make_groups <- function(students, group_size) {
  # Check arguments
  if (group_size < 2) {
    stop("A group should have at least two members.")
  }

  # How many groups does a given group size result in?
  no_groups <- nrow(students) %/% group_size

  # Prepare
  students <- students %>%
    # sort by frequency of nationalities
    add_count(nationality, sort = TRUE) %>%
    select(-n) %>%
    # distribute students across groups
    mutate(group = rep_len(paste0("group_", (1:no_groups)), nrow(.))) %>%
    arrange(group)

  print(students)
  check_expertise_diversity(students)
  check_gender_balance(students)
}
