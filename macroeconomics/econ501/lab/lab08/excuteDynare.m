%addpath C:\dynare\4.4.3\matlab
%addpath 'C:\Program Files\dynare\4.3.3\matlab'

clear all; 
close all;

% execute a Dynare file 

% specify parameters 7 8 beta = 0.99; 9 alpha = 1/3;10 sigma = 1; 11 sigmae = 0.01; 12 rho = 0.9; 13 ? = 0.025; 14 15 

%save param nc alpha beta ? rho sigma sigmae

dynare GrowthApproximate_MC noclearall nolog;