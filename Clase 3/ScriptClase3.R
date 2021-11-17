## Curso Primeros Pasos en R - UC
## Clase 3
## Profesora: Ana María Alvarado (amalvara@uc.cl)
## Prof. Ayudante: Esteban Rucán (errucan@uc.cl)
## Fecha: Martes 16 de noviembre de 2021
## Carpeta donde se encuentra este script: https://cutt.ly/CursoR_MJ

getwd() # Get Working directory

# Ctrl + enter ; ejecutar comandos
# ctrl + shift + r : crear secciones

# Paquetes a utilizar en esta clase ------------------------------------------
# Para instalar el paquete use la función install.packages("nombrepaquete")

library(skimr) 
library(readr)
library(readxl)

# Repaso ------------------------------------------------------------------

## Vectores ----------------------------------------------------------------

notas <- c(3,4,5,6,7)
notas

mean(notas)
sum(notas)
sqrt(notas)

dias <- c("L","M","W","J","V")
dias

tipo <- c(T,F,F,T,T)
tipo

# Podemos usar operadores de comparación
# >, <, ==, !=, >=, <=
notas == 5
comp <- notas == 5
comp

notas >4


# otras Funciones para generar vectores

?seq
seq() # Toma valores por defecto

seq(from = 1, to = 100, by = 2)
seq(from = 1, to = 100, by = 0.5)
seq(1,100,2)

1:100
20:40
40:20

a <- 1:100
class(a)


?rep # ayuda de la función rep
rep(2, 20)
rep("a", 1000)

rep(c("a","b"), times = 20)

rep(c("a","b"), each = 20)

b <- rep(c("a","b"), each = 20)

class(b)

rep(2:5, 10)

LETTERS
letters
month.name


## Cómo manipular vectores.
# vector[i] extrae el elemnto en la posición i del vector

notas[3] # extrae el elemnto del vector notas, que está en la posición 3
notas[5]

notas[c(2,3)]
notas[2:3]

notas[-3] # Extrae todos los elementos excepto el de la posición 3

notas[5]

n <- length(notas)
n
notas[n]

vector  <- 345:600
n <- length(vector)
n
vector[n]
vector[n-1]

vector[(n-9):n] # Entrega los últimos 9

vector[length(vector)]


## Matrices ----------------------------------------------------------------
?matrix
matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE )
matrix(1:12, nrow = 4, ncol = 3, byrow = FALSE )


m1 <-matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE ) 

m1
dim(m1) # Filas, columnas

# Manipular matrices
# matriz[filas , columnas]

# Elemento que está en la fila 3, columna 2, de la matriz m1

m1[3,2]

# vector[1,2] esto genera error en un vector.

m1[1:2, 2]

# Si quiero la fila 2 completa .
m1[2, ]

# si quiero la columna 3 completa
m1[ ,3]
m1[,3]


# Data Frame --------------------------------------------------------------

# Cómo crear un data frame
?data.frame()

# Forma 1: crearlo directamente
data.frame(var1 = c(2,5.5,8), var2 = c("B", "C","D"), var3 = c(T,F,T))
df1 <- data.frame(var1 = c(2,5.5,8), var2 = c("B", "C","D"), var3 = c(T,F,T))
 

# Forma 2: crearlo a partir de vectores
df2 <- data.frame(dias, notas, tipo)
df2


df3 <- data.frame(dias, vector) # generar error, los vectores no tienen la misma dimensión


dim(df2)

# manipular data frames
# df[filas, columnas]
# df[registros, variables]
# df$variable

df2[2,3]
df2[2, ]
df2[ ,1]
df2[ ,2]
df2[, "dias"]
df2[, "notas"]
df2$dias
df2$notas
df2$tipo

names(df2) # nombres
colnames(df2)
rownames(df2)

# Vamos a asignar otros nombres de filas
letters[1:5]

rownames(df2) <- letters[1:5]
df2

# vamos a asignar otros nombres de columnas al df1
# notas, dias, tipo

df1
names(df1) <- c("notas", "dias", "tipo")
df1

df2[,"dias"]

df2[df2$notas > 3, ] # Es como hacer un filtro
df2[df2$dias == "M", ]



# Clase 3 -----------------------------------------------------------------


# Forma 3: importarlo desde un archivo externo

## Usar funciones de rbase

?read.csv
viviendas <- read.csv2("datos/viviendasRM.csv")
viviendas <- read.csv2("datos/viviendasRM.csv", encoding = "UTF-8")
View(viviendas)
viviendas


## Usar funciones readr
# library(readr)

viviendas2 <- read_csv2("datos/viviendasRM.csv")
viviendas2
names(viviendas)
names(viviendas2) # son más consistentes

# Opciones del menu
# file <- import data set <- from text <- seguir instrucciónes
#library(readr)
#viviendasRM <- read_delim("datos/viviendasRM.csv", 
#                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
#                          skip = 5)
#View(viviendasRM)


# Importar archivos desde la web

covid <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto3/CasosTotalesCumulativo.csv")
covid

dim(covid)
covid[,c(1,625)]
covid[,c(1,620:625)]

covid[,625] - covid[, 624]

n <- dim(covid)[2]
n
covid[,n] - covid[, n-1]


## Análisis exploratorio de datos ---------------------

df <- viviendas2

# muestras los primeros k registros
head(df)  # por defecto los primeros 6
head(df, 3)

# muestra los ultimos k registros
tail(df)
tail(df, 20)

# dimensión
dim(df)

# largo 
length(df) # cantidad de columnas o vectores
length(df$N_Estacionamientos) # la cantidad de elementos de un vector

# names: nombres
names(df)

# Class: clase del df
class(df)

# str: estructura del df
str(df)

#glimpse
dplyr::glimpse(df)



# A modo exploratorio podemos hacer un análisis descriptivo de los datos

summary(df)
skimr::skim(df)


# Importar datos en excel -------------------------------------------------
# readxl

valores <- read_xlsx("datos/valores.xlsx")
# por defecto importa la primera hoja

valores <- read_xlsx("datos/valores.xlsx", sheet = "2021")



