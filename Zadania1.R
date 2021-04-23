isDivided = function(a,b)
{
  return(a%%b==0)
}

wynik <- isDivided(6,4)
print(wynik)

avarageSpeed = function(a,b)
{
  return (2/((a+b)/(a*b)))
}

wynik <- avarageSpeed(120,90)
print(wynik)

rPearson = function(a,b)
{
  a2<-a-mean(a)
  b2<-b-mean(b)
  return(sum(a2*b2)/(sqrt(sum(a2*a2))*sqrt(sum(b2*b2))))
}

df2<-read.csv2("dane.csv")
wynik <- rPearson(df2[[1]],df2[[2]])
print(wynik)
# wartość współczynnik korelacji linowej około 0,979 bardzo silna korelacja
# dodatnia, czyli jeśli ktoś jest wysoki to często ma też większą wagę i na 
# odwrót jak jest niski to często ma niższą wagę


createDataFrame = function(ile=1)
{
  ile1 = ile+1
  df <- read.table("dane.csv", nrows=ile1)
  return (df)
  
}

testDF <- createDataFrame(5)
print(testDF)
