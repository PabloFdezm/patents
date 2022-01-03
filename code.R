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
  if (i %% 2 == 0) {
    write.table(
      patents_2000 %>% filter(n == i) %>% select(patent_id),
      paste0('branches/A/branch_A',100+i,'.txt'),
      sep = '\t',
      row.names = FALSE,
      col.names = FALSE
    )
  }else{
    write.table(
      patents_2000 %>% filter(n == i) %>% select(patent_id),
      paste0('branches/B/branch_B',100+i,'.txt'),
      sep = '\t',
      row.names = FALSE,
      col.names = FALSE
      )
  }
}


##### Patents 1990

patents_1990 <- read.csv("~/patents_1990.csv")

max_derwent = 30000
branches = nrow(patents_1990) %/% max_derwent
branches_res = nrow(patents_1990) %% max_derwent

patents_1990 = patents_1990 %>%
  mutate(complete_id = paste0(country,patent_id,kind),
         n = c(rep(1:branches, times = 1, each = max_derwent), rep(branches+1,branches_res))
  )

kinds <- patents_1990 %>%
  distinct(kind) %>%
  .[[1]]

kinds_no <- c(kinds[7], kinds[8], kinds[9], kinds[11], kinds[12])

`%ni%` <- base::Negate(`%in%`)

patents <- patents_1990 %>%
  filter(kind %ni% kinds_no)

for (i in 1:(branches+1)) {
  if (i %% 2 == 0) {
    write.table(
      patents %>% 
        filter(n == i)%>%
        select(complete_id),
      paste0('branches/A/branch_A',100+i,'.txt'),
      sep = '\t',
      row.names = FALSE,
      col.names = FALSE,
      quote = FALSE
    )
  }else{
    write.table(
      patents %>%
        filter(n == i)%>%
        select(complete_id),
      paste0('branches/B/branch_B',100+i,'.txt'),
      sep = '\t',
      row.names = FALSE,
      col.names = FALSE,
      quote = FALSE
    )
  }
}


