/*
 * This file implements  Growth Model from "Practicing Dynare.pdf" 2.2
 *
 *
 * It demonstrate the dynamic of the shock of
 *
 * This implementation was written by
 *
 * Please note that the following copyright notice only applies to this Dynare
 * implementation of the model.
 */

%----------------------------------------------------------------
%  Set up variables
%----------------------------------------------------------------



var c k lab z;
varexo e;



%----------------------------------------------------------------
%  parametrization of model
%----------------------------------------------------------------


parameters bet del alp rho the tau s;

bet     = 0.987;  % discount factor
the     = 0.357;   % share of comsuption in utility fuction
del     = 0.012;   % appreciation rate
alp     = 0.4;     % share of capital in production function
tau     = 2;       % intertempora preference parameter
rho     = 0.95;    % coefficient for AR(1) stochastic process of technology
s       = 0.007;   % standard error  coefficient for shock



%----------------------------------------------------------------
% Model:First Order Conditions
%----------------------------------------------------------------


model;
    (c^the*(1-lab)^(1-the))^(1-tau)/c=bet*((c(+1)^the*(1-lab(+1))^(1-the))^(1-tau)/c(+1))*(1+alp*exp(z(+1))*k^(alp-1)*lab(+1)^(1-alp)-del);
    c=the/(1-the)*(1-alp)*exp(z)*k(-1)^alp*lab^(-alp)*(1-lab);
    k=exp(z)*k(-1)^alp*lab^(1-alp)-c+(1-del)*k(-1);
    z=rho*z(-1)+s*e;
end;

%----------------------------------------------------------------
%  Initial Values for steady state
%---------------------------------------------------------------


initval;
k   = 1;
c   = 1;
lab = 0.3;
z   = 0;
end;

%----------------------------------------------------------------
%  define shock variances
%---------------------------------------------------------------


shocks;
var e;
stderr 0.01;
end;

%----------------------------------------------------------------
%  Solve the steady state
%---------------------------------------------------------------


steady;


%----------------------------------------------------------------
%  use command to generate TeX-Files with dynamic and static model equations
%---------------------------------------------------------------


%write_latex_dynamic_model;
%write_latex_static_model;


%----------------------------------------------------------------
% generate simulation
% generate IRFs to show
%
%----------------------------------------------------------------

stoch_simul(periods=1000,irf=40,order=1);   // order =1 is the linear approximation in order 1
datatomfile('dynasimudata',[]);  //save result
