---
title: "Generating sine-waves with R"
author: "Niko Partanen"
date: "2015-11-01 14:56:00"
output: html_document
layout: post
tags:
- R
- data
excerpt_separator: <!--more-->
---

This topic may not be immediately relevant, but can still be interesting for somebody. So the question is: How to generate sound files with R, which just play sine wave at one specific frequency. One immediate reason is to test the frequencies you are yourself able to hear. I'm now lost somewhere after 17250 hz, which sounds horrendously low, but maybe should not be so unusual for someone in my age (soon 29). <!--more-->


{% highlight r %}
# I load the packages explicitly here, and also refer to them 
# with their namespaces in individual functions.
# I understand this is somewhat redundant, but I hope it makes 
# it more obvious which function is from which package.

library(tuneR)
library(seewave)
library(plyr)

# I needed to do this on Mac to get it work.
# But please install Sox anyway, it is useful!

tuneR::setWavPlayer("sox")

# These are the frequencies we want

rates <- c(100, 200, 300, 400, 800, 1000, 1200, 1400, 1600, 1800, 2000, 4000, 6000, 8000, 10000, 12000, 14000, 15000, 15250, 15500, 15750, 16000, 16250, 16500, 16750, 17000, 17250, 17500, 17750, 18000, 20000)

# This is a tiny function that in principle could also just be inside llply itself.
# I find it easier to read this way when it is on its own and named.

write_sines <- function(x) {
        seewave::savewav(tuneR::sine(x), 
                filename = paste0("~/sounds/sound_", x ,"_hz.wav"))
}

# llply just repeats the function write_sines to all elements in rates character vector

plyr::llply(rates, write_sines)
{% endhighlight %}

So basically this just fills the folder `sounds` with the files like `sound_100_hz.wav` and so on, as specified in the `rates` vector. Just modify the values and overwrite the old files. In principle one of course could had generated those numbers more automatically, but I think in this case some manual adjustment is good to be there, as you never know exactly which ones you or your ears need.

Possible applications:

- Have fun with your cats and high sounds
- Your recording device usually would capture something up to 24 khz. This leaves us the range of 20-24 khz which is not really used as we humans can't hear it. Is there anything on these higher frequencies one could do something with?
