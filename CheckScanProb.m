clear; close all; clc;

% Lidar parameters
lidar = SetLidarParameters();
usableRange = 20;
%submap parameters
param = SetSubmapPara(usableRange);

%Load lidar data
load ('rosbag&data/RXstate.mat');
load ('rosbag&data/Rtimestamp.mat');

scanIdx = 1;
hold on
scans = cell(size(Xstate,1)/3,1);
Xpose = [];
scants = [];
N = size(Xstate, 1)/3;
%% main loop
for i = 1 : N
    Xpose = [Xpose [Xstate(3*i-2,2);Xstate(3*i-1,2);Xstate(3*i,2)]];
end

[scants,scans] = Scanreader('.\rosbag&data\ros_record',lidar);


% [scanpose,scanposets,scanposescans]=Scaninterpolate(Xpose,timestamp,scants,scans);
[scanposescans,scanposets,scanpose] = Scannointerpolate(timestamp,scants,scans,Xpose);

myMap = ones(param.size)*param.unknow;
for i = 1:size(scanpose,2)
    myMap = ProbUpdate(scanposescans{i,1}, scanpose(:,i), param, myMap);
end
Bidx = find(myMap>0.65);
Widx = find(myMap<0.2);
myMapNew = myMap;
myMapNew(Bidx) = 1;
myMapNew(Widx) = 0;
imshow(1-myMapNew);

% plot(timestamp(:,1),Xpose(3,:),'r*')
% hold on
% plot(scanposets(:,1),scanpose(3,:),'kx')
% plot(Xpose(1,:),Xpose(2,:),'r*');
% hold on
% plot(scanpose(1,1:10:end),scanpose(2,1:10:end),'kx');