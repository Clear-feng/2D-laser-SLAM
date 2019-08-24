function [scanposescans,scanposets,scanpose] = Scannointerpolate(timestamp,scants,scans,Xpose)
scanIdx = 1;
scanposescans = {};
scanposets = [];
for i = 1 : size(timestamp,1)
    for j = scanIdx : size(scants,1)
        if abs(scants(j)-timestamp(i))<=1
            scanposescans{i,1} = scans{j,1};
            scanIdx = j;
            scanposets(end+1,:) = scants(j,:);            
            break
        end
    end
end

scanpose = [];
scanpose(:,1) = Xpose(:,1);
scanpose(:,size(timestamp,1)) = Xpose(:,end);
for i = 2:size(timestamp,1)-1
    if scanposets(i) < timestamp(i)
        scanpose(:,i) = (scanposets(i)-timestamp(i-1))*(Xpose(:,i)-Xpose(:,i-1)) ...
            /(timestamp(i)-timestamp(i-1))+Xpose(:,i-1);
    else
        scanpose(:,i) = (scanposets(i)-timestamp(i))*(Xpose(:,i+1)-Xpose(:,i)) ...
            /(timestamp(i+1)-timestamp(i))+Xpose(:,i);
    end
end

end