clear all;
clc;
%% Conf 
num_agents  = 3 ;
num_dim     = 2 ;
%% Initialization
B1 = [1,0]' ;
B2 = [0,1]' ;
% Agents
Theta = [] ;
for i = 1 : num_agents
    Theta_i = @Theta_def rand(2,1) ;
    Theta = cat(1, Theta, Theta_i') ;
end

% Formation (X , Y coordinates missing)
h = [] ;
for i = 1 : num_agents
    h_i = @h_i rand(2,1) ; % 2 x 1 vector [h_ix , h_iv]'
    h = cat(1 , h , h_i) ; % 2N x 1 vector [h_1x , h_1v, h_2x, h_2v, ... ,h_Nx , h_Nv]'
end

% 