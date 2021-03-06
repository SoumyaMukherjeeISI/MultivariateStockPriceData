# Packages used randtests, tactile, mvShapiroTest, factoextra, psych
# Data is stored in the file "~//Stock Data Assignment//stocks.txt" relative to the present
# working directory (can be obtained using getwd() command in R console)
# So if getwd() gives output "C:/Users/Soumya/Documents"
# Then full file path of the data is "C://Users//Soumya//Documents//Stock Data Assignment//stocks.txt"
# Please change the file location as required

# Please remove the Hash sign from the code lines with install.packages
# if the packages are not installed 

# Installing/loading required packages

#install.packages("randtests")
#install.packages("mvShapiroTest")
#install.packages("mvnormtest")
#install.packages("factoextra")
#install.packages("psych")
library(randtests)
library(tactile)
library(mvShapiroTest)
library(factoextra) 
library(psych)




# Importing the data and performing preliminary analysis

# There is one line of data for each week and the
# weekly gains are represented as
# x1 = ALLIED CHEMICAL
# x2 = DUPONT
# x3 = UNION CARBIDE
# x4 = EXXON
# x5 = TEXACO

stocks = read.delim("~//Stock Data Assignment//stocks.txt",header=F)
colnames(stocks)=c("Allied Chemical","Du Pont","Union Carbide","Exxon","Texaco")

# The 5 variables
x1=stocks[,1]
x2=stocks[,2]
x3=stocks[,3]
x4=stocks[,4]
x5=stocks[,5]

# A glimpse of few rows of the data
stocks[c(1:4,100:103),]

# Computation of the sample mean, covariance and correaltion matrices
mean=apply(stocks,2,mean)
S=var(stocks)
zapsmall(S)
R=cor(stocks)
R

# Drawing the pairwise scatterplots
pairs(stocks)

# Performing the Wald-Wolfowitz runs test on each variable
apply(stocks,2,runs.test)




# Checking multivariate normality of the data

