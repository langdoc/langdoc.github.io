---
title: "Data workflow for linguistic fieldwork"
excerpt_separator: <!--more-->
date: "2015-09-16 12:45:13"
output: pdf_document
author: Niko Partanen
tags:
- fieldwork
- data
layout: post
---

I think quite a lot has been written about the data management workflows in documentary linguistics. Lots of this is about the whole workflow from field to the archive. I want to document here the workflow I've personally found very good for the immediate work on the field, and also desire to use later. This doesn't even touch the issues of annotating, archiving, publishing or disseminating. **I want to stress that this all is something that in my opinion should be done already at the field. Period. Don't delay it, the consequences are heavy.**<!--more-->

I've encountered occasionally an idea that taking part into a workflow such as presented here would be a sort of a choice. However, you are already there **if** you decide to involve both video and audio into your working practices. The moment you decide to bring a videocamera on the field dictates some aspects from your further workflow as well, as it has to take into account the existence of both audio and video data streams. Naturally it is possible to ignore the video, but in that case one could also ask what was it worth to do it in the first place.

As if the situation would be just about the video. Several modern audio recorders, such as Edirol R-26, automatically produce as a number of audio files from different microphones. In order to work with this data in the most effective way we must somehow take this into account, as an example, by remixing the audio in way that brings up the best aspects of these distinct audio tracks, and recording in such a manner that we actually get the benefit that is there.

The days of having just one track of audio are over. Are we winning or losing with these changes, that is to be seen. But not taking them into account is an ignorance we cannot afford.

<!--more-->

I assume that each part in the presented workflow will change in some point. The technology changes always, and there is no reason to stick into old if some better solution is around. This said, we should not end up using any solutions which we are not thoroughly familiar with. At the same time, it remains the fact that many of our tools are used the most while we are doing fieldwork, which also means that we learn very much about them on the field.

## The raw data

As mentioned, the session raw data is getting wilder and wilder. Often we use several microphones, i.e. some lapel mics + one in a boompole to capture the overall sound. Also the camera makes its own audio track, which may be very usable in many cases. With many cameras this audio is also 6 channel surround, with which we have to consider are all those tracks containing what we want in the best possible constellation. Another thing to note is that many video cameras store their audio in Dolby Digital format which is not particularly transparent. Similarly, the video may be captured in AVCHD format, which also contains it's own particularities.

Generally speaking in documentary linguistics it has been getting more and more common to capture also video. This also turns it into something one is expected to produce. In principle using two cameras is not out of the question, as it solves many problems there inherently are with the camera angle. One can be used to capture the general overview of the setting, and this gives to the other one more freedom to move around and get experimental. This is where the human component comes in. When we start to zoom camera into something that could be interesting, there is always the danger that **the interesting** takes place somewhere else. If we use only one camera we have to be careful, but with two there is already more freedom.

So a normal recording session contains very often at least the several files:

- few audio files
- few video files
- scan from fieldnotes
- metadata files
- photographs of the informants
- general photograph or screenshot from the recording setting itself

In practise the metadata can often be in a database and not in the actual folder with the session raw data, but this is not really the point here.

However, there are many steps before we actually can start to work with this data.

## Data processing

There are few steps one has to take with the raw data.

- synchronization
- mixing
- cutting

This is sort of a post-production phase which has not existed traditionally, but nowadays is there all the time. I've been using **PluralEyes** and **Final Cut Pro X** to do this. There are certainly other alternatives, but as far as I know there aren't really open source solutions for this.

### PluralEyes

What PluralEyes does is to take all the audio and video files and to look for matching segments in the audio spectrograms. This must be very similar to audio fingerprinting tools, used i.e. with Python library DejaVu. However, good side of PluralEyes is that it is easy and fast. It also exports the synchronization metadata as an XML file.

### Final Cut Pro

Final Cut Pro is a commercial video editing software, used widely by different video professionals and amateurs alike. I guess Adobe Premiere does more or less the same job equally well. Also Final Cut Pro allows us to import and export session data as an XML file, by the way.

In PluralEyes we don't really do anything for the files, but in Final Cut Pro we can start to play more with them. Naturally, the question of cutting is very acute. Are we supposed to cut? What kind of videos are we doing as documentary linguists? Well, I guess the answer is that we are doing different videos for different uses. As an example, for a DVD that is sent to informant I may do different cuts than I do for the one that will be transcribed.

At least we have good rationale to cut something away from the beginning and the end, as this often has some noise from setting up the tools and preparing for the session. The main reason to cut, in my opinion, is that often this part is captured by one of the devices, i.e. there is an audio track, but the video camera is just being set up. So it just makes it nicer if we leave that hassle out. On the other hand, this often contains very critical information about how the aims and goals of the session are explained to the informant, how the linguists negotiated among each others who stays where, how the room was rearranged to make recording work better etc. These things do influence the recording quite a lot, so it is very good if that part of the work is also documented. However, should that be part of the transcribed session? Maybe. Should that be sent to the informant who maybe just wants to have a nice DVD with the actual interview?

Another example is that often the recording is interrupted and the technology is turned off for some time. As an example, we may turn camera and recorder off during a phone call or if someone has to leave for some personal errands. However, it is very important question can we just glue these two pieces together, or should we split these two into two different sessions? I've always split them into two, since I think the idea of a session is to represent one temporally consecutive situation. However, if the breaks are somehow very well indicated, I believe there is very little reason not to play around with these things if there is the need. One need would be to make an actually nice video from shorter video and audio recordings which are somehow topically interrelated. This is also nicer to transcribe and watch than treating each little file as their own session.

