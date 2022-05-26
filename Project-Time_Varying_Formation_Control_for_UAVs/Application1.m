clear all;
clc;

%% User Parameters
% Demonstration pause scale
dem_scale_pos = 1 / 100; % Time scale for demonstration of trajectories
dem_scale_vel = 1 / 100; % Time scale for demonstration of velocities
% Demonstration enable
en_demo_pos = 1; % Enable pause to demonstrate trajectory
en_demo_vel = 1; % Enable pause to demonstrate velocities change vs time
%% General parameters
num_agents = 5 ; % number of agents

%% Matrices Definitions
K1 = [-2, -1.2] ;
K2 = [0.3416, 0.7330] ;

% Theta Initialization
Theta_ini_1 = [-0.16, 0.03, -0.07, -0.01]'  ; % 4x1 each row for [xX vX xY vY]'
Theta_ini_2 = [-4.92, -0.08, 6.38, -0.04]'  ;
Theta_ini_3 = [-12.37, -0.26, 4.08, -0.03]' ;
Theta_ini_4 = [-12.73, 0.03, -4.56, -0.04]' ;
Theta_ini_5 = [-4.63, -0.05, -7.9, 0.02]'   ;
Theta_ini = [Theta_ini_1, Theta_ini_2, Theta_ini_3, Theta_ini_4, Theta_ini_5]' ; % 5x4 each row for i = 1:5 

% Formation Function Initialization
r = 7 ; % 7 m radius of circular formation
w = 0.214 ; % angular velocity of formation

% Initial Formation function matrix
h_ini = zeros(num_agents,4); % size: 5x4 
for i=1:num_agents
    t = 0;
    h_ini(i,:)=[r * (cos(w*t + 2*pi*(i-1)/5) - 1) * g_dummy(t,i,w), ...
                - w * r * sin(w*t + 2*pi*(i - 1)/5) * g_dummy(t,i,w), ...
                r * sin(w*t + 2*pi*(i - 1)/5), ...
                w * r *cos(w*t + 2*pi*(i - 1)/5)   ] ;
end

% Initial Derivation of Formation function matrix
h_ini_dot = zeros(num_agents,4); % size: 5x4
for i=1:num_agents
    t = 0;
    h_ini_dot(i,:)=[- w * r * sin(w*t + 2*pi*(i - 1)/5 - 1) * g_dummy(t,i,w), ...
                    - w^2 * r * cos(w*t + 2*pi*(i - 1)/5) * g_dummy(t,i,w),...
                    w * r * cos(w*t + 2*pi*(i - 1)/5),...
                    - w^2 * r * sin(w*t + 2*pi*(i - 1)/5)   ] ;
end

%% Simulation 
% Stop time is 180 seconds
out = sim("Formation_demo_app1", 'StopTime', '180') ;

%% Reshape results to visualize
names = {'xX', 'vX', 'xY', 'vY'} ;  % Column content names
% Reshape simulation outputs to visualize in following sections
for i = 1:5
    for ind = 1:length(names)
        h{i}.(names{ind}) = reshape(out.h.data(i, ind, :),...
                                    [1 length(out.h.data(i, ind, :))] );
        Theta{i}.(names{ind}) = reshape(out.Theta.data(i, ind, :),...
                                    [1 length(out.Theta.data(i, ind, :))] );
        h_dot{i}.(names{ind}) = reshape(out.h_dot.data(i, ind, :),...
                                    [1 length(out.h_dot.data(i, ind, :))] );
    end
end


%% Visualize results
%% Position of UAVs
% Figure Initialization
prev_t = 0;
colors=['r', 'b', 'g', 'c', 'm'];
fig = figure;

% Setup Figure attributes
set(fig,'defaultLegendAutoUpdate','off'); % Stop legend updating every step
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];
plot(0,0,"b+"); % blue lonely star shows center
hold on;
axis tight manual;
ax.YLim = [-15 15];
ax.XLim = [-15 15];

title("Position of UAVs");
xlabel('x_iX(t) (m)');
ylabel('x_iY(t) (m)');

% Plot Initial UAV coordinates (Square shaped)
for i = 1:num_agents
    plot(Theta{i}.xX(1), Theta{i}.xY(1), "s", "Color", colors(i),"MarkerSize",8);
end
% Add legend
legend("Origin","UAV_1","UAV_2","UAV_3","UAV_4","UAV_5");

