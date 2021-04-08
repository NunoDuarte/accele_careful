
for i=1:length(E)
    % pick the elements of time vector not 0
    TimeVE = find(E{i}(:,4) ~= 0);
    % get the time information
    TE{i} = E{i}(TimeVE,1);
    % normalize

    for j=1:length(TE{i})-1
        
       diffTE{i}(j) = TE{i}(j+1) -  TE{i}(j); 
        
    end
    
end


