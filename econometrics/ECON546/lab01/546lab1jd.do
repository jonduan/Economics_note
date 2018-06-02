log using 546lab1jd

pwd

use 546lab1.dta

describe


list

summarize

su educ

l logwr

su if age <= 40 & nclt3 ==1

su logwr in 1/1000 if age <= 40 & nclt3 ==1

generate age2 = age^2

replace age2 = age^2

regress inlf age age2 educ logwr nclt3

regress inlf age age2 educ logwr nclt3, vce(hc3)


predict yfit, xb


su yfit

log close
