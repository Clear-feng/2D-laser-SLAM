function Map = ProbUpdate(scan, pose, param, Map)
%Update probability value of each cell

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Parameters
%
% % the initial map size in pixels

points = transform_to_global(scan.',pose).';

ix_occ = param.resol*(points(:,1)-param.topLeftCorner(1));
iy_occ = param.resol*(points(:,2)-param.topLeftCorner(2));

% Find grids hit by the rays (in the gird map coordinate)
ix_occ_grid = round(ix_occ);
iy_occ_grid = round(iy_occ);

ix_ori = (pose(1,:)-param.topLeftCorner(1))*param.resol;
iy_ori = (pose(2,:)-param.topLeftCorner(2))*param.resol;

ix_ori_grid = round(ix_ori);
iy_ori_grid = round(iy_ori);

N = size(pose,2);
M = size(points,1);
for j = 1:N % for each time,
    %     % Find occupied-measurement cells and free-measurement cells
    free = [];
    for k = 1:M
        [freex,freey] = linedrawing(ix_occ(k,j),iy_occ(k,j),ix_occ_grid(k,j),iy_occ_grid(k,j),...
            ix_ori(j),iy_ori(j),ix_ori_grid(j),iy_ori_grid(j));
        free = [free,[freex;freey]];
    end
    free = free';
    obst = [ix_occ_grid(:,j),iy_occ_grid(:,j)];
    
    free_union = unique(free,'rows');
    obst_union = unique(obst,'rows');
    
    free_ind = sub2ind(param.size, free_union(:,1),free_union(:,2));
    obst_ind = sub2ind(param.size, obst_union(:,1),obst_union(:,2));
    
    %     % Update the odds
        Map(free_ind) = OddAndProbability(OddAndProbability(Map(free_ind),1).*OddAndProbability(param.miss,1),2);
        Map(obst_ind) = OddAndProbability(OddAndProbability(Map(obst_ind),1).*OddAndProbability(param.hit,1),2);
    %     % Saturate the odd values
        Map(Map > param.max) = param.max;
        Map(Map < param.min) = param.min;
end
end

