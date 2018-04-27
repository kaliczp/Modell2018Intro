## https://data.giss.nasa.gov/gistemp/ az adatok forrása
teljes <- read.csv("NH.Ts+dSST.csv", skip=1)
teljes[1,14]
éves <- as.numeric(as.character(teljes[, "J.D"]))
