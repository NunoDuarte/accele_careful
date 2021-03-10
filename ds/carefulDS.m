% for the glitch of the Command Window
%MATLAB_JAVA = '/usr/lib/jvm/java-8-openjdk/jre matlab -desktop -nosplash';
% Add this to ~/.bashrc
% export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
clear
clc

addpath('ds')
addpath('processing')
addpath('data')
addpath('belief')
addpath('../../software/Khansari/SEDS/SEDS_lib')
addpath('../../software/Khansari/SEDS/GMR_lib')

% Which Person to choose (Salman, Leo, Bernardo)
% [E, F] = read('Athanasios', 'champagne');
readQMUL;

% plotting?
plotting = 1;

%% Remove Non-Zeros - Empty

if plotting
    [plotx, ploty, plotz] = deal(0);
end

for i=1:length(E)

    En{i}(:,1) = nonzeros(E{i}(:,2));
    En{i}(:,2) = nonzeros(E{i}(:,3));
    En{i}(:,3) = nonzeros(E{i}(:,4));
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
        
        % normalized over distance
        Norm2 = Norm1/max(Norm1);
        
        % flip data to have the acceleration phase at the end
        Norm2 = flip(Norm2);
        Emp3Dnorm{i} = Norm2';
    end
end
genDS(Emp3Dnorm, default, [], [], [], 'E', '2D');

%% Remove Non Zeros

if plotting
    [plotx, ploty, plotz] = deal(0);
end

for i=1:length(F)
    Fn{i}(:,1) = nonzeros(F{i}(:,2));
    Fn{i}(:,2) = nonzeros(F{i}(:,3));
    Fn{i}(:,3) = nonzeros(F{i}(:,4));
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
        Full3Dnorm{i} = Norm2';
    end
end
genDS(Full3Dnorm, default, [], [], [], 'F', '2D');


