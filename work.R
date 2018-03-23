### Normális eloszlás
## Véletlen szám generálás
t1 <- rnorm(10)

set.seed(5)

summary(t1)
mean(t1)
median(t1)
min(t1)
max(t1)
quantile(t1)

## Trimmelt átlag
mean(t1,trim=.1)

t2 = c(t1, 4)

summary(t2)
mean(t2,trim=.1)

quantile()
quantile(t1,0.11)

## Q-Q plot
qqnorm(t1)

## Testreszabás
par(las=1)
qqnorm(t1, main="",
       xlab="Elméleti kvantilisek",
       ylab="Minta kvantilisek",
       col=2)
?plot #Információ az alap paraméterekről
abline(0,1, col="lightgray", lwd=2)
qqline(t1)
## Koordináta értékek leolvasása
## identify()
locator(1)
text(0.69,0.47,"a")

qqnorm(t1, main="",
       xlab="Elméleti kvantilisek",
       ylab="Minta kvantilisek",
       col=2)
abline(0,1, col="lightgray", lwd=2)
qqline(t1)
legend("topleft",legend=c("qqline","1:1 mer. egyenes"),
       lwd=c(1,2),
       col=c("black","lightgray"))

par(mfrow=c(2,1), mar=c(2.1,2.1,0.1,0.1))
qqnorm(t1,main="", xlab="",ylab="")
qqline(t1)
## Adat generálás
teszt <- rnorm(10)
qqnorm(teszt,main="", xlab="",ylab="")
qqline(teszt)