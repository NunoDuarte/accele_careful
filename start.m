% for the glitch of the Command Window
%MATLAB_JAVA = '/usr/lib/jvm/java-8-openjdk/jre matlab -desktop -nosplash';
% Add this to ~/.bashrc
% export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
clear
clc

addpath('data')
addpath('ds')
addpath('belief')
addpath(genpath('processing/'))
addpath('scripts')
addpath('../../software/Khansari/SEDS/SEDS_lib')
addpath('../../software/Khansari/SEDS/GMR_lib')

%% 

%P = [0.3, 0.5, 0.6];
P = [1];

minVel = [0.04, 0.05, 0.06, 0.07, 0.08, 0.10, 0.12, 0.14, 0.16, 0.2];
%epsi = [0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.5, 0.55];
epsi = [0.3, 0.35, 0.4, 0.5, 0.55, 0.8, 0.9, 1, 1.1, 1.2, 1.3];

% do I have to add K parameter?
% K = [1, 2, 3];


plots = 0;
for m = 1:length(minVel)

    for i=1:length(P)
        % get the data randomized
        [Etrain, Ftrain, train, test, Etest, Ftest] = scriptAllData(P(i));

        for n = 1:length(epsi)

           scriptDS(Etrain, Ftrain, train, test, Etest, Ftest, minVel(m), epsi(n), plots)
           close all;
        end
    end
end
