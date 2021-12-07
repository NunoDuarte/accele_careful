
[train] = getDataAll();
Etrain = [];
Ftrain = [];
for i = 1:length(train)
    [E, F] = read(train{i}{1}, train{i}{2});
    Etrain = [Etrain, E];
    Ftrain = [Ftrain, F];
end

clear E3
clear En
clear F3
clear Fn

% plotting?
plotting = 1;

%% Remove Non-Zeros - Empty

if plotting
    [plotx, ploty, plotz] = deal([]);
end

for i=1:length(Etrain)
    En{i} = Etrain{i}(any(Etrain{i},2),2:4);          % remove only full rows of 0s
    En{i} = En{i}(all(~isnan(En{i}),2),:);  % remove rows of NANs    
    E3{i}(1,:) = En{i}(:,1)';
    E3{i}(2,:) = En{i}(:,2)';
    E3{i}(3,:) = En{i}(:,3)';       
    E3{i} = round(E3{i},4);
    
    if plotting
        plotx = [plotx, E3{i}(1,:)];
        ploty = [ploty, E3{i}(2,:)];
        plotz = [plotz, E3{i}(3,:)];             
    end

end

if plotting
    figure;
    plot3(ploty, plotx, plotz, '.');
end

%% Remove Non Zeros - Full

if plotting
    [plotx, ploty, plotz] = deal([]);
end

for i=1:length(Ftrain)
    Fn{i} = Ftrain{i}(any(Ftrain{i},2),2:4);          % remove only full rows of 0s
    Fn{i} = Fn{i}(all(~isnan(Fn{i}),2),:);  % remove rows of NANs    
    F3{i}(1,:) = Fn{i}(:,1)';
    F3{i}(2,:) = Fn{i}(:,2)';
    F3{i}(3,:) = Fn{i}(:,3)'; 
    
    F3{i} = round(F3{i},4);
    
    if plotting
        plotx = [plotx, F3{i}(1,:)];
        ploty = [ploty, F3{i}(2,:)];
        plotz = [plotz, F3{i}(3,:)];             
    end

end

if plotting
    figure();
    plot3(ploty, plotx, plotz, '.');
end
