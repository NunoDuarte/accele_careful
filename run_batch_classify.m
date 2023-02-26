%% Classify batch of files with existing trained model in 'param' folder
%% Load Path
clear all
clc

% change to correct directory
%cd '/home/nuno/Documents/MATLAB/PhD/accele_careful/'

addpath(genpath('functions/'))
addpath('data')
addpath('param_KrAc_best/')

% Which Person to choose 
% [E, F] = read('Kunpeng', 'red-cup');
[Egan, Fgan, Eneu, Fneu] = readIST_22handovers();

% % remove outliers
% Eneu{9,3} = [];
% Fgan{10,1} = [];
% Egan{10,1} = [];
% Fneu{11,1} = [];
% Fneu{11,3} = [];
% Fneu{11,4} = [];
% Fneu{11,5} = [];
% Fneu{12,1} = [];
% Eneu{12,1} = [];
% Fgan{12,1} = [];
% Egan{12,3} = [];

%% 
matrix{1} = Egan;
matrix{2} = Fgan;
matrix{3} = Eneu;
matrix{4} = Fneu;
%readQMUL;

% set correct data frequency
%samp_freq = 1/30; % for QMUL data
samp_freq = 1/120; % for EPFL data

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

for mat=1:4
    clear b_all
    D = matrix{mat};
    if mat == 1
        fprintf('Egan \n');
    elseif mat == 2
        fprintf('Fgan \n');     
    elseif mat == 3
        fprintf('Eneu \n');     
    elseif mat == 4
        fprintf('Fneu \n');       
    end
    len = size(D);
    for n=1:len(1)
        for m=1:len(2)

            demo = D{n,m};
            if isempty(demo)
                continue
            end        
            %% preprocess data
            % remove 0s rows and NANs
            demo = demo(any(demo,2),2:4);        
            demo = demo(all(~isnan(demo),2),:);    

            % set handover point as origin
            dis = demo - demo(end,:);

            % compute vector-wise L2-norm
            Norm1 = vecnorm(dis,2,2);

            % normalized over distance
            demo_norm = Norm1/max(Norm1);   % THIS IS IMPORTANT

            %% calculate velocity
            % de-noising data (not necessary/optional)
            tmp = smooth(demo_norm,25); 

            % computing the first time derivative
            tmp_d = diff(tmp,1,1)/samp_freq;

            %% Save data
            % set the acceleration back to the origin
            tmp = tmp - repmat(tmp(1),1,size(tmp,2));

            Data=[];
            Data = [Data [tmp';0 tmp_d']];       

            %% Classify motion
            % initial values
            b = [0.5, 0.5];         % 50% v 50%
            b_d = [0, 0];           %  0  v  0
            ee = [0 0];
            epsilon = 0.14;         % adaptation rate
            minVel = 0.16;          % minimum velocity considered

            % initialization
            Xd = [];
            Er = [];
            B = [];

            for j = 1:length(Data)-1 
                B = [B; b];

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
                end

            end
            [~, argmax] = max(b);
            if argmax == 1
                b_all{n,m} = 'Empty';
            elseif argmax == 2
                b_all{n,m} = 'Full';
            end
            
            % save B data
            if mat == 1
                all_BEgan{n,m} = B(:,1);
            elseif mat == 2
                all_BFgan{n,m} = B(:,1);
            elseif mat == 3
                all_BEneu{n,m} = B(:,1);
            elseif mat == 4
                all_BFneu{n,m} = B(:,1);
            end
        end
    end

    tfull = nnz(strcmp(b_all,'Full'));
    tempty = nnz(strcmp(b_all,'Empty'));

    fprintf('Number of Full classifications: %d\n', tfull);
    fprintf('Number of Empty classifications: %d\n', tempty);

    tavgfull = tfull/(tfull+tempty);
    tavgempty = 1-tavgfull;

    fprintf('Average full %f and empty %f \n', tavgfull, tavgempty);
    
end

