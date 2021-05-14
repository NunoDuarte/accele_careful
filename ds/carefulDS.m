% for the glitch of the Command Window
%MATLAB_JAVA = '/usr/lib/jvm/java-8-openjdk/jre matlab -desktop -nosplash';
% Add this to ~/.bashrc
% export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
clear
clc

addpath('ds')
addpath(genpath('processing/'))
addpath('data')
addpath('belief')
addpath('../../software/Khansari/SEDS/SEDS_lib')
addpath('../../software/Khansari/SEDS/GMR_lib')

% Which Person to choose (Salman, Leo, Bernardo)
% [E, F] = read('Leo', 'plastic-cup');
%readQMUL;
[E, ~] = readIST('empty');
[~, F] = readIST('full');

% plotting?
plotting = 1;

%% Remove Non-Zeros - Empty

if plotting
    [plotx, ploty, plotz] = deal(0);
end

for i=1:length(E)
    E{i} = E{i}(all(~isnan(E{i}),2),:);  % for nan - rows
    En{i}(:,1) = (E{i}(:,2));
    En{i}(:,2) = (E{i}(:,3));
    En{i}(:,3) = (E{i}(:,4));
    
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

%%
plotting = 1;    % do you want to plot the 3D versions?
Emp3D = processData(E3, plotting);

%% Generate a DS for Empty Cups
% do you want the default parameters?
default = 1;    

for i=1:length(E3)
    xT = E3{i}(:,end);
    Norm1 = [];
    for j=1:length(E3{i})
        dis = xT - E3{i}(:,j);
        disN = norm(dis,2);
        Norm1 = [Norm1; disN];
       
    end
    % normalized over distance
    Norm2 = Norm1/max(Norm1);
    % flip data to have the acceleration phase at the end
    Norm2 = flip(Norm2);
    % find 1 value
    id = find(Norm2(:,1) == 1);
    % if 1 is not in last place, add other 1s on the right
    if id ~= length(Norm2)
        for n=id:length(Norm2)
            Norm2(n) = 1;
        end
    end
    Emp3Dnorm{i} = [Norm2'];
end
%samp_freq = 1/30; % for QMUL data
samp_freq = 1/120; % for EPFL/IST data

genDS(Emp3Dnorm, default, [], [], [], samp_freq, 'E');

%% Remove Non Zeros

if plotting
    [plotx, ploty, plotz] = deal(0);
end

% out = A(all(~isnan(A),2),:);  % for nan - rows

for i=1:length(F)
    F{i} = F{i}(all(~isnan(F{i}),2),:);  % for nan - rows
    Fn{i}(:,1) = (F{i}(:,2));
    Fn{i}(:,2) = (F{i}(:,3));
    Fn{i}(:,3) = (F{i}(:,4));
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

%% Generate a DS for Full Cups
% do you default parameters?
default = 1;    

for i=1:length(F3)
    xT = F3{i}(:,end);
    Norm1 = [];
    for j=1:length(F3{i})
        dis = xT - F3{i}(:,j);
        disN = norm(dis);
        Norm1 = [Norm1; disN];
        
        % normalized over distance
        Norm2 = Norm1/max(Norm1);
        
        % flip data to have the acceleration phase at the end
        Norm2 = flip(Norm2);
        % find 1 value
        id = find(Norm2(:,1) == 1);
        % if 1 is not in last place, add other 1s on the right
        if id ~= length(Norm2)
            for n=id:length(Norm2)
                Norm2(n) = 1;
            end
        end
        Full3Dnorm{i} = Norm2';
    end
end
genDS(Full3Dnorm, default, [], [], [], samp_freq, 'F');


