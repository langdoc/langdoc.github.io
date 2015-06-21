# We use R package FRelan to parse the data
library(plyr)
library(dplyr)
library(FRelan)
library(readr)


corpus_udora <- read_eaf("../data/izma/kpv_udora/")


corpus_sessions <- split(corpus_udora, corpus_udora$Session_name)
story <- corpus_sessions[53]
story <- do.call(rbind.data.frame, story)


story$Date <- "2013-08-06"
story$Title_deu <- "Valeri Butyrev Anekdote erzählt"
story$Categories <- "fishing, anecdote"


header <- paste0("---\nlayout: post\ntitle: ", '"', story$Title_deu[1], '"', "\ndate: ", story$Date[1], "\ncategories: ", story$Categories[1], "\n---\n\n")

narrative <- paste(story$Word, collapse = " ")

write.table(x = paste0(header, narrative), 
            file = paste0("_posts/", story$Date[1], "-", story$Session_name[1], ".markdown"), 
            row.names = FALSE, col.names = FALSE, quote = FALSE)

###########


kpv_vanejev <- read_eaf(eaf.list = "~/Desktop/github/data/izma/kpv_udora/kpv_udo19420000SFOuVanejevMN.eaf", part = "partT")
kpv_vanejev$PartID <- as.numeric(kpv_vanejev$PartID)
vanejev_meta <- read_delim("/Users/niko/Desktop/github/data/izma/kpv_udora/kpv_udo19420000SFOuVanejevMN-part.csv", delim = "\t")

vanejev <- left_join(kpv_vanejev, vanejev_meta) %>% select(Word, Title_deu, Categories, PartID)
vanejev$Date <- "1942-01-01"
vanejev$Session_name <- paste0("Syrjänische Texte III: ", vanejev$PartID)

parts <- split(vanejev, vanejev$Session_name)
        
header <- llply(parts, function(x) paste0("---\nlayout: post\ntitle: ", '"', x$Title_deu[1], '"', "\ndate: ", x$Date[1], "\ntags: [", x$Categories[1], "]\n---\n\n"))
        
narrative <- llply(parts, function(x) paste(x$Word, collapse = " "))

filenames <- as.character(unique(vanejev$Session_name))
header <- as.character(header)
narrative <- as.character(narrative)

files <- data.frame(filenames, header, narrative, stringsAsFactors = FALSE)

files$date <- "1942-01-01"

d_ply(files, 1, function(x) {
        content <- paste0(x$header, x$narrative)
        filename <- paste0("_posts/", x$date, "-", x$filenames, ".markdown")
        write.table(x = content, 
                    file = filename, 
                    row.names = FALSE, col.names = FALSE, quote = FALSE)
})