## QQ Plots
qqmath(x1, distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(x1, grid = TRUE)
  panel.qqmathline(x1, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

qqmath(x2, distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(x2, grid = TRUE)
  panel.qqmathline(x2, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

qqmath(x3, distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(x3, grid = TRUE)
  panel.qqmathline(x3, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

qqmath(x4, distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(x4, grid = TRUE)
  panel.qqmathline(x4, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

qqmath(x5, distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(x5, grid = TRUE)
  panel.qqmathline(x5, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

#Shapiro-Wilks Test of Univariate Normality
shapiro.test(x1)
shapiro.test(x2)
shapiro.test(x3)
shapiro.test(x4)
shapiro.test(x5)

#Test for Multivariate normality

#Multivariate Shapiro-Wilks Test for normality
mvShapiro.Test(as.matrix(stocks))






# Principal Component method along with estimate of no. of common factors 'm'

#Covariance matrix

#Principal Component Analysis
stocks_var_pca=prcomp(stocks,scale.=FALSE)

#Scree Plot
fviz_eig(stocks_var_pca, addlabels = TRUE)

#Variances of Principal components i.e. Eigenvalues
eigenvalues_stocks_var_pca=(stocks_var_pca$sdev)^2
eigenvalues_stocks_var_pca

#Eigenvectors used in determining the sample principal components
eigenvectors_stocks_var_pca=stocks_var_pca$rotation
eigenvectors_stocks_var_pca

#Proportion and cumulative proportion of variation in the data explained by
#each principal component
prop_var_pca=eigenvalues_stocks_var_pca/sum(diag(S))
names(prop_var_pca)=c("1st PC","2nd PC","3rd PC","4th PC","5th PC")
cum_prop_var_pca=cumsum(prop_var_pca)
summary_var_pca=cbind("Eigenvalue"=eigenvalues_stocks_var_pca,"Proportion of variance"=prop_var_pca,"Cumulative Proportion of variance"=cum_prop_var_pca)
summary_var_pca

#Number of common factors
mvar=2

#Estimate of L, Psi and communality
L_var_pca = eigenvectors_stocks_var_pca[,1:mvar] %*% diag(sqrt(eigenvalues_stocks_var_pca)[1:mvar])
Psi_var_pca=diag(diag(S-L_var_pca %*% t(L_var_pca)))
communality_var_pca = apply(L_var_pca,1,function(x)sum(x^2))
L_var_pca
zapsmall(Psi_var_pca)
communality_var_pca

#Residual matrix
res_var_pca=S-Psi_var_pca-L_var_pca %*% t(L_var_pca)
res_var_pca
sum(res_var_pca^2)

#Correlation matrix

#Principal Component Analysis
stocks_cor_pca=prcomp(stocks,scale.=TRUE)

#Scree Plot
fviz_eig(stocks_cor_pca, addlabels = TRUE)

#Variances of Principal components i.e. Eigenvalues
eigenvalues_stocks_cor_pca=(stocks_cor_pca$sdev)^2
eigenvalues_stocks_cor_pca

#Eigenvectors used in determining the sample principal components
eigenvectors_stocks_cor_pca=stocks_cor_pca$rotation
eigenvectors_stocks_cor_pca

#Proportion and cumulative proportion of variation in the data explained by
#each principal component
prop_cor_pca=eigenvalues_stocks_cor_pca/5
names(prop_cor_pca)=c("1st PC","2nd PC","3rd PC","4th PC","5th PC")
cum_prop_cor_pca=cumsum(prop_cor_pca)
summary_cor_pca=cbind("Eigenvalue"=eigenvalues_stocks_cor_pca,"Proportion of variance"=prop_cor_pca,"Cumulative Proportion of variance"=cum_prop_cor_pca)
summary_cor_pca

#Number of common factors
mcor=3

#Estimate of L, Psi and communality
L_cor_pca = eigenvectors_stocks_cor_pca[,1:mcor] %*% diag(sqrt(eigenvalues_stocks_cor_pca)[1:mcor])
Psi_cor_pca=diag(diag(R-L_cor_pca %*% t(L_cor_pca)))
communality_cor_pca = apply(L_cor_pca,1,function(x)sum(x^2))
L_cor_pca
zapsmall(Psi_cor_pca)
communality_cor_pca

#Residual matrix
res_cor_pca=R-Psi_cor_pca-L_cor_pca %*% t(L_cor_pca)
res_cor_pca
sum(res_cor_pca^2)






# Iterative Principal Components Method

#Covariance matrix
iter_var = fa(stocks,nfactors = 2,rotate = 'none',fm='pa',covar = TRUE)

# Estimate of L, Psi and communality 
summary_var_iter <- data.frame(dimnames(S)[[1]],iter_var$loadings[,], iter_var$communality, iter_var$uniquenesses)
colnames(summary_var_iter)=c("Variable","Factor 1 loadings","Factor 2 loadings", "Communality", "Uniqueness")
rownames(summary_var_iter)=NULL
print(summary_var_iter)

L_var_iter=as.matrix(summary_var_iter[,c(2,3)])
communality_var_iter=as.vector(summary_var_iter[,4])
Psi_var_iter=diag(communality_var_iter)
L_var_iter
zapsmall(Psi_var_iter)
communality_var_iter

#Residual matrix
res_var_iter=S-Psi_var_iter-L_var_iter %*% t(L_var_iter)
res_var_iter
sum(res_var_iter^2)

#Correlation matrix
iter_cor = fa(stocks,nfactors = 2,rotate = 'none',fm='pa')

# Estimate of L, Psi and communality 
summary_cor_iter <- data.frame(dimnames(R)[[1]],iter_cor$loadings[,], iter_cor$communality, iter_cor$uniquenesses)
colnames(summary_cor_iter)=c("Variable","Factor 1 loadings","Factor 2 loadings", "Communality", "Uniqueness")
rownames(summary_cor_iter)=NULL
print(summary_cor_iter)

L_cor_iter=as.matrix(summary_cor_iter[,c(2,3)])
communality_cor_iter=as.vector(summary_cor_iter[,4])
Psi_cor_iter=diag(as.vector(summary_cor_iter[,5]))
L_cor_iter
zapsmall(Psi_cor_iter)
communality_cor_iter

#Residual matrix
res_cor_iter=R-Psi_cor_iter-L_cor_iter %*% t(L_cor_iter)
res_cor_iter
sum(res_cor_iter^2)





# Maximum likelihood method

#Covariance matrix
ml_var = fa(stocks,nfactors = 2,rotate = 'none',fm='ml',covar = TRUE)

# Estimate of L, Psi and communality 
summary_var_ml <- data.frame(dimnames(S)[[1]],ml_var$loadings[,], ml_var$communality, ml_var$uniquenesses)
colnames(summary_var_ml)=c("Variable","Factor 1 loadings","Factor 2 loadings", "Communality", "Uniqueness")
rownames(summary_var_ml)=NULL
print(summary_var_ml)

L_var_ml=as.matrix(summary_var_ml[,c(2,3)])
communality_var_ml=as.vector(summary_var_ml[,4])
Psi_var_ml=diag(communality_var_ml)
L_var_ml
zapsmall(Psi_var_ml)
communality_var_ml

#Residual matrix
res_var_ml=S-Psi_var_ml-L_var_ml %*% t(L_var_ml)
res_var_ml
sum(res_var_ml^2)

#Correlation matrix
ml_cor = fa(stocks,nfactors = 2,rotate = 'none',fm='ml')

# Estimate of L, Psi and communality 
summary_cor_ml <- data.frame(dimnames(R)[[1]],ml_cor$loadings[,], ml_cor$communality, ml_cor$uniquenesses)
colnames(summary_cor_ml)=c("Variable","Factor 1 loadings","Factor 2 loadings", "Communality", "Uniqueness")
rownames(summary_cor_ml)=NULL
print(summary_cor_ml)

L_cor_ml=as.matrix(summary_cor_ml[,c(2,3)])
communality_cor_ml=as.vector(summary_cor_ml[,4])
Psi_cor_ml=diag(as.vector(summary_cor_ml[,5]))
L_cor_ml
zapsmall(Psi_cor_ml)
communality_cor_ml

#Residual matrix
res_cor_ml=R-Psi_cor_ml-L_cor_ml %*% t(L_cor_ml)
res_cor_ml
sum(res_cor_ml^2)

# Bartlett's large sample test of goodness of fit

bartlett.gof.test = function(data,R,m,L,Psi)
{
  n=nrow(data)
  p=ncol(data)
  n_prime=n-1-(2*p+4*m+5)/6
  bartlett.statistic=n_prime*log(det(L%*% t(L)+Psi)/det(R))
  df=((p-m)^2-(p+m))/2
  crit_val=qchisq(0.95,df)
  pval=1-pchisq(bartlett.statistic,df)
  
  if(bartlett.statistic>crit_val)
  {
    print("Bartlett's large sample test of goodness of fit")
    print(paste("Value of the test statistic is ",bartlett.statistic))
    print(paste("The degree of freedom is ",df))
    print(paste("The p-value is ",pval))
    print(paste("The critical value is",crit_val))
    print("The null hypothesis is rejected at 5% level of significance")
  }
  else
  {
    print("Bartlett's large sample test of goodness of fit")
    print(paste("Value of the test statistic is ",bartlett.statistic))
    print(paste("The degree of freedom is ",df))
    print(paste("The p-value is ",pval))
    print(paste("The critical value is",crit_val))
    print("We fail to reject the null hypothesis at 5% level of significance")
  }
}

bartlett.gof.test(stocks,R,m=2,L_cor_ml,Psi_cor_ml)







# Application of Varimax Rotation

# Iterative PC method

#Covariance matrix
iter_var_rot = fa(stocks,nfactors = 2,rotate = 'varimax',fm='pa',covar = TRUE)

# Estimate of L, Psi and communality 
summary_var_iter_rot <- data.frame(dimnames(S)[[1]],iter_var_rot$loadings[,], iter_var_rot$communality, iter_var_rot$uniquenesses)
colnames(summary_var_iter_rot)=c("Variable","Factor 1 loadings","Factor 2 loadings", "Communality", "Uniqueness")
rownames(summary_var_iter_rot)=NULL
print(summary_var_iter_rot)

L_var_iter_rot=as.matrix(summary_var_iter_rot[,c(2,3)])
communality_var_iter_rot=as.vector(summary_var_iter_rot[,4])
Psi_var_iter_rot=diag(communality_var_iter_rot)
L_var_iter_rot
zapsmall(Psi_var_iter_rot)
communality_var_iter_rot

#Residual matrix
res_var_iter_rot=S-Psi_var_iter_rot-L_var_iter_rot %*% t(L_var_iter_rot)
res_var_iter_rot
sum(res_var_iter_rot^2)

#Correlation matrix
iter_cor_rot = fa(stocks,nfactors = 2,rotate = 'varimax',fm='pa')

# Estimate of L, Psi and communality 
summary_cor_iter_rot <- data.frame(dimnames(R)[[1]],iter_cor_rot$loadings[,], iter_cor_rot$communality, iter_cor_rot$uniquenesses)
colnames(summary_cor_iter_rot)=c("Variable","Factor 1 loadings","Factor 2 loadings", "Communality", "Uniqueness")
rownames(summary_cor_iter_rot)=NULL
print(summary_cor_iter_rot)

L_cor_iter_rot=as.matrix(summary_cor_iter_rot[,c(2,3)])
communality_cor_iter_rot=as.vector(summary_cor_iter_rot[,4])
Psi_cor_iter_rot=diag(as.vector(summary_cor_iter_rot[,5]))
L_cor_iter_rot
zapsmall(Psi_cor_iter_rot)
communality_cor_iter_rot

# Maximum Likelihood method

#Covariance matrix
ml_var_rot = fa(stocks,nfactors = 2,rotate = 'varimax',fm='ml',covar = TRUE)

# Estimate of L, Psi and communality 
summary_var_ml_rot <- data.frame(dimnames(S)[[1]],ml_var_rot$loadings[,], ml_var_rot$communality, ml_var_rot$uniquenesses)
colnames(summary_var_ml_rot)=c("Variable","Factor 1 loadings","Factor 2 loadings", "Communality", "Uniqueness")
rownames(summary_var_ml_rot)=NULL
print(summary_var_ml_rot)

L_var_ml_rot=as.matrix(summary_var_ml_rot[,c(2,3)])
communality_var_ml_rot=as.vector(summary_var_ml_rot[,4])
Psi_var_ml_rot=diag(communality_var_ml_rot)
L_var_ml_rot
zapsmall(Psi_var_ml_rot)
communality_var_ml_rot

#Correlation matrix
ml_cor_rot = fa(stocks,nfactors = 2,rotate = 'varimax',fm='ml')

# Estimate of L, Psi and communality 
summary_cor_ml_rot <- data.frame(dimnames(R)[[1]],ml_cor_rot$loadings[,], ml_cor_rot$communality, ml_cor_rot$uniquenesses)
colnames(summary_cor_ml_rot)=c("Variable","Factor 1 loadings","Factor 2 loadings", "Communality", "Uniqueness")
rownames(summary_cor_ml_rot)=NULL
print(summary_cor_ml_rot)

L_cor_ml_rot=as.matrix(summary_cor_ml_rot[,c(2,3)])
communality_cor_ml_rot=as.vector(summary_cor_ml_rot[,4])
Psi_cor_ml_rot=diag(as.vector(summary_cor_ml_rot[,5]))
L_cor_ml_rot
zapsmall(Psi_cor_ml_rot)
communality_cor_ml_rot






# Factor scores


#Function to calculate the wls and regression factor scores
factor_scores=function(data,L,Psi,covar=TRUE)
{
  if(covar==FALSE)
  {
    data=scale(data)
  }
  mean=apply(data,2,mean)
  centered_data=apply(data,1,function(x){x-mean})
  mat_wls=solve(t(L)%*%solve(Psi)%*%L)%*%t(L)%*%solve(Psi)
  mat_reg=t(L)%*%solve((L%*%t(L)+Psi))
  fa_scores_wls=t(mat_wls%*%centered_data)
  fa_scores_reg=t(mat_reg%*%centered_data)
  colname=rep("name",ncol(L))
  for(i in 1:ncol(L))
  {
    colname[i]=paste("Factor",i,"scores")
  }
  colnames(fa_scores_wls)=colnames(fa_scores_reg)=colname
  return(list(wls_scores=fa_scores_wls,reg_scores=fa_scores_reg))
}

# Maximum Likelihood

# Correlation matrix

ml_cor_scores=factor_scores(stocks,L_cor_ml_rot,Psi_cor_ml_rot,covar=FALSE)
ml_cor_scores$wls_scores
ml_cor_scores$reg_scores

# Checking normality and pairwise independence assumptions

# Weighted Least Squares Method

# QQPlot

# Factor 1 scores
qqmath(ml_cor_scores$wls_scores[,1], distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(ml_cor_scores$wls_scores, grid = TRUE)
  panel.qqmathline(ml_cor_scores$wls_scores, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

# Univariate normality testing using shapiro-wilks test
shapiro.test(ml_cor_scores$wls_scores[,1])
shapiro.test(ml_cor_scores$wls_scores[,1])$p.value

# Factor 2 scores
qqmath(ml_cor_scores$wls_scores[,2], distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(ml_cor_scores$wls_scores, grid = TRUE)
  panel.qqmathline(ml_cor_scores$wls_scores, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

# Univariate normality testing using shapiro-wilks test
shapiro.test(ml_cor_scores$wls_scores[,2])
shapiro.test(ml_cor_scores$wls_scores[,2])$p.value

# Multivariate normality testing using multivaraite Shapiro-Wilks test
mvShapiro.Test(ml_cor_scores$wls_scores)
mvShapiro.Test(ml_cor_scores$wls_scores)$p.value

# Checking pairwise independence of factor scores
cor.test(ml_cor_scores$wls_scores[,1], ml_cor_scores$wls_scores[,2], method = "pearson")
cor.test(ml_cor_scores$wls_scores[,1], ml_cor_scores$wls_scores[,2], method = "pearson")$p.value

# Regression Method

# QQPlot

# Factor 1 scores
qqmath(ml_cor_scores$reg_scores[,1], distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(ml_cor_scores$reg_scores, grid = TRUE)
  panel.qqmathline(ml_cor_scores$reg_scores, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

# Univariate normality testing using shapiro-wilks test
shapiro.test(ml_cor_scores$reg_scores[,1])
shapiro.test(ml_cor_scores$reg_scores[,1])$p.value

# Factor 2 scores
qqmath(ml_cor_scores$reg_scores[,2], distribution = qnorm, panel = function(x, ...) {
  panel.qqmath(ml_cor_scores$reg_scores, grid = TRUE)
  panel.qqmathline(ml_cor_scores$reg_scores, col = "red")
  panel.qqmathci(x, y = x, ci = 0.95)},
  xlab="Theoretical quantiles",
  ylab="Sample Quantiles")

# Univariate normality testing using shapiro-wilks test
shapiro.test(ml_cor_scores$reg_scores[,2])
shapiro.test(ml_cor_scores$reg_scores[,2])$p.value

# Multivariate normality testing using multivaraite Shapiro-Wilks test
mvShapiro.Test(ml_cor_scores$reg_scores)
mvShapiro.Test(ml_cor_scores$reg_scores)$p.value

# Checking pairwise independence of factor scores
cor.test(ml_cor_scores$reg_scores[,1], ml_cor_scores$reg_scores[,2], method = "pearson")
cor.test(ml_cor_scores$reg_scores[,1], ml_cor_scores$reg_scores[,2], method = "pearson")$p.value


