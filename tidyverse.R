library(tidyverse)
library(writexl)
library(readxl)
library(lubridate)
library(janitor)

iris <- iris |>
        clean_names()

## Exportar objetos do R

View(iris) ## Visualizar os dataset iris já existentes no R

### Formato compactado do próprio R. 

saveRDS(iris, "data/iris.rds")

### Formato csv (comma separated values)

write_csv(iris, "data/iris.csv")

### Formato excel
write_xlsx(iris,"data/iris.xlsx")


## Para ler, basta usar as funções correspondentes:
iris_csv <- read_csv("data/iris.csv")

iris_rds <- readRDS("data/iris.rds")

iris_excel <- read_excel("data/iris.xlsx")

## Introdução ao pipe. 

### Para aplicar uma sequência de funções no R, há três maneiras.

### Você pode criar novos objetos para cada função aplicada:

valores <- 1:10

rais2 <- sqrt(valores)

soma <- sum(rais2)

soma

### Você alcança o mesmo resultado aninhando as funções.

sum(sqrt(1:10))

### Por fim, a maneira preferida por usuários do R é usar `|>` (pipe) para 
### chamar sequencialmente as funções desejadas:

1:10 |> 
  sqrt() |> 
  sum()

### O objeto antes do pipe se torna o primeiro argumento da função:

paste("gosto","de","jurimetria")

"gosto" |> 
  paste("de","jurimetria")


### se você quiser que o objeto seja outro argumento que não o primeiro, use o nome
### do argumento e indique o objeto com o subscrito (_):
"_" |> 
   paste("gosto","de","jurimetria", sep = _)


"de" |> 
   paste("gosto", ... = _, "Jurimetria")


### Tibble
### Tibble são como data.frames aperfeiçoadas. Há menos riscos de erros com 
### tibbles do que com data.frames. Tibble também é o nome do pacote que 
### cria tibbles e possui outras funções úteis, como imprimir uma "tibble" de
### forma mais informativa

class(iris)

iris_tb <- as_tibble(iris)

glimpse(iris) ## Impressão mais informativa

### Converte o índice das linhas em coluna.
iris <- iris |> 
     rowid_to_column(var = "id")

jurimetria <- rep("jurimetria",150)


### Adiciona uma coluna externa.
iris <- iris |> 
     add_column(jurimetria = jurimetria)


cjpg <- cjpg |>
mutate(anterior_stj = ifelse(disponibilizacao <= as.Date("2022-06-08"), "sim", "não"),
.after = disponibilizacao )


### Dplyr

### Dplyr é um dos pacotes mais importantes do R e do tidyverse. Ele possui algumas funções
### extremamente úteis para a transformação de dados. 

#### Select  ## Seleciona colunas de várias formas.

s1 <- cjpg |> 
      select(processo,assunto)

s2 <- cjpg |> 
    select(processo:magistrado)

s3 <- cjpg |> 
      select(2, 5)

s4 <- cjpg |> 
      select(-pagina)

s5 <- cjpg |> 
     select(starts_with("a"))

s6 <- cjpg |> 
    select(ends_with("o"))

s7 <- cjpg |> 
      select(contains("ma"))

#### Filter  ## Filtra linhas com base numa comparação com o valor desejado.

f1 <- cjpg |> 
     filter(comarca == "Santos")

f2 <- cjpg |> 
     select(-julgado) |> 
     filter(comarca == "Santos", anterior_stj == "sim")


f3 <- cjpg |> 
     select(!julgado) |> 
     filter(comarca == "Santos" | comarca == "Batatais")

data <- as.Date("2022-09-01")

f4 <- cjpg |> 
    select(-julgado) |> 
    filter(disponibilizacao < data)

#### Arrange ## Ordena a tibble com base em uma ou mais colunas.

cjpg2 <- cjpg |> 
       select(-julgado, -cd_doc)

a1 <- cjpg |> 
     arrange(pagina)

a2 <- cjpg2 |> 
      arrange(disponibilizacao)

a3 <- cjpg2 |> 
     arrange(desc(disponibilizacao))

a3 <- cjpg2 |> 
     arrange(comarca, disponibilizacao)

#### mutate ### Cria ou altera colunas na tibble.

cjpg2 <- cjpg2 |> 
     mutate(pagina = pagina*2)

cjpg2 <- cjpg2 |> 
     mutate(sequencial_cnj = str_sub(processo, start = 1, end = 7),
            digito_cnj = str_sub(processo,start = 8, end = 9),
            ano_cnj = str_sub(processo, start = 10, end = 13),
            segmento_cnj = str_sub(processo, 14,14),
            tribunal_cnj = str_sub(processo, 15,16),
            distribuidor_cnj = str_sub(processo, 17,20)
            )

iris <- iris |> 
     mutate(media_geral_sl  = mean(sepal_length)) |> 
     group_by(Species) |> 
     mutate(media_specie_sl = mean(sepal_length))


#### Sumarize  ### Cria sumários, especialmente estatísticos das colunas.

sumario <- iris |> 
          group_by(species) |> 
          summarize(n = n(),
                    maximo = max(sepal_length),
                    minimo = min(sepal_length),
                    media = mean(sepal_length),
                    mediana = median(sepal_length),
                    desvio_padrao = sd(sepal_length))

#### Count  ### Cria frequência de uma ou mais colunas.

classe <- cjpg |> 
         count(classe)

classe <- cjpg |> 
      count(classe, sort = TRUE)

classe <- cjpg |> 
    count(classe, sort = TRUE, name = "frequencia")

assunto <- cjpg |> 
      count(assunto, sort = TRUE, name = "frequencia")

ac <- cjpg |> 
      count(classe, assunto, sort = TRUE, name = "frequencia")


### Lubridate  

### Lubridate é um pacote que facilita o manuseio de datas, especialmente 
### dentro de uma tibble.









