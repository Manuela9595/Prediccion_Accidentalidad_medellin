#############################################################################################
#           MODELO DE PREDICCION MENSUAL DE ACCIDENTES - SOLO DAÑOS                         #
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
solo_danos_train <- read.csv("~/Docs/MAESTRIA/ANALITICA PREDICTIVA/Trabajo Final/ENTREGA FINAL/MENSUAL/mensual_sd_train.csv", sep=",")
solo_danos_test <- read.csv("~/Docs/MAESTRIA/ANALITICA PREDICTIVA/Trabajo Final/ENTREGA FINAL/MENSUAL/mensual_sd_test.csv", sep=";")

solo_danos_train <- dplyr :: select(solo_danos_train, -PERIODO)
solo_danos_test <- dplyr :: select(solo_danos_test, -PERIODO)


#### entrenamiento del modelo ####
set.seed(101)
mejorRandomforest <- randomForest(SOLO_DANOS.R ~., data = solo_danos_train, mtry = 4 , nodesize = 11, ntree = 500, sampe_size= 0.8, importance = TRUE)
mejorRandomforest


#### predicciones de train####
pred_randomForest_t <- predict(mejorRandomforest, solo_danos_train)

### metricas de bondad #####
dt_rf_1 <- data.frame(RMSE_Train = RMSE(pred_randomForest_t, solo_danos_train$SOLO_DANOS.R),
                      Rsquared_Train = R2(pred_randomForest_t, solo_danos_train$SOLO_DANOS.R))

dt_rf_1

#### predicciones de test####
pred_randomForest <- predict(mejorRandomforest, solo_danos_test)

pred_randomForest
solo_danos_test <- cbind(solo_danos_test,pred_randomForest)

#Guardamos resultados en csv
write.csv(solo_danos_test, file="mensual_sd_prediccion.csv", row.names = FALSE)

