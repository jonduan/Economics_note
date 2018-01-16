******************************
***** ECON 501 - Intro *******
******************************

clear all
set more 1

**************************
***** My Data (FRED) *****
**************************

*cd C:\MC\Teaching\ECON_501\Data\

cd c:\Dropbox\book\uvic_economics\501-2016\lab\lab7
*cd C:\Users\jonduan\Dropbox\book\uvic_economics\501-2016\lab\lab7
cap log close
log using "ECON_501_stata_lab7.log", replace
cap log off
cap log on

insheet using http://people.stern.nyu.edu/wgreene/Text/Edition7/TableF5-2.csv, clear

sum year qtr


*First, let STATA know you are using time series data
generate time=q(1950q1)+_n-1
format time %tq
sort time
tsset time
********************************
gen dp= infl-L.infl
*gen dy= log(realgdp)-log(L.realgdp)
sum realgdp infl unemp

* plot
twoway (line realgdp time)
twoway (line infl time)
twoway (line unemp time)
tsline unemp




* CORR
corr realgdp L.realgdp unemp L.unemp 
xcorr realgdp unemp, lags(10) xlabel(-10(1)10,grid)
xcorr realgdp unemp, lags(10) table


* trend and cyclical components
tsfilter hp realgdp_hp = realgdp , smooth(400) trend(realgdp_tr)
tsfilter hp unemp_hp = unemp , smooth(400) trend(unemp_tr)

* unit root test
dfuller unemp, lag(5)
dfuller unemp_hp, lag(5)

*help eststo
*help usefred
reg dp unemp
eststo model1
estat bgodfrey,lag(1/3)
*help bgodfrey


predict new1res, residuals
corrgram new1res, lags(12)
twoway (line new1res time)

*or Then, reestimate the model using an AR(1) model for the disturbance process.
*Because the sample is large, the Prais Winsten and Cochrane Orcutt estimators
*should give essentially the same answer.


*Perform Cochrane-Orcutt AR(1) regression
prais dp unemp, corc
eststo
*Perform Prais-Winsten AR(1) regression
prais dp unemp
eststo
*Same as above, but request robust standard errors
prais dp unemp, corc vce(robust)
eststo

predict new3res, residuals

corrgram new3res, lags(12)

*****************

* a regression model with ARMA disturbances

arima dp unemp,ar(1)
eststo
predict new2res, residuals

corrgram new2res, lags(12)

wntestq new2res

arima dp unemp,ar(3)
eststo
predict new21res, residuals

corrgram new21res, lags(12)

wntestq new21res


*****************************

* fitting an improved Phillips curve model

gen newecon =0
replace newecon=1   if tin(1974q1,2000q4)
gen ddp = D.dp 
reg D.dp unemp newecon
eststo
reg ddp unemp newecon
eststo
estat bgodfrey
predict new41res, residuals
corrgram new41res, lags(12)
twoway (line new4res time)
*************************
* Chapter 22 application 1

gen logcons=ln(realcons)
gen loggdp=ln(realgdp)

reg logcons L(1/2).logcons loggdp
eststo
ereturn list
estat bgodfrey
estat bgodfrey,lag(1/3)
*help bgodfrey



estat hettest


predict new5res, residuals

reg new5res L(1/3).new5res

scalar lmts=e(r2)*e(N)
di lmts

di e(r2)

scalar beta=0.07869
scalar betabar=0.07869/(1-0.968-(-0.047))
di beta
di betabar

esttab, r2 ar2 se scalar(rmse)

*********************

varbasic logcons loggdp,lags(1/3)



**********
var logcons loggdp


irf create order1, step(10) set(myirf3)
irf graph oirf, impulse(loggdp) response(logcons)



****************************



findit estout

return list

capture drop ehat
predict double ehat , resid

**************************

corrgram loggdp
xcorr realgdp unemp, lags(10) xlabel(-10(1)10,grid)
xcorr realgdp unemp, lags(10) table


*****************
xcorr realint unemp, lags(10) xlabel(-10(1)10,grid)
xcorr realint unemp, lags(10) table


*****************
varsoc realgdp cpi_u, maxlag(10)
********************


gen lcpi = log(cpi_u)

gen inf = 400*(lcpi[_n]-lcpi[_n-1])

corrgram inf if tin(1960q1,2000q4), noplot lags(8)

corrgram inf if tin(1960q1,2000q4),  lags(8)


gen dinf = inf[_n]-inf[_n-1]
reg dinf L.dinf if tin(1962q1,2000q4), r

dis "Adjusted Rsquared = " _result(8)

reg dinf L(1/4).dinf if tin(1962q1,2000q4), r
dis "Adjusted Rsquared = " _result(8)

test L2.dinf L3.dinf L4.dinf

reg dinf L(1/4).dinf L(1/4).unemp if tin(1962q1,2000q4), r








******************************

clear all
set more 1

findit freduse

freduse UNRATE

freduse GS1M CPN3M GS5

*http://www.statalist.org/forums/forum/general-stata-discussion/general/1301184-problem-with-freduse-command

