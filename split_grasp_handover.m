%% Classify batch of files with existing trained model in 'param' folder
%% Load Path
clear all
clc

% change to correct directory
%cd '/home/nuno/Documents/MATLAB/PhD/accele_careful/'

addpath(genpath('functions/'))
addpath('data')
addpath('param')
addpath('../software/Khansari/SEDS/SEDS_lib')

% Read dataset
[Egan, Fgan, Eneu, Fneu] = readIST_22();  

% set correct data frequency
%samp_freq = 1/30; % for QMUL data
samp_freq = 1/120; % for EPFL data and IST data

%% Load Eigen Vectors from 'param' folder

SigmaE = load('SigmaE.mat');
SigmaE = SigmaE.Sigma;

[Ve,De] = eig(SigmaE(:,:,1));
Ee1=Ve(:,1); 
Ee2=Ve(:,2);
Ed = sqrt(diag(De));

SigmaF = load('SigmaF.mat');
SigmaF = SigmaF.Sigma;

[Vf,Df] = eig(SigmaF(:,:,1));
Fe1=Vf(:,1); 
Fe2=Vf(:,2);
Fd = sqrt(diag(Df));

e2{1} = Ve(:,2);
e2{2} = Vf(:,2);

%% Batch all files

D = size(Egan);

for n=1:D(1)
    for m=1:D(2)

        clear testXn;
        clear test3;
       %% Belief System for 2 DS

        % pick e trajectory
        testX = Fgan{n,m};
        if isempty(testX)
            continue
        end

        % preprocess data
        testXn = testX(any(testX,2),2:4);          % remove only full rows of 0s
        testXn = testXn(all(~isnan(testXn),2),:);  % remove rows of NANs  
        test3{1}(1,:) = testXn(:,1)';
        test3{1}(2,:) = testXn(:,2)';
        test3{1}(3,:) = testXn(:,3)'; 

        %% Center the Data in the Origin

        for i=1:length(test3)
            xT = test3{i}(:,end);
            Norm1 = [];
            for j=1:length(test3{i})
                dis = xT - test3{i}(:,j);
                disN = norm(dis,2);
                Norm1 = [Norm1; disN];

                % normalized over distance
                Norm2 = Norm1/max(Norm1);

                % flip data to have the acceleration phase at the end
                Norm2 = flip(Norm2);
                Emp3Dnorm{i} = Norm2';
            end
        end

        [~ , ~, Data, index] = preprocess_demos(Emp3Dnorm, samp_freq, 0.0001);

        % flip Data to start at (0,0); 
        Data = flip(Data')';
        h = figure;
        drawnow;
        hold on;
        plot(Data(1,:), Data(2,:), '.');
        TF = islocalmin(Data(1,:));
        plot(Data(1,TF),Data(2,TF),'r*');
        try
            waitforbuttonpress
            % Close figure or leave it open
            close(h)
        catch
        end
        hold on;

        

        
    end
end

