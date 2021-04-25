install.packages( c("gtools","rvest","xml2") )

library(gtools)
library(rvest)
library(xml2)


zrobWierszRvest<- function(w,wektorLinkow){
 
  newUrl<-wektorLinkow[w]
  page<-read_html(newUrl)

  cena<-page %>% html_node(xpath = "//div[@class='offer-price']") %>% html_attr("data-price")

  v<-page %>% xml_find_all('/html/body/div[4]/main/div[2]/div[1]/div[2]/div[1]/div[1]/div[3]/div[1]/ul[1]/*/span')%>%html_text2()%>%na.omit()
  v1<-page %>% xml_find_all('/html/body/div[4]/main/div[2]/div[1]/div[2]/div[1]/div[1]/div[3]/div[1]/ul[2]/*/span')%>%html_text2()%>%na.omit()
  v2<-page %>% xml_find_all('/html/body/div[4]/main/div[2]/div[1]/div[2]/div[1]/div[1]/div[3]/div[1]/ul[1]/*/div')%>%html_text2()%>%na.omit()
  v3<-page %>% xml_find_all('/html/body/div[4]/main/div[2]/div[1]/div[2]/div[1]/div[1]/div[3]/div[1]/ul[2]/*/div')%>%html_text2()%>%na.omit()
  
  v2<-v2[1:length(v)]
  v3<-v3[1:length(v1)]
 
  nazwyKolumn<- c(v,v1)
  wartosci<-c(v2,v3)

  df1<- data.frame (matrix(wartosci,nrow = 1,ncol=length(wartosci)) )
  names(df1) <- nazwyKolumn
  df1<-cbind(cena,df1)
  df1
}

wektorLinkow<-c()
liczbaStron<-10
# ustawione na 5 stron dla testów, można zmienić np. na 500
# i wtedy zakończy przesukiwanie jak dojdzie do mniejszej z wartości
# 500 albo faktyczna liczba stron
for(i in 1:5){
  if(i>liczbaStron){
    break
  }
  newUrl<- paste0("https://www.otomoto.pl/osobowe/toyota/?search%5Border%5D=created_at%3Adesc&page=",i)
  print(newUrl)
  page<-read_html(newUrl)
  if(i==1){
    liczbaStron<-page%>%html_nodes(xpath='/html/body/div[4]/div[2]/section/div[2]/div[2]/ul/li[6]/a/span')%>%html_text()
    liczbaStron<-as.integer(liczbaStron)
  }
  result<-page%>%html_nodes(xpath='/html/body/div[4]/div[2]/section/div[2]/div[1]/div/div[1]/div[6]/article[*]/div[2]/div[1]/div[1]/h2/a')
  wektorLinkow<-c(wektorLinkow, xml_attr(result,"href"))
}

wektorLinkowU<-wektorLinkow%>%unique()
samochody<-NULL
for(w in 1: length(wektorLinkowU)){
  skip<-FALSE
  tryCatch(
    df1<-zrobWierszRvest(w,wektorLinkowU),error=function(e){skip<<-TRUE}
  )
  if(skip){next}
  if(is.null(samochody)){
    samochody<-df1
  }else{
    samochody<-smartbind(samochody,df1)
  }
}


