function z = SixHumpCamelback(in)
%SÝXHUMPCAMELBACK Summary of this function goes here
%   Fitness function of Six Hump Camelback
    % Position input is [x y] where x,y are column vectors.
    % Function returns Six Hump Camelback function output

x=in(1);
y=in(2);
z = (4 - 2.1*x.^2 + x.^4/3).*x.^2 + x.*y + (-4 + 4*y.^2).*y.^2;
% z = (4 - 2.1*x^2 + x^4/3)*x^2 + x*y + (-4 + 4*y^2)*y^2;
end

    

