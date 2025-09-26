# Librerias
library(tidyverse)
library(ggplot2)
library(grid)

# Datos ingreso sexo edad
{
  datos <- read.csv('ingreso_sexo_edad.csv',encoding = 'UTF-8')
  colnames(datos)[1] <- 'Edad'
  datos$label <- round(datos$Ingreso/3000,digits = 1)
  head(datos)
}
# Definimos colores que seran usados adelante
colores <- c("#89CFF3", "#8E8FFA",'#164863')
#colores <- c("#6499E9", "#BC7AF9",'#AAC8A7')

## Grafico ingreso sexo y edad
# Grafico base
{
  plt <- ggplot(datos, aes(y=Ingreso, x=Edad, fill = Sexo)) + 
    geom_bar(stat="identity",
             position = position_dodge(0.8),
             width = 0.7)
}
# Fondo y colores de barras
{
  plt <- plt +
    # Tema y colores de las barras
    theme(panel.background = element_rect(fill = "#F8F6F4"),
          panel.grid = element_blank(),
          plot.background = element_rect(fill = "#F8F6F4"),
          legend.background = element_rect(fill = "#F8F6F4")) +
    scale_color_manual(values = colores)+
    scale_fill_manual(values = colores)
}
# Etiqueta de barras y ejes
{
  plt <- plt +
    geom_text(
      data = datos,
      aes(y = Ingreso + 800,
          label = scales::dollar(label,accuracy = 0.1)),
      position = position_dodge(width = 0.8),
      #angle = 65,
      hjust = 0.55,
      vjust = 0.5,
      color = 'black',
      fontface = "bold",
      size = 5
    ) +
    theme(
      axis.title.x = element_blank(),
      axis.text.x = element_text(size = 12,color = 'black', face = 'bold'),
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      legend.position = 'top',
      legend.text = element_text(size = 12, color = 'black')
    )
}
# Titulo y subtitulo
{
  plt <- plt +
    labs(
      title = 'Ingreso promedio mensual\npor sexo y grupo de edad',
      subtitle = 'Cifras expresadas miles de pesos mexicanos | ENIGH 2022'
    ) +
    theme(plot.title = element_text(face = 'bold',size = 40,hjust = 0.1),
          plot.subtitle = element_text(size = 20,hjust = 0.125,color = '#526D82'),
          legend.title = element_blank()
    )
}
# Margenes (para poder agregar comentarios y fuentes)
{
  plt <- plt + 
    theme(
      plot.margin = margin(0.025, 0, 0.1, 0.01, "npc")
    )
}
plt
# Fuente de datos
{
  grid.text(
    "Fuente: Encuesta Nacional de Ingresos y Gastos de los Hogares 2022", 
    x = 0.05, 
    y = 0.06, 
    just = c("left", "bottom"),
    gp = gpar(
      col = '#526D82',
      #fontfamily = font,
      fontface = 'bold',
      fontsize = 12
    )
  )
}
# Detalles
{
  grid.rect(
    x = 0.035,
    y = 0.975,
    width = 0.0125,
    height = 0.14,
    just = c("left", "top"),
    gp = gpar(fill = "#164863", lwd = 0,col = "#164863")
  )
}


# Datos ingreso sexo escolaridad
{
  datos <- read.csv('ingreso_sexo_escolaridad.csv',encoding = 'UTF-8')
  datos$label <- round(datos$Ingreso/3000,digits = 1)
  head(datos)
  
  orden_cat <- c('Primaria','Secundaria','Preparatoria','Profesional','Posgrado','Total')
  datos$Escolaridad <- factor(datos$Escolaridad,levels = orden_cat)
}
## Grafico ingreso sexo y escolaridad
## Grafico ingreso sexo y edad
# Grafico base
{
  plt <- ggplot(datos, aes(y=Ingreso, x=Escolaridad, fill = Sexo)) + 
    geom_bar(stat="identity",
             position = position_dodge(0.8),
             width = 0.7)
}
# Fondo y colores de barras
{
  plt <- plt +
    # Tema y colores de las barras
    theme(panel.background = element_rect(fill = "#F8F6F4"),
          panel.grid = element_blank(),
          plot.background = element_rect(fill = "#F8F6F4"),
          legend.background = element_rect(fill = "#F8F6F4")) +
    scale_color_manual(values = colores)+
    scale_fill_manual(values = colores)
}
# Etiqueta de barras y ejes
{
  plt <- plt +
    geom_text(
      data = datos,
      aes(y = Ingreso + 2400,
          label = scales::dollar(label,accuracy = 0.1)),
      position = position_dodge(width = 0.8),
      #angle = 65,
      hjust = 0.55,
      #vjust = 0.5,
      color = 'black',
      fontface = "bold",
      size = 5
    ) +
    theme(
      axis.title.x = element_blank(),
      axis.text.x = element_text(size = 12,color = 'black', face = 'bold'),
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      legend.position = 'top',
      legend.text = element_text(size = 12, color = 'black')
    )
}
# Titulo y subtitulo
{
  plt <- plt +
    labs(
      title = 'Ingreso promedio mensual\npor sexo y escolaridad',
      subtitle = 'Cifras expresadas miles de pesos mexicanos | ENIGH 2022'
    ) +
    theme(plot.title = element_text(face = 'bold',size = 40,hjust = 0.1),
          plot.subtitle = element_text(size = 20,hjust = 0.125,color = '#526D82'),
          legend.title = element_blank()
    )
}
# Margenes (para poder agregar comentarios y fuentes)
{
  plt <- plt + 
    theme(
      plot.margin = margin(0.025, 0, 0.1, 0.01, "npc")
    )
}
plt
# Fuente de datos
{
  grid.text(
    "Fuente: Encuesta Nacional de Ingresos y Gastos de los Hogares 2022", 
    x = 0.05, 
    y = 0.06, 
    just = c("left", "bottom"),
    gp = gpar(
      col = '#526D82',
      #fontfamily = font,
      fontface = 'bold',
      fontsize = 12
    )
  )
}
# Detalles
{
  grid.rect(
    x = 0.035,
    y = 0.975,
    width = 0.0125,
    height = 0.14,
    just = c("left", "top"),
    gp = gpar(fill = "#164863", lwd = 0,col = "#164863")
  )
}

