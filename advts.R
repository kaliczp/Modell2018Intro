## Idősorrá alakítás
t.ts <- ts(temp.df[,"t"], start=1880)
plot(t.ts)
class(t.ts)
?ts
