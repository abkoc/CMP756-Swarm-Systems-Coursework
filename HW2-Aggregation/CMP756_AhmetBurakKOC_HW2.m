clear all;
clc;
%% Homework 2
% CMP756 Swarm Systems
% Name: Ahmet Burak KOC
% Student ID: N20152984
%% Initialization
N = 10;     % number of agents
n = 3;      % dimension of agent state

%% Q1
% initial states bounded in [-100,100] for each dimension
x_ini = 100 * 2 * rand(N,n) - 1;

%% Q2
% g(.) represents the function of attraction and repulsion between the individuals.
% x_dot = sum of g(x[i]-x[j]) for i != j
% Consider g(y)=-y(g_a(||y||)-g_r(||y||))
% Define g(y)=-g(-y) => odd function

% Assumption 1:
% unique simga exists such that 
% g_a(sigma) = g_r(sigma)
% For ||y||>sigma, g_a(||y||) > g_r(||y||)
% For ||y||<sigma, g_a(||y||) < g_r(||y||)

% Assumtion 2:
% J_a and J_r can be viewed as potentials of attraction and repulsion, respectively, created around
% each individual.
% Gradient_y of J_a(||y||) = y * g_a(||y||)
% Gradient_y of J_r(||y||) = y * g_r(||y||)

% Define g(.) function satisfying Assumption 1 and Assumption 2
help g;     % Shows g(.) function description
a=1;        % variables that defines g(.) function
b=20;
c=200;
% sigma value where attraction and repulsion are equal to each other
sigma = sqrt(c*log(b/a));

%% Q3
% Hyperbola radius
epsilon = b/a;

% time_convergence = ...

%% Simulation Section
% Simulation variables
time_step = 0.1; % timestep between each point plot
% Simulate
simOut = sim('Swarm_Simulation.slx','StopTime','100');
% Process Outputs of Simulation
x = simOut.x;  % import states vs time
numsample = size(x,3);  % number of samples during simulation
states_mean = reshape( mean(x,1) ,n ,numsample);  % mean of states vs time
%% Q4 Validation of Lemma 1
centroid_variance = [   var(states_mean(1,:)),...
                        var(states_mean(2,:)),...
                        var(states_mean(3,:))];
disp("Q4 Validation of Lemma 1:");
disp("Variance = 0 for all dimension that proves centroid coordinates keeps constant.");

% States of agents
figure;
title('centroid vs time')
% plot centroid of swarm
plot3(states_mean(1,1),states_mean(2,1),states_mean(3,1),'mo')
hold on;
plot3(states_mean(1,:),states_mean(2,:),states_mean(3,:),'m')
plot3(states_mean(1,numsample),states_mean(2,numsample),states_mean(3,numsample),'m*')
legend('initial centroid', 'centroid trajectory', 'final centroid')
disp("Figure 1 shows that for all dimensions centroid coordinates keeps constant");
pause(1);
%% Q4 Validation of Theorem 1
states_variance = zeros(N,3);
% assume steady state at last 5 sample
for i=1:N
    states_variance(i,:) = [var(x(i,1,numsample-4:end)),...
                            var(x(i,2,numsample-4:end)),...
                            var(x(i,3,numsample-4:end))];
end
disp("Q4 Validation of Theorem 1:");
disp("Variance = 0 for all dimension that proves states coordinates keeps within boundary at steady state.");

figure;
title('states vs time')
% plot states
colors=['r', 'b', 'g'];
% initial states
for i = 1:N
    plot3(  x(i,1,1),...
            x(i,2,1),...
            x(i,3,1),...
            'o','Color',colors(mod(i,3)+1));
    hold on;

end
% draw sphere bounded region
[outputArg1,outputArg2] = Draw_Sphere(epsilon,states_mean,numsample);

% plot trajectories
for t= 2:size(x,3)
    for i = 1:N
    plot3(  x(i,1,t),...
            x(i,2,t),...
            x(i,3,t),...
            '.','Color',colors(mod(i,3)+1));
    end
    pause(time_step);
end
% final states
for i = 1:N
    plot3(  x(i,1,numsample),...
            x(i,2,numsample),...
            x(i,3,numsample),...
            '*','Color',colors(mod(i,3)+1));    
end
disp("Figure 2 shows that for all dimension that proves states coordinates keeps within boundary at steady state.");
pause(1);

%% Q4 Validation of Theorem 2
% Calculate relative distances between agents for all simulation
C = nchoosek(1:N,2);
distances = [];
for t=1:numsample
    distance_vector = [];
    % calculate relative distances between agents for time = t
    for i = 1:N
        distance_vector = cat(  1,...
                                distance_vector,...
                                norm(   x(i,:,t) - states_mean(:,t))...
                            );
    end
    distances = cat(    2,...
                        distances,...
                        distance_vector);
end

figure;
title('relative distances to centroid vs time');
hold on;
for i=1:size(distances,1)
    plot(distances(i,:));
%     legend(int2str(C));
end
% epsilon_vector = repmat(epsilon,1,numsample);
% plot(epsilon_vector);
xlabel('time (s)');
ylabel('relative distances to centroid (m)')
% legend;

disp("figure shows that all relative distances to centroid are bounded within constant");
pause(1);
%% Q4 Validation of Theorem 2
% % Calculate relative distances between agents for all simulation
% C = nchoosek(1:N,2);
% distances = [];
% for t=1:numsample
%     distance_vector = [];
%     % calculate relative distances between agents for time = t
%     for ij = C'
%         distance_vector = cat(  1,...
%                                 distance_vector,...
%                                 norm(   x(ij(1),:,t) - x(ij(2),:,t))...
%                             );
%     end
%     distances = cat(    2,...
%                         distances,...
%                         distance_vector);
% end
% 
% figure;
% title('relative distances between each agent couple');
% hold on;
% for i=1:size(distances,1)
%     plot(distances(i,:));
% %     legend(int2str(C));
% end
% epsilon_vector = repmat(epsilon,1,numsample);
% plot(epsilon_vector);
% xlabel('time (s)');
% ylabel('relative distances of each agents couple (m)')
% % legend;
% 
% disp("figure shows that all relative distances ");
pause(1);