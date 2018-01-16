## Sample from Sargent Dynare document

### 1. stochShock.mod
  - Generate simudata.m
  - using "datatomfile('simudata',[]);  //save result" to
### 2. GrowthEstimate.mod
  - Bayesian Estimation.
  -  mh_replic = INTEGER
     - Number of replications for Metropolis-Hastings algorithm. For the time being, mh_replic should be larger than 1200. Default: 20000

     - the number of iterations (ie the value of mh_replic) is important enough to ensure the convergence of the MCMC to its ergodic distribution
  - mh_jscale = DOUBLE
    - The scale parameter of the jumping distribution’s covariance matrix (Metropolis-Hastings algorithm). The default value is rarely satisfactory. This option must be tuned to obtain, ideally, an acceptance ratio of 25%-33% in the Metropolis-Hastings algorithm. Basically, the idea is to increase the variance of the jumping distribution if the acceptance ratio is too high, and decrease the same variance if the acceptance ratio is too low. In some situations in may help to consider parameter specific values for this scale parameter, this can be done in the estimated_params block. Default: 0.2   
  - See more option on [manual](http://www.dynare.org/manual/index_27.html)  
### 3. Sargent Dynare document
  - 2.3 Estimation. Page 4 - 7
    - explain the model and result.
### 4. First order condition for the Growth Model
  - How to set up the model block
