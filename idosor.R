## https://data.giss.nasa.gov/gistemp/ az adatok forrása
teljes <- read.csv("NH.Ts+dSST.csv", skip=1)
teljes[1,14]
éves <- as.numeric(as.character(teljes[, "J.D"]))
plot(éves)
temp.df <- data.frame(ido = 1880:2018,t = éves)
temp.df <- temp.df[-nrow(temp.df),]
# Nem-paraméteres módszer lokális regresszió
temp.lowess <- lowess(temp.df)
plot(temp.df)
lines(temp.lowess)
temp.lowess5 <- lowess(temp.df,f=1/28)
lines(temp.lowess5, col=2)

plot(temp.df$ido, temp.df$t-temp.lowess5$y)
lines(lowess(temp.df$ido, temp.df$t-temp.lowess5$y), col=2)


## Regresszió
temp.reg <- lm(t ~ ido, temp.df)
abline(temp.reg,col=3)
plot(temp.reg)
## Regresszió diagnosztika
plot(resid(temp.reg) ~ temp.df$ido)
lines(lowess(temp.df$ido, resid(temp.reg)),col=2)

## Másodfokú polinom
temp.reg2 <- lm(t ~ ido + I(ido^2), temp.df)
summary(temp.reg2)
lines(fitted(temp.reg2) ~ temp.df$ido,col=4)
## Negyedfokú polinom
temp.reg4 <- lm(t ~ poly(ido,4), temp.df)
lines(fitted(temp.reg4) ~ temp.df$ido,col=5)

## Előrejelzés
plot(temp.df, xlim=c(1880,2050),ylim=c(-0.5,6))

lines(2018:2050,predict(temp.reg,data.frame(ido=2018:2050)),col=1)
lines(2018:2050,predict(temp.reg2,data.frame(ido=2018:2050)),col=2)
lines(2018:2050,predict(temp.reg4,data.frame(ido=2018:2050)),col=3)
