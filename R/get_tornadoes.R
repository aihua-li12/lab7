library(rvest)
library(tidyverse)

year <- 1998:2017
get_ok_tornado <- function(year) {
  url <- str_c("http://www.tornadohistoryproject.com/tornado/Oklahoma/",
               year, "/table")
  html_doc <- read_html(url)
  html_doc %>% 
    html_nodes(css = "#results") %>% 
    html_table(header = T) %>% 
    .[[1]] %>% 
    janitor::clean_names() %>% 
    select(spc_number:lift_lon) %>% 
    filter(spc_number != "SPC #") %>% 
    tibble()
}
ok_tornado <- map_dfr(year, get_ok_tornado)

saveRDS(ok_tornado, file = "~/desktop/fall2020/sta523/lab/lab7/data/ok_tornade.rds")