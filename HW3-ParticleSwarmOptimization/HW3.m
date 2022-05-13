close all;
clear all;
clc;
%% Description
% 
%           Hacettepe University 
%       Computer Engineering Department
% 
%       CMP 756 Swarm Systems Course
%               Homework 3 
% 
% Term      : 2021-2022 Spring
% Student   : Ahmet Burak KOC

%% How to Run Code
% Configure PSO parameters
% Configure Stopping conditions
% Configure Agents initialization parameters
% Run the script

%% PSO Algorithm Parameters
% Configurable
c1 = 2 ;    % c1 value
c2 = 2 ;    % c2 value
vMax = 0.2 ;  % speed limit
% Fixed
fitness=@SixHumpCamelback; % fitness function
minimaFitness = -1.0316 ; % fitness function minima (six hump camelback)

%% Stopping Conditions
% Configurable
maxIter = 2000;        % maximum number of iterations
minError = 0.0001 ;    % error limit iterations stops when reached

%% Agents initialization parameters
% Configurable
numAgents = 200;    % number of agents
% Fixed
    % Boundaries of initial positions and velocities
        % x in [-3 3] fixed
        % y in [-2 2] fixed

%% Run algorithm
initAgents;     % Initialize agents positions and velocities
initBest;       % Initialize best position values
initStopping;   % Initialize parameters for checking stopping conditions
PSO;            % Run Particle Swarm Optimization (PSO) Algorithm

%% Rearrange history of positions, velocities and error
pHistory = permute(pHistory,[2,3,1]);
vHistory = permute(vHistory,[2,3,1]);
errorHistory = permute(errorHistory,[2,3,1]);
% "speedHistory" shows where speed of the particle is saturated.

%% Plot Initial Positions
% figure configurations
figure;
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

plot(-0.0898,0.7126,'c*');  % plot minima (cyan colored)
axis tight manual;
ax.YLim = [-2 2];
ax.XLim = [-3 3];

hold on;
% plot initial positions on figure
for i=1:numAgents
    x = reshape(pHistory(i,1,:) , [size(pHistory,3),1]);
    y = reshape(pHistory(i,2,:) , [size(pHistory,3),1]);
    plot(x(1),y(1),'*');
end
title("Initial Positions of agents");
xlabel("X");
ylabel("Y");

%% Plot Final Positions
% figure configurations
figure;
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

plot(-0.0898,0.7126,'c*');  % plot minima (cyan colored)
axis tight manual;
ax.YLim = [-2 2];
ax.XLim = [-3 3];

hold on;
% plot final positions on figure
for i=1:numAgents
    x = reshape(pHistory(i,1,:) , [size(pHistory,3),1]);
    y = reshape(pHistory(i,2,:) , [size(pHistory,3),1]);
    plot(x(end),y(end),'*');
end
title("Final Positions of agents");
xlabel("X");
ylabel("Y");

%% Plot with time
figure;
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

plot(-0.0898,0.7126,'c*');  % plot minima (cyan colored)
axis tight manual;
ax.YLim = [-2 2];
ax.XLim = [-3 3];
hold on;

color=['r.';'b.';'g.'];
title("Simulation of Population Motion");
xlabel("X");
ylabel("Y");
% plot positions of agents with time step between each iteration
for iteration = 1 : size(pHistory,3)
    for i=1:1:numAgents
        plot(   pHistory(i,1,iteration) ,...
                pHistory(i,2,iteration) ,...
                color(mod(i,3)+1,:));
    end
    % add time step to demonstrate motion of agents in each step
    pause(0.1); 
end

%% Plot gBest vs iteration

figure;
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

plot(1:numIter , repmat(minimaFitness,1,numIter));
axis tight manual;
ax.YLim = [minimaFitness, max(gBestHistory(2:end,3))];
% ax.XLim = 1:numIter;
hold on;
plot(1:numIter , gBestHistory(2:end,3));
title("fitness value at gBest vs Iteration");
xlabel("Iteration number");
ylabel("fitness value at gBest");

%% Found Minimum vs Real minimum without autoscale
figure;
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

plot(-0.0898,0.7126,'c*');  % plot position of minima (cyan colored)
axis tight manual;
ax.YLim = [-2 2];
ax.XLim = [-3 3];
hold on;
% plot best position found
plot(gBest(1,1),gBest(1,2),'r*');
title("Found Minimum vs Real minimum");
xlabel("X");
ylabel("Y");
legend("position of minima", "best position found")

%% Found Minimum vs Real minimum with autoscale
figure;
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];

plot(-0.0898,0.7126,'c*');  % plot position of minima (cyan colored)
hold on;
% plot best position found
plot(gBest(1,1),gBest(1,2),'r*');
title("Found Minimum vs Real minimum with autoscale");
xlabel("X");
ylabel("Y");
legend("position of minima", "best position found")