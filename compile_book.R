library(rmarkdown)
library(bookdown)
# render(input = "_posts/1942-01-01-Syrjaenische_Texte_III-186.markdown", 
#        output_format = pdf_document(latex_engine = "xelatex"), 
#        output_file = "book/1942-01-01-Syrjaenische_Texte_III-186.pdf")
# 
# 
# library(knitr)
# pandoc(input = "./_posts/1942-01-01-Syrjaenische_Texte_III-186.markdown", config = "config.txt")
# 
# system("pandoc _posts/*.markdown -o book/ST3_udora.pdf --latex-engine=xelatex --number-sections --variable mainfont=Arial")


# Render chapters into tex  ----------------------------------------------------
needs_update <- function(src, dest) {
        if (!file.exists(dest)) return(TRUE)
        mtime <- file.info(src, dest)$mtime
        mtime[2] < mtime[1]
}

render_chapter <- function(src) {
        dest <- file.path("book/tex/", gsub("\\.rmd", "\\.tex", src))
        if (!needs_update(src, dest)) return()
        
        message("Rendering ", src)
        command <- bquote(rmarkdown::render(.(src), bookdown::tex_chapter(),
                                            output_dir = "book/tex", quiet = TRUE, env = globalenv()))
        writeLines(deparse(command), "run.r")
        on.exit(unlink("run.r"))
        source_clean("run.r")
}

source_clean <- function(path) {
        r_path <- file.path(R.home("bin"), "R")
        cmd <- paste0(shQuote(r_path), " --quiet --file=", shQuote(path))
        
        out <- system(cmd, intern = TRUE)
        status <- attr(out, "status")
        if (is.null(status)) status <- 0
        if (!identical(as.character(status), "0")) {
                stop("Command failed (", status, ")", call. = FALSE)
        }
}

chapters <- dir("_posts", pattern = "\\.markdown$")
lapply(chapters, render_chapter)

# Copy across additional files -------------------------------------------------
file.copy("book/downrivervashka.tex", "book/tex/", recursive = TRUE)
# file.copy("diagrams/", "book/tex/", recursive = TRUE)
# file.copy("screenshots/", "book/tex/", recursive = TRUE)

# Build tex file ---------------------------------------------------------------
# (build with Rstudio to find/diagnose errors)
old <- setwd("book/tex")
system("xelatex -interaction=batchmode downrivervashka ")
system("xelatex -interaction=batchmode downrivervashka ")
setwd(old)

file.copy("book/tex/downrivervashka.pdf", "book/downrivervashka.pdf", overwrite = TRUE)
