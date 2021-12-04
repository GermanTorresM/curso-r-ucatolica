## Curso Primeros Pasos en R - UC
## Clase 8
## Profesora: Ana María Alvarado (amalvara@uc.cl)
## Prof. Ayudante: Esteban Rucan ()
## Fecha: Jueves 2 de diciembre de 2021
## Carpeta donde se encuentra este script: https://cutt.ly/CursoR_MJ

getwd() # Get Working directory
library(tidyverse) 
library(datos)
library(readxl)


## 1. importación y exploración de datos

df <- readxl::read_xlsx("../Clase 7/datos/base_bancos.xlsx") %>% janitor::clean_names()

names(df)
glimpse(df)
summary(df)

df <- df %>% 
  mutate(
  sexo = factor(sexo, labels = c("Mujer","Hombre")),
  solicitud = factor(solicitud, labels = c("No", "Si")),
  credito = factor(credito, labels = c("No", "Si"))
)
glimpse(df)
summary(df)



## 2. Profesionales según comuna

# Opción 1
table(df$comuna)
table(df$profesion)

table(df$comuna, df$profesion)

table(df$comuna, df$profesion)[, 'SI']


# Opción 2: usando tidyverse

df %>% filter(profesion == 'SI') %>% 
  group_by(comuna) %>% 
  count() %>% 
  arrange(desc(n))

# Revisar los porcentajes 
t1 <- table(df$comuna, df$profesion)

prop.table(t1)*100
prop.table(t1, margin = 1)*100 # Miramos las proporciones por filas
prop.table(t1, margin = 2)*100 # Miramos las proporciones por columna


## 3 Agrupar por rango etario

#18-30: Joven
#31-45: Adulto Joven
#46-60: Adulto
#>60: Mayor

# Creamos la variable tramo_edad
df <- df %>% mutate(
  tramo_edad = case_when(
    edad <= 30 ~ "Joven",
    edad >30 & edad <=45 ~ "Adulto Joven",
    edad > 45 & edad <=60 ~ "Adulto",
    TRUE ~ "Mayor"
  )
)


# Validamos que está bien creada
df %>% group_by(tramo_edad) %>% 
  summarise(min(edad), max(edad))

t2 <- table(df$tramo_edad, df$solicitud)
prop.table(t2, margin = 1) # opcion a * correcta
prop.table(t2, margin = 2) # opcion b

