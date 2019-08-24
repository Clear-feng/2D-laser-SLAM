function [Error, xx, yy] = FuncDiff(scan, Xstate, DTgrid, param)

%Transform scan into submap frame
scan_l = transform_to_global(scan.', Xstate).';

%Get scan points' grid index after transform
gridIdx = OccGridIdx(param.resol, param.topLeftCorner, scan_l);
xx = gridIdx(:,1);
yy = gridIdx(:,2);

%Get correspoding cost and gradient matrix
Error = DTgrid(xx, yy);
end
