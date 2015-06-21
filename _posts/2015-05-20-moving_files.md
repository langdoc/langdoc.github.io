---
layout: post
title:  "Moving files in Terminal"
date:   2015-05-18 23:55:14
tags: [Terminal]
excerpt_separator: <!--more-->
---

It is very common that we have a large amount of files in one folder, and then for whatever reason we decide that we would need to create for each filename a unique folder, where the different files sharing same name but different endings could reside. I had recently lots of ELAN files which I wanted to move into their own directories. I believe this is a very common situation, so I wanted to share it. <!--more--> It can be done with these three commands. Just copy paste them one by one to the Terminal.

**First command:** This makes the directories with the name of each ELAN file

    ls | grep '\.eaf$' | sed 's/.eaf//g' | xargs mkdir

**Second command:** This uses grep to pick all ELAN files, then creates variables for different things and repeats the move for each file

    #!/bin/bash
    for file in `ls | grep '\.eaf$'`
    do
        SESSIONNAME=$(echo $file | sed 's/.eaf//g')
        MOVFILE="$file"
        MOVDESTINATION="./$SESSIONNAME/$file"
        /bin/mv $MOVFILE $MOVDESTINATION;
    done


**Third command:** This does exactly the same as the second but for pfsx files.

    #!/bin/bash
    for file in `ls | grep '\.pfsx$'`
    do
        SESSIONNAME=$(echo $file | sed 's/.pfsx//g')
        MOVFILE="$file"
        MOVDESTINATION="./$SESSIONNAME/$file"
        /bin/mv $MOVFILE $MOVDESTINATION;
    done

I did the same recently with a folder full of mp3 and wav files. The model is identical, just the filename differs. This can be a convenient way to rearrange messy file structure, just to start dragging everything into one folder and move onward with commands like these. This also forces to check that all files are consistently named, which is of course necessary for well structured corpus.
