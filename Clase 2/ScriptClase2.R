## Curso Primeros Pasos en R - UC
## Clase 2
## Profesora: Ana María Alvarado (amalvara@uc.cl)
## Prof. Ayudante: Esteban Rucan (errucan@uc.cl)
## Fecha: Jueves 11 de noviembre de 2021
## Carpeta donde se encuentra este script: https://cutt.ly/CursoR_MJ

# ctrl + enter : ejecutar una linea de código
# ctrl + ALT + R: ejcutar la linea de codigo completo
# ctrl + r : para crear una sección

getwd()

# Repaso ------------------------------------------------------------------


poleras <- c(254,203,182,50)
meses <- c("Ene", "Feb", "Mar", "Abr")
min(poleras)
plot(poleras)
barplot(poleras, names.arg = meses, col="orange")

write.csv(poleras , "poleras.csv")
write.csv(poleras , "datos/poleras.csv") # Ruta relatica a mi espacio de trabajo


write.csv(poleras, 
          "C:/Users/cl154598324/Dropbox/Primeros pasos en R - 2021/ScriptsGrupo2/Clase 2/poleras2.csv")




# Paquetes ----------------------------------------------------------------
# install.packages("ggplot2") 
# de esta forma instalamos el paquete, sólo una vez, por eso lo dejamos comentado.



## Instalar desde CRAN -----------------------------------------------------


# install.packages("skimr")

skim(poleras) #no la encuentra

# Forma 1: usando ::
skimr::skim(poleras)

# Forma 2: Activando el paquete
library(skimr)
skim(poleras)

summary(poleras)

## Instalar desde GITHUB ------------------------------------------------

# install.packages("remotes")
remotes::install_github("cienciadedatos/datos")

mtcars

datos::mtautos
skim(datos::mtautos)

##  Para ver los paquetes activos
search()


library(ggplot2)
search()



# Cálculos en R -----------------------------------------------------------

2+2
4/2
5/2
5%/%2
sqrt(225)

## Ejercicio a
2 + 4*5 - exp(3)
exp(1) # corresponde al número e

## Ejercicio b
pi # corresponde al número pi
log(5) + pi/sqrt(5)

# redondear
round(log(5) + pi/sqrt(5), 3)

# modificar las opciones
options(digits = 10)
log(5) + pi/sqrt(5)


# Lógica de Funcionamiento en R -------------------------------------------

sqrt(521)
getwd()
Sys.Date()
Sys.time()

# Ayuda de la función
?sqrt
help(sqrt)

help(mean)


?log

log(3) # calcula el logaritmo natural de 3
log(x = 3)
log(x = 3, base = exp(1))

log(x = 10, base = 100)
log(10, 100) # logaritmo de 10 en base 100
log(100, 10) # logaritmo de 100 en base 10

log(base = 10, x = 100)


log(base = 100)
log(10, base = 100)
log(10)


# Objetos -----------------------------------------------------------------

a <- 5
b <- 3
c <- "Hola"

c <- meses

## El atajo para el operador de asignación es alt + -


d = 4

rm(a)
ls()

rm(list = ls())


# Actividad

num <- 256
sqrt(num)
resultado <- sqrt(num)
resultado


a <- 5
b <- a
a <- 3



# Tipos de datos ----------------------------------------------------------

numerico <- 2
class(numerico)

entero <- 2L
class(entero)

caracter <- "hola"
class(caracter)

logicos <- TRUE
logico2 <- FALSE
class(logicos)
class(logico2)

logicos3 <- T
logicos

logico4 <- True

a > 4
b > 4


# Estructuras de datos ----------------------------------------------------

## Vectores ------------------------------------------------

vector1 <- c(3,4,5,6) # c() funcion de concatenar
vector1


vector2 <- c("a","b","c", "d")
vector2


vector3 <- c(T,F,T,F)
vector3 


vector4 <- c(2, "a", 3)
vector4
class(vector4)

vector5 <- c(2, a, 3)
vector5

vector6 <- c(T, 2, F)
vector6 
class(vector6)


as.logical(vector6)

as.character(vector6)

### Otras formas de contruir vector -----------------------------------------

## Secuencias

1:10
vector7 <- 10:100
class(vector7)

?seq
seq(from = 10 , to = 100, by = 3)
seq(from = 10 , to = 100, by = 0.5)



