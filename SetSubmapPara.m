function param = SetSubmapPara(usableRange)
% 1. Decide map resolution, i.e., the number of grids for 1 meter.
param.resol = 20;
% 2. Decide the initial map size in pixels
submapSize = 3;
param.size = [usableRange*param.resol*submapSize,usableRange*param.resol*submapSize];
% 3. Indicate the origin offset in metrics
param.topLeftCorner = [-param.size(1)/2/param.resol,-param.size(2)/2/param.resol]';
% 4. Log-odd parameters 
param.hit = 0.55;
param.miss = 0.49; 
param.max = 1;
param.min = 0;
param.unknow = 0.5;   %initial cell probility
param.nscan = 80;   %numer of scans in per submap
end