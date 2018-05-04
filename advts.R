## Idősorrá alakítás
t.ts <- ts(temp.df[,"t"], start=1880)
plot(t.ts)
class(t.ts)
?ts

t.tsf <- filter(t.ts,c(1/3,1/3,1/3))
lines(t.tsf,col=2,lwd=2)

t.tsf9 <- filter(t.ts,rep(1/9,9))
lines(t.tsf9,col=3,lwd=2)

##Elcsúszás mentes páros ablakszélesség
t.tsf <- filter(t.ts,c(1/8,rep(1/4,3),1/8))
lines(t.tsf,col=4,lwd=2)

## CO2
?co2
co2
tsp(co2)
end(co2)
time(co2)
time(co2)[1:13] #Az idő paraméter az első évben
cycle(co2)
as.vector(co2)[1:10] #Koncentráció vektora

plot(co2)

plot(co2,main="Szén-dioxid koncentráció (1959-1997)",xlab="",ylab="[ppm]",xaxs="i",typ="n")
grid(col="grey")
lines(co2,lwd=2)

##Trend idősor nemparamétere szűrővel
co2.ma12=filter(co2,c(1/24,rep(1/12,11),1/24)) #Mozgó átlag 12 e. ablak
lines(co2.ma12,col=3)

##Dekompozíció mozgóátlaggal
co2.dec <- decompose(co2)
plot(co2.dec)

class(co2.dec) ##Objektum oszálya
class(co2)
str(co2.dec) ##Az objektum szerkezete
names(co2.dec)
window(co2.dec$trend,1970,1970.5)
##A mozgóátlagolású trend mentes sor
co2.notr <- co2 - co2.dec$trend
plot(co2.notr)
boxplot(co2.notr ~ cycle(co2.notr))

## Az előző ábra csinosítása
lines(1:12,apply(matrix(co2.notr,nr=12),1,function(x){median(x,na.rm=T)}),lwd=2)
boxplot(co2.notr ~ cycle(co2.notr),col="blue",add=T,xlab="Hónap",ylab="Eltérés a trendtől [ppm]")

### Nem biztos, hogy ez a hozam!!!!
szv <- scan("szennyv.txt")
tt2time <- seq(ISOdatetime(2007,4,10,13,46,00),ISOdatetime(2007,4,20,00,24,00),by="2 mins")
plot(data.frame(tt2time,szv))

szv.ts <- ts(szv, freq = 24*30)
plot(szv.ts) # 2 perces mintavételezés
