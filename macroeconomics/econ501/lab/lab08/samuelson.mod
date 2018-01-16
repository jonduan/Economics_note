/*
 * This file implements Backward looking models Samuelson’s Oscillator (samuelson.mod)
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

 
var ct,it,yt,gt; // Name of the variable 

varexo eg; // Name of the exogenous variable parame


%----------------------------------------------------------------
%  parametrization of model
%----------------------------------------------------------------

parameters b,c,rhog,gb,sg; // Parameters of the model


c = 0.8;  // marginal propensity of consumption

b = 0.5; // investment coefficient

rhog= 0.9;  // ar1 coefficient for government spending 

sg = 0.02; // standard error of shock of government spending

gb = 1; // steady state or the trend of balance growth path for government spending



%----------------------------------------------------------------
% Model:First Order Conditions
%----------------------------------------------------------------

// Equations of the model

model; 

ct = c*yt(-1);  // consumption

it = b*(ct-ct(-1));  // investment

yt = ct+it+gt;  // accounting identity

gt = rhog*gt(-1)+(1-rhog)*gb+eg;   // the diviation from steady state of government spending follows a ar1 process

end;



%----------------------------------------------------------------
%  Initial Values for steady state
%---------------------------------------------------------------

initval; 
eg = 0; 
gt = gb; 
it = 0; 
yt = gb/(1-c); 
ct = c*yt; 
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

var eg; 
stderr sg;
 
end;


%----------------------------------------------------------------
%  use command to generate TeX-Files with dynamic and static model equations
%---------------------------------------------------------------



%----------------------------------------------------------------
% generate simulation
% generate IRFs to show 
%
%----------------------------------------------------------------

// Launch solving procedure 

stoch_simul(linear,irf=100);

