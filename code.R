library(lubridate) 
library(data.table) 
library(dplyr) 
library(openxlsx) 
library(tidyr) 
library(fst) 
library(stringi)
library(zoo) 
library(ggplot2) 
library(scales) 
library(tibble) 
library(RMySQL)
library(pbapply)


connection = dbConnect(drv = MySQL(), #specifying database type. 
                       user = "fallenangel1", # username
                       password = 'nvoevodin', # password
                       host = 'nikitatest.ctxqlb5xlcju.us-east-2.rds.amazonaws.com', # address
                       port = 3306, # port
                       dbname = 'nikita99') # name of the database

files <- list.files('/home/ubuntu/node_api/upload_script/', pattern = '.csv')

x <- as.numeric(sample(1:3, 1))

file <- files[x]

test <- read.csv(paste0('/home/ubuntu/node_api/upload_script/',file))

test$time <- as.character(test$time)

test$time <- substr(test$time,12,18)

test$time <- paste0(test$time,'0')


test$time <- format(strptime(test$time, "%H:%M:%S"), format="%Y-%m-%d %H:%M:%S")

test <- test[,-6]

test <- test %>% dplyr::group_by(pulocationid, lat,lon,time) %>% dplyr::summarise(pus = sum(pus))
colnames(test) <- c('locationid','lat','lon','time','poops')
test <- as.data.frame(test)

##dbGetQuery(connection,'select * poops first 5')

dbWriteTable(connection, value = test, name = "poops", append = TRUE,row.names = FALSE ) 




dbDisconnect(connection)
