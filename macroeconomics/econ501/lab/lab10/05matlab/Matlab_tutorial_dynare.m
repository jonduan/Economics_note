% Simple Matlab & Dynare Tutorial
%
% Comments: Everything to the right of the % sign is ignored by Matlab
%


clc;            %clears everthing in the command window (not necessary)
clear all;      %removes everything out of memory
                %ensures that everything will be defined in the program
                %you obviously do not always want to use this

dynare modelblevel noclearall  %noclearall not necessary here

load dynarerocks

% simplify the policy function by making it a function of lnz(t) instead of
% lnz(t-1) and e(t)

decision = decision(:,[1,3]); % delete policy function for technology
A        = zeros(3,2);
A(1:2,:) = decision(1:2,:);
A(3,:)   = decision(4,:);
A_k      = A(:,1);
A_c      = A(:,2);


series_k = zeros(200,1);
series_c = zeros(200,1);
series_e = randn(200,1);
series_k = zeros(200,1);
%series_e(2)=1;

series_k(1) = A_k(1);
series_c(1) = A_c(1);
series_z(1) = 0;

for i = 2:200
    series_z(i)=0.95*series_z(i-1)+0.01*series_e(i);
    series_k(i)=A_k(1)+A_k(2)*(series_k(i-1)-A_k(1))+A_k(3)*series_z(i);
    series_c(i)=A_c(1)+A_c(2)*(series_k(i-1)-A_k(1))+A_c(3)*series_z(i);
%    [series_k(i) series_c(i) ]
end

IRF_k    = (series_k-series_k(1))/series_k(1);
plot(IRF_k)
%IRF_c    = zeros(20,1);



