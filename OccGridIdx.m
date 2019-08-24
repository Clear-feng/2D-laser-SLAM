function gridIdx = OccGridIdx(resol, topLeftCorner, points)

%update OccuGrid map
x_occ = points(:,1) - topLeftCorner(1);
y_occ = points(:,2) - topLeftCorner(2);

%Occupancy Grid Index
gridIdx = resol*[x_occ,y_occ];

end