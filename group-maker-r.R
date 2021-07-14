library(dplyr)

students <- tibble(name = c("John", "Mary", "Bob", "Kate", "Ganesh", "Marta", "Janneke"), 
                   nationality = c("NL", "RO", "US", "NL", "IN", "DE", "NL"),
                   designer = c(T, F, F, T, T, F, F),
                   gender = c("M", "F", "M", "F", "M", "F", "F"))
students$nationality <- as.factor(students$nationality)
students$gender <- as.factor(students$gender)

# How many students should be in a group?
group_size <- 2

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

check_expertise_diversity <- function(students) {
  # Check the distribution of designers per group
  expertise_distr <- students %>% 
    group_by(group) %>% 
    count(designer) %>%
    mutate(no_designers = sum(designer)) %>% 
    mutate(diff = n - lag(n)) %>%
    ungroup() %>% 
    mutate(diff_l = if_else(abs(diff) > 1, TRUE, FALSE)) %>% 
    summarise(sum(diff_l, na.rm = TRUE)) %>% 
    pull
  
  if (expertise_distr == 0) {
    print("Expertise distribution across groups: OK")
  }
}

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

make_groups(students, 2)
