## Heat map for susrita
#clean work space
remove(list = ls())

## geom data for India at district level
library(leaflet)
library(maps)
library(geojson)
library(dplyr)
library(ggplot2)
library(rjson)
library(jsonlite)
library(leaflet)

## Base file for India map downloaded from GADM: https://gadm.org/download_country_v3.html 
gadm36_IND_3_sp <- readRDS("~/Desktop/gadm36_IND_3_sp.rds")

Banswara <-  subset(gadm36_IND_3_sp, NAME_2=="Banswara")

Banswara@data[["NAME_3"]]

Banswara@data[["NAME_3"]] <- c("Banswara", "Garhi", "Ghatol", "Kushalgarh", "Bagidora")

## load Rojasthan map
Banswara_map <- leaflet(Banswara) %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL),
              weight = 1, 
              smoothFactor = 0.5,
              color = "white",
              dashArray = "3")

Banswara_map %>% addPolygons(stroke = FALSE, smoothFactor = 0.2, 
                             fillOpacity = 0.2, label = ~NAME_3)
