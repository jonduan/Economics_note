# fm_casestudy_0_InstallOrLoadLibraries.r

#   * Install/load R packages 
#   * Collect historical financial data from internet
#   * Create time series data matrix: casestudy1.data0.0
#         Closing prices on stocks (BAC, GE, JDSU, XOM)
#         Closing values of indexes (SP500)
#         Yields on constant maturity US rates/bonds (3MO, 1YR, 5YR, 10 YR)
#         Closing price on crude oil spot price
# 0. Install and load packages ----
#
# 0.1 Install packages ---
#     Set ind.install0 to TRUE if running script for first time on a computer
#     or updating the packages
ind.install0<-TRUE
#
if (ind.install0){
  install.packages("quantmod") 
  install.packages("tseries") 
  install.packages("vars")
  install.packages("fxregime")
  install.packages("moments")
  install.packages("rugarch")
  install.packages("xts")
}
# 0.2 Load packages into R session

library("quantmod")  
library("tseries")  
library("vars")  
library("fxregime")  
library("moments")  
library("rugarch")  
