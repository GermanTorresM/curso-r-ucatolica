## Curso Primeros Pasos en R - UC
## Clase 5
## Profesora: Ana María Alvarado (amalvara@uc.cl)
## Prof. Ayudante: Esteban Rucán (errucan@uc.cl)
## Fecha: Martes 23 de noviembre de 2021
## Carpeta donde se encuentra este script: https://cutt.ly/CursoR_MJ

getwd() # Get Working directory

# Paquetes a utilizar en esta clase ------------------------------------------
# Para instalar el paquete recuerde usar la función 
# install.packages("nombrepaquete")

library(tidyverse)
# library(Lock5Data)
# library(datos)

search()

# Operador Pipe -----------------------------------------------------------

# %>% lo podemos ver usando ctrl+shift+m
x <- 1:50

# Calcular la exponencial de la media del vector x.

# RBase:
exp(mean(x)) # en r base indentamos funciones

# Con Tidyverse:
x %>% mean() %>% exp() # vamos encadenando funciones de izquierda a derecaha

# Más ordenado
promedio <- x %>% 
  mean() %>% 
  exp()

promedio

# Ejemplo 2:
# datos es un paquete de datos de rbase traduciodos

paises <- datos::paises
glimpse(paises)
class(paises) # es un tible

# con r base
paises[paises$anio == 2007,] # filtramos el año 2007.
paises[paises$anio == 2007,]$poblacion 

mean(paises[paises$anio == 2007,]$poblacion)

# con tidyverse
paises %>% 
  filter(anio == 2007) %>% 
  summarise(mean(poblacion))



# Gramatica de dplyr -----------------------------------------------------
# Ejemplo

Lock5Data::HollywoodMovies
?Lock5Data::HollywoodMovies

class(Lock5Data::HollywoodMovies)

df <- Lock5Data::HollywoodMovies %>% as_tibble() %>% janitor::clean_names()
glimpse(df)


## Select ------------------------------------------------------------------
# Seleccionar o reordenar columnas.

?select
df %>% select(movie)
df %>% select(movie, year)
df2 <- df %>% select(movie, year)

df %>% select(-movie) # Selecciona todas las variables del df, excepto movie
df %>% select(!movie)

df %>% select(-c(movie, lead_studio, genre))

df %>% select(movie:genre)
df %>% select(1:5)
df %>% select(c(1,3,10))

df %>% select(-c(1,3,10))

df %>% select(-movie,-lead_studio,-genre)


# Utilizar otras funciones dentro de select
df %>% select(year, everything()) # reordena las columnas dentro del data fram
df %>% select(starts_with(match = "m"))
df %>% select(ends_with(match = "e"))


# Variantes de select
df %>% select_if(is.numeric) # selecciona si se cumple la condición is.numeric

# ejemplo: calcular la correlación.
df %>% cor()
df %>% select_if(is.numeric) %>% cor()
df %>% select_if(is.numeric) %>% na.omit() %>% cor()

df %>% select_if(is.numeric) %>% na.omit() %>% cor() %>% round(2)

df %>% select_all(toupper)



## Filter ------------------------------------------------------------------
# filtra las filas de acuerdo a algún criterio

?filter
# utilizamos los operadores de comparación ==, <, >, >= , !=

df %>% filter(year == 2018) # filtramos solo las películas del 2018
df %>% filter(budget > 50)
df %>% filter(budget > mean(budget, na.rm = TRUE)) %>% select(movie, budget)


# tambien podemos usar los operadores lógicos
df %>% filter(year == 2018 & genre == "Action")
df %>% filter( genre == "Action" | genre == "Drama")

# podemos ir agregando condiciones para el filtro con una coma 
df %>% filter(year == 2018 , genre == "Action", budget > 50)

df %>% filter(is.na(rotten_tomatoes))

# Filtrar filas que pertenezcan a algún conjunto de datos
estudios <- c("Warner Bros. ", "Universal Pictures ", "Lionsgate " ,
              "Twentieth Century Fox ")

df %>% filter(lead_studio %in% estudios)


## Mutate ------------------------------------------------------------------
# Crea o transforma variables dentro del conjunto de datos.
?mutate

df %>% select(movie, budget, year) %>% 
  mutate(budget_pesos = budget * 820)

df %>% select(movie, budget, year) %>% 
  mutate(budget = log(budget))


# Algunas variantes
df %>% select(movie, budget, year, lead_studio) %>% 
  mutate_all(str_to_upper)


df %>% select(movie, budget, year, lead_studio) %>% 
  mutate_if(is.double, as.integer)


## Case When --------
## crear un vector categorico del budget, va a tomar el valor alto si budget 
## es mayor que 1000 y bajo en caso contrario

df %>% select(movie, budget, year, lead_studio) %>% 
  mutate(bud_cat = case_when(budget > 100 ~ "Alto",
                             budget <= 100 ~ "Bajo"))


df %>% select(movie, budget, year, lead_studio) %>% 
  mutate(bud_cat = case_when(budget > 100 ~ "Alto",
                             budget <= 100 ~ "Bajo",
                             TRUE ~ "Otro")) # Equivalente al ELSE.


## Arrange -----------------------------------------------------------------
# Ordena las filas según valores de alguna columna

df %>% select(movie, budget, year, lead_studio) %>% 
  arrange(budget)

df %>% select(movie, budget, year, lead_studio) %>% 
  arrange(desc(budget))


df %>% select(movie, budget, year, lead_studio) %>% 
  arrange(year, desc(budget))


## Group by ----------------------------------------------------------------
# Agrupa filas a partir de un conjunto de categorías

df %>% group_by(lead_studio)

df %>% group_by(year)


## Count -------------------------------------------------------------------
df %>% group_by(lead_studio) %>% count() %>% arrange(desc(n))

df %>% group_by(genre) %>% count() %>% arrange(desc(n))


# Summarize ---------------------------------------------------------------
# Calcula un resumen en base a funciones

df %>% group_by(genre) %>% summarise( promedio = mean(budget, na.rm = TRUE) )

df %>% group_by(genre) %>% summarise( promedio = mean(budget, na.rm = TRUE) ,
                                      desv_est = sd(budget, na.rm = TRUE),
                                      cantidad = n())

resumen <- df %>% group_by(genre) %>% summarise( promedio = mean(budget, na.rm = TRUE) ,
                                                 desv_est = sd(budget, na.rm = TRUE),
                                                 cantidad = n())
write_csv(resumen, "resumen.csv")




# Taller práctico - Tarea -------------------------------------------------

resumen <- df %>% select(all_of(seleccionadas)) %>% 
  filter(lead_studio %in% estudios  ) %>%
  mutate(pbudgetmax = budget/max(budget, na.rm =TRUE)) %>% 
  group_by(lead_studio) %>% 
  summarise( n = n(), 
             minimo = min(budget, na.rm = TRUE),
             media = mean(budget, na.rm = TRUE), 
             sd_score = sd(budget, na.rm = TRUE) ,
             q1 = quantile(pbudgetmax, probs = 0.25, na.rm = TRUE),
             q2 = quantile(pbudgetmax, probs = 0.5, na.rm = TRUE),
             q3 = quantile(pbudgetmax, probs = 0.75, na.rm = TRUE))

