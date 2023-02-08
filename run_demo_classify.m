%% Classify one file with existing trained model in 'param' folder
%% Load Path
clear all
clc

% change to correct directory
%cd '/home/nuno/Documents/MATLAB/PhD/accele_careful/'

addpath(genpath('functions/'))
addpath('data')
addpath('param')
addpath('../software/Khansari/SEDS/SEDS_lib')

% Which Person to choose 
% [E, F] = read('Kunpeng', 'red-cup');
readIST_22;     % [Egan, Fgan, Eneu, Fneu]
%readQMUL;

%% Belief System for 2 DS

% pick e trajectory
testX = F{1}; 

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
%samp_freq = 1/30; % for QMUL data
samp_freq = 1/120; % for EPFL data


[~ , ~, Data, index] = preprocess_demos(Emp3Dnorm, samp_freq, 0.0001); 

% flip Data to start at (0,0);
Data = flip(Data')';
plot(Data(1,:), Data(2,:), '.')

%% Load Eigen Vectors

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


%% Real Velocity of testX
% dt = 0.02; % frequency 
% 
% for i=2:length(testXn(1,:))
% %     if i==2
% %         testX_d(1,i-1) = -0.2;
% %     else
%         testX_d(1,i-1) = (testXnnorm0(1,i) - testXnnorm0(1,i-1))/dt;
% %     end
% end
% testX_d(1,i) = 0;
% %testX_d = diff(testXn,1,2);

%% Run each DS to get the desired velocity?
opt_sim.dt = 0.02;
opt_sim.i_max = 1;
opt_sim.tol = 0.001;
opt_sim.plot = 0;

b1 = 0.5;
b2 = 0.5;
b = [b1, b2];
b1_d = 0;
b2_d = 0;
b_d = [b1_d, b2_d];
epsilon = 0.12; % adaptation rate
minVel = 0.18; %

d = 1; %dimension of data
xT = 0;
Xd = [];

B = [];
B = [B; b];
Er = [];

K = 0; % out many values to average
for j = 1:length(Data)-K-1   
    ee = [0 0];

    if abs(Data(2,j)) > minVel
        for i = 1:2

            outD(j) = abs((Data(2,j+1)-Data(2,j))/(Data(1,j+1)-Data(1,j)));

            % rate of change for careful/not careful
            xd = abs((e2{i}(2)/e2{i}(1)));

            % error (real velocity - desired velocity)
            ed = -1*abs(outD(j) - xd(:,1));
            ee(i) = ed;   

            %Xd(j,i) = xd(:,1)';
            Xd = [Xd, xd(:,1)'];
            b_d(i) = epsilon * (ed' + (b(i) - 0.5)*norm(xd(:,1), 2)); 

        end
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



% probably smooting;

