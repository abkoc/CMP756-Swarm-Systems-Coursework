%% Particle Swarm Optimization (PSO) Loop
% Remember position matrix for each time step
pHistory = zeros(0,numAgents,2);
vHistory = zeros(0,numAgents,2);
errorHistory = [inf];
speedHistory = zeros(numAgents,0);
gBestHistory = [0 0 inf];
% PSO loop
while ~stopFlag
    % Calculate Fitness value
    for i = 1:numAgents
        fitnessVal=fitness(p(i,:));
        if fitnessVal < pBest(i,3)
            % update best position for particle
            pBest(i,:) = cat(2 , p(i,:) , fitnessVal);
        end
    end

    % Choose the particle with the best fitness value of all as gBest
    [~,j]=min(pBest(:,3));
    gBest = pBest(j,:);     % update gBest
    gBestHistory = cat(1,gBestHistory,gBest);

    % For each particle calculate velocity, update position
    for i = 1: numAgents
        % Calculate velocity (equation a)
        v(i,:) = v(i,:) + c1 * rand() * (pBest(i,1:2)-p(i,:)) + c2 * rand() * (gBest(1,1:2)-p(i,:));
        if norm(v(i,:)) > vMax
            
            v(i,:) = v(i,:) * vMax / norm(v(i,:)); % velocity is saturated in same direction
        end
        % Calculate new position (equation b)
        p(i,:) = p(i,:) + v(i,:);
    end
    speedHistory = cat(2,speedHistory,(vecnorm(v'))');
    % Update stopping conditions
    error = abs(gBest(3) - minimaFitness) ; % calculate error
    disp("error is");                       % display error
    disp(error);
    numIter = numIter + 1 ;         % increment iterations
    disp("number of iteration is"); % display number of iterations
    disp(numIter);

    % Check stopping conditions
    if (numIter == maxIter)
        stopFlag = true;
        disp("maximum iteration number is reached, ITERATION STOPPED")
    elseif (error < minError)
        stopFlag = true;
        disp("error is minimized as desired, ITERATION STOPPED")
    elseif (error >= errorHistory(numIter))
        stopFlag = false;
        disp("no more improvement on error, ITERATION STOPPED")
    end

    % Store position matrix for each iteration
    pHistory = cat(1,pHistory,reshape(p,1,numAgents,2));
    % Store velocity matrix for each iteration
    vHistory = cat(1,pHistory,reshape(v,1,numAgents,2));
    % Store errors for each iteration
    errorHistory = cat(1,errorHistory,error);
end