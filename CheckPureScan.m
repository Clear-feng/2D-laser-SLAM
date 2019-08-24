clear; close all; clc;

% Lidar parameters
lidar = SetLidarParameters();
usableRange = 20;
%submap parameters
param = SetSubmapPara(usableRange);

%Load lidar data
load('rosbag&data/Scan.mat');
load ('rosbag&data/Xstate.mat');
load ('rosbag&data/timestamps.mat');

% load('scan.mat');
% load ('Xstate.mat');

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

for i = 1 : size(data,1)
    scans{i,1}= data{i,1};
    ts = timestamps(i,1);
    scants = [scants; ts];
end

[scanpose,scanposets,scanposescans]=Scaninterpolate(Xpose,timestamps,scants,scans);

figure(1);
hold on
for i = 1:size(scanpose,2)
    points_w = transform_to_global(scanposescans{i,1}.',scanpose(:,i)).';
    plot(points_w(:,1),points_w(:,2),'r.');
    drawnow;
end
