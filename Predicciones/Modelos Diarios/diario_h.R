#############################################################################################
#           MODELO DE PREDICCION DIARIO DE ACCIDENTES - HERIDOS                             #
# POR: William Jovel T. - Alexis Arenas B. - Juan Esteban Arroyave D. - Manuela Londoño O.  #
#############################################################################################

### librerias ####
library(dplyr) # data wrangling
library(caret)    
library(rpart)       
library(rpart.plot)  
require(MASS)
library(randomForest)


### lectura de datos #####
heridos_train <- read.csv("~/Docs/MAESTRIA/ANALITICA PREDICTIVA/Trabajo Final/ENTREGA FINAL/DIARIO/diario_h_train.csv", sep=";")
heridos_test <- read.csv("~/Docs/MAESTRIA/ANALITICA PREDICTIVA/Trabajo Final/ENTREGA FINAL/DIARIO/diario_h_test.csv", sep=";")

heridos_train <- dplyr :: select(heridos_train, -PERIODO)
heridos_test <- dplyr :: select(heridos_test, -DIA)


#### entrenamiento del modelo ####
set.seed(101)
mejorRandomforest <- randomForest(HERIDOS ~., data = heridos_train, mtry = 10, nodesize = 7, ntree = 500, sampe_size= 0.8, importance = TRUE)
mejorRandomforest


#### predicciones de train####
pred_randomForest_t <- predict(mejorRandomforest, heridos_train)

### metricas de bondad #####
dt_rf_1 <- data.frame(RMSE_Train = RMSE(pred_randomForest_t, heridos_train$HERIDOS),
                      Rsquared_Train = R2(pred_randomForest_t, heridos_train$HERIDOS))

dt_rf_1

#### predicciones de test####
pred_randomForest <- predict(mejorRandomforest, heridos_test)

pred_randomForest
heridos_test <- cbind(heridos_test,pred_randomForest)

#Guardamos resultados en csv
write.csv(heridos_test, file="diario_h_prediccion.csv", row.names = FALSE)

