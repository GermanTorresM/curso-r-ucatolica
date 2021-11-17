getwd()
poleras <- c(254,203,182,50)
meses <- c("Ene", "Feb", "Mar", "Abr")
min(poleras)
plot(poleras)
barplot(poleras,names.arg = meses,col="orange")

write.csv(poleras, "datos/poleras.csv")
read.csv("datos/poleras.csv")
