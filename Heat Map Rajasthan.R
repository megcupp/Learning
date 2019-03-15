## Heat map for Susrita
# clean work space
remove(list = ls())

library(leaflet)
library(maps)
library(geojson)
library(dplyr)
library(ggplot2)
library(rjson)
library(jsonlite)
library(leaflet)

## data for India at district level - level 2 GADM

## Base file for India map downloaded from GADM: https://gadm.org/download_country_v3.html 
gadm36_IND_2_sp <- readRDS("~/Desktop/gadm36_IND_2_sp.rds")

# subset only to Rajasthan
Rajasthan <-  subset(gadm36_IND_2_sp, NAME_1=="Rajasthan")

# Check district names in Rajasthan
Rajasthan@data[["NAME_2"]]

## add datafile to overlay color in map
library(readxl)
Data <- read_excel("Data of accesible institutions.xlsx")

TOTAL <- as.data.frame(Data$total.CHC.PHC)
PERCENT <- as.data.frame(Data$perc.CHC.PHC)
NO <- as.data.frame(Data$no.CHC.PHC)
STERILE <- as.data.frame(Data$No.Sterilization)
JYV <- as.data.frame(Data$No.JSY)

## add Susrita's data to map file
Rajasthan@data <- cbind(Rajasthan@data, TOTAL)
Rajasthan@data <- cbind(Rajasthan@data, PERCENT)
Rajasthan@data <- cbind(Rajasthan@data, NO)
Rajasthan@data <- cbind(Rajasthan@data, STERILE)
Rajasthan@data <- cbind(Rajasthan@data, JYV)

## load Rojasthan map
Rajasthan_map <- leaflet(Rajasthan) %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)


#coloring for % data
binpal <- colorBin("Reds", Rajasthan@data[["Data$perc.CHC.PHC"]], 6, pretty = TRUE)

Rajasthan_map %>% addPolygons(fillColor = ~binpal(Rajasthan@data[["Data$perc.CHC.PHC"]]), 
                              weight = 1, 
                              smoothFactor = 0.5,
                              color = "black",
                              dashArray = "1", 
                              fillOpacity = 1) %>% 
  addLegend(pal = binpal, values = Rajasthan@data[["Data$perc.CHC.PHC"]], opacity = 1, 
            title = "% of Difficult and Very Difficult CHC + PHC")


binpal <- colorBin("Reds", Rajasthan@data[["Data$total.CHC.PHC"]], 6, pretty = TRUE)

Rajasthan_map %>% addPolygons(fillColor = ~binpal(Rajasthan@data[["Data$total.CHC.PHC"]]), 
                              weight = 1, 
                              smoothFactor = 0.5,
                              color = "black",
                              dashArray = "1",  
                              fillOpacity = 1) %>% 
  addLegend(pal = binpal, values = Rajasthan@data[["Data$total.CHC.PHC"]], opacity = 1, 
            title = "Total CHC + PHC")


binpal <- colorBin("Reds", Rajasthan@data[["Data$no.CHC.PHC"]], 6, pretty = TRUE)

Rajasthan_map %>% addPolygons(fillColor = ~binpal(Rajasthan@data[["Data$no.CHC.PHC"]]), 
                              weight = 1, 
                              smoothFactor = 0.5,
                              color = "black",
                              dashArray = "1",  
                              fillOpacity = 1) %>% 
  addLegend(pal = binpal, values = Rajasthan@data[["Data$no.CHC.PHC"]], opacity = 1, 
            title = "No. of Difficult and Very Difficult CHC + PHC")


binpal <- colorBin("Reds", Rajasthan@data[["Data$No.Sterilization"]], 6, pretty = TRUE)

Rajasthan_map %>% addPolygons(fillColor = ~binpal(Rajasthan@data[["Data$No.Sterilization"]]), 
                              weight = 1, 
                              smoothFactor = 0.5,
                              color = "black",
                              dashArray = "1",  
                              fillOpacity = 1) %>% 
  addLegend(pal = binpal, values = Rajasthan@data[["Data$No.Sterilization"]], opacity = 1, 
            title = "No. of PPP for Sterilization")


binpal <- colorBin("Reds", Rajasthan@data[["Data$No.JSY"]], 6, pretty = TRUE)

Rajasthan_map %>% addPolygons(fillColor = ~binpal(Rajasthan@data[["Data$No.JSY"]]), 
                              weight = 1, 
                              smoothFactor = 0.5,
                              color = "black",
                              dashArray = "1",  
                              fillOpacity = 1) %>% 
  addLegend(pal = binpal, values = Rajasthan@data[["Data$No.JSY"]], opacity = 1, 
            title = "No. of PPP for JSY")

#clear space
remove(list = ls())
