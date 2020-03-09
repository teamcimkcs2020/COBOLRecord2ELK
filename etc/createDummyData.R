library(XML)
library(stringr)
library(lubridate)
library(dplyr)
library(ggplot2)
library(plotly)
library(scales)
library(plyr)
library(DT)
library(shiny)
library(shinydashboard)
library(shinyBS)
library(dygraphs)
library(xts)
library(rpivotTable)
library(reshape2)
library(xml2)
library(rvest)
library(purrr)
library(stringr)
library(data.table)

dfShopInfo <- fread("dfShopInfo2.csv",data.table=FALSE,
                    colClasses = c("character","character","character","character","character"))
dfItemInfo <- fread("dfItemInfo.csv",data.table=FALSE, 
                    colClasses=c("character","character","character","character"))

cnt <- 100000

randomItem <- as.integer(runif(cnt, min = 1, max = nrow(dfItemInfo)))
dfRandomItem <- dfItemInfo[randomItem,]

randomShop <- as.integer(runif(cnt, min = 1, max = nrow(dfShopInfo)))
dfRandomShop <- dfShopInfo[randomShop,]


date_seq <- seq(as.Date("2020-01-01"), as.Date("2020-01-31"), by="days")
randomDate <- sample(date_seq, size = cnt, replace = TRUE) %>%
          stringr::str_replace_all("-","/")

randomHour <- as.integer(runif(cnt, min = 1, max = 23)) %>%
  formatC(width=2,flag="0")

randomMinute <- as.integer(runif(cnt, min = 1, max = 59)) %>%
  formatC(width=2,flag="0")

randomSeond <- as.integer(runif(cnt, min = 1, max = 59)) %>%
  formatC(width=2,flag="0")

randomTime <- paste0(randomHour, ":", randomMinute, ":", randomSeond)

orderID <- paste0("OID",
                  stringr::str_replace_all(randomDate,"/",""), 
                  "_",
                  randomHour,
                  randomMinute,
                  randomSeond)

randomOrderQuantity <- as.integer(runif(cnt, min = 1, max = 100)) %>%
  formatC(width=8,flag="0")

dfDummyData <- data.frame(orderID,
                     randomDate,
                     randomTime,
                     dfRandomItem,
                     randomOrderQuantity,
                     dfRandomShop
                     )

write.csv(dfDummyData, "dfDummyData.csv", row.names = FALSE)

