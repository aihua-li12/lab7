library(rvest)
library(janitor)
library(tidyverse)

## Sample Solution

get_tornadoes <- function(year) {
  base_url <- "http://www.tornadohistoryproject.com/tornado/Oklahoma/"
  url <- str_c(base_url, year, "/table")
  
  tor_html <- read_html(url)
  
  tor <- tor_html %>% 
    html_nodes("#results") %>% 
    html_table() %>% 
    .[[1]]  
  
  names(tor) <- tor[1, ]
  
  tor %>% 
    filter(Date != "Date") %>% 
    janitor::clean_names() %>% 
    select(date:lift_lon) %>% 
    as_tibble()
}

ok_tornadoes <- map_df(1998:2017, get_tornadoes)

saveRDS(ok_tornadoes, file = "data/ok_tor.rds")