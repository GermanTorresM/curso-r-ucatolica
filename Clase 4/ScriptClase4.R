## Curso Primeros Pasos en R - UC
## Clase 4
## Profesora: Ana María Alvarado (amalvara@uc.cl)
## Prof. Ayudante: Esteban Rucán (errucan@uc.cl)
## Fecha: Jueves 18 de noviembre de 2021
## Carpeta donde se encuentra este script: https://cutt.ly/CursoR_MJ

getwd() # Get Working directory

# Ctrl + enter ; ejecutar comandos
# ctrl + shift + r : crear secciones

# Paquetes a utilizar en esta clase ------------------------------------------
# Para instalar el paquete recuerde usar la función install.packages("nombrepaquete")

library(readr) # Importar archivos de texto
library(readxl) # Importar archivos de excel
library(janitor) # Limpieza y manejo de df
library(skimr) # Análisis exploratorio de datos
library(naniar) # Manejo de datos faltantes
library(dplyr)# # Manipulación de df
library(lubridate) # Manejo de Fechas
library(stringr) # Manipulación de caracteres

# Importación de datos -------------------------------------------------------

df_viv <- read_csv2("../Clase 3/datos/viviendasRM.csv") 

# Pueden poner la ruta completa de sus archivos, ejemplo:
# C:\Users\cl154598324\Dropbox\Primeros pasos en R - 2021\ScriptsGrupo2\Clase 3\datos

# Tambien pueden indicar a R un nuevo directorio de trabajo con setwd()
# setwd("C:/Users/cl154598324/Dropbox/Primeros pasos en R - 2021/ScriptsGrupo2/Clase 4")

search() # Aquí pueden revisar los paquetes activos
getwd() # Get Working directory

# Análisis exploratorio de datos ----------------------------------------------
names(df_viv)
glimpse(df_viv)
summary(df_viv)

# Revisar N_estacionacionamientos
df_viv$N_Estacionamientos
# Pendiente de corregir.


## Valores especiales en R -----------------------------------------------------

# infinito
Inf
-Inf
e <- exp(1)
e^1200


# NaN (Not a Number)
sqrt(-1)


# NA (Not Available)
NA

notas <- c(3, 5, NA, 7)
mean(notas) # devuelve un NA
mean(notas, na.rm = TRUE ) #Elimina el NA para hacer el cálculo.
 

?read_csv

na.omit(notas)

# notas == NA
is.na(notas) # función para identificar los NA

sum(is.na(notas)) # cuenta los verdaros, es decir NA
sum(!is.na(notas)) # cuanta los falsos, los valores completos.


# Importar archivos desde excel -----------------------------------------------
#  readxl
?read_xlsx
read_xlsx("../Clase 3/datos/valores.xlsx") # Por defecto importa la primera hoja

read_xlsx("../Clase 3/datos/valores.xlsx", sheet = "2021") # Trae la columna periodo como caracter
read_xlsx("../Clase 3/datos/valores.xlsx", sheet = "2021", na = "--")# Definimos los NA como --
read_xlsx("../Clase 3/datos/valores.xlsx", sheet = "2021", na = "--", 
          col_types = c("text", "numeric")) # indicamos el tipo de dato en cada columna

# tambien podemos llamar a las funciones de un package sin tener que activarlo.
readxl::read_xlsx("../Clase 3/datos/valores.xlsx", sheet = "2021", na = "--", 
col_types = c("text", "numeric"))


# Asignamos a un objeto nuestro df importado.
df_val2021 <- read_xlsx("../Clase 3/datos/valores.xlsx", sheet = "2021", na = "--", 
                        col_types = c("text", "numeric"))

summary(df_val2021)
mean(df_val2021$`Período: 2021`) # Los nombres no son estables.


## Limpiar nombres ------------------------------------------------------------
# package janitor

clean_names(df_val2021)
clean_names(df_viv)

df_val2021 <- clean_names(df_val2021)
names(df_val2021) # Ahora los nombres están arreglados.
names(df_viv)



## Importar datos hoja 2020 ------------------------------------------------
read_xlsx("../Clase 3/datos/valores.xlsx", sheet = "2020") 
read_xlsx("../Clase 3/datos/valores.xlsx", sheet = "2020", n_max = 10) 

df_val2020 <- read_xlsx("../Clase 3/datos/valores.xlsx", sheet = "2020", range = "A1:B11") 
df_val2020

# Ahora el problema son los nombres, y el formato numerico

df_val2020 <- clean_names(df_val2020)
df_val2020

?parse_number
parse_number(df_val2020$periodo_2020)
parse_number(df_val2020$periodo_2020, locale = locale(decimal_mark = ","))

df_val2020$periodo_2020 <- parse_number(df_val2020$periodo_2020,
                                        locale = locale(decimal_mark = ","))
df_val2020

## Exportar datos a excel --------------------------------------------------
library(xlsx)
write.xlsx(df_val2020,"datos/val2020.xlsx")

## Problema de celdas combinadas --------------------------------------------
read_xlsx("../Clase 3/datos/migracion.xlsx") 
read_xlsx("../Clase 3/datos/migracion.xlsx", skip = 1) 

df_mig <- read_xlsx("../Clase 3/datos/migracion.xlsx", skip = 1) 
df_mig <- clean_names(df_mig)
names(df_mig)

remove_empty(df_mig, which = c("cols", "rows"))
df_mig <- remove_empty(df_mig, which = c("cols", "rows"))
df_mig


library(tidyr)
?tidyr::fill

tidyr::fill(df_mig, c("region_residencia_habitual", "codigo_region"))
df_mig <- tidyr::fill(df_mig, c("region_residencia_habitual", "codigo_region"))
df_mig
summary(df_mig)


write.xlsx(df_mig, "migracion_corregido.xlsx")


# Manejo de string --------------------------------------------------------
# package stringr

cadena <- c("esta es una cadena de texto", "esta es otra cadena", "esta también")
cadena

?stringr
# Funciones de interés
str_detect(cadena, "ca")
str_extract(cadena, "ca")
str_extract(cadena, "a")
str_extract_all(cadena, "a")
str_remove(cadena, "ca")
str_remove(cadena, "a")
str_remove_all(cadena, "a")
str_replace(cadena,"ca","CA")
str_replace(cadena,"a","EEE")
str_replace_all(cadena,"a","EEE")

df_viv$N_Estacionamientos
str_replace_all(df_viv$N_Estacionamientos,"No","0")
as.numeric(str_replace_all(df_viv$N_Estacionamientos,"No","0"))

df_viv$N_Estacionamientos2 <- as.numeric(str_replace_all(df_viv$N_Estacionamientos,"No","0")) 


summary(df_viv)


str_to_lower(names(df_viv))
str_to_upper(names(df_viv))

nombres <- names(df_viv)

str_sub(nombres, 0, 0) <- "VIV_"

nombres