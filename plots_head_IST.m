%% read all head movements and store in Data

clear Data

Folder = '';
DirList = dir(fullfile(Folder, '*_head.mat'));
Data = cell(1, length(DirList));
for k = 1:length(DirList)
  Data{k} = load(fullfile(Folder, DirList(k).name));
  Data{k} = Data{k}.head;
end

%% get matrix of head movements
DataEul = [];

for k = 1:length(Data)
    for j = 1:length(Data{k})
        DataEul{k}{j}(:,1) = -Data{k}{j}(:,4); % z
        DataEul{k}{j}(:,2) = Data{k}{j}(:,2);   % x
        DataEul{k}{j}(:,3) = Data{k}{j}(:,3);   % y
        DataEul{k}{j}(:,4) = Data{k}{j}(:,5);         % w
        
%         eul0 = quat2eul(DataEul{k}{j}(1,1:4));
        eul = quat2eul(DataEul{k}{j}(:,1:4));
        DataEul{k}{j} = rad2deg(eul);        
    end
end

%% 
