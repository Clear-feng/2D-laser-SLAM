function [timestamp, data] = Scanreader(bagname, lidar)
% Read scan and timestamp from ros bag file
% Input bagname in string format
% Output timestamp and scan data
filename = [bagname,'.bag'];
bag = rosbag(filename);

% % list the topic name;
% fprintf('topic names: \n');
% bag.AvailableTopics

bagUpLaser = select(bag,'Topic','down_laser/scan','Time',[bag.StartTime,bag.EndTime]);
msgsUpLsr = readMessages(bagUpLaser);
N = size(msgsUpLsr,1);
timestamp = zeros(N,1);
data = cell(N,1);

for idx = 1 : size(msgsUpLsr,1)
    angles = lidar.angles;
    ranges = msgsUpLsr{idx, :}.Ranges;
    
    % Remove points whose range is not so trustworthy
    maxRange = min(lidar.range_max, lidar.usableRange);
    isBad = ranges < lidar.range_min | ranges > maxRange;
    angles(isBad) = [];
    ranges(isBad) = [];
    
    % Convert from polar coordinates to cartesian coordinates
    [xs, ys] = pol2cart(angles, ranges);
    scan = [xs, ys];
    ts = msgsUpLsr{idx,:}.Header.Stamp.Sec + msgsUpLsr{idx,:}.Header.Stamp.Nsec*1e-9;
    data{idx,1}=scan;
    timestamp(idx,1) = ts;
end
end





