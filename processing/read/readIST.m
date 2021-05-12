function [E, F] = readIST(name)
    % reading data of IST dataset 3
    if strcmp(name,'full')
        % give-full
        E = [];
        % 
        % Full
        F{1} = load(['data/IST_new_segs/1/1-full_r.mat']).data;
        F{2} = load(['data/IST_new_segs/1/2-full_r.mat']).data;
        F{3} = load(['data/IST_new_segs/1/3-full_r.mat']).data;
        F{4} = load(['data/IST_new_segs/2/1-full_r.mat']).data;
        F{5} = load(['data/IST_new_segs/2/3-full_r.mat']).data;
        F{6} = load(['data/IST_new_segs/3/2-full_r.mat']).data;
        F{7} = load(['data/IST_new_segs/3/3-full_r.mat']).data;
        F{8} = load(['data/IST_new_segs/4/1-full_r.mat']).data;
        F{9} = load(['data/IST_new_segs/4/2-full_r.mat']).data;
        F{10} = load(['data/IST_new_segs/6/1-full_r.mat']).data;
        F{11} = load(['data/IST_new_segs/6/2-full_r.mat']).data;
        F{12} = load(['data/IST_new_segs/6/3-full_r.mat']).data;
        
    % reading data of give-empty
    elseif strcmp(name,'empty')
        
        E{1} = load(['data/IST_new_segs/1/1-empty_r.mat']).data;
        E{2} = load(['data/IST_new_segs/1/2-empty_r.mat']).data;
        E{3} = load(['data/IST_new_segs/1/3-empty_r.mat']).data;
        E{4} = load(['data/IST_new_segs/2/1-empty_r.mat']).data;
        E{5} = load(['data/IST_new_segs/2/2-empty_r.mat']).data;
        E{6} = load(['data/IST_new_segs/2/3-empty_r.mat']).data;
        E{7} = load(['data/IST_new_segs/3/1-empty_r.mat']).data;
        E{8} = load(['data/IST_new_segs/3/2-empty_r.mat']).data;
        E{9} = load(['data/IST_new_segs/3/3-empty_r.mat']).data;
        E{10} = load(['data/IST_new_segs/4/1-empty_r.mat']).data;
        E{11} = load(['data/IST_new_segs/4/2-empty_r.mat']).data;
        E{12} = load(['data/IST_new_segs/6/1-empty_r.mat']).data;
        
        F = [];
        
    % reading data of give-empty
    elseif strcmp(name,'half')
        E = [];
        % 
        % Full
        F{1} = readmatrix(['data/IST_new_segs/1/0_right-1.csv']);     
        F{2} = readmatrix(['data/IST/give-' name '/0_right-3.csv']);     
        F{3} = readmatrix(['data/IST/give-' name '/2_right-2.csv']);     
        F{4} = readmatrix(['data/IST/give-' name '/7_right-1.csv']);     
        F{5} = readmatrix(['data/IST/give-' name '/10_right-2.csv']);     
        F{6} = readmatrix(['data/IST/give-' name '/10_right-6.csv']);     
        F{7} = readmatrix(['data/IST/give-' name '/11_right-1.csv']);     
        F{8} = readmatrix(['data/IST/give-' name '/12_right-2.csv']);     
        F{9} = readmatrix(['data/IST/give-' name '/23_right-3.csv']);     
        F{10} = readmatrix(['data/IST/give-' name '/26_right-3.csv']);     
        
    else
        error('Name not Recognized!');
    end
    
end