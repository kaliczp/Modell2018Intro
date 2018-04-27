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
## Regresszió
temp.reg <- lm(t ~ ido, temp.df)
