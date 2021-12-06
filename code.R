library(tidyverse)

patents_2000 <- tibble(read.csv("C:/Users/pablo/Downloads/patents_2000.csv"))

max_derwent = 30000
branches = nrow(patents_2000) %/% max_derwent
branches_res = nrow(patents_2000) %% max_derwent

patents_2000 = patents_2000 %>%
  mutate(complete_id = paste0(country,patent_id,kind),
         n = c(rep(1:branches, times = 1, each = max_derwent), rep(branches+1,branches_res))
  )

for (i in 1:(branches+1)) {
  write.table(
    patents_2000 %>% filter(n == i) %>% select(complete_id),
    paste0('branches/patent_branch',i,'.txt'),
    sep = '\t',
    row.names = FALSE,
    col.names = FALSE
  )
}
