x = rnorm(20000, mean=4)
x = rnorm(20000, 4) # ugyan az, mint a fenti, a sorrend!

## EDA x-re
hist(x, col=2)
# http://colorbrewer2.org #hexa kód
hist(x, col="#d7301f")
hist(x, col="red")

hist(x, col="#d7301f", main="",xlab="Konc.", ylab="Gyakoriság")

hist(x, "Scott",col="#d7301f", main="",xlab="Konc.", ylab="Gyakoriság")

hist(x, 8,col="#d7301f", main="",xlab="Konc.", ylab="Gyakoriság")

hist(x, -1:8,col="#d7301f", main="",xlab="Konc.", ylab="Gyakoriság")

hist(x, c(-1,3,5,8),col="#d7301f", main="",xlab="Konc.", ylab="Gyakoriság")

hist(x, freq=F)

x.dens=density(x)

lines(x.dens)

# Hipotézis vizsgálat
x1 = rnorm(500,4)
mean(x);mean(x1)
t.test(x,y)
t.test(x,x1,var.equal = T)

var.test(x,x1)
var.test(x,y)

y = 2*x

a.df = data.frame(x, y)
a.df$y = a.df$y + rnorm(20000)

# Felfedező adatelemzés
summary(a.df)
boxplot(a.df)
IQR(a.df$y)

plot(y ~ x, a.df)
a.lm = lm(y ~ x, a.df)
abline(a.lm, col=2)
summary(a.lm)
plot(a.lm)

## Nincs tengelymetszet
a2.lm = lm(y ~ x - 1 , a.df)
abline(a2.lm, col=3)
summary(a2.lm)

# lm objektum, lista
names(a.df)
a.lm$coefficients
(a.lm$coefficients)["x"]
boxplot(a.lm$residuals)

a.lst = list(a=1,b="a",c=1:10)
a.lst$a
names(a.lst)
