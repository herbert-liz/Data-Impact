# Cargamos librerias
library(ggplot2)
library(tidyverse)
library(viridisLite)
library(viridis)
library(hrbrthemes)
library(dplyr)

# Preparamos datos  & year %% 2 == 0 ####
datos <- read.csv('datos_temp.csv') 
datos$temp_mexico_ant <- lag(datos$temp_mexico)
datos <- datos %>% filter(year >= 1900 & year %% 5 == 0)
datos$diferencia <- round(datos$temp_mexico - datos$temp_mexico_ant,2)
datos$year <- as.factor(datos$year)

# Lollipop plot temperatura mexico vs año anterior ####
temp_mexico <- 
  datos %>% 
  ggplot() +
  geom_segment(aes(x = year, xend = year, y = temp_mexico_ant, yend = temp_mexico), color = "black") +
  geom_point(aes(x = year, y = temp_mexico_ant, color = "Año anterior"), size = 3) +
  geom_point(aes(x = year, y = temp_mexico, color = "Año actual"), size = 3) +
  geom_text(aes(x = year, y = temp_mexico, label = temp_mexico), color = "black", 
            vjust = -0.5, hjust = -0.5,size = 3) +
  coord_flip() + 
  #theme_ipsum() +
  xlab("Año") +
  ylab("Temperatura (Celcius)") +
  theme(
    text = element_text(color = "gray12", family = "serif"),
    plot.title = element_text(face = "bold", size = 20, hjust = 0.5, family = "serif"),
    plot.caption = element_text(size = 10)
  ) +
  labs(
    title = "Temperatura promedio en México (1990 - 2021)",
    caption = "\nHecho por Herbert Lizama\nSource: World Bank Group\nDatos: https://climateknowledgeportal.worldbank.org/country/mexico/climate-data-historical"
  ) +
  scale_color_manual(
    values = c("Año actual" = rgb(0.7, 0.2, 0.1, 0.5),"Año anterior" = rgb(0.2, 0.7, 0.1, 0.5)),
    labels = c("Año actual","Año anterior")
  ) +
  labs(colour = "")

# Lollipop - Temperatura mexico vs yucatan ####
temp_mexicoVSyucatan <- 
  datos %>% 
  ggplot() +
  geom_segment(aes(x = year, xend = year, y = temp_yucatan, yend = temp_mexico), color = "black") +
  geom_point(aes(x = year, y = temp_yucatan, color = "Temp. Yucatán"), size = 3) +
  geom_point(aes(x = year, y = temp_mexico, color = "Temp. México"), size = 3) +
  geom_text(aes(x = year, y = (temp_yucatan + temp_mexico)/2, label = temp_yucatan - temp_mexico), color = "black", 
            vjust = -0.5, hjust = -0.5,size = 3, fontface = 'bold') +
  geom_text(aes(x = year, y = temp_yucatan, label = temp_yucatan), color = rgb(0.7, 0.2, 0.1, 0.5), 
            vjust = -0.5, hjust = -0.5,size = 4,fontface = 'bold') +
  geom_text(aes(x = year, y = temp_mexico, label = temp_mexico), color =  '#00a58e', 
            vjust = -0.5, hjust = -0.5,size = 4,fontface = 'bold') +
  coord_flip(ylim = c(20,28)) + 
  theme_ipsum() +
  xlab("Año") +
  ylab("Temperatura (Celsius)") +
  theme(
    text = element_text(color = "gray12",size = 15,family = 'serif'),
    plot.title = element_text(size = 19, hjust = 0.5, family = "serif"),
    plot.subtitle = element_text(size = 15,hjust = 0.5,family = 'serif',color = "black"),
    plot.caption = element_text(size = 10)
  ) +
  labs(
    title = "Temperatura promedio México vs Yucatán (1905 - 2020)",
    subtitle = "(Lollipop Chart)",
    caption = "\nHecho por Herbert Lizama\nSource: World Bank Group\nDatos: https://climateknowledgeportal.worldbank.org/country/mexico/climate-data-historical"
  ) +
  scale_color_manual(
    values = c("Temp. México" = '#00a58e',"Temp. Yucatán" = rgb(0.7, 0.2, 0.1, 0.5)),
    labels = c("Temp. México","Temp. Yucatán")
  ) +
  labs(colour = "")
temp_mexicoVSyucatan
