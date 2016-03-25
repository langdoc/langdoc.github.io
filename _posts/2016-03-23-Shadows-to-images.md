---
title: "Adding shadows to images"
author: "Niko Partanen"
date: "2016-03-23 10:56:00"
output: html_document
layout: post
tags:
- Terminal
- maps
excerpt_separator: <!--more-->
---

I'm not certain if this is something anyone needs often, but at least I was surprised to learn this can also be done from the command line. So I needed to overlay something on a map as a marker, and already had fired up Gimp and started to edit a shadow file to be used in JavaScript. Little I knew that ImageMagick was able to do that as well!  <!--more-->

So if one would start with a file like this:

![example](https://upload.wikimedia.org/wikipedia/commons/2/29/Icon256x256.png)

With command like this:

    convert Icon256x256.png '(' +clone -background black -shadow 80x100+100+100 ')' +swap -background none -layers merge +repage cat_shadowed.png

We get a one with background shadow!

![shadow_example](/media/figures/cat_shadowed.png)

You have to play with the numbers to get the direction, size and distance of the shadow right. I think the main potential use for this is in map icons.
