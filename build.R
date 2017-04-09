# library(tidyverse)
# library(stringr)

# citations <- dir(".", "^\\d.*.(R|r)md") %>% purrr::map(readr::read_lines) %>%
#         unlist %>% stringr::str_extract("(?<=\\[@)([a-zEA_\\d-]+)") %>%
#         purrr::discard(is.na(.) == T) %>%
#         purrr::discard(str_detect(., "^kpv_")) %>% 
#         sort(.) %>% paste0('key : "', ., '"', collapse = " or ")

# system(paste('bib2bib -ob bibliography.bib -c \'', citations, '\' ~/Dropbox/FRibliography/bibtex/FRibliography.bib'))
# system(paste('bib2bib -ob bibliography.bib -c', "\"call-number : 'NP'\"", '~/Dropbox/FRibliography/bibtex/FRibliography.bib'))

rmarkdown::clean_site()
rmarkdown::render_site()
# browseURL("index.html")
