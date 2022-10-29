library(httr) 
library(jsonlite) 
library(rlist) 
library(dplyr) 
library(data.table)

jsonResponse <- GET('https://consulta.tjrs.jus.br/gwapptjrsmobile/rest/consultaProcesso?numeroProcesso=22000471710&codComarca=1&perfil=0',
         add_headers(Authorization = 'Basic YXBwY29uc3Byb2Nlc3N1YWw6cGozM3VTZXJ0eQ==')
      )
resposta = content(jsonResponse, as = "parsed")

df <- lapply(resposta$data[[1]],as.data.table) 
View(df)


8_243_151