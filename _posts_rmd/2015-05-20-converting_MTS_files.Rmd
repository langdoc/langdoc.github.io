---
layout: post
title:  "Concatenating MTS files"
date:   2015-05-20 23:55:14
---

We are having a good recording session in the village of Krasnoye, Nenetskiy Avtonomnyj Okrug, Northern Russia, when we realise that our new good video camera is filling up the sd-card much faster than we anticipated. Everything on the card is backed up to several external hard drives, I have one copy at my laptop even - let's make there some space. It is not so good practice to touch your SD-cards, they are so cheap that they never really should need to be reused, but this situation demanded radical solutions. I go and remove some of the backupped .MTS files - that is the actual video file, right?

Hell broke loose.<!--more-->

The consequences were not evident very soon. However, the AVCHD file format is a bit more than the actual video files. I had naively thought that the files in the other folders must be for cameras internal work, thumbnails, ok, some playlist, I guess the camera needs those!

When I started to edit the videos I realized this folder structure indeed kept some more information which was crucial for us. When the camera shoots the video, it automatically cuts the video into smaller pieces when they are large enough (with our settings that is something after half an hour, around 2,12 gigabytes per file). The way how these two files exactly combine, as far as I understand it now, is in .CPI files in CLIPINF folder.

    ffmpeg -i kpv_izva20150000-1.MTS -ss 00:00:30.0 -c copy kpv_izva20150000-1-cut.MTS

Now the synchronization is succesful, the approach works, but we are clearly removing too much. It is a matter of just a few frames. The removal should not be detectable in the final result.

We know that the video frame rate is 25 fps. Then one frame should be 0.04 seconds. After some testing I found that removing 16 first frames gives us a clean join. This doesn't happen with any less frames being removed:

    ffmpeg -i kpv_izva20150000-1.MTS -ss 00:00:00.68 -c copy kpv_izva20150000-1-cut.MTS

Doing this processing takes around half a minute, so it is fast enough to test this multiple times with different configurations.

However, when we open the file in Final Cut Pro X there is still something wrong. An annoying small green flash. However, it seems to be the case that we are somehow hitting the right spot with this cut, as any attempt to cut more seems to result in FCPX inserting black timeline between the clips. Now the clips join smoothly, which must be how it is supposed to be. Now we are not losing anything from the **audio** track which is within those two videos. That small green flash is as long as three frames, that makes 0.12 seconds. What I ended up doing was to repeat the previous frame three times, in a configuration more or less like this:

IMAGE HERE!

This leaves to video tiny tiny portion where data is missing, but in the end of the day it is still manageable loss, at least not the worst that could happen with data mismanagement.

## Questions

What are we supposed to do with AVCHD files? That is the original raw data we get. Now it seems that the easiest way to access that data is through a commercial software such as Final Cut Pro X. This is fine, as we anyway have to use something like that to edit the files. However, is the resulting MOV file exactly the same as the original files in what comes to quality? What exactly happens with those files in AVCHD structure when they are opened in FCPX? There are some other open questions, mainly with archiving.

* Should we archive the AVCHD files? If so, how they fit into our session structure? They are usually 30 GB files with lots of session in one large file. They also contain different binary files, would those be accepted as well?

* How about archiving the session related Plural Eyes Project files (.pep) and Final Cut Pro XML (.fcpxml)? Those two files contain all information about the process how the raw files have been transformed into sessions ready to be transcribed.
