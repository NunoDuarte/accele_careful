% for the glitch of the Command Window
%MATLAB_JAVA = '/usr/lib/jvm/java-8-openjdk/jre matlab -desktop -nosplash';
% Add this to ~/.bashrc
% export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
clear
clc

addpath('data')
addpath('DS')
addpath('beliefDS')
addpath('../../software/Khansari/SEDS/SEDS_lib')
addpath('../../software/Khansari/SEDS/GMR_lib')

%% 

P = [0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4];

minVel = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12];
epsi = [0.1, 0.2, 0.3];

for j = 1:2
    for m = 1:length(minVel)

        for n = 1:length(epsi)

            for i=1:length(P)

               scriptAllDataDS(P(i), minVel(m), epsi(n))
               close all;
            end
        end
    end
end