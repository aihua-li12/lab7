# Mine

library(jsonlite)
library(tidyverse)

url <- "https://data.okc.gov/services/portal/api/data/records/Fire%20Stations"
json_content <- fromJSON(url)
fire_stations <- json_content$Records %>% as_tibble() %>% 
  set_names(json_content$Fields %>% pull("FieldName"))


# Sample solution

library(tidyverse)
library(jsonlite)

fire_url <- "https://data.okc.gov/services/portal/api/data/records/Fire%20Stations"

fire_stations <- fromJSON(fire_url)$Records

colnames(fire_stations) <- c("id", "station_number", 
                             "station_address", "coordinates")

fire_stations <- as_tibble(fire_stations) %>% 
  mutate(coordinates = str_replace(coordinates, ",19", ""))

saveRDS(fire_stations, file = "data/fire_stations.rds")
