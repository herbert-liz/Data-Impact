### PLANTILLA GRAFICO DE BARRAS AGRUPADAS ###

# Librerias
library(tidyverse)
library(grid)

# Datos
{
  datos <- read.csv('percepcion_seguridad_entidad_federativa.csv')
  datos <- datos %>% 
    mutate(label = scales::percent_format(accuracy = .1)(datos$percepcion_inseguridad),
           flag_mexico = (entidad_federativa == 'Estados Unidos Mexicanos'))
}
# Grafico base
{
  plt <- ggplot(datos, aes(x = percepcion_inseguridad, y = fct_reorder(entidad_federativa, percepcion_inseguridad))) + 
    geom_col(
      aes(fill = flag_mexico),  # Colores personalizados
      width = 0.8
    )
  
  plt <- plt +
    scale_fill_manual(
      values = c("#39A7FF","#164863"),
      guide = FALSE
    )
}
# Modificamos breacks del eje x
{
  plt <- plt +
  scale_x_continuous(
    breaks = seq(0, 1, by = 0.1), 
    limits = c(0, 1.05),
    expand = c(0, 0),
    position = "top",
    labels = scales::percent_format(accuracy = 1))
}
# Fondo y etiquetas de eje
{
  plt <- plt + 
  #scale_y_discrete(expand = expansion(add = c(0, 0.5))) +
  theme(
    panel.background = element_rect(fill = "#F1F0E8"),
    plot.background = element_rect(fill = "#F1F0E8"),
    panel.grid = element_blank(),
    axis.ticks.length = unit(0, "mm"),
    axis.line.y.left = element_line(color = "black"),
    axis.title = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_blank()
  )
}
# Etiquetas de barras
{
  plt <- plt + 
  geom_text(
    aes(label = entidad_federativa, x = 0.01),
    hjust = 0, vjust = 0.3,  # Alineación a la izquierda de la etiqueta
    size = 5,
    color = 'white',
    fontface = 'bold'
  ) +
  geom_text(
    aes(label = label, x = percepcion_inseguridad,),
    hjust = -0.1, vjust = 0.3,  # Alineación a la izquierda de la etiqueta
    size = 4.5,
    color = '#427D9D',
    fontface = 'bold'
  )
}
# Titulo y subtitulo
{
  plt <- plt +
    labs(
      title = '  Percepción de la inseguridad por \n  entidad federativa',
      subtitle = '    Porcentaje de la población mayor a 18 años que considera insegura su entidad federativa (2023)'
    ) +
    theme(plot.title = element_text(face = 'bold',size = 35),
          plot.subtitle = element_text(size = 15),
          legend.title = element_blank())
  }
# Agregamos margenes
{
  plt <- plt + 
    theme(
      plot.margin = margin(0.025, 0, 0.01, 0.01, "npc")
    )
  plt
}

plt
# Agregamos fuente de datos
{
  grid.text(
    "Fuente: Encuesta Nacional de Victimización y Percepción sobre Seguridad Pública (ENVIPE)\n(https://www.inegi.org.mx/temas/percepcion/)", 
    x = 0.98, 
    y = 0.02, 
    just = c("right", "bottom"),
    gp = gpar(
      col = 'grey50',
      fontsize = 10,
      fontface = 'bold'
    )
  )
}
# Detalles
{
  grid.rect(
    x = 0.011,
    y = 0.975,
    width = 0.011,
    height = 0.1125,
    just = c("left", "top"),
    gp = gpar(fill = "#39A7FF", lwd = 0,col = "#39A7FF")
  )
}
