
E{1} = readmatrix(['data/IST/give-empty/1_right-1.csv']);


% first 18 files don't matter ???
data{1} = readmatrix(['data/pair-1/8.csv']);
data{2} = readmatrix(['data/pair-1/9.csv']);
data{3} = readmatrix(['data/pair-1/10.csv']);
data{4} = readmatrix(['data/pair-1/11.csv']);
data{5} = readmatrix(['data/pair-1/12.csv']);
data{6} = readmatrix(['data/pair-1/13.csv']);
data{7} = readmatrix(['data/pair-1/14.csv']);
data{8} = readmatrix(['data/pair-1/15.csv']);
data{9} = readmatrix(['data/pair-1/16.csv']);
data{10} = readmatrix(['data/pair-1/17.csv']);
data{11} = readmatrix(['data/pair-1/18.csv']);
data{12} = readmatrix(['data/pair-1/19.csv']);
data{13} = readmatrix(['data/pair-1/20.csv']);
data{14} = readmatrix(['data/pair-1/21.csv']);
data{15} = readmatrix(['data/pair-1/22.csv']);
data{16} = readmatrix(['data/pair-1/23.csv']);
data{17} = readmatrix(['data/pair-1/24.csv']);
data{18} = readmatrix(['data/pair-1/25.csv']);
data{19} = readmatrix(['data/pair-1/26.csv']);
data{20} = readmatrix(['data/pair-1/27.csv']);
data{21} = readmatrix(['data/pair-1/28.csv']);
data{22} = readmatrix(['data/pair-1/29.csv']);
data{23} = readmatrix(['data/pair-1/30.csv']);
data{24} = readmatrix(['data/pair-1/31.csv']);
data{25} = readmatrix(['data/pair-1/32.csv']);
data{26} = readmatrix(['data/pair-1/33.csv']);
data{27} = readmatrix(['data/pair-1/34.csv']);
data{28} = readmatrix(['data/pair-1/35.csv']);
data{29} = readmatrix(['data/pair-1/36.csv']);
data{30} = readmatrix(['data/pair-1/37.csv']);
data{31} = readmatrix(['data/pair-1/38.csv']);
data{32} = readmatrix(['data/pair-1/39.csv']);
data{33} = readmatrix(['data/pair-1/40.csv']);
data{34} = readmatrix(['data/pair-1/41.csv']);
data{35} = readmatrix(['data/pair-1/42.csv']);
data{36} = readmatrix(['data/pair-1/43.csv']);
data{37} = readmatrix(['data/pair-1/44.csv']);
data{38} = readmatrix(['data/pair-1/45.csv']);
data{39} = readmatrix(['data/pair-1/46.csv']);
data{40} = readmatrix(['data/pair-1/47.csv']);
data{41} = readmatrix(['data/pair-1/48.csv']);
data{42} = readmatrix(['data/pair-1/49.csv']);
data{43} = readmatrix(['data/pair-1/50.csv']);
data{44} = readmatrix(['data/pair-1/51.csv']);
data{45} = readmatrix(['data/pair-1/52.csv']);
data{46} = readmatrix(['data/pair-1/53.csv']);
data{47} = readmatrix(['data/pair-1/54.csv']);
data{48} = readmatrix(['data/pair-1/55.csv']);
data{49} = readmatrix(['data/pair-1/56.csv']);
data{50} = readmatrix(['data/pair-1/57.csv']);
data{51} = readmatrix(['data/pair-1/58.csv']);
data{52} = readmatrix(['data/pair-1/59.csv']);
data{53} = readmatrix(['data/pair-1/60.csv']);
data{54} = readmatrix(['data/pair-1/61.csv']);
data{55} = readmatrix(['data/pair-1/62.csv']);
data{56} = readmatrix(['data/pair-1/63.csv']);
data{57} = readmatrix(['data/pair-1/64.csv']);
data{58} = readmatrix(['data/pair-1/65.csv']);
data{59} = readmatrix(['data/pair-1/66.csv']);
data{60} = readmatrix(['data/pair-1/67.csv']);
data{61} = readmatrix(['data/pair-1/68.csv']);
data{62} = readmatrix(['data/pair-1/69.csv']);
data{63} = readmatrix(['data/pair-1/70.csv']);
data{64} = readmatrix(['data/pair-1/71.csv']);
data{65} = readmatrix(['data/pair-1/72.csv']);
data{66} = readmatrix(['data/pair-1/73.csv']);
data{67} = readmatrix(['data/pair-1/74.csv']);
data{68} = readmatrix(['data/pair-1/75.csv']);
data{69} = readmatrix(['data/pair-1/76.csv']);
data{70} = readmatrix(['data/pair-1/77.csv']);
data{71} = readmatrix(['data/pair-1/78.csv']);
data{72} = readmatrix(['data/pair-1/79.csv']);
data{73} = readmatrix(['data/pair-1/80.csv']);
data{74} = readmatrix(['data/pair-1/81.csv']);
data{75} = readmatrix(['data/pair-1/82.csv']);
data{76} = readmatrix(['data/pair-1/83.csv']);
data{77} = readmatrix(['data/pair-1/84.csv']);
data{78} = readmatrix(['data/pair-1/85.csv']);
data{79} = readmatrix(['data/pair-1/86.csv']);
data{80} = readmatrix(['data/pair-1/87.csv']);
data{81} = readmatrix(['data/pair-1/88.csv']);
data{82} = readmatrix(['data/pair-1/89.csv']);
% data{83} = readmatrix(['data/pair-1/90.csv']);
% data{84} = readmatrix(['data/pair-1/91.csv']);
% data{85} = readmatrix(['data/pair-1/92.csv']);
% data{86} = readmatrix(['data/pair-1/93.csv']);
% data{87} = readmatrix(['data/pair-1/94.csv']);
% data{88} = readmatrix(['data/pair-1/95.csv']);

