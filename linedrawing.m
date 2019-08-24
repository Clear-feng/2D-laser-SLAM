function [freex, freey] = linedrawing(occ_x,occ_y,occ_x_grid,occ_y_grid,orig_x,orig_y,ori_x_grid,ori_y_grid)
%BRESENHAM2 calculate the free girds between original and obstacle
%the matlab improfile function
%   此处显示详细说明

% ax + by +c = 0
a =  orig_y - occ_y;
b = -orig_x + occ_x;
c = orig_x*occ_y - occ_x*orig_y;
if abs(occ_y_grid - ori_y_grid) > abs(occ_x_grid - ori_x_grid)
    d = sign(occ_y_grid - ori_y_grid);
    freey = ori_y_grid:d:(occ_y_grid-d);
    freex = ceil((-b*freey - c)/a);
else
    d = sign(occ_x_grid - ori_x_grid);
    freex = ori_x_grid:d:(occ_x_grid-d);
    freey = ceil((-a*freex - c)/b);
end
end

