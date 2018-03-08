//
// Basic linear RE model
//




var y,x;// Name of the variable
varexo e; // Name of the exogenous variable


parameters a,b,rho,se; // Parameters of the model


a = 0.8;
b = 1;
rho = 0.95;
se = 0.02;

// Equations of the model

model;
y = a*y(+1)+b*x;
x = rho*x(-1)+e;

end;

initval;
e=0;
x=0;
y=0;
end;

steady; // Checking Dynamic Properties
check;

// Declaring the shocks
shocks;
var e;
stderr se;
end;


// Launch solving procedure
stoch_simul(linear,irf=20,relative_irf);
