x = rnorm(20000, mean=4)
x = rnorm(20000, 4) # ugyan az, mint a fenti, a sorrend!

## EDA x-re
hist(x, col=2)
# http://colorbrewer2.org #hexa kód
hist(x, col="#d7301f")
hist(x, col="red")

y = 2*x
