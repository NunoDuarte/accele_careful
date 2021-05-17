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

%% read empty|head|full head movements

load IST_head/empty/head_empty.mat
head = headnew;

%% get matrix of head movements
DataEul = [];

for k = 1:length(head)
    DataEul{k}(:,:) = quatrotate(head{k}(:,2:5),head{k}(:,6:8));
    % center in origin
     origin = DataEul{k}(:,:) - DataEul{k}(1,:);
     DataEul{k} = rad2deg(origin);     
%     DataEul{k} = rad2deg(DataEul{k}(:,:));        

end

%% normalize to 100

DataEulNorm = deal([]);

for k = 1:length(DataEul)
    DataEulNorm{k} = resample(DataEul{k}(:,:),100,length(DataEul{k}(:,:)));   
end

%% calculate the average and std of head movement over time

[avgX, avgY, avgZ] = deal([]);
[stdXX, stdYY, stdZZ] = deal([]);
[stdX, stdY, stdZ] = deal([]);

[sumX, sumY, sumZ] = deal(zeros(100,1));
count = 0;
for k = 1:length(DataEulNorm)
    sumX = sumX + abs(DataEulNorm{k}(:,1));
    sumY = sumY + abs(DataEulNorm{k}(:,2));
    sumZ = sumZ + abs(DataEulNorm{k}(:,3));
    stdX = [stdX, DataEulNorm{k}(:,1)];
    stdY = [stdY, DataEulNorm{k}(:,2)];
    stdZ = [stdZ, DataEulNorm{k}(:,3)];
        
    count = count + 1;
end

avgX = sumX'./count;
avgY = sumY'./count;
avgZ = sumZ'./count;
stdXX = std(stdX');
stdYY = std(stdY');
stdZZ = std(stdZ');


%% plot all sequences

[plotx, ploty, plotz] = deal([]);

figure();

hold on;
% plot(avgX, '.r');
% plot(avgY, '.g');
% plot(avgZ, '.b');

x = 1:numel(avgX);

curve1 = avgX + stdXX;
curve2 = avgX - stdXX;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'g');
hold on;
plot(x, avgX, 'r', 'LineWidth', 2);

curve1 = avgY + stdYY;
curve2 = avgY - stdYY;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'g');
hold on;
plot(x, avgY, 'r', 'LineWidth', 2);

curve1 = avgZ + stdZZ;
curve2 = avgZ - stdZZ;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'g');
hold on;
plot(x, avgZ, 'r', 'LineWidth', 2);

%%







