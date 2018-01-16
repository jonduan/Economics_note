% Simple Matlab Tutorial
%
% Comments: Everything to the right of the % sign is ignored by Matlab
%


clc;            %clears everthing in the command window (not necessary)
clear all;      %removes everything out of memory
                %ensures that everything will be defined in the program
                %you obviously do not always want to use this
                
x1 = 2;         %sets x1 equal to 2
x2 = 2          %sets xs equal to 2 and reports that x2=2 on the screen
                %with the ; you suppress (typically) output
                
%
% Creating stuff
%

y1 = ones(4,3);  % creates a 4x3 matrix with ones;
y2 = zeros(4,4);
y3 = eye(4);     % creates a 7x7 identify matrix;

z1 = [ y1 y2 ];  % horizontally appends two elements;
z2 = [ y2 y3 ];  % vertically appends two elements;

z3 = [ 4 6 8; 5 9 2]; % directly creates a 2x3 matrix


%
% Element by element operation of vectors/matrices
%

x1 = 5*ones(5,1); % redefines x1 (typically you get a warning tilde)
x2 = 7*ones(5,1);
x3 = x1*x2';      % standard multiplication of 5x1 times 1x5 matrix
x3 = x1.*x2;      % creates a 5x1 vector multiply element by element
                  % x1*x2 would not be allowed
x3 = x1.^2        % squares each element of x1
                  % x1^2 would not be allowed
x3 = fcn1(x1,x2); % fcn1 is an external function defined for multiplication

%
% Creating a grid
%

k_low   = 80;
k_high  = 120;
k_nodes = 101;
k_step  = (k_high-k_low)/(k_nodes-1);
k_grid  = (k_low:k_step:k_high);

z_low   = -0.3;
z_high  =  0.3;
z_nodes =   21;
z_step  = (z_high-z_low)/(z_nodes-1);
z_grid  = (z_low:z_step:z_high);

% 
% Random numbers
%

seed = 21021010;       % number to initialize random number generator
randn('state', seed);  % initializes random number generator
x = randn(100,1);      % generates vector with 100x1 N(0,1) random numbers

%
% Regression
%

X    = [ ones(200,1) randn(200,1) ];  % Note that X and x are not the same
u    = 0.5*randn(200,1);
beta = [ 4.56 3.89]';
y    = X*beta+u;

beta_est = inv(X'*X)*X'*y;
y_fit    = X*beta_est;

[beta beta_est]       % simple and ugly way to get this info on the screen

plot(X(:,2),y_fit,X(:,2),y,'Marker','.','LineStyle','none');

pause
%
% If/then & loops
%

for i = 1:20
    
    z1 = (1:1:20);
    z2 = z1;
    if i < 10
        z2(1:i) = z2(1:i) + 2;
    else
        z2(i) = z2(i) - 2;
    end
    figure(2)    % this opens a new figure window, without it the plot 
                 % would occur in the last figure window and overwrite 
                 % stuff in it
    plot(z1,z2)
    %pause        % gives you a chance to look at the figure
end

%
% reading and writing
%

save Xdata.dat X -ASCII   % generates a generic output file
load Xdata.dat            % uploads the numbers in Xdata.dat and calls them
                          % Xdata
save tutorialoutput X y   % saves X & y (both the names and data into
                          % a Matlab *.mat file

clear all                 % throws everything out of memory

load tutorialoutput       % pulls everything in tutorial.mat into memory

 
                          