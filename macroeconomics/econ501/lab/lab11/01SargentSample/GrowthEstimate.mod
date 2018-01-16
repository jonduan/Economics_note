/*
 * This file implements estimation of a Growth model
 *
 * Note that this mod-file implements the non-linear first order conditions and that the IRFs show the linear deviations
 * from steady state.
 *
 * It demonstrate the
 *
 * This implementation was written by
 *
 * Please note that the following copyright notice only applies to this Dynare
 * implementation of the model.
 */

var c k lab z;
varexo e;


%----------------------------------------------------------------
%  parametrization of
%----------------------------------------------------------------


parameters bet del alp rho the tau s;

bet     = 0.987;  % discount factor
the     = 0.357;   % share of comsuption in utility fuction
del     = 0.012;   % appreciation rate
alp     = 0.4;     % share of capital in production function
tau     = 2;       % intertemporal preference parameter
rho     = 0.95;    % coefficient for AR(1) stochastic process of technology
s       = 0.007;    % standard deviation of productivity shock

%----------------------------------------------------------------
% First Order Conditions/ Euler equation;, law of motion of two states variable: k and z
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
e   = 0;
end;

%----------------------------------------------------------------
%  define shock variances
%---------------------------------------------------------------


shocks;
var e;
stderr 1;
end;

%----------------------------------------------------------------
%  Estimate parameters with setting prior
%---------------------------------------------------------------


estimated_params;
stderr e, inv_gamma_pdf, 0.95,30;
rho, beta_pdf,0.93,0.02;
the, normal_pdf,0.3,0.05;
tau, normal_pdf,2.1,0.3;
end;

%----------------------------------------------------------------
%  Variables observed
%---------------------------------------------------------------


varobs c;

%----------------------------------------------------------------
%  use command to generate TeX-Files with dynamic and static model equations
%---------------------------------------------------------------


write_latex_dynamic_model;
write_latex_static_model;


%----------------------------------------------------------------
% generate estimation, specify the Metroplis Hasting Algorithm
%----------------------------------------------------------------

estimation(datafile=simudata,mh_replic=1000,mh_jscale=0.9,nodiagnostic);
