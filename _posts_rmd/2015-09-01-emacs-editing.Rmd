---
layout: post
title:  "Editing text blocks in Emacs"
date:   2015-09-01 11:06:13
tags: [emacs, digitalization]
excerpt_separator: <!--more-->
---

Often when we digitalize some text collections we end up with text blocks in one language, and the translations on some other language in similar blocks. However, in our modern language collections the text is divided into utterances, which often more or less do match with sentences.

There is no automatic way to match the sentences, because there isn't always exact correspondence at the sentence level. However, some ways to work with this data are more difficult than the others. <!--more--> One can start with some regular expressions such as these.

The point of this is to mark paragraph breaks with the hash character.

    "\n" > "\n#\n"

Then we can try to separate the sentences into their own lines.

    "(\.|\,|\?|\!|\:) " > "$1\n"

This works quite well. But there is still mismatch, almost always, at least when we have a longer text. I do this often in TextMate, but any text editor can handle this simple things.

## Editing with Emacs

I don't use Emacs that often, though there are some situations where it is irreplaceable. One situation is this. We can open the two text blocks in two diagonally split buffers, and make our editing way easier with following commands in both buffers:

    M-x toggle-truncate-lines

Now each line contains one string we want to match. Then let's have line numbers:

    M-x linum-mode

Then the last one, which actually makes all this effort worthwhile:

    M-x scroll-all-mode

Now the both buffers are scrolling down and up simultaneously. With `C-x-o` we can move between the buffers, and by moving sideways between the lines it is easy to keep two trackers matching.
