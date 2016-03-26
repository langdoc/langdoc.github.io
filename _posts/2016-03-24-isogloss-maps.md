---
title: "Isogloss maps with Shapefiles"
author: "Niko Partanen"
date: "2016-03-23 18:00:00"
output: html_document
layout: post
tags:
- R
- maps
excerpt_separator: <!--more-->
---

I've been working lately a lot with language areas as different Shapefiles. This works nicely, and usually it is quite unproblematic to make a functional map. There are some problems I haven't solved, mainly with the best way to store different attributes relevant for languages, but which I wouldn't like to store repeatingly inside the Shapefile. But now I tackle a bit different issue, which is the use of Shapefiles to mark isoglosses. As usually, I don't want to take the easiest route, but would look for something efficient, economic, pretty and easy to manage. <!--more-->

Let's take a look into a Shapefile, or Geojson, whatever. When the data is read to R as `SpatialPolygonsDataFrame` it behaves the same way whatever the origin. It is bit more complex format which has slots for different kinds of information. The most important ones are `@data` and `@polygons`. The first is just a data frame, and it can be accessed with `object@data$column`. It is possible to do there quite many of those things which you would do with any other data frame, which makes it very powerful tool.


{% highlight r %}
library(rgdal)
library(dplyr)
library(leaflet)

# Here we read in the polygons - now in geojson, but the original format is not that relevant

kpv <- readOGR("https://raw.githubusercontent.com/nikopartanen/language_maps/master/geojson/kpv.geojson", "OGRGeoJSON")
koi <- readOGR("https://raw.githubusercontent.com/nikopartanen/language_maps/master/geojson/koi.geojson", "OGRGeoJSON")
jzv <- readOGR("https://raw.githubusercontent.com/nikopartanen/language_maps/master/geojson/koi-j.geojson", "OGRGeoJSON")

# Those polygons are added as new layers to the Leaflet map

map <- leaflet() %>%
              addProviderTiles("Esri.WorldTopoMap") %>%
    addPolygons(data = kpv,
              fillOpacity = 0.4, 
              color = "gray", 
              weight = 1,
              popup = ~dial) %>%
    addPolygons(data = koi,
              fillOpacity = 0.4, 
              color = "gray", 
              weight = 1,
              popup = ~dial) %>%
    addPolygons(data = jzv,
              fillOpacity = 0.4, 
              color = "gray", 
              weight = 1,
              popup = ~dial)
{% endhighlight %}

<iframe width="100%" height="500" src="http://nikopartanen.github.io/language_maps/webmap/komi_basic.html"></iframe>

Now there are of course lots of different isoglosses, but they don't necessarily align by dialects. So we cannot just store information with what kind of isogloss value which polygon is associated. In a way where this line goes can be rather arbitrary, although it is also absolute in the sense that at least on more abstract level we can say this line goes along the line. It is always another question how the isoglosses pattern in our actual corpus data. But I think both representations have their own value and use.

This is a good example which cuts across all main variants, showing the variation in stress within Komi. It is taken from Batalova's 1982 book **Ареальные исследования по восточным финно-угорским языкам (коми языки)**, page 41.

![stress in Komi](/media/figures/batalova1982a-41.png)

To explain it simply, the majority of Komi-Zyrian has no morphologically significant stress, but in some southern dialects this feature is present, as it is in almost all Komi-Permyak, besides small eastern region where the stress is connected to vowel system more widely, as it is in all Komi-Yazva. In this case almost all action is in the southern varieties, so I'll try to display it so that the attention is more theere (and some southern varieties are geographically very small, which makes them difficult to show on large scale maps).

We could take the polygons above and modify a variant which is cut according to this pattern, but this has some problems as well. Mainly that the changes in original polygons would not be reflected in the Shapefiles which contain the isoglosses! This would have fast quite disastrous results, and generally speaking would not be very elegant.


{% highlight r %}
library(maptools)

# This is same as above, but the polygon is read from Shapefile

isogloss <- readShapePoly("/Volumes/langdoc/maps/language_maps/isoglosses/kom.shp", proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

map %>% addPolygons(data = isogloss,
              fillOpacity = 0.1, 
              color = "gray", 
              weight = 3,
              popup = ~value)
{% endhighlight %}

<iframe width="100%" height="500" src="http://nikopartanen.github.io/language_maps/webmap/komi_isogloss_blobs.html"></iframe>

This is maybe a bit strange approach. But in many ways it is the best I've come up with. We can use this command from GDAL to clip the isogloss polygon with the areas defined in the language polygon.

    ogr2ogr -clipsrc langs/kom/kom.shp isoglosses/kom_isogloss_1_cut.shp isoglosses/kom_isogloss.shp

This gives us something we can easily use elsewhere on maps. It will look as good as the language polygons do, but we can associate any kind of overlays with it and still be rather sure things are not breaking apart. The isogloss shapefiles will not need special maintenance work when the language polygons are modified, and this is something really important if the idea is to have something more reliable than just graphics used once and forgotten.

It can be bit annoying ot modify Shapefiles like these, so take a look into snapping options in QGIS to make this bit easier. Otherwise it would be next to impossible to get the polygons align prettily, and I think it is quite crucial there are no holes between the polygons.

There is nothing really new going on in the map below, but note that we are using `RColorBrewer` package to set up the color scheme. The colors are always little bit complicated. On one hand they should just appear automatically and be nice, but that doesn't work so well with varying number of features, and at times some combinations just don't work and you want to touch them manually. However, something with `RColorBrewer` should be simple enough to have inside a function which tries to select suitable color palette for most of the cases. And if there would be tens of different values to map, it probably would not be always that good idea to place them all on one map to start with.


{% highlight r %}
library(RColorBrewer)

isogloss_cut <- readShapePoly("/Volumes/langdoc/maps/language_maps/isoglosses/kom_isogloss_1_cut.shp", proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

# Here we need to play around a bit to get the values and colors correctly both on map and in legend.
# There maybe is some better way to do it, but this is how I've done it now.

value <- as.character(distinct(isogloss_cut@data, value) %>% arrange(value) %>% .$value) 
colors <- RColorBrewer::brewer.pal(length(value), "Dark2")

leaflet() %>% setView(lng = 54, lat = 60, zoom = 6) %>% 
    addProviderTiles("Esri.WorldTopoMap") %>%
    addPolygons(data = isogloss_cut,
              fillOpacity = 1,
              fillColor = ~colors,
              weight = 1,
              popup = ~value,
              stroke = .5) %>%
  addLegend("bottomright", colors = colors, labels = value,
    title = "Stress in Komi Dialects",
    opacity = 1)
{% endhighlight %}

<iframe width="100%" height="500" src="http://nikopartanen.github.io/language_maps/webmap/komi_isogloss_stress.html"></iframe>

I think the next topic would be how to associate points with polygons, for example, to gather data from polygon layers to the token level data frames where there are different coordinates. It could be quite interesting to locate all speakers whose bithplace and place of residence are on different isogloss areas, as just looking to the adaptation of different variables could be enlightening.
