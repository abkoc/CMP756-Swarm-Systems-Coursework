%% Initialize agents
% Boundaries
    % x in [-3 3]
    % y in [-2 2]
% Initial positions are defined randomly within boundaries
p=[rand(numAgents,1)*6-3 , rand(numAgents,1)*4-2];
% Initial velocities
v = zeros(numAgents,2);