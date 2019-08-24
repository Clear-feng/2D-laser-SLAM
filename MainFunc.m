clear; close all; clc;

%% Set Parameters

%Lidar parameter
lidar = SetLidarParameters();

%Map parameters
param = SetSubmapPara(lidar.usableRange);
map = {};   %use to save all completed submap

%Load scan data-
[timestamps,data] = Scanreader('.\rosbag&data\ros_record',lidar);
% load('dataset/horizental_lidar.mat');
N = size(timestamps,1);

%% main loop
for idx = 1:N
    %Display current scan index
    disp(['scan ', num2str(idx)]);
    
    % Get current scan [x1,y1; x2,y2; ...]
    scan = data{idx,1};
    %     scan = ReadAScan(ranges(idx,:), idx, lidar);
    
    
    caseidx = WhichCase(idx, param.nscan);
    if idx == 1 %the first scan
        submap1 = InitializeSubmap(scan, idx, param);
        continue
    end
    
    %% Store and reset a new submap
    if caseidx == 1 %reset submap1
        map{size(map,1)+1, 1} = submap1;
    elseif caseidx ==2 && exist('submap2','var') %reset submap1
        map{size(map,1)+1, 1} = submap2;
    end
    
    
    %% Building the submap
    switch caseidx
        case 1 %initialize submap1
            submap1 = InitializeSubmap(scan, idx, param);
            submap2 = UpdateSubmap(submap2, scan, idx, param);
        case 2 %initialize submap2
            submap2 = InitializeSubmap(scan, idx, param);
            submap1 = UpdateSubmap(submap1, scan, idx, param);
        case 3 %update both submaps
            submap1 = UpdateSubmap(submap1, scan, idx, param);
            submap2 = UpdateSubmap(submap2, scan, idx, param);
        case 4 %first several scans
            submap1 = UpdateSubmap(submap1, scan, idx, param);
    end
end

Zstate = GetZstate(map);
save('.\rosbag&data\Zstate.mat','Zstate');
save('.\rosbag&data\Scan.mat','data');
save('.\rosbag&data\Param.mat','param');
save('.\rosbag&data\timestamps.mat','timestamps');
