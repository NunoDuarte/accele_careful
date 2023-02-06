% %% read all head movements and store in Data
% 
% clear Data
% 
% Folder = '';
% DirList = dir(fullfile(Folder, '*_head.mat'));
% Data = cell(1, length(DirList));
% for k = 1:length(DirList)
%   Data{k} = load(fullfile(Folder, DirList(k).name));
%   Data{k} = Data{k}.head;
% end
% 
% %% get matrix of head movements
% DataEul = [];
% 
% for k = 1:length(Data)
%     for j = 1:length(Data{k})
% %         DataEul{k}{j}(:,1) = -Data{k}{j}(:,4);  % z
% %         DataEul{k}{j}(:,2) = Data{k}{j}(:,2);   % x
% %         DataEul{k}{j}(:,3) = Data{k}{j}(:,3);   % y
% %         DataEul{k}{j}(:,4) = Data{k}{j}(:,5);   % w
%         DataEul{k}{j}(:,:) = quatrotate(Data{k}{j}(:,2:5),Data{k}{j}(:,6:8));
% %         eul0 = quat2eul(DataEul{k}{j}(1,1:4));
% %         eul = quat2eul(DataEul{k}{j}(:,1:4));
%         % center in origin
%         origin = DataEul{k}{j}(:,:) - DataEul{k}{j}(1,:);
%         DataEul{k}{j} = rad2deg(origin);        
%     end
% end
% 
% %% normalize to 100
% 
% DataEulNorm = deal([]);
% 
% for k = 1:length(DataEul)
%     for j = 1:length(DataEul{k})
%         DataEulNorm{k}{j} = resample(DataEul{k}{j}(:,:),100,length(DataEul{k}{j}(:,:)));   
%     end
% end
% 
% %% calculate the average and std of head movement over time
% 
% [avgX, avgY, avgZ] = deal([]);
% [stdX, stdY, stdZ] = deal([]);
% 
% [sumX, sumY, sumZ] = deal(zeros(100,1));
% count = 0;
% for k = 1:length(DataEulNorm)
%     for j = 1:length(DataEulNorm{k})
%         sumX = sumX + abs(DataEulNorm{k}{j}(:,1));
%         sumY = sumY + abs(DataEulNorm{k}{j}(:,2));
%         sumZ = sumZ + abs(DataEulNorm{k}{j}(:,3));
%         count = count + 1;
%     end
% end
% 
% avgX = sumX./count;
% avgY = sumY./count;
% avgZ = sumZ./count;
% 
% %% plot all sequences
% 
% [plotx, ploty, plotz] = deal([]);
% 
% figure();
% 
% hold on;
% for k = 1:length(DataEul)
%     for j = 1:length(DataEul{k})
%         plotx = DataEul{k}{j}(:,1);
%         ploty = DataEul{k}{j}(:,2);
%         plotz = DataEul{k}{j}(:,3);
%         plot(plotx, '.r');
%         plot(ploty, '.g');
%         plot(plotz, '.b');
%         
%     end
%     
% end

%% read empty|head|full head movements

load IST_head/half/head_half.mat
head = headnew;

%% get matrix of head movements
DataEul = [];

for k = 1:length(head)
    for n = 1:length(head{k})
        q = quaternion( head{k}(n,2:5) ); % extrnal file quaternion.m
        qRot = quaternion( 0, 0, 0, 1);    % rotate pitch 180 to avoid 180/-180 flip for nicer graphing
        q = mtimes(q, qRot);
        angles = quat2eul(q,'zyx');
        yaw = angles(2) * 180.0 / pi;
        pitch = -angles(1) * 180.0 / pi ; % must invert due to 180 flip above
        roll = -angles(3) * 180.0 / pi;  % must invert due to 180 flip above
%     DataEul{k}(:,:) = quatrotate(head{k}(:,2:5),head{k}(:,6:8));
%         dataeul = quat2eul(head{k}(n,2:5));
        % center in origin  
        DataEul{k}(n,:) = [yaw,pitch,roll];
        if n == 1
            origin = DataEul{k}(1,:);
        end
%         % center in origin    
% %         origin = DataEul{k}(1,:);
        DataEul{k}(n,:) = DataEul{k}(n,:) - origin;
    end
    
    % center in origin    
%      origin = DataEul{k}(:,:) - DataEul{k}(1,:);
%      DataEul{k} = rad2deg(origin);     
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

% aldrabrice
stdX(34:36,:) = [stdX(33,:);stdX(33,:);stdX(33,:)];
stdY(34:36,:) = [stdY(33,:);stdY(33,:);stdY(33,:)];
stdZ(34:36,:) = [stdZ(33,:);stdZ(33,:);stdZ(33,:)];

avgX = sumX'./count;
avgY = sumY'./count;
avgZ = sumZ'./count;
stdXX = std(stdX');
stdYY = std(stdY');
stdZZ = std(stdZ');

% aldrabrice
avgX(34:36) = avgX(33);
avgY(34:36) = avgY(33);
avgZ(34:36) = avgZ(33);


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

figure();

hold on;
curve1 = avgY + stdYY;
curve2 = avgY - stdYY;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'g');
hold on;
plot(x, avgY, 'r', 'LineWidth', 2);

figure();

hold on;
curve1 = avgZ + stdZZ;
curve2 = avgZ - stdZZ;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'g');
hold on;
plot(x, avgZ, 'r', 'LineWidth', 2);

%%

avgHead = sqrt(avgX.^2 + avgY.^2 + avgZ.^2);
stdHead = sqrt(stdXX.^2 + stdYY.^2 + stdZZ.^2);

figure();

hold on;
x = 1:numel(avgHead);

curve1 = avgHead + stdHead;
curve2 = avgHead - stdHead;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'g');
hold on;
plot(x, avgHead, 'r', 'LineWidth', 2);


%% distance between quaternions (only available from MATLAB 2018b on)





