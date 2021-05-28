% for the glitch of the Command Window
%MATLAB_JAVA = '/usr/lib/jvm/java-8-openjdk/jre matlab -desktop -nosplash';
% export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
clear
clc

addpath('data')
addpath('ds')
addpath('belief')
addpath(genpath('processing/'))
addpath('scripts')
addpath('param')
addpath('../../software/Khansari/SEDS/SEDS_lib')
addpath('../../software/Khansari/SEDS/GMR_lib')

%% 

%P = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1];
P = [1];

minVel = [0.0, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14, 0.16, 0.18, 0.2]; % for 1 vs all 
%minVel = [0.0, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14, 0.16, 0.18, 0.2]; % for QMUL data

epsi = [0.05, 0.08, 0.1, 0.11, 0.12, 0.14, 0.15, 0.16, 0.18, 0.2,]; % for 1 vs all
%epsi = [0.05, 0.08, 0.1, 0.11, 0.12, 0.14, 0.15, 0.16, 0.18, 0.2, 0.22, 0.25, 0.3, 0.35, 0.4, 0.5, 0.55, 0.7, 0.8]; % 
%epsi = [0.35, 0.4, 0.5, 0.55, 0.7, 0.8, 0.9, 1.0, 1.15, 1.2, 1.25, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9]; % for QMUL data

% do I have to add K parameter?
K = [2];

% what data is it? EPFL/IST 1/120 ? QMUL 1/30 ?
freqs.train = 1/120; 
freqs.test = 1/120;

plots = 0;
for m = 1:length(minVel)

    for i=1:length(P)
        % get the data randomized
        for k=1:1
            [Etrain, Ftrain, train, test, Etest, Ftest] = scriptAllData(P(i));

            for n = 1:length(epsi)

               scriptDS(Etrain, Ftrain, train, test, Etest, Ftest, K, minVel(m), epsi(n), plots, freqs)
               close all;
            end
        end
    end
end
