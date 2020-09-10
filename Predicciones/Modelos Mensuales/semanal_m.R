#############################################################################################
#           MODELO DE PREDICCION SEMANAL DE ACCIDENTES - MUERTES                            #
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
muertes_train <- read.csv("~/Docs/MAESTRIA/ANALITICA PREDICTIVA/Trabajo Final/ENTREGA FINAL/SEMANAL/semanal_m_train.csv", sep=";")
muertes_test <- read.csv("~/Docs/MAESTRIA/ANALITICA PREDICTIVA/Trabajo Final/ENTREGA FINAL/SEMANAL/semanal_m_test.csv", sep=";")

muertes_train <- dplyr :: select(muertes_train, -ANYO)
muertes_test <- dplyr :: select(muertes_test, -PERIODO)


#### entrenamiento del modelo ####
set.seed(101)
mejorRandomforest <- randomForest(MUERTES ~., data = muertes_train, mtry = 6, 
                                  nodesize = 7, sampe_size = 0.8,
                                  ntree = 500, importance = TRUE)
mejorRandomforest


#### predicciones de train####
pred_randomForest_t <- predict(mejorRandomforest, muertes_train)

### metricas de bondad #####
dt_rf_1 <- data.frame(RMSE_Train = RMSE(pred_randomForest_t, muertes_train$MUERTES),
                      Rsquared_Train = R2(pred_randomForest_t, muertes_train$MUERTES))

dt_rf_1

#### predicciones de test####
pred_randomForest <- predict(mejorRandomforest, muertes_test)

pred_randomForest
muertes_test <- cbind(muertes_test,pred_randomForest)

#Guardamos resultados en csv
write.csv(muertes_test, file="semanal_m_prediccion.csv", row.names = FALSE)

