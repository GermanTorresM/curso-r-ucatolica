## Curso Primeros Pasos en R - UC
## Clase 1
## Profesora: Ana María Alvarado (amalvara@uc.cl)
## Prof. Ayudante: Esteban Rucan (errucan@uc.cl)
## Fecha: Martes 09 de noviembre de 2021
## Carpeta donde se encuentra este script: https://cutt.ly/CursoR_MJ

print("Hola R")  # Para ejecutar presionamos ctrl + enter o presionar botón run.

print("Hola R")

max.col()

#hola<-d, # Aquí se identifica un error

# Esto es un comentario
#esto es un comentario



# Sección 1: Importación de datos -----------------------------------------

# Para hacer una sección presionamos ctrl+ shift + r


# Sección 2: Análiis exploratorio de datos --------------------------------

# O también terminar con 4# o 4-

# Sección 3: Entrenamiento ####


# Sección 4: Resultados ----
## Sección 4.1 ---------------------------------------------------------------
### Sección 4.1.2 ---------------------------------------------------------------



# Ana María Alvarado ------------------------------------------------------

poleras <- c(254,203,182,50)
meses <- c("Ene", "Feb", "Mar", "Abr")
min(poleras)
plot(poleras)
barplot(poleras, names.arg = meses, col="orange")


getwd() # Get Working Directory


write.csv(poleras, "poleras.csv") # Este lo guarda en el directorio de trabajo actual
write.csv(poleras, "C:\\Users\\cl154598324\\Desktop\\poleras.csv") # no es buena práctica


setwd("C:\\Users\\cl154598324\\Desktop")
setwd("C:/Users/cl154598324/Desktop")


getwd()

write.csv(poleras, "poleras2.csv")
write.csv(poleras, "datos\\poleras2.csv")
