function [g_output,sigma] = g(xi,xj,a,b,c)
% Define g(.) function satisfying Assumption 1 and Assumption 2
% [g_output,sigma] = g(xi,xj,a,b,c)
%
% g represents the function of attraction
% and repulsion between the individuals
%
% y = xi-xj
% g_output = -y .* (a - b*exp(-norm(y)^2/c));
% sigma = sqrt(c*log(b/a));

y=xi-xj;
g_output = -y .* (a - b*exp(-norm(y)^2/c));
sigma = sqrt(c*log(b/a));
end