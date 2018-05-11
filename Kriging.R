## Topo adatok
library(spatial)
library(MASS)
data(topo)

plot(topo$x, topo$y, asp=T)

# Regressziós felület
topo.ls <- surf.ls(2, topo)
trsurf <- trmat(topo.ls,0,6.5,0,6.5,50)
# Plot
eqscplot(trsurf, typ="n")
contour(trsurf, add=T)
points(topo)
text(topo, lab=topo$z,adj=c(0,1))

# Loess felület
topo.loess <- loess(z ~ x * y, topo,span=0.25, normalize=F)
topo.ma <- list(x=seq(0,6.5,0.1),y=seq(0,6.5,0.1))
topo.lo <- predict(topo.loess, expand.grid(topo.ma), se=T)
eqscplot(topo.ma, typ="n")
contour(topo.ma$x, topo.ma$y, topo.lo$fit, add=T)

# Térbeli korreláció
correlogram(topo.ls, 25) # "nint" argumentum változtatás

d <- seq(0, 7, 0.3)
lines(d, expcov(d, 0.7))
lines(d, gaucov(d, 1.0, 0.3), lty = 3)

variogram(topo.ls, 25)

### Krigelés
## gls kovarianciával
topo.kr <- surf.gls(2, expcov, topo, d=0.7)
correlogram(topo.kr,25)
variogram(topo.kr,25)

prsurf <- prmat(topo.kr, 0, 6.5, 0, 6.5, 50)
contour(prsurf)

# sp csomaggal
library(sp)
coordinates(topo) <- ~x+y
class(topo)

# Ábrázolás
plot(topo)
axis(1)
axis(2)
box()

## Variogram modellek gstattal
library(gstat)
show.vgms()
vgm()

# gstat feldolgozás

hscat(z ~ 1, topo, 0:7)

var.z <- variogram(z ~ 1, topo)
plot(var.z)

var.zcloud <- variogram(z ~ 1, topo, cloud=T)
plot(var.zcloud)

var.res <- variogram(z ~ x + y , topo)
plot(var.res)

data(meuse)
hist(meuse$zinc)
hist(log(meuse$zinc))
boxplot(meuse$zinc)
boxplot(log(meuse$zinc))

coordinates(meuse) <- ~x+y
hscat(log(zinc)~1, meuse, c(0, 80, 120, 250, 500, 1000))

var.b=variogram(log(zinc)~1, meuse)
plot(var.b)

var.cloud=variogram(log(zinc)~1, meuse, cloud=T)
plot(var.cloud)

var.res= variogram(log(zinc)~x+y, meuse)
plot(var.res)

var.res.dir <- variogram(log(zinc)~x+y, meuse, alpha=c(0,45,90,135))
plot(var.res.dir)

plot(variogram(log(zinc)~1, meuse, width=90, cutoff=1300))

## Variogram modell
v = variogram(log(zinc)~x+y, meuse)
v.fit = fit.variogram(v, vgm(1, "Sph", 700, 1))
v.fit
plot(v,v.fit)

data("meuse.grid")
gridded(meuse.grid) <- ~x+y
class(meuse.grid)
plot(meuse.gir)
plot(meuse.grid)
points(meuse)

m <- vgm(.39, "Sph", 1100, .08)
plot(v,m)

m.k1 <- krige(log(zinc)~1, meuse, meuse.grid, model=m)
plot(m.k1)
spplot(m.k1["var1.pred"])

m.k2 <- krige(log(zinc)~1, meuse, meuse.grid, model=m, beta=5.9)
m.k3 <- krige(log(zinc)~x+y, meuse, meuse.grid, model=m)
