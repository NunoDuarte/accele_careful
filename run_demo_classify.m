%% Classify one file with existing trained model in 'param' folder
%% Load Path
clear test3
clc

% change to correct directory
%cd '/home/nuno/Documents/MATLAB/PhD/accele_careful/'

addpath(genpath('functions/'))
addpath('data')
addpath('param')

% Which Person to choose 
[E, F] = read('Kunpeng', 'red-cup');
% [Egan, Fgan, Eneu, Fneu] = readIST_22();  
% readQMUL;

% pick a trajectory
demo = E{2}; 

%% preprocess data
% remove 0s rows and NANs
demo = demo(any(demo,2),2:4);        
demo = demo(all(~isnan(demo),2),:);    

% shift to origin
xT = demo(end,:);
dis = demo - xT;    % THIS IS IMPORTANT

% compute vector-wise L2-norm
Norm1 = vecnorm(dis,2,2);

% normalized over distance
Norm2 = Norm1/max(Norm1);   % THIS IS IMPORTANT (-1) or not

% flip data to have the acceleration phase at the end
Norm2 = flip(Norm2);        % THIS IS IMPORTANT
% transpose data
demo_norm = Norm2';

%% calculate velocity
% pick sampling frequency
%samp_freq = 1/30; % for QMUL data
samp_freq = 1/120; % for EPFL or IST data

% de-noising data (not necessary/optional)
tmp = smooth(demo_norm,25); 

% computing the first time derivative
tmp_d = diff(tmp,1,1)/samp_freq;

tmp = tmp - repmat(tmp(end),1,size(tmp,2));

% saving demos next to each other
Data=[];
Data = [Data [tmp';tmp_d' 0]];

Data = flip(Data')';
figure();
plot(Data(1,:), Data(2,:), '.')

%% Load Eigen Vectors

SigmaE = load('SigmaE.mat');
SigmaE = SigmaE.Sigma;
SigmaF = load('SigmaF.mat');
SigmaF = SigmaF.Sigma;

[Ve,~] = eig(SigmaE(:,:,1));
[Vf,~] = eig(SigmaF(:,:,1));

e2{1} = Ve(:,2);
e2{2} = Vf(:,2);

%% Classify motion
% initial values
b = [0.5, 0.5];         % 50% v 50%
b_d = [0, 0];           %  0  v  0
ee = [0 0];
epsilon = 0.12;         % adaptation rate
minVel = 0.18;          % minimum velocity considered

% initialization
Xd = [];
Er = [];
B = [];

for j = 1:length(Data)-1   
    ee = [0 0];

    if abs(Data(2,j)) > minVel
        for i = 1:2
            % compute real velocity
            outD(j) = abs((Data(2,j+1)-Data(2,j))/(Data(1,j+1)-Data(1,j)));

            % rate of change for careful/not careful
            xd = abs((e2{i}(2)/e2{i}(1)));

            % error (real velocity - desired velocity)
            ed = -1*abs(outD(j) - xd(:,1));
            ee(i) = ed;   

            Xd = [Xd, xd(:,1)'];
            b_d(i) = epsilon * (ed' + (b(i) - 0.5)*norm(xd(:,1), 2)); 

        end
        % save the error
        Er = [Er;ee];

        B_d = winnertakeall(b, b_d);
        for i = 1:2
            b(i) = b(i) + B_d(i)*0.1;
            b(i) = max(0., min(1., b(i)));
        end
        b(2) = 1. - b(1);
        B = [B; b];   
    end

end

