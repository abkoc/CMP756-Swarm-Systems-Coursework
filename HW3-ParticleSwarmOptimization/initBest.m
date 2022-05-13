%% Initializations of pBest and gBest
% initialized according to the initial positions of particles
pBest=[];
for i = 1:numAgents
    pBest = cat(1 , pBest , [p(i,:),fitness(p(i,:))]);
end
[~,j]=min(pBest(:,3));
gBest = pBest(j,:);