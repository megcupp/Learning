library(leaflet)
library(maps)
library(geojson)
library(tidyverse)
library(readxl)

rm(list=ls())

UK <- readRDS("~/Desktop/gadm36_GBR_3_sp.rds")

Schools <- read_excel("~/Desktop/Adunlocked.xlsx")
View(Schools)

UK_map <- leaflet(UK)

Schools$Latitude <- as.numeric(as.character(Schools$Latitude))

mapping <- function(ID) {
  UK_map %>% addProviderTiles(providers$Stamen.Toner) %>% 
  addCircleMarkers(Schools$Latitude, Schools$Longitude, radius = 2, opacity = 0.2, color = "red", label=Schools$School, labelOptions = labelOptions(noHide = F, textOnly = TRUE, direction = "center"))
}

Final_map <- lapply(1:120, mapping)

# color idea
## https://rpubs.com/jcheng/example2
