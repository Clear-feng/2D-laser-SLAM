function p = transform_to_relative(p, b)
% function p = transform_to_relative(p, b)
%
% Transform a list of poses [x;y;phi] relative to a base pose.
% Also works for lists of points [x;y].
%
% Tim Bailey 1999

% translate
p(1,:) = p(1,:) - b(1);
p(2,:) = p(2,:) - b(2);

% rotate
rot = [cos(b(3)) sin(b(3));
   -sin(b(3)) cos(b(3))];
p(1:2, :) = rot*p(1:2, :);

% for pose lists only
if size(p,1)==3
   p(3,:) = wrapToPi(p(3,:) - b(3));
end
