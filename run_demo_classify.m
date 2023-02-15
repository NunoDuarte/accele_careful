%% Classify one file with existing trained model in 'param' folder
%% Load Path
clear all
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
demo = F{1}; 

%% preprocess data
% remove 0s rows and NANs
demo = demo(any(demo,2),2:4);        
demo = demo(all(~isnan(demo),2),:);    

% set handover point as origin
dis = demo - demo(end,:);

% compute vector-wise L2-norm
Norm1 = vecnorm(dis,2,2);

% normalized over distance
demo_norm = Norm1/max(Norm1);   % THIS IS IMPORTANT (-1) or not

%% calculate velocity
% pick sampling frequency
%samp_freq = 1/30; % for QMUL data
samp_freq = 1/120; % for EPFL or IST data

% de-noising data (not necessary/optional)
tmp = smooth(demo_norm,25); 

% computing the first time derivative
tmp_d = diff(tmp,1,1)/samp_freq;

%% Save data
% set the acceleration back to the origin (if you want to plot)
tmp = tmp - repmat(tmp(1),1,size(tmp,2));

Data=[];
Data = [Data [tmp';tmp_d' 0]];

%% Plot Data
figure();
plot(-1*Data(1,:), -1*Data(2,:), '.')

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

