
N = 10;  % number of agents
n = 3;  % dimension of agent state
a = 1;  % coefficients of g function
b = 20;
c = 200;
[~,sigma] = g(zeros(1,n),zeros(1,n),a,b,c);
x_ini = 100 * 2 * rand(N,n) - 1;  % initial states bounded in 100* ([-1,1] , [-1,1])
u_ini = zeros(N,n);         % initial control inputs are zero

% Simulation variables
time_step = 0.01; % timestep between each point plot