# Cargar las bibliotecas necesarias
library(ggplot2)
library(sf)
library(ggvoronoi)
library(rnaturalearth)
library(ggforce)

# Obtener los datos de las coordenadas de las capitales de los estados de México
coordenadas <- data.frame(
  estado = c("Aguascalientes", "Baja California", "Baja California Sur", "Campeche",
             "Coahuila", "Colima", "Chiapas", "Chihuahua", "Ciudad de México",
             "Durango", "Guanajuato", "Guerrero", "Hidalgo", "Jalisco",
             "México", "Michoacán", "Morelos", "Nayarit", "Nuevo León",
             "Oaxaca", "Puebla", "Querétaro", "Quintana Roo", "San Luis Potosí",
             "Sinaloa", "Sonora", "Tabasco", "Tamaulipas", "Tlaxcala",
             "Veracruz", "Yucatán", "Zacatecas"),
  lat = c(21.8795, 32.6245, 24.1448, 19.8454, 25.4389, 19.2433, 16.7538, 28.6350, 
          19.4326, 24.0255, 21.0167, 17.5567, 20.1169, 20.6597, 19.2826, 19.7069, 
          18.9242, 21.5260, 25.6866, 17.0732, 19.0414, 20.5888, 18.5028, 22.1566, 
          24.8049, 29.0729, 17.9869, 23.7369, 19.3182, 19.5438, 20.9670, 22.7709),
  lon = c(-102.2961, -115.4523, -110.3153, -90.5230, -100.9734, -103.7242, -93.1140, 
          -106.0889, -99.1332, -104.6754, -101.2500, -99.5050, -98.7333, -103.3496,
          -99.6557, -101.1949, -99.2216, -104.8938, -100.3161, -96.7266, -98.2063,
          -100.3899, -88.2965, -100.9855, -107.3939, -110.9559, -92.9308, -99.1419,
          -98.2375, -96.9102, -89.6237, -102.5832)
)


# Descargar los datos geoespaciales de México
mexico <- ne_countries(country = "Mexico", scale = "large", returnclass = "sf")

# Mapa voronoi
ggplot() +
  geom_sf(data = mexico, fill = "white", color = "black") +
  geom_point(data = coordenadas, aes(x = lon, y = lat), color = "red", size = 1) +
  labs(title = "Mapa de México con Diagramas de Voronoi y Límites de Estados",
       subtitle = "División de estados basada en las distancias a las capitales") +
  geom_voronoi_segment(data = coordenadas, aes(x = lon, y = lat), color = "black") +
  theme(axis.title = element_blank())


# Mapa de México normalcon la división por estados
mexico_normal <- ne_states(country = "Mexico", returnclass = "sf")

ggplot() +
  geom_sf(data = mexico_normal, fill = "white", color = "black") +
  labs(title = "Mapa de México con División por Estados",
       subtitle = "Mapa actual de los estados de México") +
  geom_point(data = coordenadas, aes(x = lon, y = lat), color = "red", size = 1) +
  theme(axis.title = element_blank())

