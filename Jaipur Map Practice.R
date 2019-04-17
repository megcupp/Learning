library(leaflet)
library(maps)
library(geojson)

rm(list=ls())

gadm36_IND_3_sp <- readRDS("~/Desktop/gadm36_IND_3_sp.rds")
Jaipur <-  subset(gadm36_IND_3_sp, NAME_2=="Jaipur")
Jaipur@data[["NAME_3"]]

Jaipur_edit <- leaflet(Jaipur) %>% setView(75.788815, 26.916649, zoom = 11.5)

Jaipur_edit %>% addProviderTiles(providers$Stamen.Toner) %>% 
  addCircleMarkers(75.838202, 26.966892, radius = 25, opacity = 0.2, color = "orange", label="Jal Mahal", labelOptions = labelOptions(noHide = T, textOnly = TRUE, direction = "center")) %>% 
  addCircleMarkers(75.781469, 26.957287, radius = 25, opacity = 0.2, color = "orange", label="Vidhyadhar Nagar", labelOptions = labelOptions(noHide = T, textOnly = TRUE,  direction = "center")) %>% 
  addCircleMarkers(75.802754, 26.949359, radius = 25, opacity = 0.2, color = "orange", label="Shastri Nagar", labelOptions = labelOptions(noHide = T, textOnly = TRUE,  direction = "center"))


