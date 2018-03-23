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