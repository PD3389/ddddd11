install.packages("httr")
install.packages("jsonlite")


library(httr)
require(jsonlite)

endpoint<-"https://api.openweathermap.org/data/2.5/weather?q=Warszawa&appid=1765994b51ed366c506d5dc0d0b07b77"
getWeather<-GET(endpoint)
weatherText<-content(getWeather, as="text")
weatherJson <-fromJSON(weatherText,flatten=FALSE)
weatherJson
weatherDF<-as.data.frame(weatherJson)
weatherDF

weatherText

x<- 124.5
x
class(x)
is.vector(x)

x<-"123"
x
is.vector(x)

x<-c(1,2,4,5,6,7,8,9,10)
x
y<-c(2,2)
class(x)

as.integer(x)
wynik<-x+y

wynik<-x*y
wynik
