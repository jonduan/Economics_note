'econ546 lab05
wage.hist

'part d
smpl @all if wage>0

'part e
equation eq01.ls(cov=white) lwage c exper educ kidslt6 kidsge6 nwifeinc

'part f
equation eq01.ls(cov=white) lwage c exper educ kidslt6 kidsge6 nwifeinc 'this is a LS estimation

'part g

series u0 = 10 + @sqr(3) * nrnd
'series u1 = 10 + @sqr(3) * @rnorm
u0.hist
series u2=@rexp(200)
u2.hist
'part h http://www.eviews.com/help/helpintro.html#page/content/mathapp-Statistical_Distribution_Functions.html

rndseed 123456
genr t30 = @rtdist(30)
t30.hist

'part i
for !j = 1 to 5 step 1
equation eq{!j}.ls lwage c exper educ kidslt6 kidsge6 nwifeinc
next

'part j
!count =0
while !count <3
smpl @all if kidslt6 = !count
equation eqkids!count.ls lwage c exper educ kidsge6 nwifeinc
!count = !count+1
wend


'control variables
!i = 1
series y{!i} = nrnd
!j = 0
series y{!j}{!i} = nrnd

!i = 1
series y!i = nrnd
!j = 0
series y!j!i = nrnd
