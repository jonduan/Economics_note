/*
 * This file implements Newclassical / Ramsey models
 *
 * Note that this mod-file implements the non-linear first order conditions and that the IRFs show the linear deviations
 * from steady state.
 *
 * It demonstrate the dynamic of the shock of government spending
 *
 * This implementation was written by 
 *
 * Please note that the following copyright notice only applies to this Dynare 
 * implementation of the model.
 */
 
%----------------------------------------------------------------
%  Set up variables 
%----------------------------------------------------------------


var y I k z c w R r;

varexo e;

%----------------------------------------------------------------
%  parametrization of model
%----------------------------------------------------------------

parameters alpha beta delta rho sigma sigmae;

alpha = 1/3;
beta = 0.99;
delta = 0.025;
rho = 0.95;
sigma = 1;
sigmae = 0.01;


%----------------------------------------------------------------
% Model:First Order Conditions
%----------------------------------------------------------------

// Equations of the model

model;

exp(c)^(-sigma) = beta*exp(c(+1))^(-sigma)*(alpha*exp(z(+1))*exp(k)^(alpha-1) + (1-delta));
exp(y) = exp(z)*exp(k(-1))^(alpha);
exp(k) = exp(z)*exp(k(-1))^(alpha) - exp(c) + (1-delta)*exp(k(-1));
z = rho*z(-1) + e;
exp(y) = exp(c) + exp(I);
exp(c)^(-sigma) = beta*exp(c(+1))^(-sigma)*(1+r);
exp(R) = alpha*exp(z)*exp(k(-1))^(alpha-1);
exp(w) = (1-alpha)*exp(z)*exp(k(-1))^(alpha);

end;


%----------------------------------------------------------------
%  Initial Values for steady state
%---------------------------------------------------------------

initval;
k = log(30);
y = log(3);
c = log(2.5);
I = log(0.5);
z = 0;
r = (1/beta) - 1;
R = log((1/beta) - (1-delta));
w = log(1);
end;

%----------------------------------------------------------------
%  Solve the steady state
%---------------------------------------------------------------

steady; 
check;


%----------------------------------------------------------------
%  define shock variances
%---------------------------------------------------------------

// Declaring the shocks

shocks;
var e = sigmae^2;
//stderr 0.01;
end;



%----------------------------------------------------------------
%  use command to generate TeX-Files with dynamic and static model equations
%---------------------------------------------------------------


write_latex_dynamic_model;
write_latex_static_model;



%----------------------------------------------------------------
% generate simulation
% generate IRFs to show 
%
%----------------------------------------------------------------

// Launch solving procedure 


stoch_simul(order=1,irf=40,periods=5000);
