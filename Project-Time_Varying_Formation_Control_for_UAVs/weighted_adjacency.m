function W = weighted_adjacency(W, Theta, num_agents)
    % size num_agents x num_agents (i.e 5x5)
    for i = 1:num_agents
        for j = 1:num_agents
            if i == j
                W(i,j) = 0 ;
            else
                W(i,j) = norm( [Theta(i,1) - Theta(j,1) , Theta(i,3) - Theta(j,3)] ) ;
            end
        end
    end
