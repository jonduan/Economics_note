
clear
use "C:\Dell2017files\files\courses\546\spring 2018\labs\546lab3.dta"
capture log close
log using "C:\Dell2017files\files\courses\546\spring 2018\labs\546lab3.log", replace

set seed 1234567

g age2=age^2 // creating the square of age
graph twoway (scatter logwr educ) ///
              (lfit logwr educ)
graph save "c:\dell2017files\files\courses\546\spring 2018\labs\graph1.gph", replace

label variable inlf "Women’s participation =1 yes, =0 no"

label variable nclt18 "Number of children between 4 and 18"

label variable age "Age of woman"

notes logwr: this is the natural logarithm of the wage rate

sum inlf if age<=30 | age>=50

g n3=0
replace n3=1 if nclt3 != 0
sum n3

g n4 = nclt3 != 0
sum n4

g x1=rnormal()
g x2=rnormal(50,5)
sum x1 x2

local variables nclt18 age age2 educ logwr
regress inlf nclt3 `variables'

// illustrating a forvalues loop

forvalues loop=0/2 {
regress inlf `variables' if nclt3==`loop'
}

// illustrating a while loop

local k=1
while `k'<=2 {
regress inlf `variables' if nclt3==`k'
local k=`k'+1
}

log close
