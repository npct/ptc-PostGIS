# Set Up the packages and connect to the database
source("set-up.R")
source("connect.R")
library(leaflet)
library(shiny)

#query the database

#query <- "SELECT msoa84.id, msoa84.geom, msoa84.code, msoa_data.home_msoa, msoa_data.all_tran, msoa_data.bicycle FROM msoa84 INNER JOIN msoa_data ON msoa84.code = msoa_data.home_msoa WHERE geom && ST_MakeEnvelope(-0.18, 51.45, -0.05, 51.5, 4326)"
#answer <- askDB_o(query) #testing the open query

query2 <- "SELECT id, geom FROM regions WHERE id < 10"
answer2 <- askDB(query2) #testing the open query

query_zone <- paste0("SELECT id, geom FROM regions WHERE geom && ST_MakeEnvelope(-0.18, 51.45, -0.05, 51.5, 4326)")
answer_zone <- askDB(query_zone)

query_zone <- paste0("SELECT id, geom FROM regions WHERE geom && ST_MakeEnvelope(",-0.18,",",51.45,",",-0.05,",",51.5,",4326)")
answer_zone <- askDB(query_zone)

askDB_c() # disconnect from db

# change co-ordinate system to WGS84
#answer84 <- spTransform(answer, CRS("+init=epsg:4326"))

#plot the results
qpal <- colorQuantile("Blues", answer$bicycle, n = 7)
leaflet() %>%
    addTiles() %>%
    addPolygons(data = answer, 
                color = ~qpal(answer$bicycle), 
                stroke = TRUE, 
                fillOpacity = 0.5) %>%
    addCircleMarkers(data = answer2, color = "red", radius = 3, stroke = FALSE, fillOpacity = 0.7)




