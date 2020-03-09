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

dfZip2Geoc <- fread("Zip2Geoc.csv",data.table=FALSE, encoding="UTF-8",
                   colClasses = c("character","character","character","character","character","character"))

dfZip2Geoc$location <- paste0(dfZip2Geoc$Lat,",", dfZip2Geoc$Lon)

dfZip2Geoc <- dplyr::select(dfZip2Geoc, Zip, location)


write.table(dfZip2Geoc, "dfZip2Geoc.yml", row.names = FALSE, col.names = FALSE, sep=": ")

