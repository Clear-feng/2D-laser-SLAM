% Lidar parameters
function lidar = SetLidarParameters()
lidar.angle_min = -2.3561945;
lidar.angle_max = 2.3561945;
lidar.angle_increment = 0.0043633;
lidar.npoints   = 1081;
lidar.range_min = 0.5;
lidar.range_max = 60;
lidar.scan_time = 0.025;
lidar.time_increment  = 1.736112e-05;
lidar.angles = (lidar.angle_min : lidar.angle_increment : lidar.angle_max)';
lidar.usableRange = 24;  %maxium usable lidar range

% lidar.angle_min = -2.351831;
% lidar.angle_max =  2.351831;
% lidar.angle_increment = 0.004363;
% lidar.npoints   = 1079;
% lidar.range_min = 0.023;
% lidar.range_max = 60;
% lidar.scan_time = 0.025;
% lidar.time_increment  = 1.736112e-05;
% lidar.angles = (lidar.angle_min : lidar.angle_increment : lidar.angle_max)';
% lidar.usableRange = 24;
end