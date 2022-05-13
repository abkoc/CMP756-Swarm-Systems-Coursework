x = out.x;
numsample = size(x,3);

states_mean = reshape( mean(x,1) , n , numsample);
%% States of agents
figure;
%%% plot centroid of swarm
plot3(states_mean(1,1),states_mean(2,1),states_mean(3,1),'mo')
hold on;
plot3(states_mean(1,:),states_mean(2,:),states_mean(3,:),'m')
plot3(states_mean(1,numsample),states_mean(2,numsample),states_mean(3,numsample),'m*')

%%% Draw sphere around initial and final centroid
[x_sphere,y_sphere,z_sphere] = sphere;
x_sphere = x_sphere * sigma;
y_sphere = y_sphere * sigma;
z_sphere = z_sphere * sigma;
% around initial centroid
plot3(  x_sphere+states_mean(1,1),...
        y_sphere+states_mean(2,1),...
        z_sphere+states_mean(3,1),...
        'ko','MarkerSize',5);
% around final centroid
plot3(  x_sphere+states_mean(1,numsample),...
        y_sphere+states_mean(2,numsample),...
        z_sphere+states_mean(3,numsample),...
        'c*','MarkerSize',5);

%%% plot states
colors=['r', 'b', 'g'];
% initial states
for i = 1:N
    plot3(  x(i,1,1),...
            x(i,2,1),...
            x(i,3,1),...
            'o','Color',colors(mod(i,3)+1));    
end
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

%% Distances between agents
C = nchoosek(1:N,2);

% calculate relative distances between agents for all simulation
distances = [];
for t=1:numsample
    distance_vector = [];
    % calculate relative distances between agents for time=t
    for ij = C'
        distance_vector = cat(  1,...
                                distance_vector,...
                                norm(   x(ij(1),:,t) - x(ij(2),:,t))...
                            );
    end
    distances = cat(    2,...
                        distances,...
                        distance_vector);
end
figure;

hold on;
for i=1:N
    plot(distances(i,:));
end
sigma_vector = repmat(sigma,1,numsample);
plot(sigma_vector);
% xlim= [-5 5];
ylim = [-5 5];
legend;







