---
layout: post
title:  "Spectrograms with Spek"
date:   2015-05-18 23:55:14
tags: [audio, recording]
excerpt_separator: <!--more-->
---

One of the problems in ELAN is that it doesn't really give you a good picture from the wave form for the whole file. Often this is full of visual cues that help us to find relevant pieces, i.e. songs, where new section starts etc. Naturally for different purposes we need different views, and this means use of different programs which handle some aspect particularly well.<!--more-->

To get overview into the file, I'd say that among free programs Audacity does this well, Reaper is another good low-cost option, but I think the way Audacity produces the view is the most telling. (I bet one can produce waveforms also directly from R with [Seewave R package](http://rug.mnhn.fr/seewave/), but this is an experiment for another time.)

One thing we would need every now and then is to have very clean spectrograms from the audio in order to see what is really going on at the different frequencies, especially the highest ones. This tells us a lot about the background noices of the recording space.

This example is from one session which was done indoors in a quiet environment, closed door, closed windows. But there was some periodic work going on outside which we didn't really hear through closed window, but it was there. Some sort of machinery operating pretty far away from us, but still apparently close enough for microphones to catch something from it.

![Spek image](/media/figures/0409_100225.WAV.png)

The pattern here reminds the one produced by every fieldworkers enemy number one: the Russian refridgerator. This is something less problematic, not really even audible in itself. Ideally we would have view like this into our recordings while they are being done.

This also reminds from [Nyquist–Shannon sampling theorem](http://en.wikipedia.org/wiki/Nyquist%E2%80%93Shannon_sampling_theorem). It states that the highest frequency that can be captured is approximately half from the sampling rate chosen. As our sampling rate is always 48 kHz, it means that we would capture something up to 20+ kHz. This seems to be the case. And it is of course reasonable as we capture basically the range a human can hear and a bit extra.

What would happen if the sampling rate would be higher? As a very young man I was doing fieldwork in Karelia, and indeed some time had set the sampling rate into 96 kHz. I must have been thinking that if I have the settings high enough at least I can't screw it up! Well, I guess there is no harm done, only wasted hard disk space. 

![Spek image 2](/media/figures/0515_124033.WAV.png)

Suddenly there are higher frequencies! And this must be a consequence of higher sampling rate. These both files were recorded with Edirol HR-09 recorder, but the first one with an external lapel mic. That explains the exceptional clarity of the signal.

In principle, if one would record in a cave full of bats, then would their high-frequency noise appear as distortion on 48 kHz recording but be captured adequately at the 96 kHz recording? The problem is that those high frequency sounds are present in the lower sampling rate too, they just are not there so systematically that their actual form would had been captured! Something to think about (yet nothing to act upon, this is a theoretical question)!

## Things to do

* Check what is going on at the Praat level of view with higher frequency noises on and off
* Simulate the environment with lots of above-hearing-level frequency noise and see what happens to the recordings
