path = '/Users/Nuno/Documents/MATLAB/accele_careful/data/IST_2022/';
files = dir(path);
dirFlags = [files.isdir];
subFolders = files(dirFlags);
subFolderNames = {subFolders(3:end).name};
% remove 'first' directory
subFolderNames(ismember(subFolderNames, 'first')) = [];

% order sequence of careful (water) and not careful (empty) cups
c = [0, 2, 5, 6, 8, 9];
nc = [1, 3, 4, 7, 10, 11];

% loop for all P## files
for k = 1 : length(subFolderNames)
    
    subpath = strcat(path,'/',subFolderNames{k});
    subfiles = dir(subpath);
    subdirFlags = [subfiles.isdir];
    subsubFolders = subfiles(subdirFlags);
    subsubNames = {subsubFolders(3:end).name};
    
    % loop for both GAN and neutral of each P##
    for l = 1 : length(subsubNames)
%         fprintf('Sub folder #%d = %s\n', k, subsubNames{l});
        
        if contains(subsubNames{l},'GAN')
            
            subsubpath = strcat(subpath,'/',subsubNames{l});
            filespath = strcat(subsubpath,'/','*_wrist.csv');
            files = dir(filespath);
            % path of all 12 trajectories
            fullpaths = fullfile({files.folder}, {files.name});
            
            % only save those P## which have 12 sequences
            if length(fullpaths) == 12
                indexE = nc+1;
                indexF = c+1;
                for i=1:length(nc)
                    Egan{k,i} = csvread(fullpaths{indexE(i)});
                end
                for i=1:length(indexF)
                    Fgan{k,i} = csvread(fullpaths{indexF(i)});
                end 
            end
            
        elseif contains(subsubNames{l},'neu') || contains(subsubNames{l},'NEU')
            
            subsubpath = strcat(subpath,'/',subsubNames{l});
            filespath = strcat(subsubpath,'/','*_wrist.csv');
            files = dir(filespath);
            % path of all 12 trajectories
            fullpaths = fullfile({files.folder}, {files.name});
            
            % only save those P## which have 12 sequences
            if length(fullpaths) == 12
                indexE = nc+1;
                indexF = c+1;
                for i=1:length(nc)
                    Eneu{k,i} = csvread(fullpaths{indexE(i)});
                end
                for i=1:length(indexF)
                    Fneu{k,i} = csvread(fullpaths{indexF(i)});
                end 
            end
            
        else 
            error('Wrong file name');
        end
    end

end
 