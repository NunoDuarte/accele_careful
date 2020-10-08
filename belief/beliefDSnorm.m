%% Load Path
clear all
clc

% change to correct directory
cd '/home/nuno/Documents/MATLAB/PhD/accele_careful/'

addpath('../SEDS')
addpath('processing')
addpath('data')
addpath('beliefDS')
addpath('../../Khansari/SEDS/SEDS_lib')
addpath('../../Khansari/SEDS/GMR_lib')

% Which Person to choose (Salman, Leo, Bernardo)
[E, F] = read('Leo', 'red-cup');

%% Belief System for 2 DS

% pick e trajectory
testX = F{1}; 

% remove nonzeros
testXn(:,1) = nonzeros(testX(:,2));
testXn(:,2) = nonzeros(testX(:,3));
testXn(:,3) = nonzeros(testX(:,4));
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

[~ , ~, Data, index] = preprocess_demos(Emp3Dnorm, 0.02, 0.0001); 

% flip Data to start at (0,0);
Data = flip(Data')';

% testXn = test3{1};
% testXn = testXn - testXn(:,end);
% testXn = round(testXn,3);
% 
% % do the norm of all dimensions
% for n = 1:length(testXn)   
%     testXnnorm(n) = norm(testXn(:,n));       
% end
% % testXnnorm = round(testXnnorm,4);
% 
% testXnnorm0 = testXnnorm - testXnnorm(:,end);
% testXnnorm0 = testXnnorm0;
% testXnnorm0 = round(testXnnorm0,3);

%% Load Eigen Vectors

SigmaE = load('SigmaE.mat');
SigmaE = SigmaE.Sigma;

[Ve,De] = eig(SigmaE);
Ee1=Ve(:,1); 
Ee2=Ve(:,2);
Ed = sqrt(diag(De));

SigmaF = load('SigmaF.mat');
SigmaF = SigmaF.Sigma;

[Vf,Df] = eig(SigmaF);
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
epsilon = 0.2; % adaptation rate

d = 1; %dimension of data
xT = 0;
Xd = [];

B = [];
B = [B; b];
Er = [];

K = 0; % out many values to average
for j = 1:length(Data)-K-1   
    ee = [0 0];
    for i = 1:2
        
        outD(j) = (Data(2,j+1)-Data(2,j))/0.02;
  
        xd = e2{i}(2)/e2{i}(1);
        
        % error (real velocity - desired velocity)
        ed = abs(outD(j) - xd(:,1));
        ee(i) = ed;   
        
        %Xd(j,i) = xd(:,1)';
        Xd = [Xd, xd(:,1)'];
        b_d(i) = epsilon * (ed'*xd(:,1) + (b(i) - 0.5)*norm(xd(:,1), 2)); 
        
    end
    Er = [Er;ee];
    
    if abs(outD(j)) > 0.15
       [b1_d, w] = max(b_d); 
        if w == 1
            0;
        elseif w == 2
            b_dold = b_d;
            b_d(1) = b1_d;
            b_d(2) = b_dold(1);       
        end
    end
        
    B_d = winnertakeall(b, b_d);
    for i = 1:2
        b(i) = b(i) + B_d(i)*0.1;
        b(i) = max(0., min(1., b(i)));
    end
    b(2) = 1. - b(1);
    B = [B; b];    
end



% probably smooting;

