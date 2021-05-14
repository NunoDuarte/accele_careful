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


%%

Folder = 'data/IST/1/';
DirList = dir(fullfile(Folder, '*.mat'));
Data = cell(1, length(DirList));
for k = 1:length(DirList)
  Data{k} = load(fullfile(Folder, DirList(k).name));
  Data{k} = Data{k}.data;
end




