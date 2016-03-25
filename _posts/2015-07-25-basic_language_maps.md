---
layout: post
title:  "Basic language maps"
date:   2015-07-25 23:55:14
tags: [maps, R, leaflet]
excerpt_separator: <!--more-->
---

I started to write some long rant about the data situation with semi-large language like Komi, and ended up combining it to geographical locations, with which I ended into mapping. For quite a while I had problems in embedding Leaflet/R based maps into Github Pages, although now when I realized how it works it is actually ridiculously easy. There are many frameworks to work with maps, but I think at the moment Leaflet is the one doing best. What kind of complicates the things is how one can use Leaflet within different frameworks, basically with JavaScript and with R. I have been working with both of them intensively, and started also collecting different language maps into a new Github repository called [Language Maps](http://github.com/nikopartanen/language_maps/).<!--more-->

I have this idea that we are not using geographical data as complexly as could.

At the moment the map shows only Komi-Zyrian dialects. I'm on my way to connect it to our database and get some markers from there.

<iframe width="100%" height="500" src="http://nikopartanen.github.io/language_maps/webmap/kpv_dial.html"></iframe>

Also more complicated work is possible, as an example, the map below shows the languages which are part of the INEL project I'm now working with.

<iframe width="100%" height="500" src="http://nikopartanen.github.io/language_maps/webmap/language_maps_inel_osm.html"></iframe>



