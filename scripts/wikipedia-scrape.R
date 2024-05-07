### DESCRIPTION #####

# Scrape the Wikipedia list of german Hip Hop artists.
# https://de.wikipedia.org/wiki/Liste_von_Hip-Hop-Musikern_Deutschlands

### PACKAGES #####

library(rvest)
library(tidyverse)

### COLLECT DATA FROM WIKIPEDIA #####

# last accessed on 2024-05-07
url <- "https://de.wikipedia.org/wiki/Liste_von_Hip-Hop-Musikern_Deutschlands"

html <- read_html(url)

wiki_artists <- data.frame(html %>% 
                             html_element("table.wikitable.sortable") %>% 
                             html_table()
                           )

wiki_artists <- wiki_artists %>%
  select(-`Var.1`) %>%
  rename(
    "artistname" = "Künstlername",
    "realname" = "Bürgerlicher.Name",
    "bandmembership" = "Mitgliedschaft.in.Bands",
    "dateofbirth" = "Lebensdaten",
    "origin" = "Herkunft"
  ) %>%
  mutate_all(na_if, "")

save(
  wiki_artists,
  file = paste("data/wiki-artists-", str_sub(today(),3,-1), ".RData", sep = "")
  )
