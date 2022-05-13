numsample = size(out.x_1,3);
x_1 = reshape(out.x_1,2,numsample);
x_2 = reshape(out.x_2,2,numsample);
x_3 = reshape(out.x_3,2,numsample);

states_mean = [     mean([x_1(1,:); x_2(1,:); x_3(1,:)]); ...
                    mean([x_1(2,:); x_2(2,:); x_3(2,:)])    ];

figure;
hold on;

% plot centroid of swarm
plot(states_mean(1,1),states_mean(2,1),'mo')
plot(states_mean(1,:),states_mean(2,:),'m')
plot(states_mean(1,numsample),states_mean(2,numsample),'m*')

% Draw circle around initial and final centroid
% initial
th = 0:pi/50:2*pi;
xunit = sigma * cos(th) + states_mean(1,1);
yunit = sigma * sin(th) + states_mean(2,1);
plot(xunit, yunit);
% final
xunit = sigma * cos(th) + states_mean(1,numsample);
yunit = sigma * sin(th) + states_mean(2,numsample);
plot(xunit, yunit);



% plot initial states
plot(x_1(1,1),x_1(2,1),'ro');
plot(x_2(1,1),x_2(2,1),'bo');
plot(x_3(1,1),x_3(2,1),'go');
% plot trajectories
plot(x_1(1,:),x_1(2,:),'r');
plot(x_2(1,:),x_2(2,:),'b');
plot(x_3(1,:),x_3(2,:),'g');
% plot final states
plot(x_1(1,numsample),x_1(2,numsample),'r*');
plot(x_2(1,numsample),x_2(2,numsample),'b*');
plot(x_3(1,numsample),x_3(2,numsample),'g*');