% Plot trajectories
for t = 2:length(out.tout)
    if en_demo_pos == 1
        pause((out.tout(t) - prev_t) * dem_scale_pos);
    end
    prev_t = out.tout(t);
    for i = 1:num_agents
        % Points show UAV coordinates
        plot(Theta{i}.xX(t), Theta{i}.xY(t), ".", "Color", colors(i),"MarkerSize",8);
    end
    for i = 1:num_agents
        % Stars show UAV coordinates
        plot(h{i}.xX(t), h{i}.xY(t), "o", "Color", colors(i));
    end
end

%% Velocity of UAVs
% Figure Initialization
prev_t = 0;
colors=['r', 'b', 'g', 'c', 'm'];
fig = figure;
% Setup Figure attributes
set(fig,'defaultLegendAutoUpdate','off'); % Stop legend updating every step
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];
plot(0,0,"b+"); % blue lonely star shows center
hold on;
axis tight manual;
ax.YLim = [-2 2];
ax.XLim = [-2 2];

title("Velocity of UAVs");
xlabel('v_iX(t) (m/s)');
ylabel('v_iY(t) (m/s)');

% Plot Initial UAV velocities (Diamond shaped)
for i = 1:num_agents
    plot(Theta{i}.vX(1), Theta{i}.vY(1), "d", "Color", colors(i),"MarkerSize",8);
end
% Add legend
legend("Origin","UAV_1","UAV_2","UAV_3","UAV_4","UAV_5");

% Plot velocities
for t = 2:length(out.tout)
    if en_demo_vel == 1
        pause((out.tout(t) - prev_t) * dem_scale_vel);
    end
    prev_t = out.tout(t);
    for i = 1:num_agents
        % Points show UAV velocities
        plot(Theta{i}.vX(t), Theta{i}.vY(t), ".", "Color", colors(i),"MarkerSize",8);
    end
end

%% Adjacency Matrix W of UAVs
% Display W which is taken as 0-1
prev_t = 0;
for t = 1:1
    prev_t = out.tout(t);
    disp("W at time");
    disp(prev_t)
    disp(out.W.data(1:5,1:5,t));
end


%% Formation Time-variation
% Figure Initialization
prev_t = 0;
colors=['r', 'b', 'g', 'c', 'm'];
fig = figure;

% Setup Figure attributes
set(fig,'defaultLegendAutoUpdate','off'); % Stop legend updating every step
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];
plot(0,0,"b+"); % blue lonely star shows center
hold on;
axis tight manual;
ax.YLim = [-15 15];
ax.XLim = [-15 15];

title("Formation Time-variation");
xlabel('h_iX(t) (m)');
ylabel('h_iY(t) (m)');

% Plot Initial formation (Square shaped)
for i = 1:num_agents
    plot(h{i}.xX(1), h{i}.xY(1), "<", "Color", colors(i),"MarkerSize",8);
end
% Add legend
legend("Origin","UAV_1","UAV_2","UAV_3","UAV_4","UAV_5");

% Plot trajectories
for t = 2:length(out.tout)
    if en_demo_pos == 1
        pause((out.tout(t) - prev_t) * dem_scale_pos);
    end
    prev_t = out.tout(t);
    for i = 1:num_agents
        % Points show Formation function
        plot(h{i}.xX(t), h{i}.xY(t), "o", "Color", colors(i),"MarkerSize",3);
    end

end


%% Position of UAVs w/o plotting Formation Function
% Figure Initialization
prev_t = 0;
colors=['r', 'b', 'g', 'c', 'm'];
fig = figure;

% Setup Figure attributes
set(fig,'defaultLegendAutoUpdate','off'); % Stop legend updating every step
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];
plot(0,0,"b+"); % blue lonely star shows center
hold on;
axis tight manual;
ax.YLim = [-15 15];
ax.XLim = [-15 15];

title("Position of UAVs w/o plotting Formation Function");
xlabel('x_iX(t) (m)');
ylabel('x_iY(t) (m)');

% Plot Initial UAV coordinates (Square shaped)
for i = 1:num_agents
    plot(Theta{i}.xX(1), Theta{i}.xY(1), "s", "Color", colors(i),"MarkerSize",8);
end
% Add legend
legend("Origin","UAV_1","UAV_2","UAV_3","UAV_4","UAV_5");

% Plot trajectories
for t = 2:length(out.tout)
    if en_demo_pos == 1
        pause((out.tout(t) - prev_t) * dem_scale_pos);
    end
    prev_t = out.tout(t);
    for i = 1:num_agents
        % Points show UAV coordinates
        plot(Theta{i}.xX(t), Theta{i}.xY(t), ".", "Color", colors(i),"MarkerSize",8);
    end
end






