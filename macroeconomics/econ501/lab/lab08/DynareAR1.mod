/*
 * This file implements AR1 Model
 *
 * Note that this mod-file implements the non-linear first order conditions and that the IRFs show the linear deviations
 * from steady state.
 *
 * It demonstrate the dynamic of the shock of a 

 * Simple AR(1) model 
 * This version: 04/10/08
 *
 * This implementation was written by 
 *
 * Please note that the following copyright notice only applies to this Dynare 
 * implementation of the model.
 */
 
%----------------------------------------------------------------
%  Set up variables 
%----------------------------------------------------------------



var x; 


varexo e; 




%----------------------------------------------------------------
%  parametrization of model
%----------------------------------------------------------------


parameters rho,se, b;


b = 1;

rho = 0.95; 

se = 0.02;





%----------------------------------------------------------------
% Model:First Order Conditions
%----------------------------------------------------------------

model;

x=  rho*x(-1) + b + e; 

end;




%----------------------------------------------------------------
%  Initial Values for steady state
%---------------------------------------------------------------


initval; 

e = 0; 

x = 1; 

end;

%----------------------------------------------------------------
%  Solve the steady state
%---------------------------------------------------------------

steady; 


check;




%----------------------------------------------------------------
%  define shock variances
%---------------------------------------------------------------

shocks; 

var e; 

stderr se; 

end;



%----------------------------------------------------------------
%  use command to generate TeX-Files with dynamic and static model equations
%---------------------------------------------------------------



%----------------------------------------------------------------
% generate simulation
% generate IRFs to show 
%
%----------------------------------------------------------------

stoch_simul(linear);
