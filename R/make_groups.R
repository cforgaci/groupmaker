#' Make Groups
#'
#' Given a list of students and a desired group size, assign the students to
#' groups in such a way that the diversity of group members is maximised.
#'
#' @param students A data frame.
#' @param group_size A number. integer
#'
#' @return The students data frame with a new column \code{group}.
#' @import dplyr
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' # Dummy data included in the groupmaker package
#' students
#'
#' # How many members should a group have?
#' group_size <- 3
#'
#' # Make groups of students
#' make_groups(students = students, group_size = group_size)
make_groups <- function(students, group_size) {
  # Check arguments
  if (group_size < 2) {
    stop("A group should have at least two members.")
  }

  # How many students need to be grouped?
  no_students <- nrow(students)

  # How many groups does a given group size result in?
  no_groups <- no_students %/% group_size

  # Prepare
  students <- students %>%
    # sort by frequency of nationalities
    dplyr::add_count(.data$nationality, sort = TRUE) %>%
    dplyr::select(-.data$n) %>%
    # distribute students across groups
    dplyr::mutate(group = rep_len(x = paste0("group_", (1:no_groups)), length.out = no_students)) %>%
    dplyr::arrange(.data$group) %>%
    dplyr::mutate(group = as.factor(.data$group))

  print(students)
  check_expertise_diversity(students)
  check_gender_balance(students)
}


