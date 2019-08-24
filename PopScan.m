%
function submap = PopScan(submap, scan, pose, param, scanIdx)

% scan_w = transform_to_global(scan.', pose).';
% newPoints = scan_w(abs(error)>sqrt(2), :);
%
% submap.points = [submap.points; newPoints];

% connections
% ToDo: Estimate the relative pose and covariance, they will be useful
% when we close a loop (pose graph optimization).
c = length(submap.connections);
submap.connections(c+1).pair = [scanIdx, submap.begin];
submap.connections(c+1).relativePose = pose;

%update OccuGrid map
%Occupancy Grid Index
submap.cell = ProbUpdate(scan, pose, param,submap.cell);
submap.grid = zeros(param.size);

obst = submap.cell>=param.hit;
submap.grid(obst) = 1;
submap.distmap = bwdist(submap.grid);
end




