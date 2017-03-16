use http://fmwww.bc.edu/ec-p/data/stockwatson/fatality
twoway (scatter mrall beertax) (lfit mrall beertax)


*http://fmwww.bc.edu/ec-p/data/stockwatson/datasets.list.html


xtset state year

gen vfrall = mrall*10000

xtreg vfrall beertax, fe vce(cluster state)



gen y83=(year==1983)
* First generate all the time binary variables

gen y84=(year==1984)
 gen y85=(year==1985)
 
 gen y86=(year==1986)
 gen y87=(year==1987)
 gen y88=(year==1988)
 
 global yeardum "y83 y84 y85 y86 y87 y88"
 xtreg vfrall beertax $yeardum, fe vce(cluster state)
 
 
 areg vfrall beertax y83 y84 y85 y86 y87 y88, absorb(state) r

 test $yeardum
 
 * demean
 areg vfrall beertax, absorb(state) r
 
 
*•	“areg” automatically de-means the data
*•	this is especially useful when n is large
*•	the reported intercept is arbitrary

 
 
reg fatalityRate beertax if year == 1988
gen frate = mrall*1000

regress frate beertax if(year==1982), robust



regress frate beertax if(year==1988), robust


*Results of first-difference regression



regress dy dx, robust

*http://fmwww.bc.edu/ec-p/data/wooldridge/datasets.list.html

ssc install bcuse
bcuse smoke, clear


*regress lpackpc rtax lperinc

regress lcigpric cigs lincome


*CIG85_95: N=528, Panel data, annual per capita cigarette sales for 48 states in packs per fiscal year from 1985-1995.
use http://fmwww.bc.edu/ec-p/data/stockwatson/cig85_95, clear
gen lpackpc = log(packpc)
gen lperinc = log(income)

regress lpackpc tax lperinc

*Before-After estimation
gen diff_rtax= rtax1995- rtax1985 
gen diff_lpackpc= lpackpc1995- lpackpc1985 
gen diff_lperinc= lperinc1995- lperinc1985

regress diff_lpackpc diff_rtax diff_lperinc, nocons

*http://www.stata.com/support/faqs/data-management/creating-dummy-variables/
tabulate state, generate(stateB)

*Least squares with dummy variables (no constant term) .
 
regress lpackpc tax lperinc stateB*, nocons

*Least squares with dummy variables with constant term . 
regress lpackpc tax lperinc stateB*


*http://www.stata.com/support/faqs/data-management/creating-group-identifiers/

egen STATE = group(state)

*Within estimation
xtreg lpackpc tax lperinc, fe i(STATE)




