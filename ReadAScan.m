% Read a laser scan
function [scan,timestamp] = ReadAScan(ranges, idx, lidar)

angles = lidar.angles;
% ranges = lidar_data.ranges(idx, :)';

% Remove points whose range is not so trustworthy
maxRange = min(lidar.range_max, lidar.usableRange);
isBad = ranges < lidar.range_min | ranges > maxRange;
angles(isBad) = [];
ranges(isBad) = [];

% Convert from polar coordinates to cartesian coordinates
[xs, ys] = pol2cart(angles, ranges.');
scan = [xs, ys];
end