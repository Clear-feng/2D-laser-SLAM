function [scanpose,scanposets,scanposescans]=Scaninterpolate(Xpose,timestamp,scants,scans)
%Linear interpolation for scan pose
%scants: timestamp for scan pose
%timestamp: timestamp for optimized pose
scanpose = [];
scanIdx = 1;
scanposets = [];
scanposescans = {};
for j = 2:size(Xpose,2)
    for i = scanIdx:size(scants,1)
        if scants(i) < timestamp(j)
            if scants(i) > timestamp(1)
                if abs(Xpose(3,j)-Xpose(3,j-1)) < 3.14
                    scanpose(:,end+1) = (scants(i)-timestamp(j-1))*(Xpose(:,j)-Xpose(:,j-1)) ...
                        /(timestamp(j)-timestamp(j-1))+Xpose(:,j-1);
                    scanposets(end+1,:) = scants(i,:);
                    scanposescans(end+1,:) = scans(i,:);
                else
                    scanpose(1:2,end+1) = (scants(i)-timestamp(j-1))*(Xpose(1:2,j)-Xpose(1:2,j-1)) ...
                        /(timestamp(j)-timestamp(j-1))+Xpose(1:2,j-1);
                    theta1 = Xpose(3,j-1);
                    theta2 = Xpose(3,j);
                    if theta1 > theta2
                        theta2 = theta2 + 2*pi;
                    else
                        theta1 = theta1 + 2*pi;
                    end
                    scanpose(3,end) = (scants(i)-timestamp(j-1))/(timestamp(j)-timestamp(j-1))*(theta2-theta1)+theta1;
                    scanposets(end+1,:) = scants(i,:);
                    scanposescans(end+1,:) = scans(i,:);
                end
            end
        else
            scanIdx = i;
            break
        end
    end
end

end


