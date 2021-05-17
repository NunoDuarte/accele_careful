%% read all head movements and store in Data

clear Data

Folder = '';
DirList = dir(fullfile(Folder, '*_head.mat'));
Data = cell(1, length(DirList));
for k = 1:length(DirList)
  Data{k} = load(fullfile(Folder, DirList(k).name));
  Data{k} = Data{k}.head;
end

%% read empty|head|full head movements

load IST_head/empty/head_empty.mat
head = headnew;

%% get matrix of head movements
DataEul = [];

for k = 1:length(Data)
    for j = 1:length(Data{k})
%         DataEul{k}{j}(:,1) = -Data{k}{j}(:,4);  % z
%         DataEul{k}{j}(:,2) = Data{k}{j}(:,2);   % x
%         DataEul{k}{j}(:,3) = Data{k}{j}(:,3);   % y
%         DataEul{k}{j}(:,4) = Data{k}{j}(:,5);   % w
        DataEul{k}{j}(:,:) = quatrotate(Data{k}{j}(:,2:5),Data{k}{j}(:,6:8));
%         eul0 = quat2eul(DataEul{k}{j}(1,1:4));
%         eul = quat2eul(DataEul{k}{j}(:,1:4));
        % center in origin
        origin = DataEul{k}{j}(:,:) - DataEul{k}{j}(1,:);
        DataEul{k}{j} = rad2deg(origin);        
    end
end

%% normalize to 100

DataEulNorm = deal([]);

for k = 1:length(DataEul)
    for j = 1:length(DataEul{k})
        DataEulNorm{k}{j} = resample(DataEul{k}{j}(:,:),100,length(DataEul{k}{j}(:,:)));   
    end
end

%% calculate the average and std of head movement over time

[avgX, avgY, avgZ] = deal([]);
[stdX, stdY, stdZ] = deal([]);

[sumX, sumY, sumZ] = deal(zeros(100,1));
count = 0;
for k = 1:length(DataEulNorm)
    for j = 1:length(DataEulNorm{k})
        sumX = sumX + abs(DataEulNorm{k}{j}(:,1));
        sumY = sumY + abs(DataEulNorm{k}{j}(:,2));
        sumZ = sumZ + abs(DataEulNorm{k}{j}(:,3));
        count = count + 1;
    end
end

avgX = sumX./count;
avgY = sumY./count;
avgZ = sumZ./count;

%% plot all sequences

[plotx, ploty, plotz] = deal([]);

figure();

hold on;
for k = 1:length(DataEul)
    for j = 1:length(DataEul{k})
        plotx = DataEul{k}{j}(:,1);
        ploty = DataEul{k}{j}(:,2);
        plotz = DataEul{k}{j}(:,3);
        plot(plotx, '.r');
        plot(ploty, '.g');
        plot(plotz, '.b');
        
    end
    
end