%% Remove Non-Zeros - Empty
% plotting?

clear En; 
clear E3;
plotting = 1;

if plotting
    [plotx, ploty, plotz] = deal([]);
end


for i=1:length(data)

%     En{i}(:,1) = (data{i}(:,79));
%     En{i}(:,2) = (data{i}(:,80));
%     En{i}(:,3) = (data{i}(:,81));
%     En{i}(:,4) = (data{i}(:,2));
    
    En{i}(:,1) = (data{i}(:,55));
    En{i}(:,2) = (data{i}(:,56));
    En{i}(:,3) = (data{i}(:,57));
    En{i}(:,4) = (data{i}(:,2));
    
    E3{i}(1,:) = En{i}(:,1)';
    E3{i}(2,:) = En{i}(:,3)';
    E3{i}(3,:) = -En{i}(:,2)';
    E3{i}(4,:) = En{i}(:,4)';
    E3{i} = round(E3{i},4);
    
    if plotting
        plotx = [plotx, E3{i}(1,:)];
        ploty = [ploty, E3{i}(2,:)];
        plotz = [plotz, E3{i}(3,:)];             
    end

end
if plotting
    figure;
    plot3(plotx, ploty, plotz, '.');
    xlabel('x') 
    ylabel('y') 
end

%% x > 0.2 (20 cm)

for i=1:length(data)

    I1{i} = find(E3{i}(2,:) < 0.3);
    I2{i} = find(E3{i}(3,:) > 0.1);
    
end

for i=1:length(data)

    [val,pos]=intersect(I1{i},I2{i});
    I{i} = nonzeros(val);
end

%%
% 1, 4, 16, 19, 28, 29, 30, 43, 59, 63, 72, 

figure;

i = 1;

% find in I the different sequences
nEi = find((diff(I{i}(:))==1) == 0) ;

% nI = I{19}(1) - 200;
nI =  I{i}(1);
nE = I{i}(end);

