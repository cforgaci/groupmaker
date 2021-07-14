library(dplyr)

students <- tibble(name = c("John", "Mary", "Bob", "Kate", "Ganesh", "Marta", "Janneke"), 
                   nationality = c("NL", "RO", "US", "NL", "IN", "DE", "NL"),
                   designer = c(T, F, F, T, T, F, F),
                   gender = c("M", "F", "M", "F", "M", "F", "F"))
students$nationality <- as.factor(students$nationality)
students$gender <- as.factor(students$gender)

# How many students should be in a group?
group_size <- 2

make_groups <- function(students, group_size, no_groups = 2) {
  # Check arguments
  if (group_size < 2 & no_groups < 2) {
    stop("A group should have at least two members.\nAt least two groups are required.")
  } else if (group_size < 2) {
    stop("A group should have at least two members.")
  } else if (no_groups < 2) {
    stop("At least two groups are required.")
  }
  
  # How many groups does a given group size result in?
  no_groups <- nrow(students) %/% group_size
  
  # Prepare 
  students <- students %>% 
    # sort by frequency of nationalities
    add_count(nationality, sort = TRUE) %>% 
    select(-n) %>% 
    # distribute students across groups
    mutate(group = rep_len(paste0("group_", (1:no_groups)), nrow(.)))
  
  # check the distribution of designers per group
  students %>% 
    group_by(group) %>% 
    count(designer) %>% 
    filter(designer == TRUE)
  
  # check the gender balance in groups
  students %>% 
    group_by(group) %>%
    count(gender)
  # or
  table(students$group, students$gender)
}
