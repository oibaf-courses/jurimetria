library(stringr)
library(dplyr)
library(tidyverse)
library(quanteda)

cjpg <- readRDS('./data-raw/cjpg.rds')

cjpg <- cjpg |>
  mutate(anterior_stj = ifelse(disponibilizacao <= as.Date("2022-06-08"), "sim", "não"),
         .after = disponibilizacao )

cjpg <- cjpg |>
        mutate(ans = str_detect(julgado, '(?i)\\b(ans|agência|agencia)\\b'))

cjpg |> count(ans)

corpo <- cjpg |> 
          select(cd_doc, julgado) |> 
          distinct(cd_doc, .keep_all = TRUE) |> 
          corpus(odid_field= 'cd_doc', text_field = 'julgado')

ans <- kwic(corpo, pattern='ans', window=10, valuetype='fixed')

rol <- kwic(corpo, pattern='rol', window=10, valuetype='fixed')

rol_ans <- rol |> 
          mutate(consta_rol = case_when(
            str_detect(pre, '(?i)(nao|não).*(consta|previsto|contempla)') ~"não",
            str_detect(pre, '(?i)(aus.n)') ~"não",
            TRUE ~"sim"
          ))


