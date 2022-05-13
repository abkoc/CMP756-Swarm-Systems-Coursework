function [outputArg1,outputArg2] = Draw_Sphere(epsilon,states_mean, numsample)
%DRAW_SPHERE Summary of this function goes here
%   Detailed explanation goes here
%%% Draw sphere around initial and final centroid
[x_sphere,y_sphere,z_sphere] = sphere;
x_sphere = x_sphere * epsilon;
y_sphere = y_sphere * epsilon;
z_sphere = z_sphere * epsilon;
% around initial centroid
outputArg1 = plot3( x_sphere+states_mean(1,1),...
                    y_sphere+states_mean(2,1),...
                    z_sphere+states_mean(3,1),...
                    'ko','MarkerSize',5);
% around final centroid
outputArg2 = plot3( x_sphere+states_mean(1,numsample),...
                    y_sphere+states_mean(2,numsample),...
                    z_sphere+states_mean(3,numsample),...
                    'c*','MarkerSize',5);
end

