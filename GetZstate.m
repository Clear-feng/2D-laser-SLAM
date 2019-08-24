function  Zstate = GetZstate(map)
mapLength = size(map,1);
Zstate = zeros(mapLength(:,1)*size(map{1,1}.connections,2)*3,4);
beginState = map{1,1}.connections(1).pair(:,2)-1;
for i = 1:mapLength(:,1)
    for k = 1 : size(map{1,1}.connections,2)
        Zstate((i-1)*size(map{1,1}.connections,2)*3+3*k-2,:) = [map{i,1}.connections(k).relativePose(1,:), 1, map{i,1}.connections(k).pair(:,1)-1-beginState, map{i,1}.connections(k).pair(:,2)-1-beginState];
        Zstate((i-1)*size(map{1,1}.connections,2)*3+3*k-1,:) = [map{i,1}.connections(k).relativePose(2,:), 1, map{i,1}.connections(k).pair(:,1)-1-beginState, map{i,1}.connections(k).pair(:,2)-1-beginState];
        Zstate((i-1)*size(map{1,1}.connections,2)*3+3*k,:) = [map{i,1}.connections(k).relativePose(3,:), 1, map{i,1}.connections(k).pair(:,1)-1-beginState, map{i,1}.connections(k).pair(:,2)-1-beginState];
    end
end
end

%     i = 170;
%     for k = 20 : 39
%         Zstate1(3*(k-19)-2,:) = [map{i,1}.connections(k).relativePose(1,:), 1, map{i,1}.connections(k).pair(:,1)-1, map{i,1}.connections(k).pair(:,2)-1];
%         Zstate1(3*(k-19)-1,:) = [map{i,1}.connections(k).relativePose(2,:), 1, map{i,1}.connections(k).pair(:,1)-1, map{i,1}.connections(k).pair(:,2)-1];
%         Zstate1(3*(k-19),:) = [map{i,1}.connections(k).relativePose(3,:), 1, map{i,1}.connections(k).pair(:,1)-1, map{i,1}.connections(k).pair(:,2)-1];
%     end