Of course the Final Cut Pro XML files contain data about the ways how files are rearranged and cut.

### Note about XML files

Naturally it is one thing to archive the XML files produced by these programs and actually do something useful with them. Understanding their structure and actually getting information out from them is not always trivial either. There are no real applications at the moment that would really use this data, similarly, I don't think it has been very common practise to archive XML files like these. However, I think the only way we can excuse the use of commercial software is to make certain that the data is not locked into these systems. In any points. Certainly, the most comfortable way to work with fcpxml files is to open them in Final Cut Pro. But we have to make sure that is not the only option.

## Audio mixing

I must admit that I have no education about this topic. Maybe I should, as I'm a linguist who works with this stuff all the time, but I think there are very few instances of linguistic departments which include audio engineering as a part of their curricula.

I sort of thought I had got it already work nicely, but then one musician friend of mine was listening some ELAN sessions and complained about an echo. Yes, indeed, several audio tracks played simultaneously make sort of a nice sound where everyone can be heard well, but there was indeed some small echo. I remixed the tracks differently, putting some more quiet, some louder, and the echo disappeared. Not that I would understand anything about the process, but clearly this is an enormous field someone should understand about.

The situation is even more acute when it comes to work with old recordings. The sound quality is often quite bad, and there are certainly things we can do. I've used often ReaFir effect in REAPER to mute some frequencies, though there has been no way to include any audio editing software into the current workflow I have with documentary linguistic sessions. As our modern recordings are almost always very decent there is maybe little space for this, but still the question remains that mixing these audio channels from different devices is not trivial task at all.

This also means that it has to be very well indicated which are the actual raw data files and which are mixed for actual session. Naturally for phonetic analysis one should consult the raw data, but what you get into ELAN is usually a mix of several audio files, I see no other alternative.

## Processed data

So now the session folder actually contains already these files:

- few audio files
- few video files
- scan from fieldnotes
- metadata files
- photograhps of the informants
- general photograph or screenshot about the recording setting itself
- PluralEyes XML
- Final Cut Pro XML
- audio file for ELAN
- video file for ELAN
- ELAN file

What I have been doing now is to create new folders for different outputs, i.e. I have folder called session_name-i for the file version that has been sent for the informant, that often contains just a DVD disc image. Then there are folders marked with a, b, and c etc. for distinct subsessions if they exist. Usually they do. One problem is that the session can be understood to work out so that if the beginning hassle counts as something of its own, then that's the part a. Then the actual recording, if uninterrupted, gets the symbol b, and the end hassle is c. So then there is a very large amount of sessions with the symbol b in their name, which feels bit stupid at times, but doesn't really matter so much. Maybe there are better ways to arrange these files.

## What's the point?

My idea about this workflow is such, that this would be ready for every session when we leave the fieldsite. If we have several video files, this version can be done with the most simple and general video there is. Don't worry about nice video for the informants, that can be polished and sent back later. Quality wins over speed in that. For the later use it is possible to remix the video with different angles, this doesn't influence the ELAN file of course in any way, unless there is actual mixing of the content, problems of which I already discussed briefly.

I already keep track from all metadata on the field, and make sure that everything is arranged into their own folders and metadata is filled up, if possible, at the same evening. More days pass more difficult it gets to actually reconstruct what has happened. I think actually taking it as far as even exporting the media for ELAN files and creating those dummy ELAN files does make sense. If this video management workflow is not taken care of instantly, it will become an enormous burden for someone (I've been that someone for several times). Running through this workflow is not very slow in the end, the only slow part is exporting. So process the session data at the evening with a beer or the local mildly alcoholic beverage of choice, leave the computer export and backup over night, repeat. If you have a research assistant or someone else doing this, make sure they are unstressed and have the beverage they deserve, this is not easy work, but it is worth doing on the spot.

I understand this workflow probably doesn't work in locations where electricity is scarce. I work mainly in the Northern Russia, and there the villages are often very good locations for using computer at the evenings. I understand this is not always possible also time-wise, but my advice would be not to let this kind of work accumulate. I've spent months working with video and audio files from few weeks long fieldtrip, and very big part of that could had been ready even before I got back home.

## Is anything going to change?

Maybe when the computers get faster also video exporting gets faster, though this is unlikely as the video probably gets larger at the same rate. Maybe in some point it gets convenient enough to make notes straight away in digital format. This would change a lot, if one could, as an example, timestamp the notes and associate them with the raw data.

There has been this development that there is more and more fieldwork equipment. Two cameras means two tripods, and so on. However, there are some interesting developments. As an example, there have been lately more and more camera models which have a high quality objective in very small body. Naturally, one could assume that cameras like these are very good in video, as modern DSLR's tend to be, and the small size makes them much more user-friendly. Now there are lots of hipstery retro models out there, but in some point we probably start to see products that could be immediately useful for documentary linguists as well. Just a note, in this workflow the video needs only some audio, it can be really bad even, just enough that it can be synchronized with the audio files.

The majority of events we record tend to be interviews of some sort. They are in many ways near conversations, but there is often the setting that one tells and another asks. Even when there are multiple participants it is normal that someone takes a very central role and does the most of the speaking. It isn't fully solved how to record more naturally occurring speech events, usually luck has something to do with that. I think one change in the thinking would be to realize that now we basically record people when they are supposed to say something. Instead we maybe should record people when they do something, and if we are lucky, they say something. This means that we would end up recording much more situations where no one actually says a thing. I'm not currently certain how to move forward with that, but I'm sure the coming years will be interesting.

Of course it is very interesting if we would have recordings that last many hours and contain only few utterances. Why not. Hard disk space is cheap. These languages being used naturally is priceless.
