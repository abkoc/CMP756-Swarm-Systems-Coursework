numsample = size(out.x_1,3);
x_1 = reshape(out.x_1,n,numsample);
x_2 = reshape(out.x_2,n,numsample);
x_3 = reshape(out.x_3,n,numsample);

states_mean = cat(1, ...
                    mean([x_1(1,:); x_2(1,:); x_3(1,:)]),...
                    mean([x_1(2,:); x_2(2,:); x_3(2,:)]),...
                    mean([x_1(3,:); x_2(3,:); x_3(3,:)])) ;

%% States of agents
figure;
% plot centroid of swarm
plot3(states_mean(1,1),states_mean(2,1),states_mean(3,1),'mo')
hold on;
plot3(states_mean(1,:),states_mean(2,:),states_mean(3,:),'m')
plot3(states_mean(1,numsample),states_mean(2,numsample),states_mean(3,numsample),'m*')

% Draw sphere around initial and final centroid
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

% plot initial states
plot3(x_1(1,1),x_1(2,1),x_1(3,1),'ro');
plot3(x_2(1,1),x_2(2,1),x_2(3,1),'bo');
plot3(x_3(1,1),x_3(2,1),x_3(3,1),'go');
% plot trajectories
plot3(x_1(1,:),x_1(2,:),x_1(3,:),'r');
plot3(x_2(1,:),x_2(2,:),x_2(3,:),'b');
plot3(x_3(1,:),x_3(2,:),x_3(3,:),'g');
% plot final states
plot3(x_1(1,numsample),x_1(2,numsample),x_1(3,numsample),'r*');
plot3(x_2(1,numsample),x_2(2,numsample),x_2(3,numsample),'b*');
plot3(x_3(1,numsample),x_3(2,numsample),x_3(3,numsample),'g*');

%% Distances between agents
distances=[];
for t=1:numsample
    distances = cat(2, distances,...
                    [   norm(x_1(:,t)-x_2(:,t));...
                        norm(x_1(:,t)-x_3(:,t));...
                        norm(x_2(:,t)-x_3(:,t))
                        ]);
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







