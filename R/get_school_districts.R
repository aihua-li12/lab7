# Mine

library(tidyverse)
library(jsonlite)

url <- "https://data.okc.gov/services/portal/api/data/records/School%20District%20Boundaries"
school_districts <- fromJSON(url)$Records %>% as_tibble() %>% 
  set_names(c("id", "district_code", "district_name", "coordinates")) %>% 
  mutate(coordinates = str_remove(coordinates, ",\\d{2}"))


# Sample solution

library(tidyverse)
library(jsonlite)

school_url <- "https://data.okc.gov/services/portal/api/data/records/School%20District%20Boundaries"

school_districts <- fromJSON(school_url)$Records

colnames(school_districts) <- c("id", "district_code", 
                                "district_name", "coordinates")

school_districts <- as_tibble(school_districts) %>% 
  mutate(coordinates = str_replace(coordinates, ",\\d{2}", ""))


saveRDS(school_districts, file = "data/school_districts.rds")
