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

dfShopInfo <- data.frame()
for (i in 1:108){
  print(i)
  targetUrl <- paste0("https://www.kusurinofukutaro.co.jp/shop/?cm=l&pn=", i, "&pr=20#list")
  
  data <- read_html(targetUrl)
  shopList <- html_nodes(data, xpath = '//*[@id="shop-list"]')
  #shopInfo <- html_nodes(shopList, ".shopinfo")
  shopInfo <- html_nodes(shopList,xpath="//ul/li/div/p[1]")
  
  shop_name <- html_nodes(shopList, ".name") %>% html_text()
  shopInfo_zip <- html_nodes(shopInfo, ".zip") %>% html_text() %>% stringr::str_replace_all(pattern="[^0-9]", replacement="")
  shopInfo_address <- html_nodes(shopInfo, ".add") %>% html_text()
  shopInfo_tel <- html_nodes(shopInfo, ".tel") %>% 
                    html_text() %>% 
                    stringr::str_replace(pattern="“d˜b”Ô†F", replacement="") %>% stringr::str_replace_all(pattern="[^0-9-]", "") %>% 
                    stringr::str_sub(start=1,end=12)
  
  min_length <- min(length(shop_name), length(shopInfo_zip), length(shopInfo_address), length(shopInfo_tel))
  shop_name <- shop_name[1:min_length]
  shopInfo_zip <- shopInfo_zip[1:min_length]
  shopInfo_address <- shopInfo_address[1:min_length]
  shopInfo_tel <- shopInfo_tel[1:min_length]
  
  
  dfTemp <- data.frame(shop_name, shopInfo_zip, shopInfo_address, shopInfo_tel)

  if (nrow(dfShopInfo)>0){
    dfShopInfo <- rbind(dfShopInfo, dfTemp)
  } else {
    dfShopInfo <- dfTemp
  }
  
}

max(nchar(as.character(dfShopInfo$shop_name), type = "bytes"))
max(nchar(as.character(dfShopInfo$shopInfo_address), type = "bytes"))
max(nchar(as.character(dfShopInfo$shopInfo_zip), type = "bytes"))

dfShopInfo_test <- dfShopInfo
dfShopInfo_test <- dplyr::filter(dfShopInfo_test, nchar(as.character(dfShopInfo$shopInfo_zip), type = "bytes")==7)


dfShopInfo_test$shop_name <- stringr::str_pad(as.character(dfShopInfo_test$shop_name), side="right", width=60, pad=" ")
dfShopInfo_test$shopInfo_address <- stringr::str_pad(as.character(dfShopInfo_test$shopInfo_address), side="right", width=120, pad=" ")


dfShopInfo_test <- data.frame(shop_id=paste0("S",formatC(1:nrow(dfShopInfo_test),width=5,flag="0")), dfShopInfo_test)


write.csv(dfShopInfo_test, "dfShopInfo.csv", row.names = FALSE)

