# Questão: julgamento do STJ mudou o resultado dos julgamentos no TJSP?
# Data da sentença no STJ: 
# 

library(tjsp)
library(tidyverse)

data_decisao_stj = as.Date('2022-06-08')

cjpg = readRDS('./data-raw/cjpg.rds')

