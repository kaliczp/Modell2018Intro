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

szv.dec <- decompose(szv.ts)
plot(szv.dec)

library(zoo)
szv.zoo <- zoo(szv, tt2time)
plot(szv.zoo)
szvax <- as.POSIXct(paste0("2007-04-",11:19," 0:0:0"))
axis(1,at=szvax, tck=1, lab=F)

library(xts)
szv.xts <- as.xts(szv.zoo)
plot(szv.xts)
szv2.xts <- szv.xts['2007-04-11/2007-04-19']
plot(szv2.xts)
szv3.xts <- szv.xts['2007-04-11']
plot(szv3.xts)

szv2.ts <- ts(as.numeric(szv2.xts),frequ=720)
szv2.dec <- decompose(szv2.ts)
plot(szv2.dec)

## stl loess
plot(co2)
##Lokális regresszió ?lowess
lines(lowess(co2),col=4)
lines(lowess(co2,f=1/5),col=5,lwd=2)

##Dekompozíció -- loess
co2.loe=stl(co2,"per") #Szezonális dekompozíció a loess eljárással
?loess
plot(co2.loe)
co2.loe
plot(co2.loe$time[,3])
acf(co2.loe$time[,3])

## Fehér zaj autokorrelogramm
acf(rnorm(100))

## Szennyvízre
szv2.loe <- stl(szv2.ts,"per")
plot(szv2.loe)

##Spline simítás
plot(co2)
lines(smooth.spline(time(co2),co2),col=2)
lines(smooth.spline(time(co2),co2,spar=.5))

co2.dt.ma12=co2-co2.ma12
plot(co2.dt.ma12)
##A mozgóátlag az idősor kezdetén és végén nem értelmezett:
round(window(co2.dt.ma12,1959,1961),2) #Ablak függvény
co2.dt=na.omit(co2.dt.ma12) ##Az adathiányok eltüntetése
plot(co2.dt)

## Trend előállítása lokális regresszióval
co2.stl <- stl(co2,"period")
co2.trend = co2.stl$time[,2]
## Trendmentesítés
co2.dt=co2-co2.trend
plot(co2.dt)
## A spektrum elemzése
spectrum(co2.dt)
## Ha a spektrum skála (y tengely) nem logaritmikus:
spectrum(co2.dt,log="no")

## Több lépésben simított spektrum
spectrum(co2.dt,spans=c(3,3))
## Különböző ablakszélességgel simított spektrum és az adatok kezelése
co2.spec=spectrum(co2.dt,spans=c(9,7,5))
names(co2.spec) #Lista elemek
co2.spec$freq[1:50]
plot(co2.spec$freq,co2.spec$spec,type="l")

## Véletlen komponens
co2.maradek = co2.stl$time[,3]
plot(co2.maradek)
## Autokorreláció
acf(co2.maradek)
## Fehér zaj, korrelálatlan idősor azonos hosszúságú, mint a maradék
zaj <- rnorm(length(co2.maradek),mean(co2.maradek),sd(co2.maradek))
plot(ts(zaj))
acf(zaj)

