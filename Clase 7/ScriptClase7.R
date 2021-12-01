## Curso Primeros Pasos en R - UC
## Clase 7
## Profesora: Ana María Alvarado (amalvara@uc.cl)
## Prof. Ayudante: Esteban Rucan ()
## Fecha: Martes 30 de noviembre de 2021
## Carpeta donde se encuentra este script: https://cutt.ly/CursoR_MJ

getwd() # Get Working directory

# Paquetes a utilizar en esta clase ------------------------------------------
# Para instalar el paquete recuerde usar la función 
# install.packages("nombrepaquete")

library(tidyverse) # paquetes dplyr y ggplot2
library(RColorBrewer)
library(ggcorrplot)
library(GGally)
library(gridExtra)
library(datos)
library(guaguas)
?RColorBrewer

colores <- c("#fde0dd","#fa9fb5","#c51b8a")

df_paises <- datos::paises
names(df_paises)

g_chile <- df_paises %>% filter(pais == "Chile") %>% 
  ggplot(aes(x = anio, y = esperanza_de_vida))+
  geom_point(colour = "#c51b8a" )+
  geom_line( colour = "#c51b8a")
  
vecinos <- c("Chile", "Argentina", "Perú", "Bolivia")

g_vecinos <- df_paises %>% filter(pais %in% vecinos) %>% 
  ggplot(aes(x=anio, y=esperanza_de_vida, color = pais))+
  geom_line(size = 2)+
  theme_classic()+
  labs(title = "Evolución esperanza de vida",
       x = "Año",
       y="Esperanza de Vida")+
  scale_color_brewer(palette = "Set3")

g_vecinos

ggsave("grafico_vecinos.png")
ggsave("grafico_vecinos2.png", g_vecinos)
ggsave("Graficos/grafico_vecinos2.png", g_vecinos)


gridExtra::grid.arrange(g_chile, g_vecinos, ncol = 2)


g_paneles <- df_paises %>% filter(pais %in% vecinos) %>% 
  ggplot(aes(x=anio, y=esperanza_de_vida, col = pais))+
  geom_line(size = 2)+
  facet_wrap(vars(pais))
g_paneles



## ggcorrplot --------------------------------------------------------------
# Matriz de correlaciones

df_autos  <- datos::mtautos %>% mutate(cilindros = factor(cilindros),
                                       transmision = factor(transmision),
                                       forma = factor(forma))

glimpse(df_autos)

df_autos %>% select_if(is.numeric) %>% cor() %>% round(4)


df_autos %>% select_if(is.numeric) %>% cor() %>% round(4) %>% 
  ggcorrplot::ggcorrplot()


df_autos %>% select_if(is.numeric) %>% cor() %>% round(4) %>% 
  ggcorrplot::ggcorrplot(method = "circle")



## ggpairs -----------------------------------------------------------------
## Matriz de dispersion

df_autos %>% select(1:6) %>% GGally::ggpairs()



# Gráfico de barra --------------------------------------------------------
df_autos %>% ggplot(aes(x = cilindros, fill=cilindros)) + geom_bar() +
  scale_fill_brewer(palette= "Accent")




# Clase 7 -----------------------------------------------------------------


## Importación y exploración de datos -----------------------------------

df_im <- readxl::read_xlsx("datos/Data_IMACEC.xlsx") %>% 
  janitor::clean_names()
names(df_im)
glimpse(df_im)
dim(df_im)
summary(df_im)



## Medidas de tendencia Central --------------------------------------------

# R BASE
mean(df_im$precio_cobre, na.rm = TRUE)


# Usando tidyverse

df_im %>% summarise(
  media = mean(precio_cobre,na.rm = TRUE),
  mediana = median(precio_cobre, na.rm=TRUE)
)



# La moda en este caso no tiene sentido

df_im %>% ggplot(aes(x=precio_cobre))+geom_histogram(col = "white")


# La media o promedio  es sensible a valores extremos
sueldos <- c(200, 230, 190, 250, 3000000)
mean(sueldos)
median(sueldos)

# Si queremos comparar promedio y la mediana del precio del cobre por año
df_im %>% group_by(year) %>% 
  summarise(
    media = mean(precio_cobre,na.rm = TRUE),
    mediana = median(precio_cobre, na.rm=TRUE)
  )


# por ejemplo por mes
df_im %>% group_by(month) %>% 
  summarise(
    media = mean(precio_cobre,na.rm = TRUE),
    mediana = median(precio_cobre, na.rm=TRUE)
  )

## Medidas de dispersión ---------------------------------------------------

df_im %>% summarise(
  varianza = var(precio_cobre),
  desv_estandar = sd(precio_cobre),
  coef_var = statip::cv(precio_cobre),
  coef_var2 = desv_estandar / mean(precio_cobre)
)


sd(sueldos)
statip::cv(sueldos)



# Medidas de posición relativa --------------------------------------------



df_im %>% summarise(
  minimo = min(precio_cobre),
  máximo = max(precio_cobre),
  percentil10 = quantile(precio_cobre, probs = 0.10),
  percentil90 = quantile(precio_cobre, probs = 0.90)
)

# cuartiles
quantile(df_im$precio_cobre, probs = c(0.25,0.5,0.75))



# Otras medidas de dispersión ---------------------------------------------

rango <- max(df_im$precio_cobre)- min(df_im$precio_cobre)
rango

RIC <- IQR(df_im$precio_cobre)
RIC

max(sueldos)- min(sueldos)

IQR(sueldos)
