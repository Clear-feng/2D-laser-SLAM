function submap = InitializeSubmap(scan, idx, param)
%Initialize submap with the first scan in this submap
%submap.cell is probability map
%submap.grid is binary map
%submap.distmap is distance value to represent the distance value (in cell)
%to the closet obstacle;

% Points in world frame
submap.cell = ones(param.size)*param.unknow;
% submap.points = scan;
submap.connections = [];
submap.begin = idx;

%Populate scan into submap
submap.cell = ProbUpdate(scan, [0;0;0], param,submap.cell);
submap.grid = zeros(param.size);
obst = submap.cell>=param.hit;
submap.grid(obst) = 1;
submap.distmap = bwdist(submap.grid);
end