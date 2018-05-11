pi.gen <- function(ttnum, plot=FALSE)
{
  x=runif(ttnum)
  y=runif(ttnum)
  dist=sqrt(x^2+y^2)
  inside=ifelse(dist <= 1,TRUE,FALSE)
  if(plot)
  {
    plot(x,y,asp=1,pch=".",xaxs="i", yaxs="i")
    lines(seq(0,1,0.01),sqrt(1-(seq(0,1,0.01)^2)))
    points(x[inside],y[inside],col=2,pch=".")
  }
  4*(sum(inside)/ttnum)
}