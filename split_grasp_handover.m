%% Classify batch of files with existing trained model in 'param' folder
%% Load Path
clear all
clc

% set correct data frequency
%samp_freq = 1/30; % for QMUL data
samp_freq = 1/120; % for EPFL data and IST data

%% Batch all files

path = '/Users/Nuno/Documents/MATLAB/accele_careful/data/IST_2022/';
files = dir(path);
dirFlags = [files.isdir];
subFolders = files(dirFlags);
subFolderNames = {subFolders(3:end).name};
% remove 'first' directory
subFolderNames(ismember(subFolderNames, 'first')) = [];

newfolder = '/Users/Nuno/Documents/MATLAB/accele_careful/data/IST_2022_handovers/';
if ~exist(newfolder, 'dir')
   mkdir(newfolder)
end
    
% order sequence of careful (water) and not careful (empty) cups
% order {0, 10, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9}
c = [0, 4, 7, 8, 10, 11];
nc = [1, 2, 3, 5, 6, 9];

% loop for all P## files
for k = 1 : length(subFolderNames)

    subpath = strcat(path,'/',subFolderNames{k});
    subfiles = dir(subpath);
    subdirFlags = [subfiles.isdir];
    subsubFolders = subfiles(subdirFlags);
    subsubNames = {subsubFolders(3:end).name};
    
    subnewfolder = strcat(newfolder,'/',subFolderNames{k});
    if ~exist(subnewfolder, 'dir')
       mkdir(subnewfolder)
    end

    % loop for both GAN and neutral of each P##
    for l = 1 : length(subsubNames)
%         fprintf('Sub folder #%d = %s\n', k, subsubNames{l});

        if contains(subsubNames{l},'GAN')
            
            subsubnewfolder = strcat(subnewfolder,'/',subsubNames{l});
            if ~exist(subsubnewfolder, 'dir')
                mkdir(subsubnewfolder)
            end

            subsubpath = strcat(subpath,'/',subsubNames{l});
            filespath = strcat(subsubpath,'/','*_wrist.csv');
            files = dir(filespath);
            % path of all 12 trajectories
            fullpaths = fullfile({files.folder}, {files.name});

            % only save those P## which have 12 sequences
            if length(fullpaths) == 12
                indexE = nc+1;
                indexF = c+1;
                for id=1:length(nc)
                    % pick e trajectory
                    testX = csvread(fullpaths{indexE(id)});
                    
                    % preprocess data
                    Data = data_norm_preprocessing(testX, samp_freq);
 
                    % filter out just a specific interval
                    logicalIndexes = Data(1,:) < 0 &  Data(1,:) > -0.4;
                    hold on;
                    TF = islocalmin(Data(2,logicalIndexes), 'MaxNumExtrema',3, 'FlatSelection','first', 'MinProminence',0.1);
                    result = find(TF==1);
                    vel_values = Data(2,result);
                    [argvalue, argmin] = min(vel_values);
                    result = result(argmin);
%                     plot(Data(1,:), Data(2,:), '.', Data(1,TF),Data(2,TF),'r*');
                    fprintf('Sub folder %s, handover %d\n', subsubNames{l}, nc(id));

                    % cut just the handover
                    hello = testX(result:end,:);
                    if ~isempty(hello)
                        initT = hello(1,1);     % reset time
                        hello(:,1) = hello(:,1) - initT;

                        % preprocess data to view output
                        Data = data_norm_preprocessing(hello, samp_freq);
%                         plot(Data(1,:), Data(2,:), '.');


                        filespath = strcat(subsubnewfolder,'/handoverE_', num2str(nc(id)), '.csv');
                        csvwrite(filespath, hello) 
                    else
                        filespath = strcat(subsubnewfolder,'/handoverE_', num2str(nc(id)), '.csv');
                        initT = testX(1,1);     % reset time
                        testX(:,1) = testX(:,1) - initT;
                        csvwrite(filespath, testX)
                    end
                    
                end
                for id=1:length(indexF)
                    % pick e trajectory
                    testX = csvread(fullpaths{indexF(id)});
                    
                    % preprocess data
                    Data = data_norm_preprocessing(testX, samp_freq);
 
                    % filter out just a specific interval
                    logicalIndexes = Data(1,:) < 0 &  Data(1,:) > -0.4;
                    hold on;
                    TF = islocalmin(Data(2,logicalIndexes), 'MaxNumExtrema',3, 'FlatSelection','first', 'MinProminence',0.1);
                    result = find(TF==1);
                    vel_values = Data(2,result);
                    [argvalue, argmin] = min(vel_values);
                    result = result(argmin);
%                     plot(Data(1,:), Data(2,:), '.', Data(1,TF),Data(2,TF),'r*');
                    
                    handover = c(id);
                    fprintf('Sub folder %s, handover %d\n', subsubNames{l}, handover);

                    % cut just the handover
                    hello = testX(result:end,:);
                    if ~isempty(hello)
                        initT = hello(1,1);     % reset time
                        hello(:,1) = hello(:,1) - initT;

                        % preprocess data to view output
                        Data = data_norm_preprocessing(hello, samp_freq);
