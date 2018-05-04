## Idősorrá alakítás
t.ts <- ts(temp.df[,"t"], start=1880)
plot(t.ts)
class(t.ts)
?ts

t.tsf <- filter(t.ts,c(1/3,1/3,1/3))
lines(t.tsf,col=2,lwd=2)
