---
layout: post
title:  "Google Docs and Markdown"
date:   2015-06-21 23:55:14
tags: [R, workflows]
excerpt_separator: <!--more-->
---

We were recently writing a small abstract together with a few colleagues (Michael Rießler and Hanna Thiele). We started in Dropbox, but that is, as usually, quite bad in intensive writing. In principle we could use other tools we use already anyway, GitHub or SVN, but the same problem remains that it would be very convenient to see what others are editing and use some clear system for commenting.<!--more-->

I personally like to write this kind of simple things in Markdown. It has several advantages over LaTeX. It is easy, fast to type and allows good connection with bibtex bibliography. So I started to think whether there is some way to combine the best of both worlds. I know there are some other collaborative editors for Markdown itself, but there were some other reasons to stick to Google Docs. I have one colleague with who I collaborate regularly, who uses ChromeBook as his main computer. Thereby for him it is the best to stick into that. And this means that for me it is the best to figure out some ways to use Google Docs more effectively.

The workflow presented here was inspired by this [blogpost](http://ericpgreen.com/reproducible-research-with-word/) by Eric P. Green, though it is not at all that sophisticated.

All code is stored in a GitHub [repository](www.github.com/langdoc/GoogleDocs_with_md), but I go it through here piece by piece. Here are the steps that come.

- Create a YAML header
- Download text from Google Docs
- Remove mysterious NUL character from the beginning of file
- Delete the comments that may be present
- Combine the header and the text
- Write those into a markdown document
- Render HTML
- Render PDF

It is really very simple. **The idea is to read data directly from Google Docs.** And it allows [this](https://docs.google.com/document/d/1D1C_79nLDM25r96dWinufVUd70-ipsHzv6cK-9cK-Io/edit?usp=sharing):

![Google Docs](/media/figures/example_gdocs.png)

To be turned into something like this:

![Example PDF](/media/figures/example_pdf.png)

Or into an HTML page, or into .docx file, or .epub, or basically into anything [Pandoc](http://pandoc.org/) supports. So let's go through step by step how this works.

### The header

Header is a simple block of YAML. We are telling it the date, author, title, the location of a bibliography and other such details. It depends a bit from our desired output format what we want to have here, as we can also pass many of these settings directly into Pandoc. Here we just save the header as a character string.


{% highlight r %}
header <- '---
title: "Collaborative authoring in Google Docs"
author: "Niko Partanen"
date: "19 Jun 2015"
pdf_document:
        keep_tex: yes
bibliography: ./bibtex/FRibliography_example.bib
---
'
{% endhighlight %}

### Reading the file

Then we read the file from Google Docs and write it as a file. The link to Google Docs is very easy to generate. You can get the document ID from the link you use to share it.

The structure is like this:

    https://docs.google.com/document/d/put-id-here/export?format=txt

One could have there also some other format, but a simple text file is the best for now.


{% highlight r %}
library(readr)

doc <- read_file("https://docs.google.com/document/d/1D1C_79nLDM25r96dWinufVUd70-ipsHzv6cK-9cK-Io/export?format=txt")

fileConn <- file("temp.txt")
writeLines(doc, fileConn)
close(fileConn)
{% endhighlight %}

### Removing the NUL character

For some reason the text file contains a [NUL character](https://en.wikipedia.org/wiki/Null_character) in the beginning of the first line. I don't understand at all what it is doing there, but R, LaTeX and Pandoc are all giving errors for it later, so having it around is unacceptable. I was trying to find out how to delete it for quite some time, and ended up to do it from Terminal, by simply removing those first bytes.


{% highlight r %}
system("cat temp.txt | tail -c +4 > temp_clean.txt")

doc <- read_file("temp_clean.txt")
{% endhighlight %}

I would be very happy to know if there is some easier way to do this!

### Removing the comments

It is possible that there are some comments left into the document. They have formatting like [a] or [b] in the text, and the actual comment text comes to the end. I assume there could be some way to turn them into footnotes in the PDF, but at the moment I just want to delete them.


{% highlight r %}
doc <- gsub("(.+## References).+", "\\1", doc)
doc <- gsub("\\[.\\]", "", doc)
{% endhighlight %}

### Putting it together

Then we simply paste together the header and the document. This is then written into a new Markdown document.


{% highlight r %}
full_paper <- paste0(header, doc)

fileConn <- file("example.md")
writeLines(full_paper, fileConn)
close(fileConn)
{% endhighlight %}

### Converting the files

After this we can start to convert the file. Now I convert it into HTML and PDF. **Note for linguists:** The default fonts used here are not very good for any exotic script. There are lots of situations where the basic fonts in principle can handle what you have there, but in some specific situations (such as within a code block) the font in that environment doesn't have what you need. Well, this is how the things always are with typography and lesser used languages. But remember to play with Pandoc font settings if you have any non-latin stuff there.


{% highlight r %}
library(rmarkdown)

render('example.md', output_format = "html_document")

system("pandoc example.md --latex-engine=xelatex --biblio ./bibtex/FRibliography_example.bib -o example.pdf --variable mainfont=Georgia")
{% endhighlight %}

We can even turn it into an EPUB! Not that this would be necessary, but it is possible! I like epubs a lot, not really for scientific texts, but for normal books they are pleasant to use.


{% highlight r %}
system("pandoc example.md --biblio ./bibtex/FRibliography_example.bib -o example.epub")
{% endhighlight %}

![epub](/media/figures/example_epub.png)

Now there are already some font issues rising their ugly heads...

As the last thing I also convert the PDF into a picture used in the beginning of this post. It uses free program [ImageMagick](http://www.imagemagick.org/script/index.php).


{% highlight r %}
system("convert -density 300  example.pdf example.png")
{% endhighlight %}

The script can be downloaded in one piece from [here](www.github.com/langdoc/GoogleDocs_with_md/compile_gdocs.R).