m = 0
mf = 0
% one1 = nan(length(I{i}(:))+m - mf + 9,4);

%one1 = nan(length(I{i}(:))+m,4);
one1 = nan(nE-nI+32+m-mf,4);

% one1(:,1) = [E3{i-1}(1,end-m:end), E3{i}(1,1:I{i}(end)-mf)];
% one1(:,2) = [E3{i-1}(2,end-m:end), E3{i}(2,1:I{i}(end)-mf)];
% one1(:,3) = [E3{i-1}(3,end-m:end), E3{i}(3,1:I{i}(end)-mf)];   
% one1(:,4) = [E3{i-1}(4,end-m:end), E3{i}(4,1:I{i}(end)-mf)];   

% one1(:,1) = E3{i}(1,I{i}(nI) -m:I{i}(end)-mf);
% one1(:,2) = E3{i}(2,I{i}(nI) -m:I{i}(end)-mf);
% one1(:,3) = E3{i}(3,I{i}(nI) -m:I{i}(end)-mf);   
% one1(:,4) = E3{i}(4,I{i}(nI) -m:I{i}(end)-mf);  

% one1(:,1) = E3{i}(1,I{i}(1) -m:I{i}(nEi)-mf);
% one1(:,2) = E3{i}(2,I{i}(1) -m:I{i}(nEi)-mf);
% one1(:,3) = E3{i}(3,I{i}(1) -m:I{i}(nEi)-mf);   
% one1(:,4) = E3{i}(4,I{i}(1) -m:I{i}(nEi)-mf);  

one1(:,1) = E3{i}(1,I{i}(1) -m:I{i}(end)-mf);
one1(:,2) = E3{i}(2,I{i}(1) -m:I{i}(end)-mf);
one1(:,3) = E3{i}(3,I{i}(1) -m:I{i}(end)-mf);   
one1(:,4) = E3{i}(4,I{i}(1) -m:I{i}(end)-mf);   

plot3(one1(:,1), one1(:,2), one1(:,3), '.');

% if plotting
%     [plotx, ploty, plotz] = deal([]);
% end
% 
% figure;
% 
% if plotting
%     plotx = [plotx, E3{1}(1,850:1000)];
%     ploty = [ploty, E3{1}(2,850:1000)];
%     plotz = [plotz, E3{1}(3,850:1000)];   
%     time = data(850:1000,2);
% end
% plot3(ploty, plotx, plotz, '.');
%%

for i=1:length(one1(:,1))
    
   
    hold on;
    plot3(one1(i,1), one1(i,2), one1(i,3), '.');
    pause(0.05);
    
end
%% Remove Non-Zeros - Empty
% plotting?

clear En; 
clear E3;
plotting = 1;

if plotting
    [plotx, ploty, plotz, time] = deal([]);
end


for i=1:length(data)

%     En{i}(:,1) = (data{i}(:,79));
%     En{i}(:,2) = (data{i}(:,80));
%     En{i}(:,3) = (data{i}(:,81));
%     En{i}(:,4) = (data{i}(:,2));
    
    En{i}(:,1) = (data{i}(:,55));
    En{i}(:,2) = (data{i}(:,56));
    En{i}(:,3) = (data{i}(:,57));
    En{i}(:,4) = (data{i}(:,2));
     
    E3{i}(1,:) = En{i}(:,1)';
    E3{i}(2,:) = En{i}(:,3)';
    E3{i}(3,:) = -En{i}(:,2)';
    E3{i}(4,:) = En{i}(:,4)';
    E3{i} = round(E3{i},4);
    
    if plotting
        plotx = [plotx, E3{i}(1,:)];
        ploty = [ploty, E3{i}(2,:)];
        plotz = [plotz, E3{i}(3,:)];     
        time = [time, E3{i}(4,:)];
    end

end

%%
figure()
for i=1:10:length(time)
    
   
    hold on;
    plot3(plotx(i), ploty(i), plotz(i), '.');
    time(i)
    pause;
    
end

