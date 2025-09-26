# Cargamos librerias ####
library(haven)
library(ggplot2)
library(dplyr)
library(sf)
library(reshape2)
library(wbstats)
library(gtrendsR)
library(viridis)
library(maps)

# 1. Consultamos los indicadores sobre algun tema de interes ####
index_search <- wb_search(pattern = 'tree')

# 2. Seleccionamos indicador, en este caso ####
datos_indicador <- wb(country = "countries_only",indicator = "AG.LND.FRST.K2", 
                      startdate = 2021, enddate = 2021)

# 3. Descargamos informacion del mapa mundial ####
world_map <- rnaturalearth::ne_countries(scale = 50, returnclass = "sf")

# 4. Unimos informacion de mapa e indicador ####
map_urban <- left_join(world_map, datos_indicador, by = c("iso_a2" = "iso2c"))

# 5. Creamos mapa ####
urban_graph <- ggplot() +
  geom_sf(data = map_urban, aes(fill = value)) +
  scale_fill_gradient(low = "#4ccae0", high = "#113f40") +
  ggtitle("Superficie forestal en KM cuadtrados | 2020") +
  theme_bw() +
  labs(caption = "Data Source: World Bank") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.caption = element_text(size = 10, face = "bold"))
urban_graph
