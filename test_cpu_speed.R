library(foreach)
library(MASS)
library(doSNOW)
cl<-makeCluster(8) #change the 2 to your number of CPU cores
registerDoSNOW(cl)


ptm <- Sys.time()

a<-foreach(i=1:10^5) %dopar% {
  library(MASS)
  n <- 100  
  A <- matrix(runif(n^2)*2-1, ncol=n) 
  Sigma <- t(A) %*% A+diag(4,100,100)
  X<-mvrnorm(1000,rep(0,100),Sigma)
  y<-rnorm(1000)
  fit<-lm(y~X)
 BIC(fit)
}

temp<-Sys.time() - ptm
print(temp)
ptm <- proc.time()

  for (i in 1:10^3) {
    library(MASS)
    n <- 100  
    A <- matrix(runif(n^2)*2-1, ncol=n) 
    Sigma <- t(A) %*% A
    X<-mvrnorm(1000,rep(0,100),Sigma)
    y<-rnorm(1000)
    fit<-lm(y~X)
  }

temp<-proc.time() - ptm
print(temp)