# Librerias
extrafont::loadfonts(device="win")
library(tidyverse)
library(ggplot2)
library(grid)

# Datos spotify 2023
base <- read.csv('spotify-2023.csv')
base$streams <- as.numeric(base$streams)
base <- base %>% filter(!is.na(streams))

# Top 10 canciones mas escuchadas
{
  top_10_canciones <- base %>% 
    select(track_name,artist.s._name,released_year,streams) %>% 
    arrange(desc(streams)) %>% 
    head(10) %>% 
    mutate(streams_millones = streams / 1000000,
           label_tag = paste0(track_name,
                             ' (',
                             artist.s._name,
                             ', ',
                             released_year,
                             ')')
    )
}
font = 'Trebuchet MS'
# Grafico de barras simple
{
  plt <- ggplot(top_10_canciones) +
    geom_col(aes(streams_millones, fct_reorder(label_tag,streams)), 
             fill = '#076fa2', 
             width = 0.6)
  plt
}
# Personalizando eje horizontal y breacks
{
  plt <- plt + 
    scale_x_continuous(
      breaks = seq(0, 4000, by = 500), 
      limits = c(0, 4100),
      expand = c(0, 0), # The horizontal axis does not extend to either side
      position = "top"  # Labels are located on the top
    )
  plt
}
# Personalizando ejes y fondo
{
  plt <- plt + 
    scale_y_discrete(expand = expansion(add = c(0, 0.5))) +
    theme(
      # Fondo color blanco
      panel.background = element_rect(fill = "white"),
      # Colo y grosor del grid para el eje horizontal
      panel.grid.major.x = element_line(color = "#A8BAC4", size = 0.3),
      # Removemos las marcas negras del eje x
      axis.ticks.length = unit(0, "mm"),
      # Removemos los titulos de ambos ejes
      axis.title = element_blank(),
      # Remarcamos el eje vertical de color negro
      axis.line.y.left = element_line(color = "black"),
      # Removemos etiquetas del eje y
      axis.text.y = element_blank(),
      # Personalizamos tipo de letra y tamano etiquedas eje x
      axis.text.x = element_text(family = font, size = 15)
    )
  plt
}
# Personalizando etiquedas
{
  plt <- plt + 
    geom_text(
      data = top_10_canciones,
      aes(50, y = label_tag, label = label_tag),
      hjust = 0,
      nudge_x = 0.3,
      colour = "white",
      family = font,
      size = 5
    )
  plt
}
# Agregamos Titulos y subtitulos
{
  plt <- plt +
    labs(
      title = "Top 10 canciones más escuchadas de Spotify",
      subtitle = "Número de reproducciones en millones (información a septiembre 2023)"
    ) + 
    theme(
      plot.title = element_text(
        family = font, 
        face = "bold",
        size = 22
      ),
      plot.subtitle = element_text(
        family = font,
        size = 17
      )
    )
  plt
}
# Agregamos margenes
{
  plt <- plt + 
    theme(
      plot.margin = margin(0.05, 0, 0.1, 0.01, "npc")
    )
}
# Agregamos etiqueta de valor 
{
  plt <- plt +
    geom_text(
      data = top_10_canciones,
      aes(x = streams_millones + 150,
          y = label_tag, 
          label = format(round(streams_millones),big.mark = ',')),
      color = '#076fa2',
      family = font,
      size = 6
    )
}
# Agregamos anotaciones
plt
{
  # Agregamos fuente de datos
  grid.text(
    "Sources: Kaggle datasets (kaggle.com)", 
    x = 0.005, 
    y = 0.06, 
    just = c("left", "bottom"),
    gp = gpar(
      col = 'grey50',
      fontsize = 16,
      fontfamily = font
    )
  )
  # Agregamos nombre de la pagina
  grid.text(
    "Data Impact", 
    x = 0.005, 
    y = 0.035, 
    just = c("left", "bottom"),
    gp = gpar(
      col = 'grey50',
      fontsize = 16,
      fontfamily = font
    )
  )
}
# Agregamos detalles 
{
  grid.lines(
    x = c(0, 1),
    y = 1,
    gp = gpar(col = "#e5001c", lwd = 4)
  )
  
  grid.rect(
    x = 0,
    y = 1,
    width = 0.05,
    height = 0.025,
    just = c("left", "top"),
    gp = gpar(fill = "#e5001c", lwd = 0,col = "#e5001c")
  )
}
