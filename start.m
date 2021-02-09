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

P = [0.3, 0.5, 0.6];

minVel = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12];
epsi = [0.1, 0.2, 0.3];

plots = 0;
for j = 1:2
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
end