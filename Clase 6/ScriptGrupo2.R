## Curso Primeros Pasos en R - UC
## Clase 6
## Profesora: Ana María Alvarado (amalvara@uc.cl)
## Prof. Ayudante: Esteban Rucán (errucan@uc.cl)
## Fecha: jueves 25 de noviembre de 2021
## Carpeta donde se encuentra este script: https://cutt.ly/CursoR_MJ

getwd() # Get Working directory

# Paquetes a utilizar en esta clase ------------------------------------------
# Para instalar el paquete recuerde usar la función 
# install.packages("nombrepaquete")

library(tidyverse)
library(tidyverse)
library(RColorBrewer)
library(ggcorrplot)
library(GGally)
library(gridExtra)
library(datos)
library(guaguas)

?datos::mtautos
?mtcars

# sin ggplot
hist(datos::mtautos$millas)

df <- datos::mtautos %>% as_tibble()
glimpse(df)
# Con ggplot


# Capa base ---------------------------------------------------------------
# Operador pipe ctr + shift + m
df %>% ggplot(aes(x = millas))

# Capa geom  ---------------------------------------------------------------
# Histograma: distribución de una variable continua
df %>% ggplot(aes(x = millas)) +
  geom_histogram( bins = 10, col = "white", fill = "lightblue")

# Gráfico de puntos: ver la relación entre dos variables
df %>% ggplot(aes(x = peso, y=millas)) +
  geom_point()

df %>% ggplot(aes(x = peso, y=millas)) +
  geom_point(size = 3, col = "darkblue")

df %>% ggplot(aes(x = peso, y=millas)) +
  geom_point(size = 6, col = "darkblue", alpha = 0.5)


# Capa labs ---------------------------------------------------------------


df %>% ggplot(aes(x = peso, y=millas)) +
  geom_point(size = 6, col = "darkblue", alpha = 0.5) +
  labs(title = "Mi primer gráfico en ggplot",
       subtitle = "Relación entre rendimiento y peso del vehículo",
       x = "Peso en toneladas",
       y ="Millas por galón",
       caption = "Fuente de eleaboración propia") 
       
# Capa de temas   --------------------------------------------------------------
df %>% ggplot(aes(x = peso, y=millas)) +
  geom_point(size = 6, col = "darkblue", alpha = 0.5) +
  labs(title = "Mi primer gráfico en ggplot",
       subtitle = "Relación entre rendimiento y peso del vehículo",
       x = "Peso en toneladas",
       y ="Millas por galón",
       caption = "Fuente de eleaboración propia") +
  theme_classic()

df %>% ggplot(aes(x = peso, y=millas)) +
  geom_point(size = 6, col = "darkblue", alpha = 0.5) +
  labs(title = "Mi primer gráfico en ggplot",
       subtitle = "Relación entre rendimiento y peso del vehículo",
       x = "Peso en toneladas",
       y ="Millas por galón",
       caption = "Fuente de eleaboración propia") +
  theme_dark()

df %>% ggplot(aes(x = peso, y=millas)) +
  geom_point(size = 6, col = "darkblue", alpha = 0.5) +
  labs(title = "Mi primer gráfico en ggplot",
       subtitle = "Relación entre rendimiento y peso del vehículo",
       x = "Peso en toneladas",
       y ="Millas por galón",
       caption = "Fuente de eleaboración propia") +
  theme_minimal()

?theme_grey

# Como personalizar el tema

?theme

g1_puntos <- df %>% ggplot(aes(x = peso, y=millas)) +
  geom_point(size = 6, col = "darkblue", alpha = 0.5) +
  labs(title = "Mi primer gráfico en ggplot",
       subtitle = "Relación entre rendimiento y peso del vehículo",
       x = "Peso en toneladas",
       y ="Millas por galón",
       caption = "Fuente de eleaboración propia") +
  theme(plot.title = element_text(face = "bold", size = 20, hjust = 0.5))

g1_puntos


# Interación entre variables ----------------------------------------------

# Continuas
df %>% ggplot(aes(x = peso, y = millas, size = velocidad)) +
  geom_point()


df %>% ggplot(aes(x = peso, y = millas, colour = velocidad)) +
  geom_point(size = 4)


# Categóricas

## FACTORES ##

?mtautos
glimpse(mtautos)

df$transmision
factor(df$transmision, labels = c("Automatico", "Manual"))

df <- df %>% mutate(
  transmision_fac = factor(transmision, labels = c("Automatico", "Manual")),
  cilindros_fac = factor(cilindros) 
  )

glimpse(df)


df %>% ggplot(aes(x = peso, y=millas, col = transmision_fac))+
  geom_point(size = 4)

# podemos agregar una recta para ver la relación
df %>% ggplot(aes(x = peso, y=millas, col =transmision_fac ))+
  geom_point(size = 4)+
  geom_smooth(aes(color=NULL))

df %>% ggplot(aes(x = peso, y=millas, col =transmision_fac ))+
  geom_point(size = 4)+
  geom_smooth(aes(color=NULL), method = "lm")


# que pasa si no utilizamos la variable transformada a factor
df %>% ggplot(aes(x = peso, y=millas, col =transmision))+
  geom_point(size = 4)+
  geom_smooth(aes(color=NULL), method = "lm")



df %>% ggplot(aes(x = peso, y=millas, col =cilindros_fac))+
  geom_point(size = 4)


# Paneles -----------------------------------------------------------------

df %>% ggplot(aes(x = peso, y=millas, col =cilindros_fac))+
  geom_point(size = 4) +
  facet_wrap(vars(cilindros_fac))

# Para combinar 4 variables
df %>% ggplot(aes(x = peso, y=millas, col =cilindros_fac))+
  geom_point(size = 4) +
  facet_wrap(vars(transmision_fac))


g2_paneles <- df %>% ggplot(aes(x = peso, y=millas, col =cilindros_fac))+
  geom_point(size = 4) +
  facet_grid(transmision_fac~cilindros_fac)

g2_paneles 


# Boxplot  -----------------------------------------------------------------
df %>% ggplot(aes(x=millas))+
  geom_boxplot()

df %>% ggplot(aes(y=millas))+
  geom_boxplot()


df %>% ggplot(aes(y=millas, x=cilindros_fac))+
  geom_boxplot(fill = "salmon")


# Gráfico de linea --------------------------------------------------------

df2 <- guaguas::guaguas_frecuentes

minombre <- "Vicente"

df_minombre <- df2 %>% filter(nombre == minombre)

df_minombre %>% ggplot(aes(x = anio, y = n))+
  geom_line(size = 1.5, col = "turquoise")+
  geom_point(size = 3,col = "turquoise")


nombres <- c("Kevin", "Bryan")
grafico_bb <- df2 %>% filter(nombre %in% nombres) %>% 
  ggplot(aes(x = anio, y = n, color = nombre)) +
  geom_line(size = 1.5)+
  labs(title="Nombres Backstreet Boys")

grafico_bb


nombres <- c("Milenka", "Branco", "Salomé")
grafico_rom <- df2 %>% filter(nombre %in% nombres) %>% 
  ggplot(aes(x = anio, y = n, color = nombre)) +
  geom_line(size = 1.5)+
  labs(title = "Nombres Romané")

grafico_rom

gridExtra::grid.arrange(g1_puntos, g2_paneles, grafico_bb, grafico_rom)


