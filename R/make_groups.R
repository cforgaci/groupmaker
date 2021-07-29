#' Make Groups
#'
#' Given a list of students and a desired group size, assign students to
#' groups in such a way that diversity of group members is maximised.
#'
#' @param students data frame
#' @param group_size integer
#'
#' @return
#' @export
#'
#' @examples
#' require(dplyr)
#'
#' # Example data
#' students <- tibble(name = c("John", "Mary", "Bob", "Kate", "Ganesh", "Marta", "Janneke"),
#'                    nationality = c("NL", "RO", "US", "NL", "IN", "DE", "NL"),
#'                    designer = c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE),
#'                    gender = c("M", "F", "M", "F", "M", "F", "F"))
#' students$nationality <- as.factor(students$nationality)
#' students$gender <- as.factor(students$gender)
#'
#' # How many students should be in a group?
#' group_size <- 3
#'
#' # Make groups
#' make_groups(students, group_size)
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
