
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

%% computing the first and second time derivative

dt = 1/120;
for i=1:length(E3)
    tmp = E3{i};
    tmp_d{i} = diff(tmp,1,2)/dt;
    tmp_2d{i} = diff(tmp_d{i},1,2)/dt;
end

for i=1:length(tmp_d)
    % x
    xT = E3{i}(:,end);
    Norm1 = [];
    for j=1:length(E3{i})
        dis = xT - E3{i}(:,j);
        disN = norm(dis,2);
        Norm1 = [Norm1; disN];
       
    end
    % normalized over distance
    Norm2 = Norm1/max(Norm1);
    Emp3Dnorm{i} = [Norm2'];
    
    % dx1/dt1
    Norm1 = [];
    for j=1:length(tmp_d{i})
        dis = tmp_d{i}(:,j);
        disN = norm(dis,2);
        Norm1 = [Norm1; disN];
       
    end
    d3tmp_d{i} = [Norm1'];
    
    % dx2/dt2
    Norm1 = [];
    for j=1:length(tmp_2d{i})
        dis = tmp_2d{i}(:,j);
        disN = norm(dis,2);
        Norm1 = [Norm1; disN];
       
    end
    d3tmp_2d{i} = [Norm1'];
end

[plotx, ploty, plotz] = deal([]);
for i=1:length(tmp_d)
    if plotting
        plotz = [plotz, Emp3Dnorm{i}(1,:)];     
        plotx = [plotx, [d3tmp_d{i}(1,:),NaN]];
        ploty = [ploty, [d3tmp_2d{i}(1,:), NaN,NaN]];         
    end
end
if plotting
    figure(4);
    plot3(plotx, ploty, plotz, '.');
end
hold on;

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

%% computing the first and second time derivative

clear tmp_d
clear tmp_2d

dt = 1/120;
for i=1:length(F3)
    tmp = F3{i};
    tmp_d{i} = diff(tmp,1,2)/dt;
    tmp_2d{i} = diff(tmp_d{i},1,2)/dt;
end

for i=1:length(tmp_d)
    % x
    xT = F3{i}(:,end);
    Norm1 = [];
    for j=1:length(F3{i})
        dis = xT - F3{i}(:,j);
        disN = norm(dis,2);
        Norm1 = [Norm1; disN];
       
    end
    % normalized over distance
    Norm2 = Norm1/max(Norm1);
    Fmp3Dnorm{i} = [Norm2'];
    
    % dx1/dt1
    Norm1 = [];
    for j=1:length(tmp_d{i})
        dis = tmp_d{i}(:,j);
        disN = norm(dis,2);
        Norm1 = [Norm1; disN];
       
    end
    d3tmp_d{i} = [Norm1'];
    
    % dx2/dt2
    Norm1 = [];
    for j=1:length(tmp_2d{i})
        dis = tmp_2d{i}(:,j);
        disN = norm(dis,2);
        Norm1 = [Norm1; disN];
       
    end
    d3tmp_2d{i} = [Norm1'];
end

[plotx, ploty, plotz] = deal([]);
for i=1:length(tmp_d)
    if plotting
        plotz = [plotz, Fmp3Dnorm{i}(1,:)];     
        plotx = [plotx, [d3tmp_d{i}(1,:),NaN]];
        ploty = [ploty, [d3tmp_2d{i}(1,:), NaN,NaN]];         
    end
end
if plotting
    figure(4);
    plot3(plotx, ploty, plotz, '.');
end

