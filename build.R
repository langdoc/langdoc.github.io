library(tidyverse)

dir(".", "^\\d.*.Rmd") %>% purrr::map(readr::read_lines) %>% 
        unlist %>% stringr::str_extract("(?<=\\[@)([a-zEA_\\d-]+)") %>% 
        purrr::discard(is.na(.) == T)
rmarkdown::clean_site()
rmarkdown::render_site()
# browseURL("index.html")
