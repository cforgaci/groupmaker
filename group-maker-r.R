library(dplyr)

students <- tibble(name = c("John", "Mary", "Bob", "Kate", "Ganesh", "Marta", "Janneke"), 
                   nationality = c("NL", "RO", "US", "NL", "IN", "DE", "NL"),
                   designer = c(T, F, F, T, T, F, F),
                   gender = c("M", "F", "M", "F", "M", "F", "F"))
students$nationality <- as.factor(students$nationality)
students$gender <- as.factor(students$gender)

group_size <- 2
no_groups <- nrow(students) %/% group_size


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

# 



# for (i in 1:no_groups) {
#   assign(paste0("group_", i), tibble(name = c(),
#                                     nationality = c(),
#                                     designer = c(),
#                                     gender = c()))
# }

# Case 1: maximum diversity of nationalities is the first criterion
# for (i in seq(1, nrow(students), no_groups)) {
#   for (j in i:(i + no_groups - 1)) {
#     if (j %% no_groups != 0) {
#       group <- paste0("group_", j %% no_groups)
#     } else {
#       group <- paste0("group_", no_groups)
#     }
#     assign(group, drop_na(add_row(get(group), students[j, ])))
#   }
# }

## Check number of designers in each group
for (j in 1:no_groups) {
  
}