%                         plot(Data(1,:), Data(2,:), '.');


                        filespath = strcat(subsubnewfolder,'/handoverF_', num2str(handover), '.csv');
                        csvwrite(filespath, hello) 
                    else
                        filespath = strcat(subsubnewfolder,'/handoverF_', num2str(handover), '.csv');
                        initT = testX(1,1);     % reset time
                        testX(:,1) = testX(:,1) - initT;
                        csvwrite(filespath, testX)
                    end                
                   
                end 
            end

        elseif contains(subsubNames{l},'neu') || contains(subsubNames{l},'NEU')
                        
            subsubnewfolder = strcat(subnewfolder,'/',subsubNames{l});
            if ~exist(subsubnewfolder, 'dir')
                mkdir(subsubnewfolder)
            end

            subsubpath = strcat(subpath,'/',subsubNames{l});
            filespath = strcat(subsubpath,'/','*_wrist.csv');
            files = dir(filespath);
            % path of all 12 trajectories
            fullpaths = fullfile({files.folder}, {files.name});

            % only save those P## which have 12 sequences
            if length(fullpaths) == 12
                indexE = nc+1;
                indexF = c+1;
                for id=1:length(nc)
                    testX = csvread(fullpaths{indexE(id)});
                    
                    % preprocess data
                    Data = data_norm_preprocessing(testX, samp_freq);
 
                    % filter out just a specific interval
                    logicalIndexes = Data(1,:) < 0 &  Data(1,:) > -0.4;
                    hold on;
                    TF = islocalmin(Data(2,logicalIndexes), 'MaxNumExtrema',3, 'FlatSelection','first', 'MinProminence',0.1);
                    result = find(TF==1);
                    vel_values = Data(2,result);
                    [argvalue, argmin] = min(vel_values);
                    result = result(argmin);
%                     plot(Data(1,:), Data(2,:), '.', Data(1,TF),Data(2,TF),'r*');
                    
                    handover = nc(id);
                    fprintf('Sub folder %s, handover %d\n', subsubNames{l}, handover);

                    % cut just the handover
                    hello = testX(result:end,:);
                    if ~isempty(hello)
                        initT = hello(1,1);     % reset time
                        hello(:,1) = hello(:,1) - initT;

                        % preprocess data to view output
                        Data = data_norm_preprocessing(hello, samp_freq);
%                         plot(Data(1,:), Data(2,:), '.');


                        filespath = strcat(subsubnewfolder,'/handoverE_', num2str(handover), '.csv');
                        csvwrite(filespath, hello) 
                    else
                        filespath = strcat(subsubnewfolder,'/handoverE_', num2str(handover), '.csv');
                        initT = testX(1,1);     % reset time
                        testX(:,1) = testX(:,1) - initT;
                        csvwrite(filespath, testX)
                    end

%                     try
%                         waitforbuttonpress
%                         % Close figure or leave it open
%                         close()
%                     catch
%                     end                     
                    
                end
                for id=1:length(indexF)
                    testX = csvread(fullpaths{indexF(id)});
                    
                    % preprocess data
                    Data = data_norm_preprocessing(testX, samp_freq);
 
                    % filter out just a specific interval
                    logicalIndexes = Data(1,:) < 0 &  Data(1,:) > -0.4;
                    hold on;
                    TF = islocalmin(Data(2,logicalIndexes), 'MaxNumExtrema',3, 'FlatSelection','first', 'MinProminence',0.1);
                    result = find(TF==1);
                    vel_values = Data(2,result);
                    [argvalue, argmin] = min(vel_values);
                    result = result(argmin);
%                     plot(Data(1,:), Data(2,:), '.', Data(1,TF),Data(2,TF),'r*');
                    
                    handover = c(id);
                    fprintf('Sub folder %s, handover %d\n', subsubNames{l}, handover);

                    % cut just the handover
                    hello = testX(result:end,:);
                    if ~isempty(hello)
                        initT = hello(1,1);     % reset time
                        hello(:,1) = hello(:,1) - initT;

                        % preprocess data to view output
                        Data = data_norm_preprocessing(hello, samp_freq);
%                         plot(Data(1,:), Data(2,:), '.');


                        filespath = strcat(subsubnewfolder,'/handoverF_', num2str(handover), '.csv');
                        csvwrite(filespath, hello) 
                    else
                        filespath = strcat(subsubnewfolder,'/handoverF_', num2str(handover), '.csv');
                        initT = testX(1,1);     % reset time
                        testX(:,1) = testX(:,1) - initT;
                        csvwrite(filespath, testX)
                    end

%                     try
%                         waitforbuttonpress
%                         % Close figure or leave it open
%                         close()
%                     catch
%                     end                     
                end 
            end

        else 
            error('Wrong file name');
        end
    end

end

