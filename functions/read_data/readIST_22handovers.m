function [Egan, Fgan, Eneu, Fneu] = readIST_22handovers()
    path = '/Users/Nuno/Documents/MATLAB/accele_careful/data/IST_2022_handovers/';
    files = dir(path);
    dirFlags = [files.isdir];
    subFolders = files(dirFlags);
    subFolderNames = {subFolders(3:end).name};

    % order sequence of careful (water) and not careful (empty) cups

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
                filespath = strcat(subsubpath,'/','handover*.csv');
                files = dir(filespath);
                % path of all 12 trajectories
                fullpaths = fullfile({files.folder}, {files.name});

                % only save those P## which have 12 sequences
                if length(fullpaths) == 12
                    indexE = 1:length(fullpaths)/2;
                    indexF = length(fullpaths)/2+1:length(fullpaths);
                    for i=1:length(indexE)
                        Egan{k,i} = csvread(fullpaths{indexE(i)});
                    end
                    for i=1:length(indexF)
                        Fgan{k,i} = csvread(fullpaths{indexF(i)});
                    end 
                end

            elseif contains(subsubNames{l},'neu') || contains(subsubNames{l},'NEU')

                subsubpath = strcat(subpath,'/',subsubNames{l});
                filespath = strcat(subsubpath,'/','handover*.csv');
                files = dir(filespath);
                % path of all 12 trajectories
                fullpaths = fullfile({files.folder}, {files.name});

                % only save those P## which have 12 sequences
                if length(fullpaths) == 12
                    indexE = 1:length(fullpaths)/2;
                    indexF = length(fullpaths)/2+1:length(fullpaths);
                    for i=1:length(indexE)
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
end 