function [x_dot] = control_input(x,i)
% CONTROL_ÝNPUT calculates control input of an agent using function g
%   x is agents states N x n sized matrix for N agent and n dimension
%   i is the agent number
%
%   [x_dot] = control_input(x,i)
%
%   returns Sum of g(xi-xj) for j=1:N
x_dot = zeros(1,size(x,2));
for j = 1:1:size(x,1)
    [g_output,~] = g(x(i,:),x(j,:),1,10,5);
    x_dot = x_dot + g_output; 
end
end