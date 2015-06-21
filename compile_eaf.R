# We use R package FRelan to parse the data
library(plyr)
library(dplyr)
library(FRelan)
library(readr)

kpv_vanejev <- read_eaf(eaf.list = "~/Desktop/github/data/izma/kpv_udora/kpv_udo19420000SFOuVanejevMN.eaf", 
                        part = "partT")
kpv_vanejev$PartID <- as.numeric(kpv_vanejev$PartID)
vanejev_meta <- read_delim("/Users/niko/Desktop/github/data/izma/kpv_udora/kpv_udo19420000SFOuVanejevMN-part.csv", 
                           delim = "\t")

vanejev <- left_join(kpv_vanejev, vanejev_meta) %>% 
        select(Word, Title_eng, Categories, PartID)
vanejev$Date <- "1942-01-01"
vanejev$Session_name <- paste0("Syrjaenische_Texte_III-", vanejev$PartID)

parts <- split(vanejev, vanejev$Session_name)

header <- llply(parts, function(x) paste0("---\nlayout: post\ntitle: ", 
                                          '"', x$Title_eng[1], '"',
                                          "\ndate: ", x$Date[1], 
#                                          "\nexcerpt_separator: <!--more-->",
                                          "\ntags: [", x$Categories[1], 
                                          "]\n---\n\n"))

narrative <- llply(parts, function(x) paste(x$Word, collapse = " "))

filenames <- as.character(unique(vanejev$Session_name))
header <- as.character(header)
narrative <- as.character(narrative)
citation <- "\n\nSource: *Syrjänische Texte. Bd III. Komi-Syrjänisch: Luza-Letka-, Ober-Sysola-, Mittel-Sysola-, Prisyktyvkar-, Unter-Vychegda- und Udora-Dialekte.* Gesamm. von **T. E. Uotila**. Übers. und hrsg. von **Paula Kokkonen**. SUST/MSFOu 202. 1989. [XI] + 401 p. (ISBN 951-9403-27-2). Digital files processed by **Niko Partanen** in 2013 within Down River Vashka Project. Scanned book partially available at the website of [Finno-Ugrian Society](http://www.sgr.fi/sust/st/st3.pdf)"

#### This is now a good place to stop and fix the narrative parts for whatever problems 
#### there are, i.e. with unconventional spellings, too many spaces etc. They could of
#### course be fixed directly to ELAN files, but at times this is not convenient. These
#### corrections serve also a list of things that have to be done to the originals in
#### some point.
#### It is also good to add somewhere Jekyll excerpt separator which is now <!--more-->

library(stringr)
narrative <- llply(narrative, function(x) str_replace_all(string = x, pattern = "^(.{200,220} )", replacement = "\\1<!--more-->"))
narrative <- llply(narrative, function(x) str_replace_all(string = x, pattern = " (\\.|\\!|\\?|,|;|:|\\))", replacement = "\\1"))
narrative <- llply(narrative, function(x) str_replace_all(string = x, pattern = "(\\() ", replacement = "\\1"))
narrative <- unlist(narrative)

files <- data.frame(filenames, header, narrative, citation, stringsAsFactors = FALSE)

files$date <- "1942-01-01"

d_ply(files, 1, function(x) {
        content <- paste0(x$header, x$narrative, x$citation)
        filename <- paste0("_posts/", x$date, "-", x$filenames, ".markdown")
        write.table(x = content, 
                    file = filename, 
                    row.names = FALSE, col.names = FALSE, quote = FALSE)
})

corpus <- vanejev

######
###### After this we have to generate the tag layouts
###### The model is for _data/tags.yml
###### 
###### - slug: github-pages
######   name: GitHub Pages
######
###### We also have to add .md files like:
###### 
###### blog/tag/github-pages.md
###### 
###### Their content needs to be:
###### ---
###### layout: blog_by_tag
###### tag: github-pages
###### permalink: /blog/tag/github-pages/
######  ---
######  

# We extract the unique tags:

corpus %>% distinct(Categories) %>% select(Categories) -> tags

yml <- paste0("- slug: ", tags$Categories, "\n  name: ", tags$Categories, "\n\n")

write.table(x = paste(yml, collapse = ""), file = "_data/tags.yml", row.names = FALSE, col.names = FALSE, quote = FALSE)

d_ply(tags, 1, function(x) {
        content <- paste0("---\nlayout: blog_by_tag\ntag: ", x$Categories, "\npermalink: /blog/tag/",  x$Categories, "/\n---")
        filename <- paste0("blog/tag/", x$Categories, ".md")
        write.table(x = content, 
                    file = filename, 
                    row.names = FALSE, col.names = FALSE, quote = FALSE)
})

