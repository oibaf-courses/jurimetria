library(tjsp)

cjpg <- readRDS('./data-raw/cjpg.rds')

classes <- cjpg |> count(classe, sort = T)
classes

processos <- cjpg |> 
  filter(classe=='Procedimento Comum Cível' | classe=='Procedimento do Juizado Especial Cível') |> 
  pull(processo)

count(processos)

tjsp_baixar_cpopg(processos, diretorio='data-raw/cpopg')
