# GRAFICO DE RADAR
# Descripcion: crea un gráfico de radar que representa los accidentes de 
#   transito por hora del dia (México - 2021)

# 0. Cargamos librerias y datos ####
library(tidyverse)
library(ggplot2)

base2021 <- read.csv('atus_anual_2021.csv') %>% 
  filter(TIPACCID != 'Certificado cero')

# 1. Preparamos la base para el radar #### 
base_horas <- base2021 %>% group_by(ID_HORA) %>% 
  summarise(accidentes = n())
base_horas$distribucion = base_horas$accidentes/sum(base_horas$accidentes)

colnames(base_horas) <- c('Hora','Accidentes','Distribucion') # Cambiamos nombre de columnas
base_horas$Hora <- as.factor(base_horas$Hora) # Cambiamos hora a character
base_horas <- as.data.frame(base_horas) # Convertimos a data frame

# Grafico radar 1 ####
radar <- ggplot(base_horas) +
  geom_col(
    aes(
      x = Hora, y = Accidentes,fill = Accidentes
    ),
    position = "dodge2",
    show.legend = TRUE,
    alpha = .9
  ) +
  theme(panel.grid.major = element_line(color = "lightgrey",
                                        size = 0.5,
                                        linetype = 1)) +
  scale_fill_continuous(low = "#E6AFAE", high = "#E02522") +
  scale_y_continuous(labels = scales::comma) +
  coord_polar()

# Grafico radar 2 ####
#   - Cambiamos la leyenda y colores
radar <- radar +
  scale_y_continuous(
    limits = c(-1500, 22000),
    expand = c(0, 0),
    breaks = c(0, 5000, 10000, 15000,20000)
  ) +
  scale_fill_gradientn(
    "Número de accidentes",
    colours = c( "#ffce98","#ff9d73","#fe6b4d","#fe3a28","#820c06"),
    labels = scales::comma
  ) +
  guides(
    fill = guide_colorsteps(
      barwidth = 15, barheight = 0.5, title.position = "top", title.hjust = .5
    )
  ) +
  theme(
    # Remove axis ticks and text
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text.y = element_blank(),
    # Use gray text for the region names
    axis.text.x = element_text(color = "gray12", size = 13,face = 'bold'), 
    legend.text = element_text(size = 11),
    # Move the legend to the bottom
    legend.position = "bottom",
    panel.background = element_rect(fill = "white", color = "white"
  )) 
radar  

# Grafico radar 3 ####
#   - Agregamos titulo y comentarios #
radar +
  labs(
    title = "\nAccidentes de tránsito por hora del día",
    subtitle = paste(
      "Se presenta un gráfico de radar que ilustra el recuento",
      "total de accidentes de tránsito por hora del día, basado",
      "en los regristros del año 2021 en México.",
      sep = "\n"
    ),
    caption = "\nHecho por Herbert Lizama\nSource:INEGI\nDatos: https://datos.gob.mx/busca/dataset/accidentes-de-transito-terrestre-en-zonas-urbanas-y-suburbanas1") +
  theme(
    # Cambiamos el tipo de texto
    text = element_text(color = "gray12", family = "serif"),
    
    # Damos formato a los titulos y subtitulos
    plot.title = element_text(face = "bold", size = 25, hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    plot.caption = element_text(size = 10, hjust = .5),
    
    # Make the background white and remove extra grid lines
    panel.background = element_rect(fill = "white", color = "white"),
    panel.grid = element_blank(),
    #panel.grid.major.x = element_blank()
  )




