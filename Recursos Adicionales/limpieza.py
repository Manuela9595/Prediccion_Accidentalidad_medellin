#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Aug 15 20:44:23 2020

@author: manulondo
"""

import pandas as pd
import numpy as np
import seaborn as sb
from sklearn.impute import SimpleImputer

filename = '/Users/manulondo/Downloads/2014-2018.csv'
data = pd.read_csv(filename, header=0, delimiter=';')

#CONTEO DE NULL Y 0 
nulls = data.notnull().apply(pd.Series.value_counts)
ceros = (data != "0").apply(pd.Series.value_counts)

#ELIMINACION DE NULLS BARRIO
data2 = data.copy()
data2 = data2.drop(data2[data2.BARRIO == "0"].index)
data2 = data2.drop(data2[data2.BARRIO == "7002"].index)

#ELIMINACION NULL COMUNA
data2 = data2.drop(data2[data2.COMUNA == "#N/D"].index)

#ELIMINACION RADICADO
data2 = data2.dropna()

#IDENTIFICACION DE NAN
nulls = data2.notnull().apply(pd.Series.value_counts)
imputer = SimpleImputer(missing_values=np.nan, strategy='most_frequent')
diseno = imputer.fit(data2[['DISENO']])
data2['DISENO'] = diseno.transform(data2[['DISENO']]).ravel()
clase = imputer.fit(data2[['CLASE']])
data2['CLASE'] = diseno.transform(data2[['CLASE']]).ravel()