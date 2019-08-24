function submap = UpdateSubmap(submap,scan,idx, param)
% predict robot pose on submap frame,
% update submap with current scan
% and update corespoding submap path.

%predict robot pose on submap frame with constant velocity model.
%'guess' is robot predicted pose within submap frame.
%subpose is refine robot pose within submap frame
if size(submap.connections,2) > 1
    guess = DiffPose(submap.connections(end-1).relativePose,submap.connections(end).relativePose) ...
        + submap.connections(end).relativePose;
    %guess = deltaX + current pose
elseif size(submap.connections,2) == 1
    guess = 2 * submap.connections(1).relativePose;
else
    guess = [0;0;0];
end
guess(3) = wrapToPi(guess(3));
[subpose,~] = ScanMatcher(submap.distmap,scan,guess,param);
submap = PopScan(submap,scan,subpose,param,idx);

% plot(submap.points(:,1),submap.points(:,2),'.r');
% hold on
% points = transform_to_global(scan.', subpose).';
% plot(points(:,1),points(:,2),'xk');
% hold on
% points = transform_to_global(scan.', guess).';
% plot(points(:,1),points(:,2),'ob');
end