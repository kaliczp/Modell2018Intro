## Idősorrá alakítás
t.ts <- ts(temp.df[,"t"], start=1880)
plot(t.ts)
class(t.ts)
?ts

t.tsf <- filter(t.ts,c(1/3,1/3,1/3))
lines(t.tsf,col=2,lwd=2)

t.tsf9 <- filter(t.ts,rep(1/9,9))
lines(t.tsf9,col=3,lwd=2)
